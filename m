Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC9C13E217
	for <fstests@vger.kernel.org>; Fri,  2 Feb 2024 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871613; cv=none; b=ULEv5YJfUx0W0DwmJqrHPbrqgymOBwxkDxgBbFgYh4DJaBeT6mEFVOIDKgoZZ0Fz6ox+/cmrzdK4HQeqCRFrzaofyRTeEzBF9kNLfI0jznmS9/dWdBGFOfavkBzBDIxa3RjXdwz8pNGWv6oarHtv+0NZ7QVCx6BTrFI0sTDT+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871613; c=relaxed/simple;
	bh=E6LZIRl5fMTjikSDwPeAEUieRS/Duz8aoor8Vx5URyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJa4H3esfGOvjERedel4v9neYY51gGpHU/Eqsm8Wcfac5w8MnLRR1TopZRwLa2WjMEkz1O9TTl0FigyE8WBzwjbwoRgadTOFD7P3JIMhb5G7GuVksffrC2m4wdYuYzH2FUVd4+E2yjQpHJwhPSeJF1Y7K/qK5Nf6oe0NAOdUKXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MZMZFPRM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZMZFPRM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706871610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oit28KD2elbm89kON77mfWcZigAw6a8sE3t1EdI8mP8=;
	b=MZMZFPRM1GEOZOHJuxE4Z/kxgDvSBPTNVRQ08peOjnJIkZOIwR8nS/rYmwnzXHzqtC/Epd
	GAJ2DgqwMrys9o8t6s9/cpz+2hXsFls2/sWVle1+DQroxKjqhOSh936koxAK4l5CBFPw/G
	fCwSA6hn6aZH7bPTsPeAwsFSU3R90jE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-aWXBXxjYOAWq0jOHwsq7gw-1; Fri, 02 Feb 2024 06:00:09 -0500
X-MC-Unique: aWXBXxjYOAWq0jOHwsq7gw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-558b84a7eeeso1385425a12.0
        for <fstests@vger.kernel.org>; Fri, 02 Feb 2024 03:00:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871608; x=1707476408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oit28KD2elbm89kON77mfWcZigAw6a8sE3t1EdI8mP8=;
        b=D18w3GNOWgr01Dho5kn/DdkDbUKqdnNu8AT8JyEIuaezU2oKMNXscAPKtmS/PgA9zo
         9hfe4obI9tpSj/qbvHXiPUOcZJ0CaxThWTGvnmhsUEV81U6ENoQ3bV/USdlmOzhI5dhA
         /t5KNc8qrArlZqi6uWtc+YAqyC9osF+evQSo5ICE3FImi9CJfipEb6eYv3RkdDlXGPgv
         EFT++VvoIgmxsErT0kcmjyohnM67oAcabHyaNcSekBOYOQn8/JuzsBMFHKjD8TMtx6OE
         OG0+oxjM0SYr/lkcwCf/zz0JDk00jxCiPAX8DKDYW+E2zm0Uj4CYgi58wRtePcr3D3wq
         sNKw==
X-Gm-Message-State: AOJu0Yysel2HfZYhX8ALRPE1iFDbsGnd+fQFUsRwirtzwJ1uQaKMWe8T
	ThXQPU4fuHFwlRjGUGPnG0wQI9Sq76GizHVZarNVb6YibWzoHt99JX7pvyArc5shl8r9VBp6Ttj
	AMthzIsdyCToWxCL1XvRjak4EpyjkvW/iKlH9pg2maWWyDKa51LL5hw==
X-Received: by 2002:a05:6402:8d5:b0:55f:fe74:bed2 with SMTP id d21-20020a05640208d500b0055ffe74bed2mr497601edz.33.1706871608413;
        Fri, 02 Feb 2024 03:00:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEi43umMB83PuiXr/e95yZtykK6pxe7Y8TlWz9zYnMT/8CVZhE9Vq3rq84ZzspS5bbCpKxLA==
X-Received: by 2002:a05:6402:8d5:b0:55f:fe74:bed2 with SMTP id d21-20020a05640208d500b0055ffe74bed2mr497586edz.33.1706871608097;
        Fri, 02 Feb 2024 03:00:08 -0800 (PST)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id y2-20020a056402134200b0055f17a2c26bsm692899edw.94.2024.02.02.03.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:00:07 -0800 (PST)
Date: Fri, 2 Feb 2024 12:00:07 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/682: update and fix-up golden output
Message-ID: <a2y7o7kpuexpbgdb2u3anqsgbu46oyy2qeod2omqiaecqnop45@tfx6uuamvhuw>
References: <20240201161732.6126-1-ailiop@suse.com>
 <20240201161732.6126-3-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201161732.6126-3-ailiop@suse.com>

On 2024-02-01 17:17:32, Anthony Iliopoulos wrote:
> coreutils v9.4 introduced a change in the error output of mv under
> certain errno values via commit 3cb862ce5f10 ("mv: better diagnostic for
> 'mv dir x' failure"), which broke the golden output.
> 
> Update golden output to match the change, and further add an output
> filter to avoid having the test fail on environments that ran with an
> older coreutils release, taken from commit d9323ad7a05e ("generic/245:
> Filter mv error message").
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---

LGTM
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

