Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88531207A1D
	for <fstests@vger.kernel.org>; Tue,  5 Nov 2024 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730789944; cv=none; b=iwAQvSJWfnBZNIkfMM6DiNK7AVHnXvNGE9AFXjcu3/11S92DylCpatmif62chTS+rDxIVp0VLng/8dXuM9SewE9Kx38cs7Lc1uxwmQchox/pqt/fn4Fhon9VZrHMG6pHNZe95GMTq6SjItyuTcfW+yh8q5fn+tn9ew4ighzdqlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730789944; c=relaxed/simple;
	bh=Gm9i0clkxJ30aqKU7WU/nqzFWkGI7SoxJ16OmrRd8WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwV2qC8MyyFaBQcXZXRxTSKnJzB82uTV1OYyiliOvZu1n2J/wZRGnKTAKnyX6HRMINdgCfZXCy82PKUoDmWCbcDshYi5LTtE5PnwsBKLwKQnB1OZFzE0fj4ZQlcC25fe3Tj4Qvg7LaVW1+6A0xMcIGkXZuoJq7De/LDSSagTQHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KNFV0TGe; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KNFV0TGe"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cdbe608b3so50041625ad.1
        for <fstests@vger.kernel.org>; Mon, 04 Nov 2024 22:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1730789942; x=1731394742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k3rnpr5FnaON2NYr2e34KJVxPEQKrPchOjIXUSnnsCk=;
        b=KNFV0TGecTjPG9lhaGZTUN+RO/zl19AThMjo8XQI0JRIvsngFNUa7az26IqxoMDqdr
         7unoFxMkXvEKSclv6xj4DeO1Mf+ngxg8KFI80NODhvj13CHbzXiNQm+pAel5li+Vbrjy
         6QY0HjRfwYTiy00KNH9/GJgCWiORIewD2H+ksyLtGcDrrPcxau/3neGG4BoL81u0YX1Z
         /X245spdhVzWR8nCmIncgqIhrkguVS7ZJBv14DB7o0USoEU4HvkD8g9SMB/mlccs858p
         V3mT50WioJnQC3h7g2stUEuoo6RsFggrcLoUYxDeoxZUUvVJwtwZlR1N3qYTp3xOsWY2
         lWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730789942; x=1731394742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3rnpr5FnaON2NYr2e34KJVxPEQKrPchOjIXUSnnsCk=;
        b=Ev7DpdMNPoNpb9+OsNzx/y9wAzwnL0ahJowqtdNylw3cfxyYDgTGYIa1YFrvBRiIcE
         EtPfVm1ewLmuITzr6CjnpYjj08BUF+MptvtoUjdZ4qWHSpAHigD/2pSgo70hFrOSX8O3
         Q0/Ixq49RfUxh1z5tirYuUNTLAxp01dyIiyy0UVkEGYiUTct8Ssbt0s9Zl4a+rmJepjQ
         3aYVOp8wb0r+1bIL8qBolg7YBY9O4s2KWjPZYffA4IW+T1JkfaB4NPjV1BDBc59PTOji
         HgCCVwjdPHWsBFRjeJP+HQFHTBbY4DFVQtRlm3mEaQ5+IdNOcLa6a+s9BLGyXwSyfibV
         G0CQ==
X-Gm-Message-State: AOJu0YwO3U4wgzKZGX756Q6YPpopHXeMaED6ZbXWCeQXLWf0AGqgA2SN
	2B75vKpzWZaw++y2kPHXdaUO/jxJA8P3fOR3BlYhJN/0LA24To6IV187Jxv+t6Q=
X-Google-Smtp-Source: AGHT+IEPye7e3EczdfPkKEL5uIbBUM11W80YIbastGKfWg2y8emTitUFShtETky2q5yRQeLZZv4kQg==
X-Received: by 2002:a17:902:e852:b0:20b:6458:ec83 with SMTP id d9443c01a7336-210f74f6e5emr331609685ad.4.1730789941796;
        Mon, 04 Nov 2024 22:59:01 -0800 (PST)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c51e8sm71760145ad.210.2024.11.04.22.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 22:59:01 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t8DWk-00AOOk-22;
	Tue, 05 Nov 2024 17:58:58 +1100
Date: Tue, 5 Nov 2024 17:58:58 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs/157: mkfs does not need a specific fssize
Message-ID: <ZynCMiPQMnxrISve@dread.disaster.area>
References: <20241031193552.1171855-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031193552.1171855-1-zlang@kernel.org>

On Fri, Nov 01, 2024 at 03:35:52AM +0800, Zorro Lang wrote:
> The xfs/157 doesn't need to do a "sized" mkfs, the image file is
> 500MiB, don't need to do _scratch_mkfs_sized with a 500MiB fssize
> argument, a general _scratch_mkfs is good enough.
.....
> diff --git a/tests/xfs/157 b/tests/xfs/157
> index 9b5badbae..459c6de7c 100755
> --- a/tests/xfs/157
> +++ b/tests/xfs/157
> @@ -66,8 +66,7 @@ scenario() {
>  }
>  
>  check_label() {
> -	MKFS_OPTIONS="-L oldlabel $MKFS_OPTIONS" _scratch_mkfs_sized $fs_size \
> -		>> $seqres.full
> +	_scratch_mkfs -L oldlabel >> $seqres.full 2>&1
>  	_scratch_xfs_db -c label
>  	_scratch_xfs_admin -L newlabel "$@" >> $seqres.full
>  	_scratch_xfs_db -c label

Looks good, fixes the failure I'm getting here.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-Dave.
-- 
Dave Chinner
david@fromorbit.com
