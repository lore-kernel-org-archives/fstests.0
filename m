Received: from mx1.redhat.com ([209.132.183.28]:59617 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529AbcFUHd1 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 21 Jun 2016 03:33:27 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6627F7F09A
	for <fstests@vger.kernel.org>; Tue, 21 Jun 2016 07:08:20 +0000 (UTC)
Date: Tue, 21 Jun 2016 15:08:18 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v4 2/2] xfs/006: new case to test xfs fail_at_unmount
 error handling
Message-ID: <20160621070818.GT5140@eguan.usersys.redhat.com>
References: <1466429073-10124-1-git-send-email-zlang@redhat.com>
 <1466429073-10124-2-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1466429073-10124-2-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, sandeen@redhat.com, cem@redhat.com
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 20, 2016 at 09:24:33PM +0800, Zorro Lang wrote:
> XFS bring in a new configuration under /sys/fs/xfs/error, named
> fail_at_unmount from below commit:
> 
>   a5ea70d xfs: add configuration of error failure speed
> 
> It's used to stop unmount retrying forever when it hit IO error.
> This case try to unmount an faulty dm device, and to sure unmount
> won't retry forever if fail_at_unmount=1.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

"xfs/006: new case to test xfs fail_at_unmount error handling"

No need to prefix a new case with a test sequence number, it might be
renumbered :)

> ---
> 
> Hi,
> 
> V4 did below changes:
> 1) Due to common/rc changed, so change this case to use new function name.
> 2) Remove _pwrite_byte operation
> 3) After umount error device test, load working table back, and make sure
>    fs consistent.
> 
> Thanks,
> Zorro
> 
>  tests/xfs/006     | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/006.out |  2 ++
>  tests/xfs/group   |  1 +
>  3 files changed, 84 insertions(+)
>  create mode 100755 tests/xfs/006
>  create mode 100644 tests/xfs/006.out
> 
> diff --git a/tests/xfs/006 b/tests/xfs/006
> new file mode 100755
> index 0000000..be736f9
> --- /dev/null
> +++ b/tests/xfs/006
> @@ -0,0 +1,81 @@
> +#! /bin/bash
> +# FS QA Test 006
> +#
> +# Test xfs' "fail at unmount" error handling configuration. Stop
> +# XFS retrying to writeback forever when unmount.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2016 YOUR NAME HERE.  All Rights Reserved.
                        ^^^^^^^^^^^^^^ Wrong copyright
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
> +	_dmerror_cleanup
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmerror
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_supported_os Linux
> +_require_dm_target error
> +_require_scratch
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_require_fs_sysfs $SCRATCH_DEV error/fail_at_unmount

Usually we call _require_xxx before mkfs and do the real test, a comment
to explain why we need to mkfs first would be good.

> +
> +# The device is still a linear device at here
> +_dmerror_init
> +_dmerror_mount
> +
> +# Enable fail_at_unmount
> +_set_fs_sysfs_param $DMERROR_DEV error/fail_at_unmount 1

We have to make sure the behavior on EIO, ENOSPC is configured to retry
forever, though that's the default behavior, e.g.

# configure xfs to retry forever on errors and enable error/fail_at_unmount,
# so unmount breaks out "retry forever" loop
_set_fs_sysfs_attr $DMTHIN_VOL_DEV error/metadata/default/max_retries -1
_set_fs_sysfs_attr $DMTHIN_VOL_DEV error/metadata/ENOSPC/max_retries -1
_set_fs_sysfs_attr $DMTHIN_VOL_DEV error/metadata/EIO/max_retries -1
_set_fs_sysfs_attr $DMTHIN_VOL_DEV error/fail_at_unmount 1

Then check the above attribute values are really what we set? And we can
dump the outputs to golden image. e.g.

# make sure it's really what we set
_get_fs_sysfs_attr $DMTHIN_VOL_DEV error/metadata/default/max_retries
_get_fs_sysfs_attr $DMTHIN_VOL_DEV error/metadata/ENOSPC/max_retries
_get_fs_sysfs_attr $DMTHIN_VOL_DEV error/metadata/EIO/max_retries
_get_fs_sysfs_attr $DMTHIN_VOL_DEV error/fail_at_unmount

> +
> +
> +# umount will cause XFS try to writeback something to root inode.
> +# So after load error table, it can trigger umount fail.
> +_dmerror_load_error_table
> +_dmerror_unmount

Unmount still doesn't hang for me when I set fail_at_unmount to 0. Maybe
it's hard to hit the correct timing everytime.

> +
> +# Due to above operations cause fs inconsistent, that's expected.
> +# But we need fs be consistent before this case end.
> +_dmerror_load_working_table
> +_dmerror_mount
> +_dmerror_unmount
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/006.out b/tests/xfs/006.out
> new file mode 100644
> index 0000000..675c1b7
> --- /dev/null
> +++ b/tests/xfs/006.out
> @@ -0,0 +1,2 @@
> +QA output created by 006
> +Silence is golden
> diff --git a/tests/xfs/group b/tests/xfs/group
> index f4c6816..39169ea 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -4,6 +4,7 @@
>  004 db auto quick
>  005 auto quick
>  007 auto quota quick
> +006 auto quick unmount

I don't see the value to add a new "unmount" group.

Thanks,
Eryu

>  008 rw ioctl auto quick
>  009 rw ioctl auto prealloc quick
>  010 auto quick repair
> -- 
> 2.5.5
> 
