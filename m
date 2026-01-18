Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757023D291
	for <fstests@vger.kernel.org>; Sun, 18 Jan 2026 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768763953; cv=none; b=tcY9CJCxMKsCOfffbdTMb0/cvi9hKoJPalC9EjzqDEGEC3f3f3EtPaWQHnw28u4HP/r+EnOaxuAl1syTqyk5iRCIJtwlXul6+JTScLKjc60/nXDIHj43+aIePBz50zbmJV2wozKv2aqmVDFFpTKPP8ZPOwKBKpX/JwjFpWTvdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768763953; c=relaxed/simple;
	bh=82Mf2NJeAvt2o3n0VPrMIXZfLa8qYg+zAv5mNLENzcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sog1Da1UJm3HUW4gemIvCsYaB8ggreTdCfUKM9E1y7KIkiXwYU5F9TQdXMBpuQer2cOe73eoLBVecxvOrQPweVKlj8NI5CUc6l1Nkj/GtcCmhNcOEerUX8Od6U3cKfvlHh202DWqPV9P21mugyi6dxPiAnExk5etScWkALxtXoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXUFoe2l; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXUFoe2l"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so21934765e9.3
        for <fstests@vger.kernel.org>; Sun, 18 Jan 2026 11:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768763950; x=1769368750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFArAHFNDsmlr0nPHwPIpxNTvQE9baTRoexdP9gjAwk=;
        b=NXUFoe2l/q48oIfFkHDTgsGf5X0bpBIIibEIhW6Mu6S4SiU2qkEqqrRnZEgiYtYbNy
         I5dcDGNFQYMqX7Jc3COF3LCUZYP3vX4G4ZEnPpK+1KR9hWnG+b7I4gZM6fvXkgpstrgC
         kMaXIF5h4444GkXuaOxtIHUwh2LLVQlGxrTv3JAsV7qn0cPDAlQdsAbv41/6E5IAf9Nv
         t6TppIg05qGauklRMl2Tx5IhVXe3d6WedpykRvskiaOMfq/s8tVsTJkNbvxAFrk1c+cG
         +9E35LB3BIjxxxugfc5bj588OzrsYtKX7Jr3k/Y/hjOkqYgbJ1NWSKMtEkzYal8Z69m6
         0JFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768763950; x=1769368750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFArAHFNDsmlr0nPHwPIpxNTvQE9baTRoexdP9gjAwk=;
        b=I1HJik1Ul4UqPp5aFvWyVTfLVDoPeBO7iHt2AC1VUB0J8U2pvUvCWyiF9BOOp94vrQ
         rvRkLCIiZ5zbQghwz5hoGBs2LurkbPukYTdKWX+FzM5BacaKxHBDdrw3y3VNnDk24IF0
         7zvFNFZB5FaeuF+4hDaS9RIGcVBcOzwFfCspFwd1yiH+DoXkBgwGFE5+s0W6WSmlj/vG
         Vj+hfc3/F4LcaGsg5Whbt+PoQcFNZwu+Wt17n3K2+YDj69Q3hGBUmgUkP8GH1XjC/Qwa
         0w9r710J24EJHUqSgGoScmP+QI/a+DUSCaW0+FI2gB33an/xGwnJGvCXqL7zh1fTqFMU
         KSvg==
X-Forwarded-Encrypted: i=1; AJvYcCXWsZkV0sGPWNOdUV6/UBK6UGgiwDEArXOsDe8+f+04Zx+z9lmRxBwykrcfkaVuN3nQNXndq/h0@vger.kernel.org
X-Gm-Message-State: AOJu0YyCHpclFwSP6OnhSIIVcalC4bf5HaGOewwihoPvHtrsh+q99iRk
	Q2CWafNdz0rvy3/zAn+XWMKNHyXEiGvfkbseFZ8kEg5x4bcNxoMPD/nN
X-Gm-Gg: AY/fxX5teDIuJegS6B2c5bt2FhGW1ii9bdGnC5Q//5cZCDeeyUSJtduMXml7X8NN9e2
	mTHpoOOzVJ7+5twQX5S8Lqj7sxoiAVAoBdMMcr+srlhRp+LwWCvwS38axwnkOI7RiNlDzGzUPhM
	jDcHjcpifzZXQPnWHp62l6wm66De3aD9tdwh79PEg8+r+LEpxMc7wp1R61xlWt8D28uiGlA19rc
	0CMEmrfYqORFtAz93ch7FHDTTMoPDlu6saQB8X2oofdUokaXme/Puaw3Mm/r5UzwqvzF6/cusYx
	MPWlUZkRpbMjZgAm+Nj6SOrxrukU9U/pv46pvayEL7o7JGseB9UH5OCL3HMelvyQUB+a+RWfZqU
	tkB4CoeFTFDm9sUAD3BSR/VFVpLdrf7l4ZRULmqjyG6ephpEq2VilGlPdYsJ+iuRD8QUwLcDe0u
	UFBuA=
X-Received: by 2002:a05:600c:19d3:b0:479:2651:3f9c with SMTP id 5b1f17b1804b1-480215e207cmr100616015e9.14.1768763950359;
        Sun, 18 Jan 2026 11:19:10 -0800 (PST)
Received: from f13 ([2a01:e11:3:1ff0:f108:9c47:a37e:e4a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8caceesm152849235e9.13.2026.01.18.11.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 11:19:10 -0800 (PST)
Date: Sun, 18 Jan 2026 20:19:08 +0100
From: Luca Di Maio <luca.dimaio1@gmail.com>
To: Zorro Lang <zlang@redhat.com>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org, djwong@kernel.org, 
	hch@infradead.org, david@fromorbit.com
Subject: Re: [PATCH v6] xfs: test reproducible builds
Message-ID: <aW0x4lXOhO0g1_wm@f13>
References: <20260108142222.37304-1-luca.dimaio1@gmail.com>
 <20260118175327.hdevfpau7uifdsb7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118175327.hdevfpau7uifdsb7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Mon, Jan 19, 2026 at 01:53:27AM +0800, Zorro Lang wrote:
> On Thu, Jan 08, 2026 at 03:22:22PM +0100, Luca Di Maio wrote:
> I think it's not good to be commit log, better to move this part ->
> 
> > 
> > Signed-off-by: Luca Di Maio <luca.dimaio1@gmail.com>
> > ---
> 
>   -> here
> 

Thanks Zorro, sent a v7 with the correction

L.
