Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3DEC432BE
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Aug 2021 13:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DBE60FE8
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Aug 2021 13:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhH3NJ3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Aug 2021 09:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232055AbhH3NJ0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Aug 2021 09:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630328912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SSnoiz3fsr0n60rPSK6MyU+7QpJuvIyUd7Mr/xf7eGU=;
        b=WMVuO7nsfNAmZ++st22vG+xjg+xhLnLZrQQwFLerinreACEM8/zGu9VM7OUeDkofMXmyCq
        ayOpDdsFSQfU6cHPbnUFXLogM/o4V/nzMCxaZN2ty23ZRqsFgE7FYGKQjhWppD0julPsAC
        Ha9jwo3x04EZpJvAJVpT7za0yaAB6JA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-jKLfWoChOhuCGF4jR0HiOA-1; Mon, 30 Aug 2021 09:08:31 -0400
X-MC-Unique: jKLfWoChOhuCGF4jR0HiOA-1
Received: by mail-pj1-f70.google.com with SMTP id p7-20020a17090a2c4700b0018d4e028ee6so482598pjm.6
        for <fstests@vger.kernel.org>; Mon, 30 Aug 2021 06:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=SSnoiz3fsr0n60rPSK6MyU+7QpJuvIyUd7Mr/xf7eGU=;
        b=tEEZ5Pbmw7/7LpBLz1d4noKe3JJJnuvaTJsoO62g3Vpn4LYfidNjuyoKsGUvnBQuDc
         EGTl7wM0bXlLhUQNL+2OK1tGirKP0hipa8UzkEk8JvNDN8XqB7rCdu6PQl35s+tEweB+
         Cef1Dz/EYvVgkoyjjLaDa3iTzf4k4DIVZ8dUg6NB/ycSGVGXVxuSN+F7pA/FfuyfQ1Rg
         LXzE9iTWrj4NBlzeVIMrMstCwDq/r4fbypkQr8eEUIa/hvkGJIX3kA390GGxtJCBtFAF
         zyA5tEzl/kCPUCwsdfdgaPcm18J7XNJyKbV/mTbtnLbEOINiWY0q40w3x4Fn4ezbYx+q
         SRgg==
X-Gm-Message-State: AOAM531Vgnh+ibNnvu3NXDNLROhMGp+agM5zZlZg+T6BTF712K85h3Tn
        QrLkJbTauMMwMSbPJ4bXuQMa1vtOoKxyZ+TnMoRhnrWlo/sti0znzaJ6s+vRMZS7W2vdZW3JnHI
        VlbvGyd4F9xJPCXmyxA==
X-Received: by 2002:a17:90b:f97:: with SMTP id ft23mr26498189pjb.135.1630328910037;
        Mon, 30 Aug 2021 06:08:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxUSUJCll3DV3MnARjKcs63sTg1TcEhxuWJA+XinTRtvV9r1/ULaKyaY21aijh2Gt+F5W07w==
X-Received: by 2002:a17:90b:f97:: with SMTP id ft23mr26498160pjb.135.1630328909658;
        Mon, 30 Aug 2021 06:08:29 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j16sm15388909pfi.165.2021.08.30.06.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 06:08:29 -0700 (PDT)
Date:   Mon, 30 Aug 2021 21:29:27 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: which has been deprecated by Debian
Message-ID: <20210830132927.7glbrcsgwep6xq4v@fedora>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        fstests@vger.kernel.org
References: <20210830011401.697295-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830011401.697295-1-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 30, 2021 at 11:14:01AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> This patch is brought to you by the Department That Hates Users.
> 
> The latest debian unstable release is now causing a bunch of new
> test failures because they have deprecated the which command.
> 
> Rather than make everyone jump through hoops chasing problems with
> 'which' while debian decides to how to package at least three
> variants of 'which' - each which will different semantics, behaviour
> and support - as alternatives users then have to opt into, let's
> just remove the remaining uses of the shell independent 'which'
> command and replace them with bash builtin 'type -P' operations.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---




>  common/rc         | 2 +-
>  src/fill2fs       | 2 +-
>  tests/ext4/006    | 2 +-
>  tests/generic/128 | 2 +-
>  tests/generic/452 | 2 +-
>  tests/xfs/293     | 2 +-
>  tests/xfs/505     | 2 +-
>  tests/xfs/514     | 2 +-
>  tests/xfs/515     | 2 +-
>  9 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index a7f9ed86..db400c4d 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4,7 +4,7 @@
>  
>  . common/config
>  
> -BC=$(which bc 2> /dev/null) || BC=
> +BC="$(type -P bc)" || BC=
>  
>  _require_math()
>  {
> diff --git a/src/fill2fs b/src/fill2fs
> index 1c3383a8..d5e5436b 100755
> --- a/src/fill2fs
> +++ b/src/fill2fs
> @@ -111,7 +111,7 @@ sub normal {
>  #
>  
>  chomp($cwd = `pwd`);
> -chomp($_ = `which fill2 2>&1 | head -1`);
> +chomp($_ = `type -P fill2 | head -1`);
>  if (-x $_) {
>    # look in the path
>    $fill2 = fill2;
> diff --git a/tests/ext4/006 b/tests/ext4/006
> index 17e77f86..48ed6bee 100755
> --- a/tests/ext4/006
> +++ b/tests/ext4/006
> @@ -24,7 +24,7 @@ _cleanup()
>  . ./common/populate
>  . ./common/fuzzy
>  
> -if [ ! -x "$(which e2fuzz)" ]; then
> +if [ ! -x "$(type -P e2fuzz)" ]; then
>  	_notrun "Couldn't find e2fuzz"
>  fi
>  
> diff --git a/tests/generic/128 b/tests/generic/128
> index dfc67fd5..dc1d43f4 100755
> --- a/tests/generic/128
> +++ b/tests/generic/128
> @@ -23,7 +23,7 @@ _scratch_mkfs >/dev/null 2>&1
>  _scratch_mount "-o nosuid"
>  
>  mkdir $SCRATCH_MNT/nosuid
> -cp `which ls` $SCRATCH_MNT
> +cp "$(type -P ls)" $SCRATCH_MNT
>  chmod 700 $SCRATCH_MNT/nosuid
>  chmod 4755 $SCRATCH_MNT/ls
>  
> diff --git a/tests/generic/452 b/tests/generic/452
> index ee4dfe9e..7cbd2dfa 100755
> --- a/tests/generic/452
> +++ b/tests/generic/452
> @@ -26,7 +26,7 @@ _exclude_scratch_mount_option "noexec"
>  _scratch_mkfs > $seqres.full 2>&1
>  _scratch_mount >> $seqres.full 2>&1
>  
> -LS=$(which ls --skip-alias --skip-functions)
> +LS="$(type -P ls) --skip-alias --skip-functions)"

I think the "--skip-alias" and "--skip-functions" options are belong to
the "which" command, so this change might cause fail.

Thanks,
Zorro


>  SCRATCH_LS=$SCRATCH_MNT/ls_on_scratch
>  cp $LS $SCRATCH_LS
>  
> diff --git a/tests/xfs/293 b/tests/xfs/293
> index fbd26b63..20f8c486 100755
> --- a/tests/xfs/293
> +++ b/tests/xfs/293
> @@ -30,7 +30,7 @@ case "$MANPAGE" in
>  *)		CAT=cat;;
>  esac
>  
> -_require_command `which $CAT` $CAT
> +_require_command "$(type -P $CAT)" $CAT
>  
>  for COMMAND in `$XFS_IO_PROG -c help | awk '{print $1}' | grep -v "^Use"`; do
>    $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
> diff --git a/tests/xfs/505 b/tests/xfs/505
> index 8a999ff4..71fb6e9d 100755
> --- a/tests/xfs/505
> +++ b/tests/xfs/505
> @@ -26,7 +26,7 @@ case "$MANPAGE" in
>  *.xz)		CAT=xzcat;;
>  *)		CAT=cat;;
>  esac
> -_require_command `which $CAT` $CAT
> +_require_command "$(type -P $CAT)" $CAT
>  
>  for COMMAND in `$XFS_SPACEMAN_PROG -c help $TEST_DIR | awk '{print $1}' | grep -v "^Use"`; do
>    $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
> diff --git a/tests/xfs/514 b/tests/xfs/514
> index a9c67645..cf5588f2 100755
> --- a/tests/xfs/514
> +++ b/tests/xfs/514
> @@ -34,7 +34,7 @@ case "$MANPAGE" in
>  *.xz)		CAT=xzcat;;
>  *)		CAT=cat;;
>  esac
> -_require_command `which $CAT` $CAT
> +_require_command "$(type -P $CAT)" $CAT
>  
>  file=$TEST_DIR/xx.$seq
>  truncate -s 128m $file
> diff --git a/tests/xfs/515 b/tests/xfs/515
> index 32216fe6..2d7bbb35 100755
> --- a/tests/xfs/515
> +++ b/tests/xfs/515
> @@ -34,7 +34,7 @@ case "$MANPAGE" in
>  *.xz)		CAT=xzcat;;
>  *)		CAT=cat;;
>  esac
> -_require_command `which $CAT` $CAT
> +_require_command "$(type -P $CAT)" $CAT
>  
>  for COMMAND in `$XFS_QUOTA_PROG -x -c help $file | awk '{print $1}' | grep -v "^Use"`; do
>    $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
> -- 
> 2.31.1
> 

