Received: from mx1.redhat.com ([209.132.183.28]:50170 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015AbcGUDV3 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 Jul 2016 23:21:29 -0400
Date: Thu, 21 Jul 2016 11:21:26 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] ext4/022: add regression test for ext4lazyinit_task
 deadlock
Message-ID: <20160721032126.GA27776@eguan.usersys.redhat.com>
References: <1468931005-774-1-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468931005-774-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 19, 2016 at 04:23:25PM +0400, Dmitry Monakhov wrote:
> global ext4lazyinit task may deadlock on frozen under li_list_mtx lock.
> Once that happen all mount/umount tasks also blocked.
> Patch pended.
> 
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
> ---
>  tests/ext4/022     | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/022.out |  2 ++
>  tests/ext4/group   |  1 +
>  3 files changed, 86 insertions(+)
>  create mode 100755 tests/ext4/022
>  create mode 100644 tests/ext4/022.out
> 
> diff --git a/tests/ext4/022 b/tests/ext4/022
> new file mode 100755
> index 0000000..1b9a33c
> --- /dev/null
> +++ b/tests/ext4/022
> @@ -0,0 +1,83 @@
> +#! /bin/bash
> +# FS QA Test No. ext4/022
> +#
> +# Regression test for:
> +# [TODO:ADD_COMMIT] ext4: improve ext4lazyinit scalability
> +# Check ext4lazyinit deadlock

Not sure if it's a valid test for ext4 yet, just add some comments from
fstests perspective of view.

> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2014 Fujitsu.  All Rights Reserved.

Wrong copyright?

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
> +    umount $loop_mnt/1

$UMOUNT_PROG

> +    _destroy_loop_device $loop_dev1
> +    _destroy_loop_device $loop_dev2
> +    if [ $status -eq 0 ]; then

I don't think this is needed, removing them unconditionally is ok to me.

> +	rm -rf $img_dir $loop_mnt
> +    fi
> +    _scratch_unmount

should remove $tmp.* in _cleanup: "rm -f $tmp.*"

And please use tab for indention, not spaces, nor mixed tab and spaces.

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
> +
> +rm -f $seqres.full
> +echo "Silence is golden"
> +
> +img_dir=$SCRATCH_MNT/$seq.fs
> +loop_mnt=$SCRATCH_MNT/$seq.mnt
> +_scratch_mkfs_xfs >> $seqres.full 2>&1

_scratch_mkfs ?

> +_scratch_mount
> +mkdir -p $img_dir
> +mkdir -p $loop_mnt/{1,2}
> +truncate -s 5G $img_dir/1.img
> +truncate -s 5G $img_dir/2.img

Use xfs_io to do truncate, old distributions like RHEL5 don't have
truncate binary, not a big issue at this moment, but we have better
choice, so why not :)

$XFS_IO_PROG -fc "truncate 5G" $img_dir/1.img

> +
> +loop_dev1=$(_create_loop_device $img_dir/1.img)
> +loop_dev2=$(_create_loop_device $img_dir/2.img)

Better to explain in comments why two loop devices are needed.

> +
> +# Use nodiscard mode in order to force lazy init mode
> +$MKFS_EXT4_PROG -F -E nodiscard,lazy_itable_init=1 $loop_dev1 \
> +    >> $seqres.full 2>&1
> +$MKFS_EXT4_PROG -F -E nodiscard,lazy_itable_init=1 $loop_dev2 \
> +    >> $seqres.full 2>&1
> +
> +_mount $loop_dev1 $loop_mnt/1
> +xfs_freeze -f $loop_mnt/1
> +#If bug is not fixed any mount/umount will be blocked
> +for i in $(seq 0 5)
> +do

fstests prefers this "for" format:

for i in $(seq 0 5); do
...
done

> +    _mount $loop_dev2 $loop_mnt/2
> +    sleep 1
> +    umount $loop_mnt/2
> +    sleep 1
> +done
> +xfs_freeze -u $loop_mnt/1
> +status=0
> +exit
> diff --git a/tests/ext4/022.out b/tests/ext4/022.out
> new file mode 100644
> index 0000000..394c6a7
> --- /dev/null
> +++ b/tests/ext4/022.out
> @@ -0,0 +1,2 @@
> +QA output created by 022
> +Silence is golden
> diff --git a/tests/ext4/group b/tests/ext4/group
> index bbdbe1d..f9d00b1 100644
> --- a/tests/ext4/group
> +++ b/tests/ext4/group
> @@ -24,6 +24,7 @@
>  019 fuzzers
>  020 auto quick ioctl rw
>  021 auto quick
> +022 auto quick

This test hangs latest 4.7-rc7 kernel, we can add it to 'dangerous'
group as well.

Thanks,
Eryu

>  271 auto rw quick
>  301 aio auto ioctl rw stress
>  302 aio auto ioctl rw stress
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
