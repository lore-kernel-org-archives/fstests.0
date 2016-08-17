Received: from mx1.redhat.com ([209.132.183.28]:39562 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbcHQKPf (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 17 Aug 2016 06:15:35 -0400
Date: Wed, 17 Aug 2016 18:14:59 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] ext4/023: add regression test for ext4lazyinit_task
 deadlock V2
Message-ID: <20160817101459.GV27776@eguan.usersys.redhat.com>
References: <1471263727-25943-1-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1471263727-25943-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 15, 2016 at 04:22:07PM +0400, Dmitry Monakhov wrote:
> global ext4lazyinit task may deadlock on frozen under li_list_mtx lock.
> Once that happen all mount/umount tasks also blocked.
> Patch proposed: http://marc.info/?l=linux-ext4&m=146893382329138
> 
> changes since V1:
>  - Fix coding style according to eguan's comments
>  - Add deadlock timout, so test failure will not block other tests.
> 
> 
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
> ---
>  tests/ext4/023     | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/023.out |  2 ++
>  tests/ext4/group   |  1 +
>  3 files changed, 98 insertions(+)
>  create mode 100755 tests/ext4/023
>  create mode 100644 tests/ext4/023.out
> 
> diff --git a/tests/ext4/023 b/tests/ext4/023
> new file mode 100755
> index 0000000..0f60490
> --- /dev/null
> +++ b/tests/ext4/023
> @@ -0,0 +1,95 @@
> +#! /bin/bash
> +# FS QA Test No. ext4/023
> +#
> +# Regression test for deadlock in ext4lazyinit thread
> +# Patch proposed: http://marc.info/?l=linux-ext4&m=146893382329138
> +# TODO: Add commit ID
> +#
> +#
> +#-----------------------------------------------------------------------
> +# (c) Dmitry Monakhov
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#-----------------------------------------------------------------------
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +status=1
> +_cleanup()
> +{
> +    # Failure cleanup
> +    if [ $status -ne 0 ]; then
> +	xfs_freeze -u $loop_mnt/1
> +	$UMOUNT_PROG $loop_mnt/2

I hit $loop_mnt/2 not properly unmounted in failure case, I think that's
because test hit "mount: deadlock detected. Fail" and $loop_mnt/2 was
not mounted yet right after unfreezing $loop_mnt/1 in cleanup.

[root@dhcp-66-86-11 xfstests]# diff -u tests/ext4/023.out /root/workspace/xfstests/results//ext4_4k/ext4/023.out.bad
--- tests/ext4/023.out  2016-08-17 17:08:53.702000000 +0800
+++ /root/workspace/xfstests/results//ext4_4k/ext4/023.out.bad  2016-08-17 18:05:30.164000000 +0800
@@ -1,2 +1,10 @@
 QA output created by 023
 Silence is golden
+./tests/ext4/023: line 86: 10983 Killed                  timeout -s SIGKILL 10 $MOUNT_PROG $loop_dev2 $loop_mnt/2
+mount: deadlock detected. Fail
+(see /root/workspace/xfstests/results//ext4_4k/ext4/023.full for details)
+umount: /mnt/testarea/scratch/023.mnt/2: not mounted
+rm: cannot remove '/mnt/testarea/scratch/023.mnt/2': Device or resource busy
+umount: /mnt/testarea/scratch: target is busy.
+        (In some cases useful info about processes that use
+         the device is found by lsof(8) or fuser(1))

And this failure prevents subsequent tests from running, because
$SCRATCH_DEV is busy.

Adding "sleep 1" before "$UMOUNT_PROG $loop_mnt/2" works for me, but
that's more like a workaround.

> +    fi
> +    
> +    # Normal cleanup
> +    $UMOUNT_PROG $loop_mnt/1
> +    _destroy_loop_device $loop_dev1
> +    _destroy_loop_device $loop_dev2
> +    rm -rf $img_dir $loop_mnt
> +    _scratch_unmount
> +    cd /
> +    #rm -f $tmp.*

This line should be uncommented.

And tab and space are mixed, please use tab for indention.

> +
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs ext4
> +_supported_os Linux
> +_require_scratch
> +_require_loop
> +_require_freeze
> +_require_xfs_io_command "falloc"
> +
> +rm -f $seqres.full
> +echo "Silence is golden"
> +
> +img_dir=$SCRATCH_MNT/$seq.fs
> +loop_mnt=$SCRATCH_MNT/$seq.mnt
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +mkdir -p $img_dir
> +mkdir -p $loop_mnt/{1,2}
> +
> +$XFS_IO_PROG -fc "truncate 1G" $img_dir/1.img
> +$XFS_IO_PROG -fc "truncate 1G" $img_dir/2.img
> +loop_dev1=$(_create_loop_device $img_dir/1.img)
> +loop_dev2=$(_create_loop_device $img_dir/2.img)
> +
> +# Use nodiscard mode in order to force lazy init mode
> +$MKFS_EXT4_PROG -F -E nodiscard,lazy_itable_init=1 $loop_dev1 \
> +    >> $seqres.full 2>&1
> +$MKFS_EXT4_PROG -F -E nodiscard,lazy_itable_init=1 $loop_dev2 \
> +    >> $seqres.full 2>&1
> +
> +# Freeze first fs and check that we may mount/umount second one.
> +# If bug is not fixed mount/umount may deadlock
> +_mount $loop_dev1 $loop_mnt/1
> +xfs_freeze -f $loop_mnt/1
> +for i in $(seq 0 5); do
> +    timeout -s SIGKILL 10 $MOUNT_PROG $loop_dev2 $loop_mnt/2 || \

Need test the existence of command timeout, e.g.

in common/config:
export TIMEOUT_PROG="`set_prog_path timeout`"

and in test:
_require_command "$TIMEOUT_PROG" timeout

Thanks,
Eryu

> +	_fail "mount: deadlock detected. Fail"
> +    sleep 1
> +    timeout -s SIGKILL 10 $UMOUNT_PROG $loop_mnt/2 || \
> +	_fail "umount: deadlock detected. Fail"
> +    sleep 1
> +done
> +xfs_freeze -u $loop_mnt/1
> +status=0
> +exit
> diff --git a/tests/ext4/023.out b/tests/ext4/023.out
> new file mode 100644
> index 0000000..5c4197b
> --- /dev/null
> +++ b/tests/ext4/023.out
> @@ -0,0 +1,2 @@
> +QA output created by 023
> +Silence is golden
> diff --git a/tests/ext4/group b/tests/ext4/group
> index e0772ab..6ccc5e8 100644
> --- a/tests/ext4/group
> +++ b/tests/ext4/group
> @@ -25,6 +25,7 @@
>  020 auto quick ioctl rw
>  021 auto quick
>  022 auto quick attr dangerous
> +023 auto quick
>  271 auto rw quick
>  301 aio auto ioctl rw stress
>  302 aio auto ioctl rw stress
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
