Received: from mx1.redhat.com ([209.132.183.28]:37846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754291AbdKOINo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 15 Nov 2017 03:13:44 -0500
Date: Wed, 15 Nov 2017 16:13:41 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic: add testcase to test fallocate & f{data,}sync
Message-ID: <20171115081341.GO17339@eguan.usersys.redhat.com>
References: <20171113085350.42455-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171113085350.42455-1-yuchao0@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: fstests@vger.kernel.org, jaegeuk@kernel.org, chao@kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Nov 13, 2017 at 04:53:50PM +0800, Chao Yu wrote:
> f2fs can skip isize updating in fsync(), since during mount, f2fs tries
> to recovery isize according to valid block address or preallocated flag
> in last fsynced dnode block.
> 
> However, fallocate() breaks our rule with setting FALLOC_FL_KEEP_SIZE
> flag, since it can preallocated block cross EOF, once the file is fsynced,
> in POR, we will recover isize incorrectly based on these fallocated
> blocks.
> 
> This patch adds a new testcase to test fallocate, in order to verify
> whether filesystem will do correct recovery on isize.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  tests/generic/468     | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/468.out |  13 ++++++
>  tests/generic/group   |   1 +
>  3 files changed, 131 insertions(+)
>  create mode 100755 tests/generic/468
>  create mode 100644 tests/generic/468.out
> 
> diff --git a/tests/generic/468 b/tests/generic/468
> new file mode 100755
> index 000000000000..af3c5958750f
> --- /dev/null
> +++ b/tests/generic/468
> @@ -0,0 +1,117 @@
> +#! /bin/bash
> +# FS QA Test 468
> +#
> +# Do test with fallocate, f{data,}sync, power-cuts, check inode's metadata
> +# after filesystem recovery.
> +# In the case of fsync, filesystem should recover all the inode metadata, while
> +# recovering i_blocks and i_size at least for fdatasync.

Better to mention that this test is an fallocate variant of generic/392.

> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Chao Yu.  All Rights Reserved.

I didn't pay much attention to copyright statement before, but Dave
pointed out similar issue in one of his reviews: You're signing off this
patch a Huawei employee, but claiming personal copyright. Please clarify
who owns the copyright - if it's your personal copyright then please
sign off with a personal email address, not your employer's.

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
> +status=0	# failure is the default!

status=1 means "failure is the default!" :)

I noticed that you set status=1 explicitly on failure case, I don't
think that's needed, just default to 'status=1' and set status=0 before
exit in the end. The echos on failure case would break golden image
anyway.

Thanks,
Eryu

> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
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
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +
> +_require_scratch
> +_require_scratch_shutdown
> +_require_xfs_io_command "falloc" "-k"
> +
> +_scratch_mkfs >/dev/null 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +_scratch_mount
> +
> +testfile=$SCRATCH_MNT/testfile
> +
> +# check inode metadata after shutdown
> +check_inode_metadata()
> +{
> +	sync_mode=$1
> +
> +	# fsync or fdatasync
> +	if [ $sync_mode = "fsync" ]; then
> +		stat_opt='-c "b: %b s: %s a: %x m: %y c: %z"'
> +	else
> +		stat_opt='-c "b: %b s: %s"'
> +	fi
> +
> +	before=`stat "$stat_opt" $testfile`
> +
> +	$XFS_IO_PROG -c "$sync_mode" $testfile | _filter_xfs_io
> +	src/godown $SCRATCH_MNT | tee -a $seqres.full
> +	_scratch_cycle_mount
> +
> +	after=`stat "$stat_opt" $testfile`
> +
> +	if [ "$before" != "$after" ]; then
> +		echo "Before: $before"
> +		echo "After : $after"
> +		status=1;	# this is a failure!
> +	fi
> +	echo "Before: $before" >> $seqres.full
> +	echo "After : $after" >> $seqres.full
> +	rm $testfile
> +}
> +
> +# fallocate XX KB with f{data}sync, followed by power-cut
> +test_falloc()
> +{
> +	echo "==== falloc $2$3 test with $1 ====" | tee -a $seqres.full
> +	$XFS_IO_PROG -f -c "truncate 4202496"	\
> +			-c "pwrite 0 4202496"	\
> +			-c "fsync"		\
> +			-c "falloc $2 4202496 $3"\
> +			$testfile >/dev/null
> +	check_inode_metadata $1
> +}
> +
> +for i in fsync fdatasync; do
> +	test_falloc $i "" 1024
> +	test_falloc $i "" 4096
> +	test_falloc $i "" 104857600
> +	test_falloc $i "-k " 1024
> +	test_falloc $i "-k " 4096
> +	test_falloc $i "-k " 104857600
> +done
> +
> +exit
> diff --git a/tests/generic/468.out b/tests/generic/468.out
> new file mode 100644
> index 000000000000..b3a28d5ea07c
> --- /dev/null
> +++ b/tests/generic/468.out
> @@ -0,0 +1,13 @@
> +QA output created by 468
> +==== falloc 1024 test with fsync ====
> +==== falloc 4096 test with fsync ====
> +==== falloc 104857600 test with fsync ====
> +==== falloc -k 1024 test with fsync ====
> +==== falloc -k 4096 test with fsync ====
> +==== falloc -k 104857600 test with fsync ====
> +==== falloc 1024 test with fdatasync ====
> +==== falloc 4096 test with fdatasync ====
> +==== falloc 104857600 test with fdatasync ====
> +==== falloc -k 1024 test with fdatasync ====
> +==== falloc -k 4096 test with fdatasync ====
> +==== falloc -k 104857600 test with fdatasync ====
> diff --git a/tests/generic/group b/tests/generic/group
> index 9183950c8dfc..ea2dc04d931e 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -470,3 +470,4 @@
>  465 auto rw quick aio
>  466 auto quick rw
>  467 auto quick exportfs
> +468 shutdown auto quick metadata
> -- 
> 2.15.0.55.gc2ece9dc4de6
> 
