Received: from mail-yb0-f193.google.com ([209.85.213.193]:35591 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbeAYIAZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Jan 2018 03:00:25 -0500
MIME-Version: 1.0
In-Reply-To: <20180125063413.8720-2-yi.zhang@huawei.com>
References: <20180125063413.8720-1-yi.zhang@huawei.com> <20180125063413.8720-2-yi.zhang@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 25 Jan 2018 10:00:24 +0200
Message-ID: <CAOQ4uxhz49=tcue+iC1NqfFjzS=TiwrmoMu+M3RvdRdK2VVQBw@mail.gmail.com>
Subject: Re: [xfstests PATCH 1/4] overlay: add filesystem check helper
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: "zhangyi (F)" <yi.zhang@huawei.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>, overlayfs <linux-unionfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Miao Xie <miaoxie@huawei.com>, yangerkun@huawei.com
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 25, 2018 at 8:34 AM, zhangyi (F) <yi.zhang@huawei.com> wrote:
> Add filesystem check helper for the upcoming fsck.overlay utility.
> This helper invoke fsck.overlay to check and optionally repair
> underlying directories of overlay filesystem.
>
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  common/config  |  1 +
>  common/overlay | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/common/config b/common/config
> index 5f40413..71115bd 100644
> --- a/common/config
> +++ b/common/config
> @@ -236,6 +236,7 @@ case "$HOSTOS" in
>          export MKFS_REISER4_PROG="`set_prog_path mkfs.reiser4`"
>         export E2FSCK_PROG="`set_prog_path e2fsck`"
>         export TUNE2FS_PROG="`set_prog_path tune2fs`"
> +       export FSCK_OVERLAY_PROG="`set_prog_path fsck.overlay`"
>          ;;
>  esac
>
> diff --git a/common/overlay b/common/overlay
> index 1da4ab1..c19dabc 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -151,3 +151,17 @@ _require_scratch_overlay_feature()
>                 _notrun "${FSTYP} feature '${feature}' cannot be enabled on ${SCRATCH_DEV}"
>         _scratch_unmount
>  }
> +
> +# Helper function to check underlying dirs of overlay filesystem
> +_overlay_fsck_dirs()
> +{
> +       local lowerdir=$1
> +       local upperdir=$2
> +       local workdir=$3
> +       local options=$4
> +
> +       [[ ! -x "$FSCK_OVERLAY_PROG" ]] && return 0
> +
> +       $FSCK_OVERLAY_PROG -o lowerdir=$lowerdir -o upperdir=$upperdir \
> +                          -o workdir=$workdir $options

I guess current tests do not use more than a single "options", but for
robustness,
probably better to 'shift 3' and pass $* to fsck.overlay, just like
_overlay_mount_dirs.

Thanks,
Amir.
