Received: from mail-yb1-f193.google.com ([209.85.219.193]:37917 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeJPRfG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Oct 2018 13:35:06 -0400
Received: by mail-yb1-f193.google.com with SMTP id e190-v6so8636771ybb.5
        for <fstests@vger.kernel.org>; Tue, 16 Oct 2018 02:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181016074559.24728-1-yi.zhang@huawei.com> <20181016074559.24728-2-yi.zhang@huawei.com>
In-Reply-To: <20181016074559.24728-2-yi.zhang@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Oct 2018 12:45:18 +0300
Message-ID: <CAOQ4uxh8YWXprDPp1H6Si+L1QXBwcTp1+P78MqYZD5wMzuJopg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] overlay: correct fsck.overlay exit code
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: "zhangyi (F)" <yi.zhang@huawei.com>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Miao Xie <miaoxie@huawei.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Oct 16, 2018 at 10:32 AM zhangyi (F) <yi.zhang@huawei.com> wrote:
>
> fsck.overlay should return correct exit code to show the file system
> status after fsck, instead of return 0 means consistency and !0 means
> inconsistency or something bad happened.
>
> Fix the following three exit code after running fsck.overlay:
>
> - Return FSCK_OK if the input file system is consistent,
> - Return FSCK_NONDESTRUCT if the file system inconsistent errors
>   corrected,
> - Return FSCK_UNCORRECTED if the file system still have inconsistent
>   errors.
>
> This patch also add a helper function to run fsck.overlay and check
> the return value is expected or not.
>
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> ---
>  common/overlay    | 29 +++++++++++++++++++++++++++++
>  tests/overlay/045 | 27 +++++++++------------------
>  tests/overlay/046 | 36 ++++++++++++------------------------
>  tests/overlay/056 |  9 +++------
>  4 files changed, 53 insertions(+), 48 deletions(-)
>
> diff --git a/common/overlay b/common/overlay
> index b526f24..4cc2829 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -12,6 +12,16 @@ export OVL_XATTR_NLINK="trusted.overlay.nlink"
>  export OVL_XATTR_UPPER="trusted.overlay.upper"
>  export OVL_XATTR_METACOPY="trusted.overlay.metacopy"
>
> +# Export exit code used by fsck.overlay program
> +export FSCK_OK=0
> +export FSCK_NONDESTRUCT=1
> +export FSCK_REBOOT=2
> +export FSCK_UNCORRECTED=4
> +export FSCK_ERROR=8
> +export FSCK_USAGE=16
> +export FSCK_CANCELED=32
> +export FSCK_LIBRARY=128
> +
>  # helper function to do the actual overlayfs mount operation
>  _overlay_mount_dirs()
>  {
> @@ -193,6 +203,25 @@ _overlay_fsck_dirs()
>                            -o workdir=$workdir $*
>  }
>
> +# Run fsck and check the return value
> +_run_check_fsck()
> +{
> +       # The first arguments is the expected fsck program exit code, the
> +       # remaining arguments are the input parameters of the fsck program.
> +       local expect_ret=$1
> +       local lowerdir=$2
> +       local upperdir=$3
> +       local workdir=$4
> +       shift 4
> +
> +       _overlay_fsck_dirs $lowerdir $upperdir $workdir $* >> \
> +                       $seqres.full 2>&1
> +       fsck_ret=$?
> +
> +       [[ "$fsck_ret" == "$expect_ret" ]] || \
> +               echo "fsck return unexpected value:$expect_ret,$fsck_ret"
> +}

Looks good.

Please consider the name _overlay_repair_dirs() with reference to
_repair_scratch_fs(), which is used for roughly the same purpose.

BTW, the tests generic/330 generic/332 when run with -overlay
over xfs with reflink support seem to call _repair_scratch_fs() which does:
        # Let's hope fsck -y suffices...
        fsck -t $FSTYP -y $SCRATCH_DEV 2>&1
        local res=$?
        case $res in
        0|1|2)
                res=0
                ;;
        *)
                _dump_err2 "fsck.$FSTYP failed, err=$res"

How come fsck.overlay is not complaining about missing arguments??

The rest of the generic tests that call _repair_scratch_fs() have
_require_dm_target() which _require_block_device(), so don't run with overlay.

If you do sort this out and add overlay support to
_repair_scratch_fs() its probably
worth replacing 0|1|2) with FSCK_ constants.

Thanks,
Amir.
