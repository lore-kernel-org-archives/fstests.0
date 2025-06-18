Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C551E260A
	for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750262835; cv=none; b=JIUH9yCwlP2OSWVHWk+wS5JHocZMOVzkmqZNWBN6S+Ekig1z69+t83fr8jS2Sa9Ac6+/8YJtix8gkyEVb7BzW0jJm/boFXP4yUYPS4EDIDUXITSHpQGK0CFrBK0dAqTck9p5q02Kaju53zrAfYlkjPrVJfvHgtz7wmJNSggURM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750262835; c=relaxed/simple;
	bh=nHpc+6YnSrngGD4GXck/SwGuACJWgB4b3xT7xDc2FIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIYBkS4DadxW2jQ/X3fdX4HyEvDbc4OeA9/BU/OdUUiBldTJeg0ydLO0nJjL/NpCVqfDc5zWNP2XzkwYTnzHPyyoGJYtL+0xQyewITnKn3FyXs1wiF1WDk6qLv18W7VvoDMlxQezSyPVXju4JxGAO35j5aFTH8oyFCwWHZhCeDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9ON5lv7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9ON5lv7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750262832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2FY8wiUut0zo1DgtYoO4FhQPyvJ7DmXWu5/brFsGU+g=;
	b=M9ON5lv7B2L20As15V7bEh2nM77yVQ4xeqEI5cSWgfdJitUjjeyViLwVRaY0n4kpgivhMV
	e2hM3M9pUQfphQPd4B6bXcHl+imEZ+VrfSlhgjShyZwx2z0NnNgThWTHGPF17njjBcacgk
	UORzj/YRUAS2VoIiLl4f2++4HuCBeZY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-SIhai4UZPdCFyLAPJtODkA-1; Wed, 18 Jun 2025 12:07:05 -0400
X-MC-Unique: SIhai4UZPdCFyLAPJtODkA-1
X-Mimecast-MFC-AGG-ID: SIhai4UZPdCFyLAPJtODkA_1750262824
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-313f702d37fso3700486a91.3
        for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 09:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750262824; x=1750867624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FY8wiUut0zo1DgtYoO4FhQPyvJ7DmXWu5/brFsGU+g=;
        b=m/fbeZNYuLeqPfHcRSYvdIRJq8AxkdVPsZ+dMAM37iqWZwtNesPg/y3AuN/6cMf9cK
         tJeT1r2YOaO1qMmbBJTuBuexlqR7Kb6xr+0MJ8X+hT/TT1tK0vtUXxfgNTjsd4IWaj01
         1mtfc/uAKPhNcj5+QciNPoNx70D+SGvV0L/Qg/NGGbTjvM+tFmlVbW9BT2zhpbTMI2B3
         UzgJ/CleQpJbY0O3q9OebTON/TtDXcRVAxnb8pZZ20Tex9wHjEPCrxvjSlQYTYAfks9I
         rfdm3yFQHQQmXzvZmUyICmY+YKI/g2/retfT0bslHtdWWSomfMGn/1L1H2OR6cWSuTvl
         idSw==
X-Gm-Message-State: AOJu0Yz4t+lNe6fR/DvDRRcz/hG3+aoSANYugZKP0oG+OhkLQghkoySL
	I5kgp47rbEt4vWlr7aEHlcLGHppCp0PIzcYlKtbQwWDi3y4OR/RBg1wTix39mw8zPpQrEv+8/Ln
	Kbbe9TL463lN3y1LG6vzXRpnLVZdE0FGTHN5r75ucE5HkRZHV1D2h2hfEG7w=
X-Gm-Gg: ASbGncueaOe4AN2qoW1Vno3ONIPeV0cJiOoUXzDMOVPuXxLQJ+jICZM766ryK6hT23Q
	X3oaiLqNl8Qui4hvZbH6boLoeAsF5kRJoqizCdts9PA94yUTBZcxoyIeXrr9yTEwOZuYd3/YhM2
	AdplXCg7OfkyrWeWlq6+vKdGJTzz5bErVidATgazsbfs1xnRhAjVXab8FNLahkW6hJMx+AGnBFL
	kZ3Tyg11ueE0i8ilHJtbuVVcx0lRzbYP+RgxjTBWYwhloQ1NVnS1vtDgVSe+c1dKWtZo7l6DttA
	0liHgZoetZVWdHvdnOAFMbF+Q+pWDg7clFjKmCEbYdQFeFaGCrymQ4qnirb+Dyo=
X-Received: by 2002:a17:902:ce8a:b0:234:d10d:9f9f with SMTP id d9443c01a7336-2366b14e571mr284265215ad.40.1750262823807;
        Wed, 18 Jun 2025 09:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdnEmweHNWsTB20U3D+CwVeSBK3RUOh6xl+zoNVkoujUDTuWMB6OBJqWApoo9CNHUIIXAeAw==
X-Received: by 2002:a17:902:ce8a:b0:234:d10d:9f9f with SMTP id d9443c01a7336-2366b14e571mr284261035ad.40.1750262820111;
        Wed, 18 Jun 2025 09:07:00 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a19d7sm102214425ad.83.2025.06.18.09.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:06:59 -0700 (PDT)
Date: Thu, 19 Jun 2025 00:06:56 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] src/fill2: fix segfault during fopen error cleanup
Message-ID: <20250618160656.rnrb6sdfq65asizo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250612190513.8669-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612190513.8669-1-ailiop@suse.com>

On Thu, Jun 12, 2025 at 09:05:13PM +0200, Anthony Iliopoulos wrote:
> When fill2 fails to open the output file (e.g. due to ENOSPC), it jumps
> into the cleanup code where it attempts to call fclose, and this causes
> a segfault within the glibc fclose code as it attempts to deref a null
> pointer.
> 
> Fix it by conditionally calling fclose on the file pointer only when
> non-null.
> 
> This is consistently reproducible with xfs/041.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  src/fill2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/fill2.c b/src/fill2.c
> index 4cc1c3d79a98..37ed00b1d9b1 100644
> --- a/src/fill2.c
> +++ b/src/fill2.c
> @@ -307,7 +307,7 @@ main(int argc, char **argv)
>   cleanup:
>  
>      /* close file and flush buffers - check if this fails */
> -    if (fclose(f) != 0) {
> +    if (f && fclose(f) != 0) {

Make sense to me, thanks for fixing it.
Reviewed-by: Zorro lang <zlang@redhat.com>

>  	fprintf(stderr, "fill2: fclose() on \"%s\" failed: %s\n",
>  		dfile, strerror(errno));
>  	status = 1;
> -- 
> 2.44.0
> 
> 

