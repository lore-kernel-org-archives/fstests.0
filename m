Received: from mx1.redhat.com ([209.132.183.28]:32863 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbcFNEjp (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 14 Jun 2016 00:39:45 -0400
Date: Tue, 14 Jun 2016 12:39:42 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] shared: regression test for hang when processing
 corrupted orphaned inode list
Message-ID: <20160614043942.GN5140@eguan.usersys.redhat.com>
References: <20160613093350.GJ5140@eguan.usersys.redhat.com>
 <1465873139-8724-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1465873139-8724-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 14, 2016 at 10:58:59AM +0800, Guangwen Feng wrote:
> Commit c9eb13a fixed this bug:
> 	ext4: fix hang when processing corrupted orphaned inode list
> 
> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>

Looks good to me overall. Some minor issues inline below

> ---
>  common/config        |  1 +
>  tests/shared/004     | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/shared/004.out |  2 ++
>  tests/shared/group   |  1 +
>  4 files changed, 66 insertions(+)
>  create mode 100755 tests/shared/004
>  create mode 100644 tests/shared/004.out
> 
> diff --git a/common/config b/common/config
> index cacd815..c25b1ec 100644
> --- a/common/config
> +++ b/common/config
> @@ -195,6 +195,7 @@ export DUMP_PROG="`set_prog_path dump`"
>  export RESTORE_PROG="`set_prog_path restore`"
>  export LVM_PROG="`set_prog_path lvm`"
>  export CHATTR_PROG="`set_prog_path chattr`"
> +export DEBUGFS_PROG="`set_prog_path debugfs`"
>  
>  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>  # newer systems have udevadm command but older systems like RHEL5 don't.
> diff --git a/tests/shared/004 b/tests/shared/004
> new file mode 100755
> index 0000000..213fba2
> --- /dev/null
> +++ b/tests/shared/004
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# FS QA Test 004
> +#
> +# Regression test for commit:
> +# c9eb13a ext4: fix hang when processing corrupted orphaned inode list
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2016 Fujitsu.  All Rights Reserved.
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
> +tmp=/tmp/$$
> +status=1	# failure is the default!
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
> +
> +# real QA test starts here
> +_supported_fs ext2 ext3 ext4
> +_supported_os Linux
> +_require_scratch
> +_require_command "$DEBUGFS_PROG" debugfs
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +echo "Silence is golden"
> +
> +for i in {1..10}
> +do

Good to have some comments to explain why inode 1-10 are tested.

And fstests perfers the following for loop:
	for ...; do
		do something
	done

> +	_scratch_mkfs >>$seqres.full 2>&1

Use _scratch_mkfs_sized to create smaller filesystems? So we don't spend
much time creating filesystems. This reduces test time from 57s to 2s
for me when testing with 1k block size ext2/3. e.g.

	# create smaller filesystems to save test time
	_scratch_mkfs_sized $((16 * 1024 * 1024)) >>$seqres.full 2>&1

> +	debugfs -w -R "ssv last_orphan $i" $SCRATCH_DEV >>$seqres.full 2>&1

You defined $DEBUGFS_PROG, use it here :)

> +	_scratch_mount
> +	_scratch_unmount

There's a new helper to do this now, _scratch_cycle_mount

Thanks,
Eryu
