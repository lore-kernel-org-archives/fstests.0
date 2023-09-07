Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2103EC874C
	for <linux-fstests@archiver.kernel.org>; Thu,  7 Sep 2023 18:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343725AbjIGST0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjIGSTZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Sep 2023 14:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC45170F
        for <fstests@vger.kernel.org>; Thu,  7 Sep 2023 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694110678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A/TMtqLeW5FIKNnR3OD3iwBY128ao8eyjqb+1kHrB9E=;
        b=IT9qSyUKIMqYFqGHHfVV/yOSpe4CqmeFAmrVVj7DId/W3wjd807yQQUOxtpLqKBrheu961
        1wEvJxUmeyG10Bartdb2Qn4JsHUvBAzAZdaf0GwJwI/POBtG2p20lUu//PzIs77uOIMLLx
        P+sYnfX7jnKatLHbCZShgGZnHFl4Ye0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-EjPaDK0OOPWq7GrNjBrAIQ-1; Thu, 07 Sep 2023 09:54:39 -0400
X-MC-Unique: EjPaDK0OOPWq7GrNjBrAIQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1c1fe87fc29so13565095ad.0
        for <fstests@vger.kernel.org>; Thu, 07 Sep 2023 06:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694094878; x=1694699678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/TMtqLeW5FIKNnR3OD3iwBY128ao8eyjqb+1kHrB9E=;
        b=fIjjFqpPv7IpybzgOhIqrxhIOikFHIOzqr9qo/fO98k6LMZYv8hjnaW6cACCJeO8Sg
         ssJiyT4xxeiaOa2DqVC4CYppNkbOJxwDTEXTTxeakWQ3B+zWZPC8LGcqs8T+/1JK5Qhv
         AkVxZp37bRgggQI7GtliK2Karw8sYWCX9XB0C3LlQ9meMiT7+0JwSkcBjCouQZYKsszn
         f5PA1iRoOtFhiM24Vk6mtUD30AGpuVEcTN3+ZvaeBE7WsatniYhPx90NJ34SIZAPSTia
         5TpAn8KCSh0GwL1r/GdLp09jHmocWsK9og9uYIzeGekxMhlWKKx4eDcLuZ/fj7th6N5i
         UyWQ==
X-Gm-Message-State: AOJu0Yz/dEm4kXdWJJm43yCEKPBuZX3gSl7o366PKUdYugpt0pWp0aTO
        hknUinmVypDhpkD49PhS23pMsVq88bkBXI2bLX9Dk4lFAZK3u/ZazsGdpSst+5fSCNCWSc10tjt
        1vRzMEomW2/ghPEKVGZQK1763RRuHPdo=
X-Received: by 2002:a17:902:d895:b0:1bf:5cf7:41e2 with SMTP id b21-20020a170902d89500b001bf5cf741e2mr18511136plz.44.1694094878096;
        Thu, 07 Sep 2023 06:54:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPQz6BYVgrMNH/beZEJgoeoj3OUfDYKOiBwJFJcr/qOS3UysRGmb8A0hvRDwUYwLtF+GeYPg==
X-Received: by 2002:a17:902:d895:b0:1bf:5cf7:41e2 with SMTP id b21-20020a170902d89500b001bf5cf741e2mr18511121plz.44.1694094877789;
        Thu, 07 Sep 2023 06:54:37 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jf10-20020a170903268a00b001c1f016015esm12842221plb.84.2023.09.07.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 06:54:37 -0700 (PDT)
Date:   Thu, 7 Sep 2023 21:54:34 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] tools/mvtest: ensure testcase is executable (755)
Message-ID: <20230907135434.kj44w7mg6qvpzs4m@zlang-mailbox>
References: <20230906071349.3643040-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906071349.3643040-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 06, 2023 at 03:13:49PM +0800, Shiyang Ruan wrote:
> Some test cases lack executable permission ('x'). Before running each
> test case, `./check` checks and grants them 'x' permission. However,
> this always leads to a dirty git repo. And the absence of 'x' permission
> in test cases is often overlooked during reviews.
> 
> Since maintainers use mvtest to assign new case, add this change for
> convenience of maintainers.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  tools/mvtest | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/mvtest b/tools/mvtest
> index 99b154142..e839f0256 100755
> --- a/tools/mvtest
> +++ b/tools/mvtest
> @@ -28,6 +28,8 @@ append() {
>  test "${src}" != "${dest}" || die "Test \"${src}\" is the same as dest."
>  test -e "tests/${src}" || die "Test \"${src}\" does not exist."
>  test ! -e "tests/${dest}" || die "Test \"${src}\" already exists."
> +# make sure testcase is executable
> +test `stat -c '%a' tests/${src}` == 755 || chmod 755 "tests/${src}"

(Weird, I thought I've replied this patch, but I can't find my reply anywhere.)

I said we can check and set the permission on the ${dest} file, after the
move operation is done. Due to we actually want to get a 755 ${dest} file
by running the mvtest.

Thanks,
Zorro

>  
>  sid="$(basename "${src}")"
>  did="$(basename "${dest}")"
> -- 
> 2.42.0
> 

