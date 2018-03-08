Received: from mail-vk0-f66.google.com ([209.85.213.66]:46621 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeCHKHf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Mar 2018 05:07:35 -0500
MIME-Version: 1.0
Reply-To: fdmanana@gmail.com
In-Reply-To: <20180307235910.12313-1-bo.li.liu@oracle.com>
References: <20180307235910.12313-1-bo.li.liu@oracle.com>
From: Filipe Manana <fdmanana@gmail.com>
Date: Thu, 8 Mar 2018 10:07:33 +0000
Message-ID: <CAL3q7H70wYaBEZgWxcko-3qVfGfG8aFNym5=2Wb8xcszcb3YaA@mail.gmail.com>
Subject: Re: [PATCH] fstests: test regression of -EEXIST on creating new file
 after log replay
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: Liu Bo <bo.li.liu@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 7, 2018 at 11:59 PM, Liu Bo <bo.li.liu@oracle.com> wrote:
> The regression is introduced to btrfs in linux v4.4 and it refuses to cre=
ate
> new files after log replay by returning -EEXIST.
>
> Although the problem is on btrfs only, there is no btrfs stuff in terms o=
f
> test, so this makes it generic.
>
> The kernel fix is
>   Btrfs: fix unexpected -EEXIST when creating new inode
>
> Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
> ---
>  tests/generic/481     | 75 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/generic/481.out |  5 ++++
>  tests/generic/group   |  1 +
>  3 files changed, 81 insertions(+)
>  create mode 100755 tests/generic/481
>  create mode 100644 tests/generic/481.out
>
> diff --git a/tests/generic/481 b/tests/generic/481
> new file mode 100755
> index 0000000..8d8bb2b
> --- /dev/null
> +++ b/tests/generic/481
> @@ -0,0 +1,75 @@
> +#! /bin/bash
> +# FSQA Test No. 481
> +#
> +# Reproduce a regression of btrfs that leads to -EEXIST on creating new =
files
> +# after log replay.
> +#
> +# The kernel fix is
> +#   Btrfs: fix unexpected -EEXIST when creating new inode
> +#
> +#-----------------------------------------------------------------------
> +#
> +# Copyright (C) 2018 Oracle. All Rights Reserved.
> +# Author: Bo Liu <bo.li.liu@oracle.com>
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
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +tmp=3D/tmp/$$
> +status=3D1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       _cleanup_flakey
> +       cd /
> +       rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmflakey
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_dm_target flakey
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_init_flakey
> +_mount_flakey
> +
> +# create a file and keep it in write ahead log
> +$XFS_IO_PROG -f -c "pwrite 0 4k" -c "fsync" $SCRATCH_MNT/foo | _filter_x=
fs_io

What's the point of writing data to the file if we later don't check
that the data is there (and the file size is 4K)?
To trigger the bug in btrfs, it was also not needed to write data to
the file in the first place.

Other then that looks good.
Thanks for doing this.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +
> +# fail this filesystem so that remount can replay the write ahead log
> +_flakey_drop_and_remount
> +
> +# see if we can create a new file successfully
> +touch $SCRATCH_MNT/bar
> +
> +_unmount_flakey
> +
> +echo "Silence is golden"
> +
> +status=3D0
> +exit
> diff --git a/tests/generic/481.out b/tests/generic/481.out
> new file mode 100644
> index 0000000..66a6345
> --- /dev/null
> +++ b/tests/generic/481.out
> @@ -0,0 +1,5 @@
> +QA output created by 481
> +wrote 4096/4096 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +touch: cannot touch '/mnt/scratch/bar': File exists
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index ea2056b..05f60f2 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -483,3 +483,4 @@
>  478 auto quick
>  479 auto quick metadata
>  480 auto quick metadata
> +481 auto quick
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
