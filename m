Return-Path: <SRS0=VTFL=24=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0674C33C99
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 10:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16DA20678
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 10:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSGo9j/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgAGKPh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:15:37 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45638 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGKPh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Jan 2020 05:15:37 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so51963547ioi.12
        for <fstests@vger.kernel.org>; Tue, 07 Jan 2020 02:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRJeY3ZgAa5CiBKDn2ydcAVSnpwWr9ysF0PnUby0+x8=;
        b=ZSGo9j/7+8EpPf2pKc+3B8qoJsQrSBO8dwRj1zpRM+OFjRCwb9Xo+TebVvdptwSS04
         daPNUv6dsHwSFY92ifiNB5ipv+U74PsW6TNnPTRu9Yj40wUGuTTkg8fjsHwmtXJcqb/a
         jwbaOJmoqpi9M+grvkZ4ni1DceGJLHXLliAaeG3it6zSxos/ps4s5i/1MpJU4K9Etp7Q
         H10HQsjBISl3lMG4mnka70dJrEOB/5HP7R6K/sVvLrfV0ZXr8lb6WmryWbD+5Yronov9
         R8oPPRpdsbrM0/Uvrkll3mRfw2I96wiEvjsLsJb+5uScfj8Ru7pSqpVqPDs/C+pY7fHg
         YcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRJeY3ZgAa5CiBKDn2ydcAVSnpwWr9ysF0PnUby0+x8=;
        b=phB5lxBTh6GvCVnNI4W4C7nfyq/GhsQMWg7sgEXjD/QoGcAKLRpcp7VFFT9jy4P6bx
         hhfnyIPQ7NI3Qkbo1XPaTrYWW+ethR+Mh/Ae7IjT1UYHKXWc/uvzav0He/1daBIaKhyH
         nF3JQrbt9/YcLSs4UTSHBPmNZrvymZjDhiTZp4Yut+XwowUX9j/yNCoYQtze2AhYu9zB
         CgtHoc9mW7dflqdl8QKA/4GnS7K8ZkDwE5h5FdvXRXncgHn+7XsfVQKWIniY8UA39wyn
         aZO7FMW/kX5Ina9sfRiyHMaxxNR5Q2QQiA4F3C9vsHOc56W8x36bby3wuUgadjpyzcAN
         HZCA==
X-Gm-Message-State: APjAAAXqeWj8wrNpI23i5RhT+XuEBv6cCStU+RPKCfuSptLiFGiLXAyH
        Xt+uKwe7x9lai/Sah5ol0fABSbSzXGbNSUvuRsM=
X-Google-Smtp-Source: APXvYqyb+VZblm6KSEQNC+D6Dp64l/3es4Gg9e0V4zwIiuWzHE/5f8B/2TnfMqbbER0wMqau6X+6V1WEqOYbh71g9Fk=
X-Received: by 2002:a05:6602:280b:: with SMTP id d11mr71237518ioe.250.1578392136551;
 Tue, 07 Jan 2020 02:15:36 -0800 (PST)
MIME-Version: 1.0
References: <20200107084053.2889-1-yangx.jy@cn.fujitsu.com> <20200107084053.2889-2-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20200107084053.2889-2-yangx.jy@cn.fujitsu.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 7 Jan 2020 12:15:25 +0200
Message-ID: <CAOQ4uxhuTrZvC0TUhejG36vh7wb+c4WBN8HCVBO0z9sGn1ZueA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] generic: Add check for required keep_size/punch_hole/zero_range/collapse_range
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     eguan@linux.alibaba.com, fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 7, 2020 at 10:45 AM Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
>
> Tests need the exact operations to reproduce some issues by --replay-ops so skip tests
> rather than one operation if a required operation/flag in tests is not supported.
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks

> ---
>  tests/generic/456 | 3 +++
>  tests/generic/469 | 3 +++
>  tests/generic/499 | 1 +
>  tests/generic/511 | 1 +
>  4 files changed, 8 insertions(+)
>
> diff --git a/tests/generic/456 b/tests/generic/456
> index 6124f0bb..434a0ffa 100755
> --- a/tests/generic/456
> +++ b/tests/generic/456
> @@ -36,6 +36,9 @@ _supported_fs generic
>  _supported_os Linux
>  _require_scratch
>  _require_dm_target flakey
> +_require_xfs_io_command "falloc" "-k"
> +_require_xfs_io_command "fzero"
> +_require_xfs_io_command "fcollapse"
>
>  rm -f $seqres.full
>
> diff --git a/tests/generic/469 b/tests/generic/469
> index 47fdf0cf..e9411d47 100755
> --- a/tests/generic/469
> +++ b/tests/generic/469
> @@ -40,6 +40,9 @@ rm -f $seqres.full
>  _supported_fs generic
>  _supported_os Linux
>  _require_test
> +_require_xfs_io_command "falloc" "-k"
> +_require_xfs_io_command "fpunch"
> +_require_xfs_io_command "fzero"
>
>  run_fsx()
>  {
> diff --git a/tests/generic/499 b/tests/generic/499
> index 773eab2e..b3363ac4 100755
> --- a/tests/generic/499
> +++ b/tests/generic/499
> @@ -28,6 +28,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_xfs_io_command "falloc" "-k"
>  _require_xfs_io_command "fcollapse"
>  _require_xfs_io_command "fzero"
>
> diff --git a/tests/generic/511 b/tests/generic/511
> index 4d133f49..f8022905 100755
> --- a/tests/generic/511
> +++ b/tests/generic/511
> @@ -28,6 +28,7 @@ _cleanup()
>  _supported_fs generic
>  _supported_os Linux
>  _require_scratch
> +_require_xfs_io_command "falloc" "-k"
>  _require_xfs_io_command "fzero"
>
>  rm -f $seqres.full
> --
> 2.21.0
>
>
>
