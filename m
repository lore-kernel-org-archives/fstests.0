Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6762351007
	for <fstests@vger.kernel.org>; Thu, 11 Jan 2024 20:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUQfFRXt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705005418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=30F1wNNwWIh6zVGXv/89lnDFr/vRKYELTtft779wwuE=;
	b=cUQfFRXtlPplrSSekeEYdqQM5U+UJI3yb1pFzEvBWJcGw05anKt1ZV+pb5sEG2DyazIcUD
	Qj6ZZGuaD2bS8enS0CiAv9MVNF39XhIyR2DsWmS4GyazcYwRuAcFGroeXv7kiVCB1izSzI
	8D6Wt2+Zz4hyc1qWWgt0oGpcn1twcXs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-Yay0VToeOzu3NFbLtlS54w-1; Thu, 11 Jan 2024 15:36:56 -0500
X-MC-Unique: Yay0VToeOzu3NFbLtlS54w-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d4a87da75dso38076715ad.1
        for <fstests@vger.kernel.org>; Thu, 11 Jan 2024 12:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705005416; x=1705610216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30F1wNNwWIh6zVGXv/89lnDFr/vRKYELTtft779wwuE=;
        b=HZBLdsrC6Zi0tVZA/22him04k53QT/H6D2pk6KSClCx53jdTAYxmtj+2mikxhMIjMV
         cnZ5gpF2lyvczfhOjcszKfXTRohzbHxCAvJnUcgYnz6uq/lDLEg3XqPrXIGx8Hn60y6E
         xNS9rziutiRoSbZyTZK4ZGLULnoP5rdsCQbJrZ93uJWLr5sDz77QDKD6oE3SyBv3zDTH
         SQ4MQDSoq4cMjVSS3MneD5eVTlC5mVykN4yyFjeQJSCxqXG7uCF77DIW7tccvStR6F+T
         y6/ELX/ccZqX6tLPc4uPH88gN5yilQZCj1t45GedoeGz8xV2/DwBTd2xaJrmZFcFv9+Z
         fggA==
X-Gm-Message-State: AOJu0YyONKwJDDokxVVuKHcrHSJrO/IiIG3XRaEda5zYcLpsjzUMb1IL
	lZaVfxwgCOV966z6iyc0r4k2E5CIEwW8ggSIV58zcCTx1l79wILSlSLM/6AlHGur2/Yp234s/MQ
	VsSA9pj/KRAyHnGBy8R5zp5mh/A==
X-Received: by 2002:a17:902:c44c:b0:1d4:e2f9:2ab0 with SMTP id m12-20020a170902c44c00b001d4e2f92ab0mr270392plm.103.1705005415846;
        Thu, 11 Jan 2024 12:36:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE21OfbmJaOik8i0sbLQuC4KzuqV0GDevBJZJt5RcILVBvfdRXq2sGa3Ny1UCeLZ/kMmKYybg==
X-Received: by 2002:a17:902:c44c:b0:1d4:e2f9:2ab0 with SMTP id m12-20020a170902c44c00b001d4e2f92ab0mr270385plm.103.1705005415555;
        Thu, 11 Jan 2024 12:36:55 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kt11-20020a170903088b00b001d4bc96b204sm1555492plb.304.2024.01.11.12.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 12:36:55 -0800 (PST)
Date: Fri, 12 Jan 2024 04:36:52 +0800
From: Zorro Lang <zlang@redhat.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/390: Fix test number in comment
Message-ID: <20240111203652.ygli2cwqynzh53uh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240111152658.4318-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111152658.4318-1-agruenba@redhat.com>

On Thu, Jan 11, 2024 at 04:26:58PM +0100, Andreas Gruenbacher wrote:
> Fix a comment in generic/390 to refer to the right test number.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---

OK, thanks for fixing it ;)

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/390 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/390 b/tests/generic/390
> index e8f6a5dc..9a5feeb1 100755
> --- a/tests/generic/390
> +++ b/tests/generic/390
> @@ -2,7 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
>  #
> -# FS QA Test 999
> +# FS QA Test 390
>  #
>  # Multi-threads freeze/unfreeze testing. This's a stress test case,
>  # it won't do functional check.
> -- 
> 2.43.0
> 
> 

