Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E082147E3
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790517; cv=none; b=ZvfpNyk24bUZUykUSrsZvjXmo2in19TupStr9jaim/JHw/mwcHQEdSYAboQxF+cDYSHWEJrnXtS/BMnscGA/AJKgxgcSTQ15VZZgkNFhikUh6FKFv5DZ9fW2WwlKl0uwB1Bajt7f08mgn58F9yZqYtc16hyCuPyr9VggWLgAIsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790517; c=relaxed/simple;
	bh=4c1CQdFfn/dW+knDe17drwtkrgxvFmnEZBzBNcc3VvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcuDEQ/hv3vrjT03rNc/5wO4dqYk1kQzQ5x37uEGzaddgabEfbGbkb+xnLR7YByL+4U9zf7nVTtJWcjIV/c0WSngmvB8/VHt5jyIv3Lzt3Crw/c3Q0kIxS75wXr1ewuxDKUzUFSqoMtBFND+Ph7DxrAYbsqjPCDTJP0XC4fkaZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=aKedFP/5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="aKedFP/5"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2161eb95317so5641035ad.1
        for <fstests@vger.kernel.org>; Wed, 05 Feb 2025 13:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738790516; x=1739395316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JWwkIxRKtSqIjASsHl/lHHEUmpKkeTHbd6vOaclqp1c=;
        b=aKedFP/5tCvdX+bkfe+N5kHZcv2OhJO6pxQ98LvwPNa1Pj/eoRXRFoZjwX31ZgcLge
         eiY52lRgQDh0e66h8cErhFJ2o3MzbDQhZWIgSjdlchhYta5/tAQzI/DIREFk4fL9QSC+
         euX/EdxygyGyRdtCZ0TFLcOE/hxuk/6zCQTEtDDSeHU+5+cSB6B9lxNiMsPw5poUsku6
         84PnR9Rl7+90P3l9Ow6Pk69VMa8f+P0pKEoS9wlvdKpCmc9Fa5y0Wda07+jQ30Hp7CVc
         CVzxAtiiSmoYGI+hKwLBcP2537dUlMmCuzhToXfZHPNcvrarWrJRwTI3SXDdDeBhUBNm
         dqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738790516; x=1739395316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWwkIxRKtSqIjASsHl/lHHEUmpKkeTHbd6vOaclqp1c=;
        b=VzsLCmNBDXjxqDOKVg27cvRM4IMd4ArDJzkHro1zMS35+G9TCB3I6wvQWwkxlduXHg
         /F72Nsx4po9M/dVpceJ41pSN6ZHxksTENIRhj1gSJlsavos0+Q52gI3K+VUrWkwOZ2rc
         cr8Ogltb+iF28klWIlrxwegjLFG12a8Q44oiMXTspM/RpWVnhWkiD6H1GHH3NgzCqSjC
         hfrDsjPuurGrXvEqiPN9EY+u7pb39aabDOYe2TpTOEJgkAxj+kCbrGrgJAZ6gXIi5WjP
         N4gu1UepwSP6XECykJGCfBHwKiTRfPtS65f7mpV/mMBHitdrEAIgKxRbeOKRXAovFLsK
         KUuw==
X-Gm-Message-State: AOJu0Yz0su1BrYlCj5+mqaxOqvfnVayhHBh0ACoQtlKJmUq6JpDwfgE1
	OyfIMrEiCeePS3/tIDPsp6NdeYGoXlX1zLOmiBOByDVGBQRhQ5qz0/ezeAu6RDs=
X-Gm-Gg: ASbGncueEsPwh7bTwCvPsrOLDwtcmrcI73QB+dFhZwPxIy44CCHXRhLXcJhBbrgWVJs
	FPiO4+FNccsNslWFih3Jvl//a4Qw2HASVE926VV5wEngrP6HcIHkRLHBTsdUDMkvTcmoBihvpR6
	GOuBi9+zO0ww7CGHySTeFSR3iWQ/iPuDvkV9GvJYS1+nFz7VRnVhflr/tf+m3fmJpAPWfRh0Rhz
	MDfXksLS0+EMesj7b/GCiAL0I9Rf8TPUHBeTCTNkvF5PTMPN6LeYk4ppUA75xjNJvaJQTDduqK1
	fnTBsjp+tkz/mzY2PzbnTisx8t4crqc0MBxOGhPU5cNdfP4HULz/buk/
X-Google-Smtp-Source: AGHT+IER3Sku2BPF4yvBzW7mHhEAqWYyzMVrFsk9Eou4rK/LfNULE8nqSV1UdyQnlMwkJKqVk9KKEw==
X-Received: by 2002:aa7:930d:0:b0:725:b347:c3cc with SMTP id d2e1a72fcca58-7303521f9camr7629504b3a.23.1738790514124;
        Wed, 05 Feb 2025 13:21:54 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6429a98sm13598669b3a.67.2025.02.05.13.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:21:53 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfmqF-0000000F5wq-21Ou;
	Thu, 06 Feb 2025 08:21:51 +1100
Date: Thu, 6 Feb 2025 08:21:51 +1100
From: Dave Chinner <david@fromorbit.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/5] fstests: btrfs: add test case to validate sysfs
 input arguments
Message-ID: <Z6PWb__u9h25RCX4@dread.disaster.area>
References: <cover.1738752716.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1738752716.git.anand.jain@oracle.com>

On Wed, Feb 05, 2025 at 07:06:35PM +0800, Anand Jain wrote:
> v2:
> Mainly adds a generic function to check if a sysfs attribute reports
> invalid input.
> 
> v1:
> https://lwn.net/ml/all/cover.1738161075.git.anand.jain@oracle.com/
> 
> Anand Jain (5):
>   fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
>   fstests: filter: helper for sysfs error filtering
>   fstests: common/rc: add sysfs argument verification helpers
>   fstests: btrfs: testcase for sysfs policy syntax verification
>   fstests: btrfs: testcase for sysfs chunk_size attribute validation

All looks ok, except for my comment about creating common/sysfs for
all the sysfs stuff. The individual tests look much simpler and
nicer, too.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
