Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B9DC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Mar 2022 05:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiCVF0X (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Mar 2022 01:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiCVF0W (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2022 01:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C00B62EC
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 22:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647926691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pEGdBTA/2dQDKDcKm1iHMuQ8mIaWs/+8IXlCxktvfRk=;
        b=BMvou8PtasjdCAfuV8Y9h1tmmifH9XrqEIDomc+MEFf2/JJucE0aX9LCZpLXaqmtWePtoV
        ismH99jQ9scknRfZNKTNIUgM4RzScRHo3DtYQutJqi2fKrRXrCgh1c0RTANsldKheqE6Dd
        ZTe83urAkBZ1flSHxLZpURqwFOI97Ic=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-t395unMmNBy2FcPNfa0stw-1; Tue, 22 Mar 2022 01:24:49 -0400
X-MC-Unique: t395unMmNBy2FcPNfa0stw-1
Received: by mail-qv1-f69.google.com with SMTP id s14-20020ad4446e000000b00440d3810126so12634984qvt.5
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 22:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=pEGdBTA/2dQDKDcKm1iHMuQ8mIaWs/+8IXlCxktvfRk=;
        b=2G0KQGMxm0SWK8+uhCSyQSEBYaS3PzlbLcAG8t7Bz6dWKJe2W0Bie6LHXFLWfRnDvl
         ecToNQcQaWSjmYf11wa4kGbVP904W8A3ULT5xZP1gOf2bgRUv2gbEh6vDbvWLV5QlUHp
         ibzMQdAvWyg7I1KkzgAZ8uSDGn8pW3wVnWmYPBFPCoQdxeyr59Yp3orxNwnlzUAkeUGb
         /dt90ujU1kxG18/6Doki/fGEAnoyqePb8RU428qPmaxPrR5yBpFadxhPtHwjET9pfZ2L
         TPOvsC+cvN0t8gpYtuhFvK8dgkjLaLqY5OHfpLJb+6jVEYcYbReu02oQyEA87j/6p7Fn
         DvzA==
X-Gm-Message-State: AOAM531bOEKWsOmOgpVcdLPEl24Bp42wEeS0ULOf788YOKfiUL9uAQjP
        swE/3M+L9ouLSQhMqCTgi27esBqJLMme/o/OfLoVeSzZatIbwgvWXsEUjVDQDtP+qRoy9wmQW05
        fWEyZfD4tzFDEny6TPg==
X-Received: by 2002:ac8:5dc8:0:b0:2e1:d241:b6b5 with SMTP id e8-20020ac85dc8000000b002e1d241b6b5mr18666884qtx.672.1647926689371;
        Mon, 21 Mar 2022 22:24:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfR1yqIxnhJ6ww/ZEB9B4k5mxfsR3tPg/8CPfu1iM6lJE6e6+toJ6SfchNvaGE8C2yVAi3Gw==
X-Received: by 2002:ac8:5dc8:0:b0:2e1:d241:b6b5 with SMTP id e8-20020ac85dc8000000b002e1d241b6b5mr18666876qtx.672.1647926689122;
        Mon, 21 Mar 2022 22:24:49 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u129-20020a376087000000b0067e401d7177sm7272635qkb.3.2022.03.21.22.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 22:24:48 -0700 (PDT)
Date:   Tue, 22 Mar 2022 13:24:42 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 4/4] generic/673: fix golden output to reflect vfs setgid
 behavior
Message-ID: <20220322052442.u6v34duem2tucnlj@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org
References: <164740140348.3371628.12967562090320741592.stgit@magnolia>
 <164740142591.3371628.12793589713189041823.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164740142591.3371628.12793589713189041823.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 15, 2022 at 08:30:25PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Filipe Manana pointed out[1] that the setgid dropping behavior encoded
> in this generic test is based on some outdated XFS code, and not based
> on what the VFS inode attribute change functions actually do.  Now that
> we're working on fixing that, we should update the golden output to
> reflect what all filesystems are supposed to be doing.
> 
> [1] https://lore.kernel.org/linux-xfs/CAL3q7H47iNQ=Wmk83WcGB-KBJVOEtR9+qGczzCeXJ9Y2KCV25Q@mail.gmail.com/
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Thanks for making this change clear. As this's a generic test, other filesystem
might hit new failures if this test passed on them before. And hope some downstream
XFS users won't report too many customer bugs to us :) Anyway, it's good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/673.out |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/tests/generic/673.out b/tests/generic/673.out
> index 8df672d6..4d18bca2 100644
> --- a/tests/generic/673.out
> +++ b/tests/generic/673.out
> @@ -3,7 +3,7 @@ Test 1 - qa_user, non-exec file
>  310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
>  6666 -rwSrwSrw- SCRATCH_MNT/a
>  3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> -2666 -rw-rwSrw- SCRATCH_MNT/a
> +666 -rw-rw-rw- SCRATCH_MNT/a
>  
>  Test 2 - qa_user, group-exec file
>  310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> @@ -15,7 +15,7 @@ Test 3 - qa_user, user-exec file
>  310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
>  6766 -rwsrwSrw- SCRATCH_MNT/a
>  3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> -2766 -rwxrwSrw- SCRATCH_MNT/a
> +766 -rwxrw-rw- SCRATCH_MNT/a
>  
>  Test 4 - qa_user, all-exec file
>  310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> 

