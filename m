Return-Path: <SRS0=5Nbd=Y7=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8A8C43331
	for <linux-fstests@archiver.kernel.org>; Thu,  7 Nov 2019 15:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF32F2166E
	for <linux-fstests@archiver.kernel.org>; Thu,  7 Nov 2019 15:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzJT+D4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbfKGPsE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:48:04 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41011 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfKGPsE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Nov 2019 10:48:04 -0500
Received: by mail-yb1-f193.google.com with SMTP id d95so615420ybi.8
        for <fstests@vger.kernel.org>; Thu, 07 Nov 2019 07:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFNVwIoUSDMPQfwDbDjLA/dvTwA+1Gcgc762lEAR3BA=;
        b=NzJT+D4h0K4e0OQWACJQvFdDKjhzmoMzoLajtQQONOlSjVaDK2VieYlnrcTfVRxj0f
         IKfFXaRaq2ScOF8ztG1RIfynoEN72b0EaYwqHH+LuYIuIl66gIK5ElEBm0OgTPGX561Z
         3+k4XRPxrTWjnNLrTIh+kdLvaJGsteglbvHLtc5HfZ4HrRyDtW506Wt0SwVV7a1TJJ92
         XPLCnjz+iUQLOf+sd/UJ4O0ePXgFXOOCy1LhqZiWMASQRT4aXijFxNhZ9MNnzcUZ3izi
         LrP43lqNXYY+ePgwaUbinUHXlC+uCmHMKBv/eDrl27i9pQDuuOEJSbpEheZYfUJMFevf
         r3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFNVwIoUSDMPQfwDbDjLA/dvTwA+1Gcgc762lEAR3BA=;
        b=iqgujdn8jPX1itX2kw6lHl1qJmFdAFwHcgI0V/jY6vTmfIlSWK4CY1TbX+b0mmXRuR
         0miImaDqgBVGgzPf1bQ33EFkXd7qOkIL8nvHw4d6NodOpBDS7zK3pHs+sG2gWEELUz9V
         7Yu+tSGgodMbGDwrttN4zUrVAJO0m45eqMswpOjMRerSQ9i3T8hLQaId4NQWQN40ZVKy
         5Hm+TQbqHawJiGdCr8d9/lgKi1k13iHXvBpNTajMmtw4Lcd0c4i7pU1/jA+QWjtat7R1
         237g9jVCmSuVaUfHTcxk/TlOB038M87Brde72mcZvwOdg6PU0A2Nx+Z6MO6OdtYvwrJ/
         7Z9w==
X-Gm-Message-State: APjAAAX4Zedpbjm70y0G5NFMYIsHsi84g5xZ1O1GNkR5Jz6pfAT3DxGd
        A85Bu/PGFzCLiNcJJTUKPIE2IeLXGZ5cpZiYeGgON3sj
X-Google-Smtp-Source: APXvYqyeSm7KyTyUkHfflrLYwqfivJkE7E3qP62vOrsqt/a8xbWQ11U44xkmCL6RCCOhjm2Ec4H1bUeAbWW/NBZtuBM=
X-Received: by 2002:a25:a0d3:: with SMTP id i19mr3952979ybm.14.1573141681553;
 Thu, 07 Nov 2019 07:48:01 -0800 (PST)
MIME-Version: 1.0
References: <3ac76079-7a4f-0ad6-80e9-6175c3c55a68@redhat.com>
In-Reply-To: <3ac76079-7a4f-0ad6-80e9-6175c3c55a68@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 7 Nov 2019 17:47:50 +0200
Message-ID: <CAOQ4uxi21QKH3eZ_1VdXn-EorZbbnX7e5Qc393HJVAv9dvqqvw@mail.gmail.com>
Subject: Re: [PATCH] xfs/207: explicitly test for xflag character
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 7, 2019 at 5:07 PM Eric Sandeen <sandeen@redhat.com> wrote:
>
> With a recent change to xfs_io[1], the fsxattr.xflags output line
> has added another flag column, so xfs/207 starts failing.
>
> Rather than testing for an exact set of flags, test whether the
> specific flag we are interested in is set or unset.
>
> [1] xfs_io/lsattr: expose FS_XFLAG_HASATTR flag
>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

And sorry for the fallout...

> ---
>
> diff --git a/tests/xfs/207 b/tests/xfs/207
> index e830534b..ed4e2e52 100755
> --- a/tests/xfs/207
> +++ b/tests/xfs/207
> @@ -37,6 +37,15 @@ _require_cp_reflink
>  _require_xfs_io_command "fiemap"
>  _require_xfs_io_command "cowextsize"
>
> +# Takes the fsxattr.xflags line,
> +# i.e. fsxattr.xflags = 0x0 [--------------C-]
> +# and tests whether a flag character is set
> +test_xflag()
> +{
> +    local flg=$1
> +    grep -q "\[.*${flg}.*\]" && echo "$flg flag set" || echo "$flg flag unset"
> +}
> +
>  rm -f $seqres.full
>
>  echo "Format and mount"
> @@ -73,14 +82,14 @@ echo "Set cowextsize and check flag"
>  $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
>  _scratch_cycle_mount
>
> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | _filter_scratch
> +$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
>  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>
>  echo "Unset cowextsize and check flag"
>  $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
>  _scratch_cycle_mount
>
> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | _filter_scratch
> +$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
>  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
>
>  status=0
> diff --git a/tests/xfs/207.out b/tests/xfs/207.out
> index f6dc17d1..dd2d0958 100644
> --- a/tests/xfs/207.out
> +++ b/tests/xfs/207.out
> @@ -11,8 +11,8 @@ Check extsz and cowextsz settings on 1Mbyte file
>  [0] SCRATCH_MNT/test-207/file2
>  [1048576] SCRATCH_MNT/test-207/file2
>  Set cowextsize and check flag
> -fsxattr.xflags = 0x10000 [---------------C]
> +C flag set
>  [1048576] SCRATCH_MNT/test-207/file3
>  Unset cowextsize and check flag
> -fsxattr.xflags = 0x0 [----------------]
> +C flag unset
>  [0] SCRATCH_MNT/test-207/file3
>
