Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C00C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 26 May 2022 06:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346167AbiEZGjz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 26 May 2022 02:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiEZGjv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 May 2022 02:39:51 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCB3554A2
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 23:39:49 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id cv1so1048337qvb.5
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 23:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=heSudPdDEXNaxrOIhxC4jmIAtja2mGZmu06JCteb72Y=;
        b=oJ0c00gTk3FTbe17VqA03LltPdGsdakYTwluSsr6Ud8vIo8somklDaUkgYHm+6BJKh
         MQrTW7UtZQQC6vPP1r1cPHztlH4imCVNqUNHyvcSHS72G66gWjM9FVWgQtr2oSNz0vmI
         HgHxZ9UlAAvsx5sQJLg/5XD7XjIv7h9c1qnqtPPdcS18E4FReqjSoEZSifxV9uqSkfX1
         n5D9IbgMUSyzMNa+Uy6jDTrOb+WZg+hH7QmUwR1jw0elbA0Ez1a8+xVXN21R8pmY2eYH
         j9hd82ehAMoXsLfp89JpMu/MveCyDqX0/RGkHr7/ejnyh/kzT4hX+oCjb4ogN/bqKujE
         Ar5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=heSudPdDEXNaxrOIhxC4jmIAtja2mGZmu06JCteb72Y=;
        b=vc6GOSj7d4IKEu56vfi9ipYzbxSPQarX+Y6ZMRqR4lZx747eawc76cSc+kh6qoQO+u
         Gs6IoL1Tz2Epi1NBeUOPjDhJ8OyHE+K71iv1dfMAcyFVGsOHdfHt/JFs/geTpq9C+EtK
         wnixTQxUVupiSkV0D95zwXzvUoQqzKKyNlgQC3NNkQYAScXyq/+8NKB4H+/WraWf0jhZ
         dGMxrY3+T/Ob1KP7GjEOG1y/rh7n5GRAsn62rNdwLFUfXXQomsWYXp9Zukf3WPdm9I04
         n8D1dvrUsii8HAK8/yNktkw5zHUSJQfJhNhkGNBYN8eMEGuG0XXigsncavcgF+sjjLR3
         I/mQ==
X-Gm-Message-State: AOAM533Dyq/dwOTJ+m3DgQ/KXgYwc+YIVcN88lUZF3jzWiG6nQLIm8Y6
        tuj+a+8X+6VimCSFLp1xp05fDcQct2Uwx9YhDJWtl9w0bHA=
X-Google-Smtp-Source: ABdhPJxBj8wHNhHCTtNPZwcCuOf+sw0qfbCEzWfO1VCgYY235OR/7FCjP0r66lUOG6eucjApf/RFns+9WVL1E0pSgig=
X-Received: by 2002:a05:6214:1cc4:b0:435:35c3:f0f1 with SMTP id
 g4-20020a0562141cc400b0043535c3f0f1mr29182231qvd.0.1653547189063; Wed, 25 May
 2022 23:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220525073427.3355242-1-zlang@kernel.org> <20220525073427.3355242-2-zlang@kernel.org>
In-Reply-To: <20220525073427.3355242-2-zlang@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 26 May 2022 09:39:37 +0300
Message-ID: <CAOQ4uxidP_drarQsnX2kvHW=MfXjpLN--5B-cgXkG4401CfvgQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] common: source base fs specific common file
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 25, 2022 at 2:18 PM Zorro Lang <zlang@kernel.org> wrote:
>
> When tests overlayfs, sometimes we need the underlying fs specific
> helpers, e.g. common/rc has:
>   _filesystem_timestamp_range $OVL_BASE_TEST_DEV $OVL_BASE_FSTYP
>
> So when we source common/overlay, better to source OVL_BASE_FSTYP
> too.
>
> Signed-off-by: Zorro Lang <zlang@kernel.org>

Makes sense.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  common/config  | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  common/overlay |  4 ++++
>  common/rc      | 49 +----------------------------------------
>  3 files changed, 64 insertions(+), 48 deletions(-)
>
> diff --git a/common/config b/common/config
> index c6428f90..558f148b 100644
> --- a/common/config
> +++ b/common/config
> @@ -481,6 +481,65 @@ _fsck_opts()
>         esac
>  }
>
> +# check necessary running dependences then source sepcific fs helpers
> +_source_specific_fs()
> +{
> +       local fs=$1
> +
> +       if [ -z "$fs" ];then
> +               fs=$FSTYP
> +       fi
> +
> +       case "$fs" in
> +       xfs)
> +               [ "$XFS_LOGPRINT_PROG" = "" ] && _fatal "xfs_logprint not found"
> +               [ "$XFS_REPAIR_PROG" = "" ] && _fatal "xfs_repair not found"
> +               [ "$XFS_DB_PROG" = "" ] && _fatal "xfs_db not found"
> +               [ "$MKFS_XFS_PROG" = "" ] && _fatal "mkfs_xfs not found"
> +               [ "$XFS_INFO_PROG" = "" ] && _fatal "xfs_info not found"
> +
> +               . ./common/xfs
> +               ;;
> +       udf)
> +               [ "$MKFS_UDF_PROG" = "" ] && _fatal "mkfs_udf/mkudffs not found"
> +               ;;
> +       btrfs)
> +               [ "$MKFS_BTRFS_PROG" = "" ] && _fatal "mkfs.btrfs not found"
> +
> +               . ./common/btrfs
> +               ;;
> +       ext4)
> +               [ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
> +               ;;
> +       f2fs)
> +               [ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
> +               ;;
> +       nfs)
> +               . ./common/nfs
> +               ;;
> +       cifs)
> +               ;;
> +       9p)
> +               ;;
> +       ceph)
> +               . ./common/ceph
> +               ;;
> +       glusterfs)
> +               ;;
> +       overlay)
> +               . ./common/overlay
> +               ;;
> +       reiser4)
> +               [ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
> +               ;;
> +       pvfs2)
> +               ;;
> +       ubifs)
> +               [ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
> +               ;;
> +       esac
> +}
> +
>  known_hosts()
>  {
>         [ "$HOST_CONFIG_DIR" ] || HOST_CONFIG_DIR=`pwd`/configs
> diff --git a/common/overlay b/common/overlay
> index c4e7ee58..e35419d0 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -12,6 +12,10 @@ export OVL_XATTR_NLINK="trusted.overlay.nlink"
>  export OVL_XATTR_UPPER="trusted.overlay.upper"
>  export OVL_XATTR_METACOPY="trusted.overlay.metacopy"
>
> +if [ -n "$OVL_BASE_FSTYP" ];then
> +       _source_specific_fs $OVL_BASE_FSTYP
> +fi
> +
>  # helper function to do the actual overlayfs mount operation
>  _overlay_mount_dirs()
>  {
> diff --git a/common/rc b/common/rc
> index 70a15f9c..2f31ca46 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -96,54 +96,7 @@ _log_err()
>  umask 022
>
>  # check for correct setup and source the $FSTYP specific functions now
> -case "$FSTYP" in
> -    xfs)
> -        [ "$XFS_LOGPRINT_PROG" = "" ] && _fatal "xfs_logprint not found"
> -        [ "$XFS_REPAIR_PROG" = "" ] && _fatal "xfs_repair not found"
> -        [ "$XFS_DB_PROG" = "" ] && _fatal "xfs_db not found"
> -        [ "$MKFS_XFS_PROG" = "" ] && _fatal "mkfs_xfs not found"
> -        [ "$XFS_INFO_PROG" = "" ] && _fatal "xfs_info not found"
> -
> -        . ./common/xfs
> -        ;;
> -    udf)
> -        [ "$MKFS_UDF_PROG" = "" ] && _fatal "mkfs_udf/mkudffs not found"
> -        ;;
> -    btrfs)
> -        [ "$MKFS_BTRFS_PROG" = "" ] && _fatal "mkfs.btrfs not found"
> -
> -        . ./common/btrfs
> -        ;;
> -    ext4)
> -        [ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
> -        ;;
> -    f2fs)
> -        [ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
> -        ;;
> -    nfs)
> -        . ./common/nfs
> -        ;;
> -    cifs)
> -        ;;
> -    9p)
> -        ;;
> -    ceph)
> -        . ./common/ceph
> -        ;;
> -    glusterfs)
> -        ;;
> -    overlay)
> -        . ./common/overlay
> -        ;;
> -    reiser4)
> -        [ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
> -        ;;
> -    pvfs2)
> -       ;;
> -    ubifs)
> -       [ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
> -       ;;
> -esac
> +_source_specific_fs $FSTYP
>
>  if [ ! -z "$REPORT_LIST" ]; then
>         . ./common/report
> --
> 2.31.1
>
