Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F10C4332F
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Oct 2022 15:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJMPFj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJMPFh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Oct 2022 11:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633409187A
        for <fstests@vger.kernel.org>; Thu, 13 Oct 2022 08:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665673532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HcC7V85g2NohPZDiXb9V7FIISiqVFF2r0lM+RvdABRI=;
        b=XBb+8m83OxPMeRXkKS5SNVL51AQL0R2u671r/2l130sqggoA2UFRIfiDbpbqak+E5MaWe1
        44trufu9Z6lBEVSmjq9TGupYrWmqTg2UdZJPzBjBLLiOseBsTHuVZxGctFcE5AHbDRo17V
        zZrzU+V+UlPhYQCnf6zUqNuksPZ0MQE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-533-e9pNa0AtNVuJ5Z87lKeWRw-1; Thu, 13 Oct 2022 11:05:30 -0400
X-MC-Unique: e9pNa0AtNVuJ5Z87lKeWRw-1
Received: by mail-qv1-f70.google.com with SMTP id ok8-20020a0562143c8800b004b07e9ca57eso1531621qvb.19
        for <fstests@vger.kernel.org>; Thu, 13 Oct 2022 08:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcC7V85g2NohPZDiXb9V7FIISiqVFF2r0lM+RvdABRI=;
        b=aiLkwgRhQDLoZn94+JENGGqU6a/Cz8oImmDf5YYTFjwNzFVaCaL0JKwZO2SQT2svHt
         WpYMa5BeectvkFLm9dbMpGSbQEARB5c8PrC5Po6GYX9n+7WdZNcvcAVZwsUnKh7N4i7O
         vLytNheFm2cbOlhUbS1VoP3Q+IeELu0AxS55eABmaike7EQNjDUohTJ+6TpNBfblbw76
         Ui2V5H7gtLcbVDmmSzcIwtt6FDsOSeTXEPfo8EkWruyzkM2eL4oeqaLSiUl/SeaSfwOe
         4/BCnkanSn46q933zEDzXbyxtGBUGKE34rRaXwFiDPK9g6Yu0DfO70d3UwoqC7UlL3Fg
         XSkQ==
X-Gm-Message-State: ACrzQf1gAXTuIJOIN+cfHN636T23RGJfUR71oYL2wTNe2ymnRw5JvpSi
        eiTnqu0eB1dkHQfH5GCGo+9hph3Ty2uYsRhLSw1c1dpengUu1XF3tF/yV5DDNgH0M+5NUPNQQgD
        hLjjVSZhGzVIn66eS8g==
X-Received: by 2002:a05:622a:1750:b0:39a:82aa:f4ab with SMTP id l16-20020a05622a175000b0039a82aaf4abmr158426qtk.411.1665673529416;
        Thu, 13 Oct 2022 08:05:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4akR7kqT64cCzj7bk7BqYlk71vDO2VOJFCMDlit5F5D27HgXhm5LP4OUr1Om3twnXkXnr2WQ==
X-Received: by 2002:a05:622a:1750:b0:39a:82aa:f4ab with SMTP id l16-20020a05622a175000b0039a82aaf4abmr158386qtk.411.1665673529080;
        Thu, 13 Oct 2022 08:05:29 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t12-20020a37aa0c000000b006eeb25369e9sm2667504qke.25.2022.10.13.08.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:05:28 -0700 (PDT)
Date:   Thu, 13 Oct 2022 23:05:24 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/053: remove test for i_version mount option
Message-ID: <20221013150524.rxmfkgarap37fsct@zlang-mailbox>
References: <20221013144844.90320-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013144844.90320-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 13, 2022 at 10:48:44AM -0400, Theodore Ts'o wrote:
> The i_version mount option is deprecated in favor of iversion and is
> advertised to be removed in 5.20.  It was removed in commit
> 1ff20307393e ("ext4: unconditionally enable the i_version counter") in
> Linux v6.1.  So remove the test from ext4/053.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/ext4/053 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/ext4/053 b/tests/ext4/053
> index 5d2c478aa..4f20d217d 100755
> --- a/tests/ext4/053
> +++ b/tests/ext4/053
> @@ -480,7 +480,6 @@ for fstype in ext2 ext3 ext4; do
>  	mnt barrier=1 barrier
>  	mnt barrier=99 barrier
>  	mnt -t nobarrier
> -	mnt i_version
>  	mnt stripe=512
>  	only_ext4 mnt delalloc
>  	only_ext4 mnt -t nodelalloc
> -- 
> 2.31.0
> 

