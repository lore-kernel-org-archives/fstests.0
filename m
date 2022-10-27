Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FB5FA3740
	for <linux-fstests@archiver.kernel.org>; Thu, 27 Oct 2022 12:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiJ0M4P (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 27 Oct 2022 08:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiJ0M4O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 27 Oct 2022 08:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29C261755
        for <fstests@vger.kernel.org>; Thu, 27 Oct 2022 05:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666875373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WMSwF060H2g+KMRoX/GNSVdcFUqfmSUoNCnHJHL7JbE=;
        b=ETHbvw+dhgoUD0iBSfcsHMsqOxuJhZf9NroFXIAMFBUh5Jr0ef6sL/sSdzIhhhFJI6yJRw
        dvqVlSULKqBfxfXA67WQ6p4CPPeviXWdmuvAsdMxj1yq2Wyr2OdKkEx1nZ4G7hVbIxbvlN
        /3p+KF6gBTHt35wB5iVBqur9SpNC+5w=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-530-97Oztj3BNtaNGEOtRDvikg-1; Thu, 27 Oct 2022 08:56:10 -0400
X-MC-Unique: 97Oztj3BNtaNGEOtRDvikg-1
Received: by mail-pj1-f72.google.com with SMTP id j21-20020a17090a7e9500b00212b3905d87so820920pjl.9
        for <fstests@vger.kernel.org>; Thu, 27 Oct 2022 05:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMSwF060H2g+KMRoX/GNSVdcFUqfmSUoNCnHJHL7JbE=;
        b=6VhRBnvs+7x5FDHfP/E90VTmhJdWsQvSsBmKz+bC9LHv0OmrlGrGYcvXVZQ7KJp88K
         nCDbQ4Bi8OakfoFzl7J1/bMcPyE1ivFONE91DxJPeS1Z+6cbzSssoyGKo9G+qkDb2ROG
         QFkUQw3N8J+0ZzoE4gb8Sv0Xssq9czRqpzxWDjo6ujimPz+Jl/r98JAbR44ON2u00WRT
         fSIeHntTztPHex8Y1EQBKJ/rSeLjFH5nPs1KHrXpzBPkdtM+FhTp6l6bibl9ZsuQJDpi
         RDJN/72iLNb/BY6cxOr0FFg5eBNEiGRg1B6m6+oEWpzrZa3padeu/MCY1wNty60k4ZvN
         elCg==
X-Gm-Message-State: ACrzQf1cgiEEJCagDpgCFErwviOy/tCM49ZjbaRgvKhKqB53fxvY1SUG
        Uaek9qG6FkujaqsrBrC59y+g2bm4KdS0xl00BhKh6zRixc0TC7qbFwj2qxzSBp5gHiXlS1Zt1Ay
        HkGYwjAyWR+XznVNCPA==
X-Received: by 2002:a63:8943:0:b0:46f:3a91:3618 with SMTP id v64-20020a638943000000b0046f3a913618mr9581773pgd.16.1666875369525;
        Thu, 27 Oct 2022 05:56:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6LcGYOw1KEv4brzej4F4BOR3aPBHNn4xm3K6kcotkbdmYs51YvEMV3XFWYUpGzXbParUt6nQ==
X-Received: by 2002:a63:8943:0:b0:46f:3a91:3618 with SMTP id v64-20020a638943000000b0046f3a913618mr9581752pgd.16.1666875369243;
        Thu, 27 Oct 2022 05:56:09 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902e54100b0016be834d54asm1119869plf.306.2022.10.27.05.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 05:56:08 -0700 (PDT)
Date:   Thu, 27 Oct 2022 20:56:04 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     xiubli@redhat.com
Cc:     fstests@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH v2] encrypt: add ceph support
Message-ID: <20221027125604.d2v7ubyfmuxuu73t@zlang-mailbox>
References: <20221027030021.296548-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027030021.296548-1-xiubli@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 27, 2022 at 11:00:21AM +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---

According to more details (in this mail thread) about this patch, I think
this patch works. So I'd like to give it my:

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/encrypt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/encrypt b/common/encrypt
> index 45ce0954..1a77e23b 100644
> --- a/common/encrypt
> +++ b/common/encrypt
> @@ -153,6 +153,9 @@ _scratch_mkfs_encrypted()
>  		# erase the UBI volume; reformated automatically on next mount
>  		$UBIUPDATEVOL_PROG ${SCRATCH_DEV} -t
>  		;;
> +	ceph)
> +		_scratch_cleanup_files
> +		;;
>  	*)
>  		_notrun "No encryption support for $FSTYP"
>  		;;
> -- 
> 2.31.1
> 

