Received: from mail-yw1-f68.google.com ([209.85.161.68]:43428 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504934AbfIXMdh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Sep 2019 08:33:37 -0400
MIME-Version: 1.0
References: <1569318025-36831-1-git-send-email-chengzhihao1@huawei.com>
In-Reply-To: <1569318025-36831-1-git-send-email-chengzhihao1@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Sep 2019 15:33:25 +0300
Message-ID: <CAOQ4uxhL_EZZ_ktv8RYpn-q2nDrA2v7kjv+b99a5ZKg3tmEQ8A@mail.gmail.com>
Subject: Re: [PATCH xfstests] overlay: Enable character device to be the base
 fs partition
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Eryu Guan <guaneryu@gmail.com>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>, "zhangyi (F)" <yi.zhang@huawei.com>, fstests <fstests@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 24, 2019 at 12:34 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> When running overlay tests using character devices as base fs partitions,
> all overlay usecase results become 'notrun'. Function
> '_overay_config_override' (common/config) detects that the current base
> fs partition is not a block device and will set FSTYP to base fs. The
> overlay usecase will check the current FSTYP, and if it is not 'overlay'
> or 'generic', it will skip the execution.
>
> For example, using UBIFS as base fs skips all overlay usecases:
>
>   FSTYP         -- ubifs       # FSTYP should be overridden as 'overlay'
>   MKFS_OPTIONS  -- /dev/ubi0_1 # Character device
>   MOUNT_OPTIONS -- -t ubifs /dev/ubi0_1 /tmp/scratch
>
>   overlay/001   [not run] not suitable for this filesystem type: ubifs
>   overlay/002   [not run] not suitable for this filesystem type: ubifs
>   overlay/003   [not run] not suitable for this filesystem type: ubifs
>   ...
>
> When checking that the base fs partition is a block/character device,
> FSTYP is overwritten as 'overlay'. This patch allows the base fs
> partition to be a character device that can also execute overlay
> usecases (such as ubifs).
>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  common/config | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/common/config b/common/config
> index 4c86a49..a22acdb 100644
> --- a/common/config
> +++ b/common/config
> @@ -550,7 +550,7 @@ _overlay_config_override()
>         #    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
>         #    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
>         #    overlayfs base and mount dirs inside base fs mount.
> -       [ -b "$TEST_DEV" ] || return 0
> +       [ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
>
>         # Config file may specify base fs type, but we obay -overlay flag
>         [ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
> @@ -570,7 +570,7 @@ _overlay_config_override()
>         export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
>         export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
>
> -       [ -b "$SCRATCH_DEV" ] || return 0
> +       [ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
>
>         # Store original base fs vars
>         export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
> --
> 2.7.4
>

Looks fine.

One nit: there is a message in _require_scratch_shutdown():
_notrun "$SCRATCH_DEV is not a block device"
for when $OVL_BASE_SCRATCH_DEV is not defined.

Could probably use a better describing error anyway.

Thanks,
Amir.
