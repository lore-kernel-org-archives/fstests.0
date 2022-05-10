Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12ADC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 10 May 2022 07:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbiEJHz1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 May 2022 03:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237321AbiEJHzX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 May 2022 03:55:23 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF901B3B94
        for <fstests@vger.kernel.org>; Tue, 10 May 2022 00:51:25 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t16so12964440qtr.9
        for <fstests@vger.kernel.org>; Tue, 10 May 2022 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m05a9U4eSLQ2Dg6X6bLY+uTUMxtlZMjRpY+Z31IhRHE=;
        b=ZSJswyk6F9sbuIape2dG1p6m9j0Ln9RkS/Q8gtJHW48u+TIk4IGBPEO62i79uitWQa
         2pfB3hqBzyVXx1ji6K16awEcpJe09Ht/wzpiwXzTjCEoJgi1jFPXZtiWDLogkgP5VPJY
         9TCnvRl9A0q6dhygK6Lw0gNa6Il+arYXAY5BjCrNNS1MnhmwpLgIywVlG7K3N/8AL+7I
         VavPTpvxXI9dQ6QM/sTNQTmYH4obaYPa8DZf6TLAR5AwmjXseQuBYi3Ej/hDOWXkWHGc
         xfjAy8Qn2F8uozJMyg8l9KdZSSBFqkyU3A47rhDpO8/m281KqEs3JpQqHxuTUlBUCyvd
         Lwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m05a9U4eSLQ2Dg6X6bLY+uTUMxtlZMjRpY+Z31IhRHE=;
        b=z1yQWW/tSYywcfMJ9fb/VDYAEIUqS2vAxf8VB63SU7e9Pu3Ulh9hJMHnB8y9xzdP3s
         M94cdvuPp29ICS2+e/p0PEkaDcI3rZO3EMzHjd3ItFOSQkTpmhjLbqcgYNAXXUcJsVWC
         AVCDzK0bMuRSTh7I9mKFfZlyNwvrgonpsIFTsMmpfEl07ja/5PyKYVFly5u1M8++Ww7g
         9jIWtVb9gwpboPsfPVbkQV0SpTEctDjPue93aVvh25P+Joo3+/8nFZoKpG1jGChhg3P4
         zx8r0C80nVH8zkcQgbaxmdu0+OWJ3M6L8eKGsYlUm8y9o+kCf4doXZIi9WPiNrTaUzPk
         ljBg==
X-Gm-Message-State: AOAM530uqyBxMgQarnyeFxPwc1HWUH9Ayc8fLxj/J/JAnW8nJXVS+lEX
        E1zPoFTjZftlNdOVyAwQzGlgABlreKykUvW3aavv4zEXQns=
X-Google-Smtp-Source: ABdhPJyXnqSZa2A7DIk5X5aiV+n2PIb8asBVcFKzOlkdKPFNoKSU1CzP8dFrrDo9vlyBJc7+qz3JLnGmlVqrDt2zuV8=
X-Received: by 2002:ac8:4e46:0:b0:2e1:b933:ec06 with SMTP id
 e6-20020ac84e46000000b002e1b933ec06mr19066206qtw.684.1652169084846; Tue, 10
 May 2022 00:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220510020434.2561224-1-libaokun1@huawei.com>
In-Reply-To: <20220510020434.2561224-1-libaokun1@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 10 May 2022 10:51:12 +0300
Message-ID: <CAOQ4uxhTzqvuD5=5c4O_fhzV9CrHSpipegjUiETgCbNTkdvpvA@mail.gmail.com>
Subject: Re: [RFC v3] common: xfstests support overlay+tmpfs
To:     Baokun Li <libaokun1@huawei.com>
Cc:     fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 10, 2022 at 4:50 AM Baokun Li <libaokun1@huawei.com> wrote:
>
> The local.config of overlay+tmpfs is as follows:
> ```local.config.example
> export FSTYP=tmpfs
> export TEST_DEV=tmpfs_test
> export TEST_DIR=/tmp/test
> export SCRATCH_DEV=tmpfs_scratch
> export SCRATCH_MNT=/tmp/scratch
> ```
>
> Run `./check -overlay tests` to execute test case on overlay+tmpfs.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
>         Fix the bug in version V1 and fix the issue in cycle_mount.
> V2->V3:
>         Merge two patches into one completed patch.
>
> V1: https://patchwork.kernel.org/project/fstests/patch/20220424063751.1067376-1-libaokun1@huawei.com/
> V2: https://patchwork.kernel.org/project/fstests/cover/20220507094524.949615-1-libaokun1@huawei.com/
>
>  common/config  | 12 ++++++------
>  common/overlay |  2 +-
>  common/rc      | 31 ++++++++++++++++++++++++-------
>  3 files changed, 31 insertions(+), 14 deletions(-)
>
> diff --git a/common/config b/common/config
> index 1033b890..d5953176 100644
> --- a/common/config
> +++ b/common/config
> @@ -610,15 +610,15 @@ _overlay_config_override()
>         [ ! -d "$TEST_DEV" ] || export OVL_BASE_TEST_DIR="$TEST_DEV"
>         [ ! -d "$SCRATCH_DEV" ] || export OVL_BASE_SCRATCH_MNT="$SCRATCH_DEV"
>
> +       # Config file may specify base fs type, but we obay -overlay flag
> +       [ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
> +       export FSTYP=overlay
> +
>         # 2. SCRATCH/TEST_DEV point to the base fs partitions.  In this case,
>         #    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
>         #    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
>         #    overlayfs base and mount dirs inside base fs mount.
> -       [ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
> -
> -       # Config file may specify base fs type, but we obay -overlay flag
> -       [ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
> -       export FSTYP=overlay
> +       [ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || [ "$OVL_BASE_FSTYP" == tmpfs ] || return 0
>
>         # Store original base fs vars
>         export OVL_BASE_TEST_DEV="$TEST_DEV"
> @@ -634,7 +634,7 @@ _overlay_config_override()
>         export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
>         export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
>
> -       [ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
> +       [ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || [ "$OVL_BASE_FSTYP" == tmpfs ] || return 0
>
>         # Store original base fs vars
>         export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
> diff --git a/common/overlay b/common/overlay
> index fff67ba1..c4e7ee58 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -81,7 +81,7 @@ _overlay_base_mount()
>                 return 1
>         fi
>
> -       _mount $* $dev $mnt
> +       _mount -t $OVL_BASE_FSTYP $* $dev $mnt
>         _idmapped_mount $dev $mnt
>  }
>
> diff --git a/common/rc b/common/rc
> index 553ae350..ca465438 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -410,10 +410,19 @@ _scratch_cycle_mount()
>  {
>      local opts="$1"
>
> -    if [ "$FSTYP" = tmpfs ]; then
> -       _scratch_remount "$opts"
> -       return
> -    fi
> +       case "$FSTYP" in
> +       tmpfs)
> +               _scratch_remount "$opts"
> +               return
> +               ;;
> +       overlay)
> +               if [ "$OVL_BASE_FSTYP" = tmpfs ]; then
> +                       _scratch_remount "$opts"


That doesn't look right.
_scrtach_cycle_mount is important for several overlay tests and there
is no reason to
skip it if base fs is tmpfs.
What you need to do is cycle mount the overlay without cycle mounting
the base fs.
You could do something like this:

  local unmounted
...

  overlay)
               if [ "$OVL_BASE_FSTYP" = tmpfs ]; then
                         $UMOUNT_PROG $SCRATCH_MNT
                         unmounted=true
               fi
               ;;
   esac
...
    [ "$unmounted" = true ] || _scratch_unmount
    _try_scratch_mount "$opts" || _fail "cycle mount failed"
}

There are some overlay tests that open code this pattern like overlay/077:

# Remove the lower directory and mount overlay again to create
# a "former merge dir"
$UMOUNT_PROG $SCRATCH_MNT
rm -rf $lowerdir/former
_scratch_mount

So _scratch_mount is expected to work just fine when base fs is already mounted
assuming that _check_mounted_on works correctly with tmpfs.

Thanks,
Amir.
