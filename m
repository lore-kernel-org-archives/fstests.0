Received: from mx1.redhat.com ([209.132.183.28]:58918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751879AbdBOJxH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 15 Feb 2017 04:53:07 -0500
Date: Wed, 15 Feb 2017 17:53:06 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/4] generic: new case for test mount bind operation
Message-ID: <20170215095306.GR24562@eguan.usersys.redhat.com>
References: <20170214005545.29373-1-tytso@mit.edu>
 <20170214005545.29373-3-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170214005545.29373-3-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 13, 2017 at 07:55:43PM -0500, Theodore Ts'o wrote:
> From: Zorro Lang <zlang@redhat.com>
> 
> This case will do function test for mount bind operation, it will
> verify below semantics:
> 
> ---------------------------------------------------------------------------
> |         BIND MOUNT OPERATION                                            |
> |**************************************************************************
> |source(A)->| shared       |       private  |       slave    | unbindable |
> | dest(B)  |               |                |                |            |
> |   |      |               |                |                |            |
> |   v      |               |                |                |            |
> |**************************************************************************
> |  shared  | shared        |     shared     | shared & slave |  invalid   |
> |          |               |                |                |            |
> |non-shared| shared        |      private   |      slave     |  invalid   |
> ***************************************************************************
> 
> This case use fsstress to produce a little rand load, to sure basic
> operations on the bind mountpoint won't cause hang or panic etc.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/generic/409     | 182 +++++++++++++++++++++++++
>  tests/generic/409.out | 365 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/group   |   1 +
>  3 files changed, 548 insertions(+)
>  create mode 100644 tests/generic/409

File mode for new case is better to be 755, so after running tests git
diff won't complain about the mode change.

>  create mode 100644 tests/generic/409.out
> 
> diff --git a/tests/generic/409 b/tests/generic/409
> new file mode 100644
> index 00000000..88bda6c5
> --- /dev/null
> +++ b/tests/generic/409
> @@ -0,0 +1,182 @@
> +#! /bin/bash
> +# FS QA Test 409
> +#
> +# Test mount shared subtrees, verify the bind semantics:
> +#
> +# ---------------------------------------------------------------------------
> +# |         BIND MOUNT OPERATION                                            |
> +# |**************************************************************************
> +# |source(A)->| shared       |       private  |       slave    | unbindable |
> +# | dest(B)  |               |                |                |            |
> +# |   |      |               |                |                |            |
> +# |   v      |               |                |                |            |
> +# |**************************************************************************
> +# |  shared  | shared        |     shared     | shared & slave |  invalid   |
> +# |          |               |                |                |            |
> +# |non-shared| shared        |      private   |      slave     |  invalid   |
> +# ***************************************************************************
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2016 Red Hat Inc.  All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	_clear_mount_stack
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_test

Need a "_require_block_device $SCRATCH_DEV", otherwise test on
NFS/overlay etc. will fail, because we assume $SCRATCH_DEV is a block
device.

> +
> +fs_stress()
> +{
> +	local target=$1
> +
> +	$FSSTRESS_PROG -z -n 50 -p 3 \
> +		       -f creat=5 \
> +		       -f mkdir=5 \
> +		       -f link=2 \
> +		       -f rename=1 \
> +		       -f rmdir=2 \
> +		       -f unlink=1 \
> +		       -f symlink=1 \
> +		       -f write=1 \
> +		       -f read=1 \
> +		       -f chown=1 \
> +		       -f getdents=1 \
> +		       -f fiemap=1 \
> +		       -d $target >/dev/null
> +	sync
> +}
> +
> +# prepare some mountpoint dir
> +MNTHEAD=$TEST_DIR/$seq
> +mkdir $MNTHEAD 2>>$seqres.full
> +mpA=$MNTHEAD/"$$"_mpA
> +mpB=$MNTHEAD/"$$"_mpB
> +mpC=$MNTHEAD/"$$"_mpC
> +mpD=$MNTHEAD/"$$"_mpD
> +
> +find_mnt()
> +{
> +	echo "------"
> +	findmnt -n -o TARGET,SOURCE $SCRATCH_DEV | \
> +	    sed -e "s;$mpA;mpA;g" \
> +		-e "s;$mpB;mpB;g" \
> +		-e "s;$mpC;mpC;g" \
> +		-e "s;$mpD;mpD;g" | \
> +	    _filter_spaces | _filter_scratch | \
> +	    _filter_test_dir | sort
> +	echo "======"
> +}
> +
> +start_test()
> +{
> +	local type=$1
> +
> +	_get_mount $SCRATCH_DEV $MNTHEAD
> +	mount --make-"${type}" $MNTHEAD
> +	rm -rf $mpA $mpB $mpC $mpD 2>/dev/null
> +	mkdir $mpA $mpB $mpC $mpD
> +        _scratch_mkfs >$seqres.full 2>&1

We should _scratch_mkfs before mounting $SCRATCH_DEV on $MNTHEAD, and
since the filesystem is newly created, the "rm -rf" line seems not
necessary.

> +}
> +
> +end_test()
> +{
> +	rm -rf $mpA $mpB $mpC $mpD 2>/dev/null
> +	_clear_mount_stack

Unmount all mount points then remove them, otherwise rm always fails
because of "Device is busy".

> +}
> +
> +bind_run()
> +{
> +	local source=$1
> +	local dest=$2
> +
> +	start_test $dest
> +
> +	echo "bind $source on $dest"
> +	_get_mount $SCRATCH_DEV $mpA
> +	mkdir -p $mpA/dir 2>/dev/null
> +	mount --make-shared $mpA
> +	_get_mount --bind $mpA $mpB
> +	mount --make-"$source" $mpB
> +	# maybe unbindable at here
> +	_get_mount --bind $mpB $mpC 2>/dev/null
> +	if [ $? -ne 0 ];then
> +		find_mnt
> +		end_test
> +		return 0
> +	fi
> +	_get_mount --bind $mpC $mpD
> +	for m in $mpA $mpB $mpC $mpD
> +	do
> +		_get_mount $SCRATCH_DEV $m/dir
> +		fs_stress $m/dir
> +		find_mnt
> +		_put_mount
> +	done
> +
> +	end_test
> +}
> +
> +bind_test()
> +{
> +	local dest=$1

dest is not used, can be removed.

The other two tests have similar issues, I'll fix them all.

Thanks,
Eryu
