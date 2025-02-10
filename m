Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EE92580DF
	for <fstests@vger.kernel.org>; Mon, 10 Feb 2025 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204524; cv=none; b=s6Xb4fnepmuPkW3nYeNAuxr/reha15bWDZy/F4me76k0yXeKKYjd014QrQyqDpSpQIzI503oZy7xPPbLa1/0lXqrkpbbzIo60CjBi1cIUo10GghIPYJdFclNM7R+3qmH6gQBVKncBR8MXb4edLODypry1nQB7Zky7fXsz3dPw1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204524; c=relaxed/simple;
	bh=RlOv7miWVzvvuJlR9jMQb1AKpwYU5UE7Fv7/aXx2o4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lK594Vmv6WxVaPYR0UcdtcewvepqG1UPUgW5C90NAB30of0pqbxkLAixSjisgXjufHgXkglsb3d4XLyTdGmNBKlRgTHg1PrJdkRwxHejpJWWd12wMuWZtuEUsBkOkShlZKvd5EC5w0OfHEZ8RZffkGKf4cbsQ7IMo2YWbwOuJA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiK/vhJ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiK/vhJ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739204521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KRsM7/ESCA//FFo7bredBzWHUWqzScRc4Yv7ZM8Cs7s=;
	b=GiK/vhJ6ncIArDddPobNnX7cZy27e4VGVpzlxKdMWpoIiF7yC1Kld5IrG62a2N3IvrqBCQ
	Sl+8b7++NebFCa+VSo2f0FcR7zcclnUiG3Un0s2iDvOpHfPn0S6d7V2YrfpCHfrR1fqE3U
	YfGLUISU3ffg/jDbGUJh4zcf9UuVNn0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-kj6z1iOuM4CXSu0Yi0VMdA-1; Mon, 10 Feb 2025 11:22:00 -0500
X-MC-Unique: kj6z1iOuM4CXSu0Yi0VMdA-1
X-Mimecast-MFC-AGG-ID: kj6z1iOuM4CXSu0Yi0VMdA
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fa11d8e448so13831695a91.0
        for <fstests@vger.kernel.org>; Mon, 10 Feb 2025 08:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739204519; x=1739809319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRsM7/ESCA//FFo7bredBzWHUWqzScRc4Yv7ZM8Cs7s=;
        b=ivCrYONAmXTJRVPre2SxqNpAXvhMBF+3Uoj1B8IMsrxEpOi9+2sclzWA99KrRNLKte
         bQ27RtmP6i3iloFzDAkKylFYHajQNaq+++BMGmAFaSblpBsArItRSZRRCMYCS89PYUWI
         hL2JobLIj9eCzJkX6i+PikPMvibQYUtBv3exQdyt559SYzMHtwbVx4TlUSOriejphce+
         CYGld4EjQ7InLr8XaoTwIdRQp+DgaoPNQxtGk+nbZE9kB7GPx5V3FNNkUXWViS65yp1v
         s1C6qrDi4+Ug/ceywuWbb9KVFgmqMbJPWchkGQc2oypC6diN2cKqp8kRD0nr7smVi76G
         TpRg==
X-Forwarded-Encrypted: i=1; AJvYcCVp6SCJ6ILKbuYXtvInbg+rePzV+I6mmxTVFcGsMtnXumb3blgrQTRm8Aa4ztvGYteAhBiOJAsJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxGCdHBr/ecXPJIgQP1KUOchkqqY1DpQH6t5D4BcHGSdqkCiz2f
	RB0IvOLriDr26tUlB5i7hfvq6p93ooNzuYx67SSW5JjXHsXhAXIVfoARgLGJj4XoKsoP1XGelUO
	EDXno1HIIuNo4zxsncQkTXsGRzg6eRjYgSO1NsDfyzbxMh50irUGGMUA=
X-Gm-Gg: ASbGnctMBkS4YQHAm7et+kjHCfUeJVT4WI9AOl4rlOAL02/RLYv1YJpzFp47U+NMqus
	euK2luzN7eF6KjSuaWBYQ0+cIwrpkck3F3OZr/cp3SgnYxvUN3iBsF07o4T9hA+g7tUBJcZ/yIc
	AnF9suOKccVg/07t+l3GwZAPRRf7cGg11IOT/EHDzp2JP0MKm5ltetnZVIzPaDp3EHdWtDX77Uf
	nWlWYDJYD2fBP+cBPvqwjOD9ozsqPBukyXzHG+1e7vtdnEVZIsSdqvp8LXvDEV9HsqAkEHuLyGj
	oYKCansCmNnHIUeujHm8YsO/CtRR32t6h23A7Y6YPl6Mbg==
X-Received: by 2002:a17:90b:3596:b0:2ee:b2e6:4276 with SMTP id 98e67ed59e1d1-2fa243e9aaamr20674746a91.27.1739204519005;
        Mon, 10 Feb 2025 08:21:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjqgpXL6Xwum9yd0v5zViw1Okz1NShnwkr1YDmQYinsQulu5CEab45udb7lZfk6fXl7NO3Lw==
X-Received: by 2002:a17:90b:3596:b0:2ee:b2e6:4276 with SMTP id 98e67ed59e1d1-2fa243e9aaamr20674725a91.27.1739204518664;
        Mon, 10 Feb 2025 08:21:58 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa12c885f2sm5345169a91.1.2025.02.10.08.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:21:58 -0800 (PST)
Date: Tue, 11 Feb 2025 00:21:54 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, djwong@kernel.org, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs/614: remove the _require_loop call
Message-ID: <20250210162154.3xaxy2fdzwr4k6k5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250204134707.2018526-1-hch@lst.de>
 <20250204134707.2018526-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204134707.2018526-2-hch@lst.de>

On Tue, Feb 04, 2025 at 02:46:55PM +0100, Christoph Hellwig wrote:
> This test only creates file system images as regular files, but never
> actually uses the kernel loop driver.  Remove the extra requirement.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

I think this one doesn't depend on the [PATCH 1/2], so I'll
merge this one at first. About the other one, I'll wait you
or Darrick's next patch :)

Thanks,
Zorro

>  tests/xfs/614 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/xfs/614 b/tests/xfs/614
> index 06cc2384f38c..f2ea99edb342 100755
> --- a/tests/xfs/614
> +++ b/tests/xfs/614
> @@ -22,7 +22,6 @@ _cleanup()
>  
>  
>  _require_test
> -_require_loop
>  $MKFS_XFS_PROG 2>&1 | grep -q concurrency || \
>  	_notrun "mkfs does not support concurrency options"
>  
> -- 
> 2.45.2
> 

