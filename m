Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12025258
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702742; cv=none; b=WuXI8IB1I3lZSzbG+aOO3e/0nRx0SvODishgAS3xrxS8IoQf/+VuNIV/iNCOLugSgcVc1iYzOQV5B4UIBw+X9WaPsJN6WwFLOcaB+Mp8j+G1iTbTgNaR7txIY9+u+wPxX0PfmcPODDZhJWJzhGrcecyTLhsXplWKKxaaRk1CiBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702742; c=relaxed/simple;
	bh=aSTJP1De0b/UVr2EWtRFJuikXzA4EeGkTC/NhjwY2iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkhJ7RTknhAHdFdONn9ydRdrpctPjURnFlHkgXA2Rbw9sqZ3h8OXQEx2FLw2FuYo0jYEiJzDe9rW8RKL9Re1m9/Ffedc6BCX3wrzplLYPU9FcKN3Qx2uEJXTOkPCvKSSPXEkiQtXJgY+azLZzgWA1BnQ0B+KsvegFrzVLRzrPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/cC3/UC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/cC3/UC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741702739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=53XH3kuajGlBpjomZB1JhqXApbCioeI/k4JtST4IrY0=;
	b=b/cC3/UCCn3JOQ+JTXo3E/ebRk4BcUR3y/gI/SJYJTWaT+GYkQazkt/YVi2B2moJp9ztzh
	innl2+0VhD2m+QcSdAcZ3YEMYgu03c54qKXQzacptgSkaVdHx6Kv4DQC7cdasaVDZLqfCe
	z8ptse1Qf/1Ppkslz2l8eCYIGJ1H7DU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-ACTmGB7MMZCA3jVdCEKweQ-1; Tue, 11 Mar 2025 10:18:49 -0400
X-MC-Unique: ACTmGB7MMZCA3jVdCEKweQ-1
X-Mimecast-MFC-AGG-ID: ACTmGB7MMZCA3jVdCEKweQ_1741702727
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso15356102a91.1
        for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 07:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741702727; x=1742307527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53XH3kuajGlBpjomZB1JhqXApbCioeI/k4JtST4IrY0=;
        b=Nv9AI87j2xi1Fe57gELUx3eNfMKdQ4SmAdmKj6b94vbgY/ZDyjN23wznZz7J+Tzw0g
         ZQgNNs0+DBFggzreziNINxaJ+7oRQXytRF2MfspLzNlXTkrAjP6XsDYV2Cxd0e9Xf21L
         ClQXi3g5KikJ2xMrGo5cN5j5eN5oeCv6Qn7kbUQQj4Jp0fFMNkAKIsbkj1hTlVVN79vv
         P3QNytaEvd8hpPv8qpuSdejge6iMUwU40wnMZbGdGrqMBR8tdC/pxQZ0hsvspd/3BOGq
         4Rr2fzTUtXtqD6z4GTuxLNnZUWcvFC8OH6ko9KY/KqjhGY5rrqTWbUu2nVM4aq7utQlN
         2kuA==
X-Gm-Message-State: AOJu0YwrdlUZl+jrWZACXsKJ56weqCQx3YsfXHwyn/j4rlt+j6xZUEBG
	KONoowOPef0DcyIE0xohgvOi5YW0b3aVoED/9V2eVU3R+MTiKIZ12MohjPXbRoEFxmfj4LklEu/
	vdrPtZjuQHY/ocxhzpl9XGdg4jW/Z/85y8GoPM2Y9goqwdp5/g3qoqTg=
X-Gm-Gg: ASbGncsfyC9v1vhYF1hh0eSe8xHOud+Wbbqb+DFG5avq23D2fjKmtJJE/n/W27JuoW0
	6wAiOV0EVNoeNW0J0XbEtx++YxGZHQKb1n74eiLUgDvalzv93L1X+vcsR07T5ONYnMPEYVwXj5J
	A0pCgj3D2XLIF4jsWvmzJ5KrtRckmc4RYwesKkXQBG7RCg/vXobpl0dOQM3hn8qnBymx6l42stG
	xzHbkMkM4IZuPI3rIwZd6+PCQrKKBTsm5IPz5PXOkQrbp19FG2nO1PXI5POFjlfSGOxzrkdMQ16
	O/ClB12leIF//slacAg/HYwsqDp5Mw8TQyrZ/O9bYw+4rMaqjMd78M1k
X-Received: by 2002:a17:90b:3887:b0:2ee:d193:f3d5 with SMTP id 98e67ed59e1d1-2ff7ce59637mr28293914a91.7.1741702727097;
        Tue, 11 Mar 2025 07:18:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpKPdlPcIYLWxDRGRLePrODxtIvirak1ZUXzMeqJz9UPrAhZ3BIGw6KiWpGIyTeJbe7m/OLg==
X-Received: by 2002:a17:90b:3887:b0:2ee:d193:f3d5 with SMTP id 98e67ed59e1d1-2ff7ce59637mr28293884a91.7.1741702726732;
        Tue, 11 Mar 2025 07:18:46 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109dddd8sm97928755ad.12.2025.03.11.07.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:18:45 -0700 (PDT)
Date: Tue, 11 Mar 2025 22:18:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] common/rc: use getent when available
Message-ID: <20250311141841.4fessnivr6z6sxpd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <52747027-2915-4c92-a6e9-b0dce1cbe198@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52747027-2915-4c92-a6e9-b0dce1cbe198@redhat.com>

On Mon, Mar 10, 2025 at 12:55:51PM -0500, Eric Sandeen wrote:
> Zorro noticed that on systems using nss-altfiles, some tests failed when
> trying to parse /etc/passwd directly. The "getent" command does the
> right thing in this case, so let's use it as long as it's available.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---

Hahah, you're so fast:) This's similar with what I'm doing, so it's good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

I tend to use getent too, if anyone has any better idea, please feel free to
share.

Thanks,
Zorro

> 
> diff --git a/common/rc b/common/rc
> index 6592c835..50312331 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2621,7 +2621,11 @@ _yp_active()
>  _cat_passwd()
>  {
>  	[ $(_yp_active) -eq 0 ] && ypcat passwd
> -	cat /etc/passwd
> +	if type getent &>/dev/null; then
> +		getent passwd
> +	else
> +		cat /etc/passwd
> +	fi
>  }
>  
>  # cat the group file
> @@ -2629,7 +2633,11 @@ _cat_passwd()
>  _cat_group()
>  {
>  	[ $(_yp_active) -eq 0 ] && ypcat group
> -	cat /etc/group
> +	if type getent &>/dev/null; then
> +		getent group
> +	else
> +		cat /etc/group
> +	fi
>  }
>  
>  # check if a user exists in the system
> 
> 

