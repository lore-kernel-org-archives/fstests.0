Received: from mail-yw1-f67.google.com ([209.85.161.67]:45633 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437009AbfIYHSw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 Sep 2019 03:18:52 -0400
MIME-Version: 1.0
References: <1569393333-128141-1-git-send-email-chengzhihao1@huawei.com>
In-Reply-To: <1569393333-128141-1-git-send-email-chengzhihao1@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Sep 2019 10:18:39 +0300
Message-ID: <CAOQ4uxjfko0+G_BUOt=fL1iTXdnWA=-=Kn-bgszF08g7yj4zqQ@mail.gmail.com>
Subject: Re: [PATCH xfstests v3] overlay: Enable character device to be the
 base fs partition
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Eryu Guan <guaneryu@gmail.com>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>, "zhangyi (F)" <yi.zhang@huawei.com>, fstests <fstests@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 25, 2019 at 9:29 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
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
>
> When checking that the base fs partition is a block/character device,
> FSTYP is overwritten as 'overlay'. This patch allows the base fs
> partition to be a character device that can also execute overlay
> usecases (such as ubifs).
>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks fine.
Eryu, you may change this to Reviewed-by

> ---
>  common/config | 6 +++---
>  common/rc     | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/common/config b/common/config
> index 4c86a49..4eda36c 100644
> --- a/common/config
> +++ b/common/config
> @@ -532,7 +532,7 @@ _canonicalize_mountpoint()
>  # When SCRATCH/TEST_* vars are defined in evironment and not
>  # in config file, this function is called after vars have already
>  # been overriden in the previous test.
> -# In that case, TEST_DEV is a directory and not a blockdev and
> +# In that case, TEST_DEV is a directory and not a blockdev/chardev and
>  # the function will return without overriding the SCRATCH/TEST_* vars.
>  _overlay_config_override()
>  {
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
> diff --git a/common/rc b/common/rc
> index 66c7fd4..8d57c37 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3100,7 +3100,7 @@ _require_scratch_shutdown()
>                         # SCRATCH_DEV, in this case OVL_BASE_SCRATCH_DEV
>                         # will be null, so check OVL_BASE_SCRATCH_DEV before
>                         # running shutdown to avoid shutting down base fs accidently.
> -                       _notrun "$SCRATCH_DEV is not a block device"
> +                       _notrun "This test requires a valid $OVL_BASE_SCRATCH_DEV as ovl base fs"
>                 else
>                         src/godown -f $OVL_BASE_SCRATCH_MNT 2>&1 \
>                         || _notrun "Underlying filesystem does not support shutdown"
> --
> 2.7.4
>
