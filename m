Return-Path: <SRS0=rSMp=4C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DACC35242
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 22:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573122168B
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Feb 2020 22:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/2sH7Id"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgBNWMd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:12:33 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40283 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgBNWMd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Feb 2020 17:12:33 -0500
Received: by mail-io1-f67.google.com with SMTP id x1so779767iop.7
        for <fstests@vger.kernel.org>; Fri, 14 Feb 2020 14:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YxVwv68AbS6pq98P8gJ+sfpihg1L5cx43Oy9Q1g/ERc=;
        b=P/2sH7Id6x6yKD0ODkxZ5FMNsN2NGXwmdWZ0ZueG3qRw5acN7UvEzqm+trLyhHbfdQ
         +HA5EeyMykmeT6h15HkTmbBZCw3hQxVM1K4D11lDB/1kuWacohz7gFfLrGVBIIuQsd8N
         V46JYKnvQgJjkzzzHCeUgMf9uiDIw6/N9+oTprA9Zp8OR/cgQYIfyEHrqGHxQTEpUD9W
         JvubxD27NNXvij0P+mccyKJU8HhUPzTNk8ZPePncybvi3S3thh2pbQ/eHyM4NT5gY4BX
         ei+xp6aon4i6bh3Xp4/XtlYJfyxYXQ0oI13ohUh+zBbG8LU1mEBGKgjzpQUj934wh+Zm
         sokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YxVwv68AbS6pq98P8gJ+sfpihg1L5cx43Oy9Q1g/ERc=;
        b=dt03uyeZCksRVcSvxG0uaiVP3BoZsolCbf9OvwJFMPumdRxHpXSiOdmKK30PWYZWi0
         cPz5AXaW0j/SuKkc/JH1fRj2qNHzWICPCWgZhdqYr878ozga4Y4ab2P1aRqWjco9nwAx
         /FBfujJJuC0+5F/sQszXva2+q/qVzj77IW7dWWxbS6T/C1iZ99wk852gX/c3LSvIGFp4
         4t5+9LkZd9jKpX0mPjL9pJxsfDj4Yq3F+CRAiI5OXC7+Ycf2meMdU9m0AiUnCIGJZ+ER
         aGoUN4h/Soel4CV2hPh9pKH7A6axm6/DyOPrn2a2g07Ee6FPDN5XmIuLbBdpLONlejGc
         vazQ==
X-Gm-Message-State: APjAAAWL/6kjVonajgajjadcqSQuQXvIAi0aENM8t1Yb951x6wPIqluF
        pX2AxkFEUztT1uFXShqYDnkuvn1q5DH9UPTwqIDa1TzEF/I=
X-Google-Smtp-Source: APXvYqyW+RrsKvlA3MS0x6gHiMtioNjlKf2HkWbQXeQZxxPhmz3veH0koYzCG4CB/SQj6Rsk5VA8CaYwYoXNvOxx/fY=
X-Received: by 2002:a6b:d019:: with SMTP id x25mr4020019ioa.275.1581718352669;
 Fri, 14 Feb 2020 14:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20200214151848.8328-1-mfo@canonical.com> <20200214151848.8328-3-mfo@canonical.com>
In-Reply-To: <20200214151848.8328-3-mfo@canonical.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 15 Feb 2020 00:12:21 +0200
Message-ID: <CAOQ4uxi3tRU0Xu_nDYW4UTGqpDTQeOTxTVjYjw3PZo4EF__mLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] tests/overlay: mount: replace overlay hardcode
 with OVL_FSTYP variable
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Feb 14, 2020 at 5:18 PM Mauricio Faria de Oliveira
<mfo@canonical.com> wrote:
>
> This allows other filesystem types to actually be used in these tests.
>
> Well, aufs does not support the options used in most of them anyway,
> so just let it fail to mount (instead of implementing common helpers
> for middle layers.)
>
> On fuse-overlayfs (coming) the options should be supported/compatible,
> and thus just work, so no further changes are needed.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>

I'm fine with this patch, you may add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

but for aufs testers sake, it would be nicer if you added to those tests:

[ "$OVL_FSTYP" != aufs ] || _notrun "This test is not compatible with aufs"

Thanks,
Amir.

> ---
>  tests/overlay/011 | 2 +-
>  tests/overlay/035 | 2 +-
>  tests/overlay/052 | 4 ++--
>  tests/overlay/053 | 4 ++--
>  tests/overlay/062 | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tests/overlay/011 b/tests/overlay/011
> index 1d09341b250a..0b39416c9835 100755
> --- a/tests/overlay/011
> +++ b/tests/overlay/011
> @@ -53,7 +53,7 @@ $SETFATTR_PROG -n "trusted.overlay.opaque" -v "y" $upperdir/testdir
>  # $upperdir overlaid on top of $lowerdir, so that "trusted.overlay.opaque"
>  # xattr should be honored and should not be listed
>  # mount readonly, because there's no upper and workdir
> -$MOUNT_PROG -t overlay -o ro -o lowerdir=$upperdir:$lowerdir $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT
> +$MOUNT_PROG -t $OVL_FSTYP -o ro -o lowerdir=$upperdir:$lowerdir $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT
>
>  # Dump trusted.overlay xattr, we should not see the "opaque" xattr
>  _getfattr -d -m overlay $SCRATCH_MNT/testdir
> diff --git a/tests/overlay/035 b/tests/overlay/035
> index c0aae935bcf1..bbb158f319cd 100755
> --- a/tests/overlay/035
> +++ b/tests/overlay/035
> @@ -52,7 +52,7 @@ mkdir -p $lowerdir1 $lowerdir2 $upperdir $workdir
>
>  # Mount overlay with lower layers only.
>  # Verify that overlay is mounted read-only and that it cannot be remounted rw.
> -$MOUNT_PROG -t overlay -o"lowerdir=$lowerdir2:$lowerdir1" \
> +$MOUNT_PROG -t $OVL_FSTYP -o"lowerdir=$lowerdir2:$lowerdir1" \
>                         $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT
>  touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
>  $MOUNT_PROG -o remount,rw $SCRATCH_MNT 2>&1 | _filter_ro_mount
> diff --git a/tests/overlay/052 b/tests/overlay/052
> index b1cf0da64bbf..35a7b5f1a903 100755
> --- a/tests/overlay/052
> +++ b/tests/overlay/052
> @@ -147,7 +147,7 @@ unmount_dirs
>
>  # Check encode/decode/read of lower file handles on lower layers only r/o overlay.
>  # For non-upper overlay mount, nfs_export requires disabling redirect_dir.
> -$MOUNT_PROG -t overlay $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
> +$MOUNT_PROG -t $OVL_FSTYP $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
>                         -o ro,redirect_dir=nofollow,nfs_export=on,lowerdir=$middle:$lower
>  test_file_handles $SCRATCH_MNT/lowertestdir -rp
>  test_file_handles $SCRATCH_MNT/lowertestdir/subdir -rp
> @@ -158,7 +158,7 @@ unmount_dirs
>  # Overlay lookup cannot follow the redirect from $upper/lowertestdir.new to
>  # $lower/lowertestdir. Instead, we mount an overlay subtree rooted at these
>  # directories.
> -$MOUNT_PROG -t overlay $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
> +$MOUNT_PROG -t $OVL_FSTYP $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
>                 -o ro,redirect_dir=nofollow,nfs_export=on,lowerdir=$upper/lowertestdir.new:$lower/lowertestdir
>  test_file_handles $SCRATCH_MNT -r
>  test_file_handles $SCRATCH_MNT/subdir -rp
> diff --git a/tests/overlay/053 b/tests/overlay/053
> index ff95424741ec..5ac19b32c3cb 100755
> --- a/tests/overlay/053
> +++ b/tests/overlay/053
> @@ -169,7 +169,7 @@ unmount_dirs
>
>  # Check encode/decode/read of lower file handles on lower layers only r/o overlay.
>  # For non-upper overlay mount, nfs_export requires disabling redirect_dir.
> -$MOUNT_PROG -t overlay $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
> +$MOUNT_PROG -t $OVL_FSTYP $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
>                         -o ro,redirect_dir=nofollow,nfs_export=on,lowerdir=$middle:$lower
>  test_file_handles $SCRATCH_MNT/lowertestdir -rp
>  test_file_handles $SCRATCH_MNT/lowertestdir/subdir -rp
> @@ -180,7 +180,7 @@ unmount_dirs
>  # Overlay lookup cannot follow the redirect from $upper/lowertestdir.new to
>  # $lower/lowertestdir. Instead, we mount an overlay subtree rooted at these
>  # directories.
> -$MOUNT_PROG -t overlay $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
> +$MOUNT_PROG -t $OVL_FSTYP $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
>                 -o ro,redirect_dir=nofollow,nfs_export=on,lowerdir=$upper/lowertestdir.new:$lower/lowertestdir
>  test_file_handles $SCRATCH_MNT -r
>  test_file_handles $SCRATCH_MNT/subdir -rp
> diff --git a/tests/overlay/062 b/tests/overlay/062
> index 2c86a4b6fd1e..afd3562bfd33 100755
> --- a/tests/overlay/062
> +++ b/tests/overlay/062
> @@ -72,7 +72,7 @@ create_test_files $lowertestdir
>  $MOUNT_PROG --bind $lowertestdir $lowertestdir
>
>  # For non-upper overlay mount, nfs_export requires disabling redirect_dir.
> -$MOUNT_PROG -t overlay $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
> +$MOUNT_PROG -t $OVL_FSTYP $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT \
>         -o ro,redirect_dir=nofollow,nfs_export=on,lowerdir=$lower:$lower2
>
>  # Decode an overlay directory file handle, whose underlying lower dir dentry
> --
> 2.20.1
>
