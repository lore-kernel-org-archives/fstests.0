Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19372192F9
	for <fstests@vger.kernel.org>; Wed, 21 Jan 2026 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005424; cv=none; b=fKu33N2eXg6Y6wJ+tIK+2Znr3HX3nKNQIzDK83DKMf++RvWY6fx/ONVYjGhU3+GO79HCkyF2cSCai4alLodNF2MaRJqYS2hDNDTvLSxfCzpX1y+q9MxiRFSucTO+gCTgGqIDLReza0LS2Z4D+xeIzD4euwHUkJRCHKRL6ssX5Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005424; c=relaxed/simple;
	bh=nKUMXjOmLTnE+RfU3XyoOlaUilXKRnb6aV3RgZl3MWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cky6LqZGqUH+K2AZAAG/iL4mJsaqGft5Rkxb3g964c1CThs9g+9JpGsGaRuN14tAATOjQeXQ3gXMvWBjw5Mw8btHeoPpp5x5UxAPVPwBzoQkncWkIDLxCKco9YRpa4Bn/MxFwCO8eF2VeeiRrJM4xQf8LSrBDhtr6SZ9tcxyLwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMEPhyYv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UoIFnnPH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMEPhyYv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoIFnnPH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769005421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffT6Evq9xkKRyRVBJ43QX5OBdbtSbykl1lCqzNla/MU=;
	b=FMEPhyYv0FNAFGI1ILoOBJvRivpPJH7z659aaKagxyQ+6BRr5oY8dvPJ72uSB90VDLDv1J
	hnBkogz1u92sPUOV08Cr0GHiSSThDxLkaTz/ghdRvGDDzD2L1jyuzMhajRlsX1d7eYccl7
	9MYJymD9/XrQ3EyXXvPd4XFifWUAp/U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-btwu0B60N1Op1p30fqRqBA-1; Wed, 21 Jan 2026 09:23:39 -0500
X-MC-Unique: btwu0B60N1Op1p30fqRqBA-1
X-Mimecast-MFC-AGG-ID: btwu0B60N1Op1p30fqRqBA_1769005419
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4325b182e3cso4211560f8f.2
        for <fstests@vger.kernel.org>; Wed, 21 Jan 2026 06:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769005418; x=1769610218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffT6Evq9xkKRyRVBJ43QX5OBdbtSbykl1lCqzNla/MU=;
        b=UoIFnnPH26a3qw83VrDvv8ZHi0/FuQCbKpJwqA7lfRAvvwI/yWB1s2e7E+L8jELUcq
         UVteg7J9McT0oNPpZcuK9tGJN7hf6v/yLh9AudWeLRKQrJGvJaTYcZ/+wwSrUhWbsvL8
         27BnXTXL7nGVWOMfwpe9KbOiRo1z/GfOlSm4Wcmp9kWTYYzsjZOn5B/UGdKsRGrGDFD/
         4jS1q298nvcZEUgPXe6dCVTFF8vRGSpdUpGZCNN3g58wsGKCn++iZJef8870dlO5jrHL
         farELbCe64Zt23icY2GFypueKmDJHmrUU/0uHdSbgmEKcaJAMJz/X0bIHPpLDQGprhzJ
         AR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769005418; x=1769610218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffT6Evq9xkKRyRVBJ43QX5OBdbtSbykl1lCqzNla/MU=;
        b=qOMljfyUuxlZB3GD0vzmX16mJXrokhyD6z/GiJ7Z1YHgwGdBDAjGGFho4NER5/G35M
         /S/gWNBFs0Df0nBBs6LEgoM/A2vOlwiIg3DDGZvp7btNFu9z5PVPGnK5dZnQEeAfdmaJ
         ZrQeRhxodgO23/byK50Pb1/b/YSy2tcx5FGJlP8VwtG+3FSSwhrgknr9l8O3k/vmkB1F
         03G2NIAEiGmB1UwNRULIVICSskruiA3zhOcn80BLNQDB0cIKLwOISq9WI1SjKRAQCYB7
         32X8srevfh8+nrzoDstYztGV0qf3oWO+vI5Q/EBzbBzT8PV6dqPUDOrJV7TKLCPO5OzI
         hDtA==
X-Forwarded-Encrypted: i=1; AJvYcCXb90kt55qn/3tqlJb4I4x0rxJpyq3iKvzNbH3asOCW5Ssw/8PAvjlT9xjb8a5F8DaeHDvS07S3@vger.kernel.org
X-Gm-Message-State: AOJu0YwuznIAPWnIfITqiOb0XlwJy7oZmrbDBBiELArW/DQFUqac6JPe
	07pequC25tD/9VK4TNv3TknpRCcHZuwt9sdgPXoqYyoT16PxDpZ1l38LvvxMNLpae6hQ/0biEa5
	aWBP398xQjuC7H8+tLuofWFd/oFTW/TXQloz3oRpCj3RJ195vREUAmBTOXA==
X-Gm-Gg: AZuq6aIp96mNh9Ahu3PD5H325iPWodnNk+fTUOzoFgdnl/oBEEAgQgyNLbAmcIrxWMy
	0ZmSI/zYiJSDRcg3Fd3jGkK327JvkkE1xXoUUYKczpQ43XDocXNEDAiRGbDFMeQ+Jy0XjaBPVFk
	A6L1zlFxKPR5bRUk95l3VZEOAixKiobiFloOP8LBjHwXfvTt4BP8jCFMfRCBGh4eH9QIRNfg8vV
	VTL0mztjka0wYntITn0/yRwe1/nO03WVhzbM1qvLdV70QTGa+jXhGVWqDYaReSqB8pJ491kTCUI
	R0q1QYjlkO+xjbTX0kI9u/2bYc0pW0MP9r7eaxs2tkcT1U3bEg7/C+TcnN9Ms2KrSIRKsSmGSXc
	=
X-Received: by 2002:a05:6000:178c:b0:431:7a0:dbc2 with SMTP id ffacd0b85a97d-4358ff7cec8mr8739454f8f.31.1769005418376;
        Wed, 21 Jan 2026 06:23:38 -0800 (PST)
X-Received: by 2002:a05:6000:178c:b0:431:7a0:dbc2 with SMTP id ffacd0b85a97d-4358ff7cec8mr8739394f8f.31.1769005417731;
        Wed, 21 Jan 2026 06:23:37 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm36452697f8f.4.2026.01.21.06.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:23:37 -0800 (PST)
Date: Wed, 21 Jan 2026 15:23:06 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v2 1/2] fs: add FS_XFLAG_VERITY for fs-verity files
Message-ID: <nz4xsllj46jv66y5ain5fu277umo4x44ijjjpiinel5jrkajsx@j2hr6kq65wcb>
References: <20260119165644.2945008-1-aalbersh@kernel.org>
 <20260119165644.2945008-2-aalbersh@kernel.org>
 <20260121003321.GB12110@quark>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121003321.GB12110@quark>

On 2026-01-20 16:33:21, Eric Biggers wrote:
> On Mon, Jan 19, 2026 at 05:56:42PM +0100, Andrey Albershteyn wrote:
> >  /* Read-only inode flags */
> >  #define FS_XFLAG_RDONLY_MASK \
> > -	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR)
> > +	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR | FS_XFLAG_VERITY)
> 
> This is the first flag that's both a common flag and a read-only flag.
> 
> Looking at how FS_XFLAG_RDONLY_MASK gets used in
> copy_fsxattr_from_user():
> 
>     fileattr_fill_xflags(fa, xfa.fsx_xflags);
>     fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;
> 
> So it translates the xflags into fsflags, then clears the read-only
> xflags *but not the read-only fsflags*.
> 
> If the user passed FS_XFLAG_VERITY, the result will be that
> FS_XFLAG_VERITY will *not* be set in xflags, but FS_VERITY_FL will be
> set in fsflags.
> 
> Is that working as intended?  It seems inconsistent.

Yeah, this seems wrong, thanks! I will send a patch

-- 
- Andrey

