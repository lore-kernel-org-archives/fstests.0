Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D5312E71
	for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708879117; cv=none; b=eodHn8ZdCZsmwTH54JXA4S707CuIW8tOVux/xBlNqEmpBnOgN3/vSZB6QrbLXgn7OtStlLg8TyjNimrsePacIXHO1Np36IUvoIRG+lvkEs5jgOGskpTSdJcfaZZOw9bopAtTrSCVsy0IMBs5BCJjnKnqE4AcKBH9fVKIdYdU2ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708879117; c=relaxed/simple;
	bh=UCqTkXTA6LgnlAdiKrDdNeBduGWk2xf5nQNKZB5T3Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbHFH4UYxJ/m4WIZoNaUCMVNfIL3NBPpipMsVSkfe6O6f+0wrye4OThoOWJjsttl5AcqcsGv8KEyhbSjwH7MwUeFcwtJKFAkQrGt9w8z/zVUO/9G/64AwHrF7wezLHMF6R9L7MS8joMADCRY6oI1fDbj5qTbQ9pToMSJwl/dxiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csgByTgA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csgByTgA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708879115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gT00iK1792I1ru6cy3dmEyZDGBGyy5dsWmrhf416F50=;
	b=csgByTgAjhHSKTXuly0OvmfTbVYkUO/l3cG8yLJuX+QYXhZ87yEZzsua7dEQyGfR5DBaJK
	TPii5BgEI/YSpzOiY1aHCWrqSJBKCQLcSeVPx9bqbxSAN68A4jgTfv3+rXAy03ADbyKRek
	deVhxDcHYy7sMenWB5OyaNWXo3ekHjQ=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-AzIuYv3-MX-qpG4behhcHQ-1; Sun, 25 Feb 2024 11:38:33 -0500
X-MC-Unique: AzIuYv3-MX-qpG4behhcHQ-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-59fe9adf734so1997724eaf.1
        for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 08:38:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708879113; x=1709483913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gT00iK1792I1ru6cy3dmEyZDGBGyy5dsWmrhf416F50=;
        b=XifBRvTbi2Rz2b2wJqPPEfd2ZMNqbX5YHVOlqBcRaV8855fApSd0QWnVOsjmngEnXt
         dBTnwMOmbohQ2fH7vAfwgv7nTynAjbyfP0oo5P/6zI/eDzFBqAmCGnvE6yauprIKx6AT
         +oDrPFYd9UFsbaUllzFHoq+u3MXVU2AzlHVvC8OwilOhqeaty57QLubiNKVoPuvYiqM7
         RAC5/bnpXTehNOyAo9RjN/RHFxKALLXu/IstmaDhKWVM7nL8cfj8NowO8wv0w0NtIkkn
         pOdQJmyk0DH1e1DqAzPlrj9YLiiw1LBiMj1TNMAvsLGJI/bvM12sLyEQ+2m/pe4OfOB+
         3bSw==
X-Gm-Message-State: AOJu0YwTrwii+/OOpRTH/s0gr8b02OqdPn0PkU5Y+WpiiSWiP2/ajStw
	S7uKD+StSA+LKsbQb/WQ44rBBTUmbFGvzXdeaXVytBRbITlkSAyarD43EBhy9DeZLdaA8Mb0Nn/
	V8ftv7o+2GBUwDSOPK5P33fnOf7kboiwIJJSFsXip4C3m9JbejgzDtF8=
X-Received: by 2002:a05:6358:5484:b0:17a:f909:2cef with SMTP id v4-20020a056358548400b0017af9092cefmr5411427rwe.31.1708879113140;
        Sun, 25 Feb 2024 08:38:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTEyZX16SeUmrh06Nd3Kw38b4HWrd3T4V9wM3gv4GP/RwlXqtbMeJFCF71UKjQ0hg8dAfZNA==
X-Received: by 2002:a05:6358:5484:b0:17a:f909:2cef with SMTP id v4-20020a056358548400b0017af9092cefmr5411423rwe.31.1708879112824;
        Sun, 25 Feb 2024 08:38:32 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id sc9-20020a17090b510900b00298c633bd5fsm4813920pjb.30.2024.02.25.08.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:38:32 -0800 (PST)
Date: Mon, 26 Feb 2024 00:38:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] common: dm-error now supports zoned devices
Message-ID: <20240225163828.7a3tntpg5kaywlw7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240221063741.3563039-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221063741.3563039-1-hch@lst.de>

On Wed, Feb 21, 2024 at 07:37:41AM +0100, Christoph Hellwig wrote:
> Since kernel commit a951104333bd ("dm error: Add support for zoned block
> devices") dm-error fully supports zoned devices.  Make use of that to
> also run error injection tests for zoned device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  common/rc | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 524ffa02a..f207d8ab2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2193,12 +2193,10 @@ _require_dm_target()
>  		_notrun "This test requires dm $target support"
>  	fi
>  
> -	# dm-error cannot handle the zone information
> -	#
>  	# dm-snapshot and dm-thin-pool cannot ensure sequential writes on
>  	# the backing device
>  	case $target in
> -	error|snapshot|thin-pool)
> +	snapshot|thin-pool)

This patch makes sense to me, but I think this patch might cause
failures on old kernel which doesn't has kernel commit a951104333bd, right?

Is there a simple way to check if dm-error supports zoned block device? If
there's not, I think we have to let it fails on old kernel, to make it run
on newer kernel.

Thanks,
Zorro

>  		_require_non_zoned_device ${SCRATCH_DEV}
>  		;;
>  	esac
> -- 
> 2.39.2
> 

