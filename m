Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB6DC83F12
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Aug 2023 03:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjH2Dsy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Aug 2023 23:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjH2DsW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Aug 2023 23:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EEB132
        for <fstests@vger.kernel.org>; Mon, 28 Aug 2023 20:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693280853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PXcX9C+8dwtnHfSDi+diV9zwhmNht4+RCt1TTmBpwhA=;
        b=NqMhLvIURwDBdDbWPXJ/wjbvugdQKrusWdpQnpgcVnfX+cVABhzbup3YzmtnDlq2ZA67/w
        gbkBSXd4+nvbOqL6YsN6y3jP5H5w2YUMAS50nOwut3FdwaNqmkEhDKykpR4jgJwKbef3M1
        Ev7PRaokfX0FRqLUWaKPK5EJ4ncGNm0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-Z2r7o7M1P9enQCh-z-OpgA-1; Mon, 28 Aug 2023 23:47:32 -0400
X-MC-Unique: Z2r7o7M1P9enQCh-z-OpgA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1c08a15fcf4so40134055ad.3
        for <fstests@vger.kernel.org>; Mon, 28 Aug 2023 20:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693280851; x=1693885651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXcX9C+8dwtnHfSDi+diV9zwhmNht4+RCt1TTmBpwhA=;
        b=g0brjMl5rdSsT4BFCnr43enO1qVxJC/jglwiYBeDQIlmQ+0dSaZhth43ATpPm6505b
         couaLX9AczFdPznM6xbSwQ+Oh900OtMFzICtgHUO2mTbU6PIx8AfGTQHH+g8E9JRGVXO
         34ANv5KUbLi01lxcRJAWx3LH7+/roylYIARzaYFuWRdqTH3awV76sYL8UIFh44Gbn3CU
         BxD4/wysmdua3PNH28BfPK8ze3NsucZA2jfow1mg9YYnD+Z02Y0j2MLiPZDDfDSs3QJC
         ns7NY842PTzUZUYporC1y/WqOOuDY3o6H8d1cGxOTSRgtEJi0GDF5HqBh0guH7n0F5Fu
         HPOQ==
X-Gm-Message-State: AOJu0YzqKGfQ5I0FOi7i941ftBxGs2ja6z0rP6wpONJrfx5PXdJDluim
        bnvMAhfltGckAJwyyGxGqjHuq4jtUQsaq9SVuMXAQAh4bwoYU4nx7k0yuIV2kfF0/q3S5o8Kfya
        Hw1mmEzA0ELhIYmSrj7zEz23/Uz4P
X-Received: by 2002:a17:902:c951:b0:1bd:f314:7896 with SMTP id i17-20020a170902c95100b001bdf3147896mr27572221pla.25.1693280851025;
        Mon, 28 Aug 2023 20:47:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBLlsZ2uhtyHBz2jxsqAZJjGa0Qpq99UOQBHFRF+FDpNmnZzAOJeoKX0DsioPprS0ED2ZJ0g==
X-Received: by 2002:a17:902:c951:b0:1bd:f314:7896 with SMTP id i17-20020a170902c95100b001bdf3147896mr27572210pla.25.1693280850720;
        Mon, 28 Aug 2023 20:47:30 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902ec0200b001b54d064a4bsm8221031pld.259.2023.08.28.20.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 20:47:30 -0700 (PDT)
Date:   Tue, 29 Aug 2023 11:47:27 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] aio-dio-write-verify: check for the IO errors
Message-ID: <20230829034727.p747xzy7hfwicypl@zlang-mailbox>
References: <cover.1692688971.git.naohiro.aota@wdc.com>
 <2c9519c024e39b6eb4a3bb93f448752cedd83894.1692688971.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c9519c024e39b6eb4a3bb93f448752cedd83894.1692688971.git.naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 22, 2023 at 04:28:50PM +0900, Naohiro Aota wrote:
> The async write IOs can return some errors, which may lead to a short read or
> corruption in io_verify() stage. Catch an error early to identify the root
> cause easily.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---

Looks good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  src/aio-dio-regress/aio-dio-write-verify.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/src/aio-dio-regress/aio-dio-write-verify.c b/src/aio-dio-regress/aio-dio-write-verify.c
> index 302b8fe4a096..90e41b391289 100644
> --- a/src/aio-dio-regress/aio-dio-write-verify.c
> +++ b/src/aio-dio-regress/aio-dio-write-verify.c
> @@ -238,6 +238,16 @@ static int io_write(int fd, int num_events)
>  		return 1;
>  	}
>  
> +	for (i = 0; i < num_events; i++) {
> +		int err = (int)evs[i].res;
> +
> +		if (err < 0) {
> +			fprintf(stderr, "error %s with event %d\n",
> +				strerror(err), i);
> +			return 1;
> +		}
> +	}
> +
>  	/* Try to destroy at here, not necessary, so don't check result */
>  	io_destroy(ctx);
>  
> -- 
> 2.41.0
> 

