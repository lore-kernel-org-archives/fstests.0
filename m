Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA02296BAA
	for <fstests@vger.kernel.org>; Sat, 22 Nov 2025 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763797280; cv=none; b=IspLFRHOCypSJBExTUGxzQGNSeNvJvm8pcPzcr3sU8jSWG7sqC6ta9AcPD4tpZAE1nyTE6/woeW0dpIwqIEXpRyAP7NtaryJ1YFbpHYtCwqjmvMG6SvjUd1Pb/bhd/Zsu2F3MJoKW8t5PqQCzfvEu3pP+YzDw3y+yMgNewD3Hmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763797280; c=relaxed/simple;
	bh=i5ISNR6vMM/F/kla/kmJr+XHj4sLn6qvyzzfnXmHaXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEkgmWyaYN78WbbxGpAMHzlk+rlqnukYcjU8fR11HzMKnU8gE3tGykiQzehBLUYZ6Gp1l7EO1AOJ9PGEaKr4zaGG9szB9eqmU/+4zHvPdyF6016IcgRtY4j0ukbZfJGZ5qbb6zZuWzt5QXmyzPBDYvZDW5rtQmXqDMRlsOrZELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHQbuKlV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdkHG4U8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHQbuKlV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdkHG4U8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763797278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2lzzkrYSefFSUe5bJI0RBijIkjMIBc7EYqbMfwC7QqQ=;
	b=cHQbuKlVaF8mbdP9MS8soAC0IW+oaUgLXunT2rbI5548qxNjVxmV/76iD1lNw0YRjKxTgL
	PBybbXLx21iBWuBjCKEPYblht61rTQl8chd7veQkJcOgnR3JEcsI3eWbR1uYsWR+ofhulv
	KgBnNvXWTuoTea4hfpjojK+zH4Nqwto=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-otjT3DNVPsC4-OWTXm10lw-1; Sat, 22 Nov 2025 02:41:16 -0500
X-MC-Unique: otjT3DNVPsC4-OWTXm10lw-1
X-Mimecast-MFC-AGG-ID: otjT3DNVPsC4-OWTXm10lw_1763797275
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29557f43d56so37193925ad.3
        for <fstests@vger.kernel.org>; Fri, 21 Nov 2025 23:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763797275; x=1764402075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2lzzkrYSefFSUe5bJI0RBijIkjMIBc7EYqbMfwC7QqQ=;
        b=PdkHG4U8/PwaUULJIvS/p23vFfVrP32BYhbMH3//oNcD1IaFFs7NvAyoKYLH175RN8
         Z9ftzrrice2dUMArj5KbzPo0Z5cP4wh/UpppRN8GyhHL/CUDOuvOSvLCuqcheFOxmmjj
         jVTO2vQI1hbVslG+y7ewmn+DV+++UYBS5w6afZHaLI4bRWCqzA3Ng5cCvPaFUyK/t0xc
         2Wwf73b8DC1JLu4WZ9WVEkDPpQ1vVkhdmpJEWCMvil3xvF4HD2/BMFFN7wakmpwHZAKo
         AEDSdHLa4lXXlyarohvpY2UGz78hItXXzzm33KYgMeHCKg5GG9sDa4wDRI87MFrhBpfs
         rmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763797275; x=1764402075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lzzkrYSefFSUe5bJI0RBijIkjMIBc7EYqbMfwC7QqQ=;
        b=Pi9RDowENj1hK+K9DsZ+WilnWyIDke/fKI2HH4JqfPlClEK5KehimZe5eBx9Vj2Ahg
         iCtZ83LL8XVjiunZp4Bx3JKR8bYkcwozOF6te3nqMYGr7iz4mzZ/EO8xAgWuq0q7B0s3
         kYT6jLLbqrBoOVNtvbHKEijrXpzvKUWCn/F7b2fAzOduXOgvEkkMS3n5TIlEJZgxqI7n
         EsnVDy/oRpsz9T66ZkZj9Qzdqfb2lf8X14VJccuLh87s183v92YXqQQIezy0LrGZZUND
         At6qI14QbRHjZUh4QEXVq8ZHM1MOEnoF8aMBNXqNTDqp5+kdFu9Mhx2zYMTBhlcRpYKK
         A3Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVCHuwhMnMf3j09/XGhdhIOanry2+RA2ifGRLakM9GP7xcS9IdyPmYWOlwSlbEbYEU7bJ3p6W1d@vger.kernel.org
X-Gm-Message-State: AOJu0YyS4TZVILWBCdkeUzF15eAhw+qpIOnRcPfUF9JozesIQRTPcRfH
	rHzLK09X2V5iLNKPlsEaQUhSBRmsyQdi0uChNgLGUybB+xLV0wy2eaX10Ub450/lSVMu9jWZnKr
	c2ILrp4Rh330UZeh+LVsj/I+3qmBzpRTR+vB3c3tpQKnXURLGqBpqakEh7vE=
X-Gm-Gg: ASbGncu6YrhO9ZIEPbp2MfNVBBQNhlMN1dAsDvMFvqwCR2V6MNDl+UD6+8gm6JtGooR
	Y3wwFWauvasPzIUyu5XKKvCDDGcTOeKS8yrGDlflbsh73q2VDXUObBrS7eEoM4ihQ2u5voK1Lbk
	vGutgPb3b9foczfqWWbkY9n6hwcQ58Fw3JZmutt9Z9W49mn+tVW0oY7xYC110ElPAOtk67y42GF
	+Xtzj52wROj3x/exM4xfZgbekzhmczzR/zHsPJJcvQEXnHu83I2BlEnVVBbYZvzP1JY6bMta2Uz
	ZfM1dH9iTer19O7ptf1s/hW/iuy/6Tym3+fS+mnsQc9U3TNsgKRM+Esoz45cUCysCdZfBikXyGo
	WfNmVRt2oAkKvAEn1uNq84ZUPxz4XrNFDFeczBI52I0W9B1HUpw==
X-Received: by 2002:a17:903:3c46:b0:269:82a5:f9e9 with SMTP id d9443c01a7336-29b6bf3bdc4mr61786055ad.29.1763797274884;
        Fri, 21 Nov 2025 23:41:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeQbPuHNYN4oOKN5LWmPMEd3/TkK5RwO8DF2irVXxmUm2vCXD3Fwsq79Vn2QYwDeataKTxwQ==
X-Received: by 2002:a17:903:3c46:b0:269:82a5:f9e9 with SMTP id d9443c01a7336-29b6bf3bdc4mr61785875ad.29.1763797274388;
        Fri, 21 Nov 2025 23:41:14 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2a6b22sm76166955ad.86.2025.11.21.23.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 23:41:13 -0800 (PST)
Date: Sat, 22 Nov 2025 15:41:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: cem@kernel.org
Cc: zlang@kernel.org, hch@lst.de, hans.holmberg@wdc.com,
	johannes.thumshirn@wdc.com, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/2] common/zoned: enable passing a custom capacity
Message-ID: <20251122074108.x4zenebioteynejq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251120160901.63810-1-cem@kernel.org>
 <20251120160901.63810-2-cem@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120160901.63810-2-cem@kernel.org>

On Thu, Nov 20, 2025 at 05:08:29PM +0100, cem@kernel.org wrote:
> From: Carlos Maiolino <cem@kernel.org>
> 
> Extend _create_zloop() to accept a custom zone capacity.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  common/zoned | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/common/zoned b/common/zoned
> index 88b81de5db4d..51c011b247d2 100644
> --- a/common/zoned
> +++ b/common/zoned
> @@ -61,7 +61,7 @@ _find_next_zloop()
>  }
>  
>  # Create a zloop device
> -# usage: _create_zloop <base_dir> <zone_size> <nr_conv_zones>
> +# usage: _create_zloop <base_dir> <zone_size> <nr_conv_zones> <zone_capacity>

Actually from the logic of _create_zloop, these 4 arguments are optional, not
necessary, so the "<...>" should be "[...]"

>  _create_zloop()
>  {
>      local id="$(_find_next_zloop)"
> @@ -80,9 +80,13 @@ _create_zloop()
>          local conv_zones=",conv_zones=$3"
>      fi
>  
> +    if [ -n "$4" ]; then
> +	local zone_capacity=",zone_capacity_mb=$4"
> +    fi
> +
>      mkdir -p "$zloop_base/$id"
>  
> -    local zloop_args="add id=$id,base_dir=$zloop_base$zone_size$conv_zones"
> +    local zloop_args="add id=$id,base_dir=$zloop_base$zone_size$conv_zones$zone_capacity"

If the "zone_capacity" isn't a new feature which need a _require_ helper to check
it's supported, then this patch looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>      echo "$zloop_args" > /dev/zloop-control || \
>          _fail "cannot create zloop device"
> -- 
> 2.51.1
> 

