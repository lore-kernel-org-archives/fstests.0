Received: from mail-yb1-f193.google.com ([209.85.219.193]:39077 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJRMyM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Oct 2018 08:54:12 -0400
Received: by mail-yb1-f193.google.com with SMTP id j193-v6so76730ybj.6
        for <fstests@vger.kernel.org>; Wed, 17 Oct 2018 21:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181016074559.24728-1-yi.zhang@huawei.com> <20181016074559.24728-2-yi.zhang@huawei.com>
In-Reply-To: <20181016074559.24728-2-yi.zhang@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 18 Oct 2018 07:54:54 +0300
Message-ID: <CAOQ4uxh+4QaFuv+hrbM+9W0pSUk=UQhULcSmZL0R7wC6u5Ophg@mail.gmail.com>
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

Let's put some naming rules into effect here.
Helper should be prefixed _overlay.
_run_* to me implies run_check() wrapper.
So what's a better descriptive name for this helper? I donno, maybe
_overlay_fsck_expect() ?

Thanks,
Amir.
