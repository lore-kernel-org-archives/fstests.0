Return-Path: <SRS0=FwvB=EE=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE8CC55179
	for <linux-fstests@archiver.kernel.org>; Thu, 29 Oct 2020 09:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F7D520796
	for <linux-fstests@archiver.kernel.org>; Thu, 29 Oct 2020 09:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jC3/1/4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgJ2J5M (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 29 Oct 2020 05:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgJ2J5M (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Oct 2020 05:57:12 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1176C0613D5
        for <fstests@vger.kernel.org>; Thu, 29 Oct 2020 02:57:10 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x7so2388265ili.5
        for <fstests@vger.kernel.org>; Thu, 29 Oct 2020 02:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otEqV9AFNvb+StaAd3Y8+G8sZ0r6bKY4wKauOTFDiCk=;
        b=jC3/1/4w1g4g1xk1FEqz6xkuvtRSwuAbl6/e6eUG1Nujphc0pypHC5FFejn7rvtdHe
         IUkNnnjbcrNotfPYVvKTU+L8B/kW/xkKhK9mYaSkqfBcKq/vyfWbe4+sXGUgV4QFekDG
         i5REaAxfpmZfWSrPnO32JDnPUIbwwOBczUura5n/83NsIfmsFG4LMYcrIEvjED1O6o4G
         MCkoSHOl7Z7LgR0Llf44tAg67EfAcIY4vw9/XS0HqkBGBaIUExzsZO6jyc/zYVGHXpA2
         0TaK2K/+yp/JnKG2jQq3DdyaBlGJ71k4Hbdz+S55FwStBAbHv7afIiIAajdyDkj/lojc
         B1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otEqV9AFNvb+StaAd3Y8+G8sZ0r6bKY4wKauOTFDiCk=;
        b=KHfz7YF9dBfIp0LA63F7tfK2HLGog87FBQZhPNAGguB+UHTmwtdkONIQAPXPcUcytk
         deAvF6gRZ5ScmsnpRa2od6XzzIotaIK55LjSb+MQ1pqFURX2+Rs9jeDwVEz/4ngODr5x
         t/DzVZQuA+XT8OhZL0jBncdez3CQSB1tOZF+GaqgslYNBORXpBFcV1UwPB9GIy8DZNq1
         hm17iFzViHzhwpIYIo2F+rdPtlHkjiEd589X6GkPOzOX+Yoo8FOFoVC4ntA7KJ/QhDP0
         Y/oZNjm+0LsY5o4tR7fj6WrvIMeNlDURr8LvmCKTlr5wCPpCwon54rUYsyF7yDfiVdzN
         fMPA==
X-Gm-Message-State: AOAM532mG/7cpI8y4iEpFNrpNOldU0h6irbQRuoxsz95/O7N4L8mhJ9U
        MVVxju7SCA0eXJKJ8n53cNO0OXHLmN5f7oAZnpguZzRbwMA=
X-Google-Smtp-Source: ABdhPJwW3xFaT71FvbMvD2ZDodxTlcP/aMo2cwd3dKnSYfGPLkFglrPs78/ETGC/gWZ+armM5ZT2t3ZoQFSkmwTIbh4=
X-Received: by 2002:a92:d30f:: with SMTP id x15mr713386ila.9.1603965429949;
 Thu, 29 Oct 2020 02:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201029040338.238990-1-palmerdabbelt@google.com>
In-Reply-To: <20201029040338.238990-1-palmerdabbelt@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 29 Oct 2020 11:56:58 +0200
Message-ID: <CAOQ4uxj2NiyC7ZrNBNYQR7PuMex-Dm4XwXoGKcK05QizoD9ztg@mail.gmail.com>
Subject: Re: [PATCH] open_by_handle: Don't use MAX_HANDLE_SZ
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 29, 2020 at 11:01 AM Palmer Dabbelt
<palmerdabbelt@google.com> wrote:
>
> When I compile this normally I end up with the definition of
> MAX_HANDLE_SZ, but when I compile it in a minimal buildroot-based
> environment I don't.  I'm not sure where this is supposed to come from,
> but as of 3f4760c2 ("open_by_handle: add option -z to query file handle
> size") it appears to be unnecessary.
>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
> I haven't actually run this, as I haven't figured out how to yet.  It
> does build, though.
> ---
>  src/open_by_handle.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/src/open_by_handle.c b/src/open_by_handle.c
> index 0f74ed08..ddeffb7a 100644
> --- a/src/open_by_handle.c
> +++ b/src/open_by_handle.c
> @@ -92,7 +92,6 @@ Examples:
>
>  struct handle {
>         struct file_handle fh;
> -       unsigned char fid[MAX_HANDLE_SZ];
>  } handle[MAXFILES], dir_handle;

This is absolutely wrong!

I don't know what's the best way to fix the build error,
but this fid member is absolutely needed.

For all I care, you can define MAX_TEST_HANDLE_SZ to 128 or to
MAX_HANDLE_SZ if it is defined.

The test doesn't really care what the value of MAX_HANDLE_SZ is.
It just needs to be large enough to accomodate for the size of file handles
of the tested filesystem.

Thanks,
Amir.
