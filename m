Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CCA12E70
	for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708878143; cv=none; b=Qw7/VsUodersE/fcDfd1mDMMF2yVa0hYcaMy47A0RWK3ccWjKzMKf2dkck1C1l+oobgR04VqyfHQiq6tqeTl+qBu9B9t6jvdc7kIDATTv6lQCDhDWiH8hXXQfovpz0Ay9flFdTvkwF5CGOMOfK9b/W9YLpn3PuRSp09aMgNfgd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708878143; c=relaxed/simple;
	bh=/lDq9CRjcCluhBqhf4xNQ58eHdjRm+s34XQQWcMgZdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNhoGbpvLDPWYEsyxbaow8eppSi+WeN8svaVEXyTAqCtGA1PE89f3UF9YYovBLMXTcYWfT8e+QOVBh0L+gxJH6w4/OUpdmmNrRG4r5T0SaYYIoWUzKd0nhSn1r/Bv7yDfcQPvZvKR/2Fs0uHBssiHCZ7n7dV4pGeZVy26NTwszM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JVZ3dhEx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVZ3dhEx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708878140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IbUW9yfzzUofBZpGKvSVueN5wdAewAQZIGdB0vmOcPI=;
	b=JVZ3dhEx/z40Lq2EMeNlX7Xm0ue27GuPQYP7aPaXI5Agu8KEAGMXWi1nEZ+Z17LwFdSXKb
	SRyoTHwJ3phXYM3X2YRJ4cmrsCPCc2DfInibOt2bDu1JeMkevSJdOXp7OJdyjlW0gLN6jh
	l8P8Pp+R24U6BbgnmZPivHUpn4LNE0w=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-5am3tz2DMNm6OZxtdmGdmw-1; Sun, 25 Feb 2024 11:22:18 -0500
X-MC-Unique: 5am3tz2DMNm6OZxtdmGdmw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-299727c3e8bso1984841a91.1
        for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 08:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708878137; x=1709482937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbUW9yfzzUofBZpGKvSVueN5wdAewAQZIGdB0vmOcPI=;
        b=UOnqREXdqlD21rwmcdu4ETo798ve2/bZqszvELwtZeSuTo6K1oTWf/CjvLNc9S5dGm
         955yG1urnWQS2LY7n6YSWkZNuvVNpgsg00xn150W+8we7YGSYd/kibi8VRgU21P8k5CN
         YBFnGtwYlXyInPto+skhgqYLzz/lCrYULHHMT/fKwHmjaTrgp7jX8jNmmYKkcdpTk4iz
         paH+bzkuyL4w8yu5uaXDLNMDeJzLlwiMrBGEkl7YJB0vGze/YCI1XQV6ccmwnO7cp5FL
         nUfuLE+gU5gTf/UQlWamPI+pl4fMSFx2mdEFfSLaP/BBApzXE0PizThVIYYGttUxjiy7
         GLfg==
X-Gm-Message-State: AOJu0YwlnV8p+GKeTKWR7eAQZ9L+AFVFVhNbSRj7Vmh984zGm6jGW5sS
	BWQCFJqlJGUlNw0CbELm+keY8pevB+rkPUVidX1e0NfKx7FU2O/jS1fOzj7BVnBDrWJsHKc3Bvc
	mhDNgYHZX+HeHcKcZwZtJqvpxsSXYIVFcAwhEcAXVu0HDNoNQJfK8geM=
X-Received: by 2002:a05:6a20:6f02:b0:1a0:e469:2599 with SMTP id gt2-20020a056a206f0200b001a0e4692599mr7190633pzb.13.1708878137705;
        Sun, 25 Feb 2024 08:22:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk47mQVpV0s+6hiNr6yJRfuqPxIdFC+pCAVvhlJqi6tNUxhi71tJINDK2WSlKlxY8g3i0y/Q==
X-Received: by 2002:a05:6a20:6f02:b0:1a0:e469:2599 with SMTP id gt2-20020a056a206f0200b001a0e4692599mr7190618pzb.13.1708878137378;
        Sun, 25 Feb 2024 08:22:17 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b006e530aca55asm78315pfj.123.2024.02.25.08.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:22:17 -0800 (PST)
Date: Mon, 26 Feb 2024 00:22:12 +0800
From: Zorro Lang <zlang@redhat.com>
To: Su Yue <glass.su@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, l@damenly.org,
	Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2] btrfs/172,206: call _log_writes_cleanup in _cleanup
Message-ID: <20240225162212.qcidpyb2bhdburl6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240216102550.46210-1-l@damenly.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216102550.46210-1-l@damenly.org>

On Fri, Feb 16, 2024 at 06:25:50PM +0800, Su Yue wrote:
> From: Su Yue <glass.su@suse.com>
> 
> Because block group tree requires require no-holes feature,
> _log_writes_mkfs "-O ^no-holes" fails when "-O block-group-tree" is
> given in MKFS_OPTION.
> Without explicit _log_writes_cleanup, the two tests fail with
> logwrites-test device left. And all next tests will fail due to
> SCRATCH DEVICE EBUSY.
> 
> Fix it by overriding _cleanup to call _log_writes_cleanup.
> 
> Signed-off-by: Su Yue <glass.su@suse.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
> changelog:
> v2:
>     Remove unneeded comments for _cleanup.
>     Add rvbs.
> ---
>  tests/btrfs/172 | 5 +++++
>  tests/btrfs/206 | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/tests/btrfs/172 b/tests/btrfs/172
> index f5acc6982cd7..e5e16681ec21 100755
> --- a/tests/btrfs/172
> +++ b/tests/btrfs/172
> @@ -13,6 +13,11 @@
>  . ./common/preamble
>  _begin_fstest auto quick log replay recoveryloop
>  
> +_cleanup()
> +{
> +	_log_writes_cleanup &> /dev/null

Currently we need to copy the code in default _cleanup into new _cleanup()
function, if you need a override, e.g.

        cd /
        _log_writes_cleanup
        rm -f $tmp.*

> +}
> +
>  # Import common functions.
>  . ./common/filter
>  . ./common/dmlogwrites
> diff --git a/tests/btrfs/206 b/tests/btrfs/206
> index f6571649076f..d9ce33b659e7 100755
> --- a/tests/btrfs/206
> +++ b/tests/btrfs/206
> @@ -14,6 +14,11 @@
>  . ./common/preamble
>  _begin_fstest auto quick log replay recoveryloop punch prealloc
>  
> +_cleanup()
> +{
> +	_log_writes_cleanup &> /dev/null
> +}
> +
>  # Import common functions.
>  . ./common/filter
>  . ./common/dmlogwrites
> -- 
> 2.43.0
> 
> 

