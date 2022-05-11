Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3279BC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 11 May 2022 09:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243315AbiEKJHw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 May 2022 05:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241953AbiEKJHo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 May 2022 05:07:44 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA302CDDF
        for <fstests@vger.kernel.org>; Wed, 11 May 2022 02:07:23 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id k8so1806460qki.8
        for <fstests@vger.kernel.org>; Wed, 11 May 2022 02:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2kykbnpNgIwbWTfEBeG4L0EXqsPynHn1rW49k9y2R4=;
        b=puYTNXUWEPU0xV/v5XO1W2lq27zJUu/lyyqzRArZGEEc1KBt/oz3+qtqgV+2UmjI0g
         UXC0LRtthR7cRjqWLcdGVfbPwKMPkNqCfyAwNwQ+W8w8nhUeN8AsdiWj6eHyYV2ksb88
         vd6sIs/qF3KYmR0RTdoquM11umjipRbeK+7U/6Lh81DjEMwbby+/lYfsxCVVQfCgVJn5
         oJmqZxqRjtBbpiPlI5g4fLQnBn04pzaU6oM7TBc0iBKz1MdxtavTemTCAcnosZG6eKPj
         EtYEMmeeDvtOrRPqs5CauCLhMoAaoMD1N2r28ov1NEEfR6IbZ57bPryXhnCpGQfJ688T
         WMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2kykbnpNgIwbWTfEBeG4L0EXqsPynHn1rW49k9y2R4=;
        b=1zXVzxWrowzcojW+QjuECM9Ji00zsovReFCSRZMMib5ZEIVqqvjMppRV2YOf2f4WN6
         ZEh+ioZZof0LP1gHm53VFg9Zzgp2IJrwFWYkHwzzNyvblJazGspRYVBPIotg6pmasooj
         6lBca2/e6lDnSYzvIcL4BI7hcLrxh8Ogrt4N2nELacxCbINh1aakOh5TASg2/WOTHqb7
         j6Cxs1x8RwpkRYO27r8CZcg6ajeNS/rzASRntM3jMIBOHUR18bfuSCPOoC7CNx54k7WN
         sW+kdJhFlvXQS/fp3/JreyjbLADjRjsCYzYecSrQe4QxBwS3LzpaUez6v91lGC17D7fC
         BlaQ==
X-Gm-Message-State: AOAM53328cUEs1Fvh7kAI64MgqJ0DdnCSRGOqk+lYdDoepaHo2gXcua7
        czI8xv7OKK44I4jioIgR+VfSWrkANLdxxl1Qfuc=
X-Google-Smtp-Source: ABdhPJxfgjjkffUrruVh+3Om6Q/2FSC9hyjYtusJ/fBzWK7Rf/0GRacJop4fFgXiRf7oITc2ab4mZbaGraXary9e7N4=
X-Received: by 2002:a05:620a:2909:b0:6a0:472b:a30d with SMTP id
 m9-20020a05620a290900b006a0472ba30dmr17588955qkp.258.1652260042178; Wed, 11
 May 2022 02:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220511083404.3315147-1-libaokun1@huawei.com>
In-Reply-To: <20220511083404.3315147-1-libaokun1@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 11 May 2022 12:07:10 +0300
Message-ID: <CAOQ4uxh7TbkXHsaGA8Th5MQepsVfN_3L8nasiOK52aMeTwk_xg@mail.gmail.com>
Subject: Re: [RFC v4] common: xfstests support overlay+tmpfs
To:     Baokun Li <libaokun1@huawei.com>
Cc:     fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 11, 2022 at 11:20 AM Baokun Li <libaokun1@huawei.com> wrote:
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> V1->V2:
>         Fix the bug in version V1 and fix the issue in cycle_mount.
> V2->V3:
>         Merge two patches into one completed patch.
> V3->V4:
>         Cycle mount the overlay without cycle mounting the base fs.
>
> V1: https://patchwork.kernel.org/project/fstests/patch/20220424063751.1067376-1-libaokun1@huawei.com/
> V2: https://patchwork.kernel.org/project/fstests/cover/20220507094524.949615-1-libaokun1@huawei.com/
> V3: https://patchwork.kernel.org/project/fstests/patch/20220510020434.2561224-1-libaokun1@huawei.com/
>
>  common/config  | 12 ++++++------
>  common/overlay |  2 +-
>  common/rc      | 39 ++++++++++++++++++++++++++++++---------
>  3 files changed, 37 insertions(+), 16 deletions(-)
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
> index 553ae350..0d50cc22 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -409,15 +409,25 @@ _scratch_remount()
>  _scratch_cycle_mount()
>  {
>      local opts="$1"
> +    local unmounted
> +
> +    case "$FSTYP" in
> +    tmpfs)
> +        _scratch_remount "$opts"
> +        return
> +        ;;
> +    overlay)
> +        if [ "$OVL_BASE_FSTYP" = tmpfs ]; then
> +            $UMOUNT_PROG $SCRATCH_MNT
> +            unmounted=true
> +        fi
> +        ;;
> +    esac
>
> -    if [ "$FSTYP" = tmpfs ]; then
> -       _scratch_remount "$opts"
> -       return
> -    fi
>      if test -n "$opts"; then
>         opts="-o $opts"
>      fi
> -    _scratch_unmount
> +    [ "$unmounted" = true ] || _scratch_unmount
>      _try_scratch_mount "$opts" || _fail "cycle mount failed"
>  }
>
> @@ -522,10 +532,21 @@ _test_unmount()
>
>  _test_cycle_mount()
>  {
> -    if [ "$FSTYP" = tmpfs ]; then
> -       return
> -    fi
> -    _test_unmount
> +    local unmounted
> +
> +    case "$FSTYP" in
> +    tmpfs)
> +        return
> +        ;;
> +    overlay)
> +        if [ "$OVL_BASE_FSTYP" = tmpfs ]; then
> +            $UMOUNT_PROG $TEST_DIR
> +            unmounted=true
> +        fi
> +        ;;
> +    esac
> +
> +    [ "$unmounted" = true ] || _test_unmount
>      _test_mount
>  }
>
> --
> 2.31.1
>
