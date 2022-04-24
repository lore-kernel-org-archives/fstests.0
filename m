Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E93C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Apr 2022 12:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiDXMFR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Apr 2022 08:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiDXMFQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Apr 2022 08:05:16 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA437B87C
        for <fstests@vger.kernel.org>; Sun, 24 Apr 2022 05:02:15 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id bz24so8633607qtb.2
        for <fstests@vger.kernel.org>; Sun, 24 Apr 2022 05:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASFxX18Rlte5C3sOGlwJSvdnFJMP2MBrblRoKjzk+lg=;
        b=SoeQoZwzvs+xo1QK0Yp7rHwm/4QACmu7RqndAJXBZQ/wKNo79vTnIfCQjLUz2knmjb
         CMeqSMOH0V1OYg03fVwNFtK9OYvSc+y9nvhaKhs/6ImadoAMk8sC2aVDDGlXvgPyDC5a
         JimAgMzJj1yW3Tl9cxmzN0c0eJIXBEC9Jj9343lKa/beMgzbI+BfiU3sPn3/Xc93XTmU
         8UJobG+4NJO0jakCtKUbpQyBF4y0fMpUOnP51MmKMAB/mBw0YpZfdlYXxEkMyRV4ieAx
         Z5RyLNGUorZjw4LEfFvl/ljGHDKCK0yv8aRDeb9RJpF/iimeMaSMkiZJCDjdYQm6RK1g
         sp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASFxX18Rlte5C3sOGlwJSvdnFJMP2MBrblRoKjzk+lg=;
        b=SBpz/SFcwO047ESNzg+ZTiPcrvnkEY9TNPL2UWwqY0bsqjyEiIi//NCIRDRAcm8E4k
         W53kUqOYxK3QYOKezCuxQBpJqg5b0mWUWo1i3hlgrDtExL/aJOsjku48olhkhAHaHBCH
         hJnutG5pO9EnzIkWZJyggW5GSpnh/+d+T8qO/mzcGiaYhpEbMx3iP3/zReQPdq5Ul0zW
         mL4h+8Qk0gPiYKCBjIKGBXdeSgjwWxANDLA4Nvd6EikiViHqlTXnhekxvH/GzT/jUqL+
         CavKVRRDn5/z7NHPIRKBNZmVCsvFAQ7DANr+7JTH1/qZjWaIEeoH64FWadjarKFgrB6F
         Sicw==
X-Gm-Message-State: AOAM533E/A7A0+brOBvp1K2u5w8V/nbxbYGJBWOn98/T5j8mFWfPN6K1
        k+2sdISRa1CO94jByauYC/jo1FQ5qLdjEJF65ng=
X-Google-Smtp-Source: ABdhPJylaGAGe9C7agP7FvSxD+aSOgUxawApsB3Wy08IAkj7qICdJMr/cL7NfUZC5XmC4ORGgsC+iXe1olkqOuYpoUw=
X-Received: by 2002:ac8:5a4f:0:b0:2ed:d39b:5264 with SMTP id
 o15-20020ac85a4f000000b002edd39b5264mr8768195qta.477.1650801734877; Sun, 24
 Apr 2022 05:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220424063751.1067376-1-libaokun1@huawei.com>
In-Reply-To: <20220424063751.1067376-1-libaokun1@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 24 Apr 2022 15:02:03 +0300
Message-ID: <CAOQ4uxgEXEgZ-uAYgiJi1sxX9Zzmg25NewBRiRQR6D8z+qOXHA@mail.gmail.com>
Subject: Re: [RFC] common: overlay support tmpfs
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Zorro Lang <zlang@redhat.com>, Eryu Guan <guaneryu@gmail.com>,
        fstests <fstests@vger.kernel.org>, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Apr 24, 2022 at 2:21 PM Baokun Li <libaokun1@huawei.com> wrote:
>
> xfstests support overlay+tmpfs

Thanks for this improvement.
Can you please share the results of ./check -overlay -g auto ?

How many tests ran? notran? failed?

Best if you have those numbers compared to
overlay+(already supported base fs)


>
> ```local.config.example
> export FSTYP=tmpfs
> export TEST_DEV=tmpfs_test
> export TEST_DIR=/tmp/test
> export TEST_FS_MOUNT_OPTS="-t tmpfs"
> export SCRATCH_DEV=tmpfs_scratch
> export SCRATCH_MNT=/tmp/scratch
> export MOUNT_OPTIONS="-t tmpfs"

These mount options for tmpfs are very awkward.
Please fix _overlay_base_mount to use -t $OVL_BASE_FSTYP
like _test_mount() and _try_scratch_mount() do


> ```
> Run `./check -overlay tests` to execute test case on overlay+tmpfs.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  common/config | 4 ++--
>  common/rc     | 7 ++++++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/common/config b/common/config
> index 1033b890..3dc047e8 100644
> --- a/common/config
> +++ b/common/config
> @@ -614,7 +614,7 @@ _overlay_config_override()
>         #    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
>         #    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
>         #    overlayfs base and mount dirs inside base fs mount.
> -       [ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
> +       [ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || [ "$FSTYP" == tmpfs ] || return 0
>
>         # Config file may specify base fs type, but we obay -overlay flag
>         [ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"

Please move the setting of OVL_BASE_FSTYP to the top of the function and use
[ "$OVL_BASE_FSTYP" == tmpfs ] consistently.

> @@ -634,7 +634,7 @@ _overlay_config_override()
>         export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
>         export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
>
> -       [ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
> +       [ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || [ "$OVL_BASE_FSTYP" == tmpfs ] || return 0
>
>         # Store original base fs vars
>         export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
> diff --git a/common/rc b/common/rc
> index 553ae350..12498189 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -834,13 +834,18 @@ _scratch_mkfs()
>         local mkfs_status
>
>         case $FSTYP in
> -       nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|virtiofs)
> +       nfs*|cifs|ceph|glusterfs|pvfs2|9p|virtiofs)
>                 # unable to re-create this fstyp, just remove all files in
>                 # $SCRATCH_MNT to avoid EEXIST caused by the leftover files
>                 # created in previous runs
>                 _scratch_cleanup_files
>                 return $?
>                 ;;
> +       overlay)
> +               [ ! "$OVL_BASE_FSTYP" == tmpfs ] || return 0
> +               _scratch_cleanup_files
> +               return $?
> +               ;;

Why? What's the problem with cleaning the ovl-* layers on tmpfs?


Thanks,
Amir.
