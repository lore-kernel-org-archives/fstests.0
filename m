Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A7D10940
	for <fstests@vger.kernel.org>; Sun,  5 Nov 2023 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECuupG0q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF41BE
	for <fstests@vger.kernel.org>; Sun,  5 Nov 2023 10:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699208712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZvSW7uA9jieleDU4V1l+y2j5a8KC5zzZKSr0A2sRUo=;
	b=ECuupG0q5rtYFYKSzw37+ilBSLzyLQCoe/vLenUMM/8zs8Et2UKI50FNtuDm6SebxHrDI6
	pxLUmRO8hrb24bee6G10ImkaS0NKedTkf/AbPjqFMMvr31Gp17HadxXf8mP2copWcRuizk
	Y6y+mNPTszHj1FrEttDAVD5cd+HT2KI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-s8tbB8fXN2yOxMF6Eq7i4g-1; Sun, 05 Nov 2023 13:25:10 -0500
X-MC-Unique: s8tbB8fXN2yOxMF6Eq7i4g-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5b7fb057153so2998785a12.1
        for <fstests@vger.kernel.org>; Sun, 05 Nov 2023 10:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699208709; x=1699813509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZvSW7uA9jieleDU4V1l+y2j5a8KC5zzZKSr0A2sRUo=;
        b=Je2Dw8btJdFsCKMVp9tGhlmx10/oQptI2jRe6+yB8RD3IqaqvkvewXri1Hlf6MJuAH
         h7IwqEIP6m8IGgrmg8OI0UHbPmJuPhJvMCymh8k0jcFwXxDcDdI3+ojID9nuoiqmfpba
         5NFzGqncIAN7YNJmb7rH9FQQAqSmo7e52/4VdjZdTqrzZ2jBu3bfGZw4MFnyRjeJm9Po
         GmKruZPC7EqitnxdpYsFEYXxu+daRHvNg5peehY7CShYxM2G8uhFMg5rhImOvWm+JBu3
         yc9l0PpcoaXNvmMcZjy3Vya7hAANzsb2/wp4HKe3jlzEDGi281Q9qK58VWIjqEywjkRC
         UJng==
X-Gm-Message-State: AOJu0Yzj+gzfmpzDI1155ZmGtIWBGtl/4kba1Ao0a93REpi16sRMag6d
	K/fLXL1fu/81IZN5zSzzvnWq1E44HiCNGXYiSwvwhUcavS/d7eTAGrTf0ClB1WXQT9+YQCStUSz
	HNdIfYekS0BFYL11eRqQF5n1H1w==
X-Received: by 2002:a05:6a20:258e:b0:159:c2d0:9fc6 with SMTP id k14-20020a056a20258e00b00159c2d09fc6mr32635740pzd.8.1699208709236;
        Sun, 05 Nov 2023 10:25:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGghWQbWznyKAKA7w24WfPqn63pMT4znnEl92c4t0wELzPtmlrDS3qzFFLeSV8UB7iBdKz+7A==
X-Received: by 2002:a05:6a20:258e:b0:159:c2d0:9fc6 with SMTP id k14-20020a056a20258e00b00159c2d09fc6mr32635729pzd.8.1699208708844;
        Sun, 05 Nov 2023 10:25:08 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p55-20020a056a0026f700b006c2d53e0b5fsm4326635pfw.57.2023.11.05.10.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 10:25:08 -0800 (PST)
Date: Mon, 6 Nov 2023 02:25:04 +0800
From: Zorro Lang <zlang@redhat.com>
To: Khem Raj <raj.khem@gmail.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] ltp/fsx.h: Explicitly use int for return type for
 aio_rw()
Message-ID: <20231105182504.gzkm737ug4fvtxrd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231105082014.1010683-1-raj.khem@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105082014.1010683-1-raj.khem@gmail.com>

On Sun, Nov 05, 2023 at 01:20:14AM -0700, Khem Raj wrote:
> Fixes build with clang-17+
> error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---

You've fixed this bug with below commit:

commit ab81b565f360218e63d71d33d244edae608f9e7a
Author: Khem Raj <raj.khem@gmail.com>
Date:   Wed Sep 27 15:16:17 2023 +0200

    fsx: Add a return type to aio_rw

Please try to rebase to the latest upstream xfstests, and check that.

Thanks,
Zorro

>  ltp/fsx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index ee4b8fe4..c0aec23f 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -2581,7 +2581,7 @@ out_error:
>  	return -1;
>  }
>  #else
> -aio_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
> +int aio_rw(int rw, int fd, char *buf, unsigned len, unsigned offset)
>  {
>  	fprintf(stderr, "io_rw: need AIO support!\n");
>  	exit(111);
> -- 
> 2.42.1
> 
> 

