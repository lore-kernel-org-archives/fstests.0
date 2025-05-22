Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F97933F7
	for <fstests@vger.kernel.org>; Thu, 22 May 2025 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747876100; cv=none; b=ag3ZqFRVRokylv+tmglg+jeqUPiiTaIPgLgrV9+IsZVZ7FCJ+zqABfxiYMObJ1wnrLYwvFc9oBbsZHZcSJS5xIqWW/TKQWMcL/tHunC/1DSGlaflY3zBOmQW/z1nwArhi9VW035VMo//fWUD8HsjUgCa+rDBntS4iCAlycZhsTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747876100; c=relaxed/simple;
	bh=1vgijheRdSTCw7AR14LJxoQWjpRlW0Q7nRJgicefYkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2OcDvyc2NV5TLd7JAUCp04DZKnZaOol8FezvbjBwPsooowmsPVeN2bTmiPjOfFyW2YrFdagNafxVoSxVC8BlPRFUGrpW9On5KgECfPpUMps9gUHqKDRwHVpZqPeLU2va4LWKla+je2yk3XKFPNOj4CsZZ7GsDbX5aLiHZmZWlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=E2DeFWAG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="E2DeFWAG"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so6151617b3a.0
        for <fstests@vger.kernel.org>; Wed, 21 May 2025 18:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747876097; x=1748480897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=80bOzbdxL7OUqgWiAoK5JiHqoOqJ2Cv6sGjVMSznoe4=;
        b=E2DeFWAGO/DCqActqTxbkOhIes6cWsIxR9eY1Rc2ExzDjGGF1U3mQoBQ7vHMYMRhSs
         aowG+1i/zmDie10JkORPJSIV5UVsQxs6vuuFwg8SC2Y0ypVZGqX2qdqap+3zaawPoe2K
         8aNfR6xOV5lHCjfy7EaH/8+2oHbB27VeQEmaIXaOCRB0LCsq29RT1KCbCVvW3ZNUTtFP
         Yj+tEdezhW7Ijm6H2HOGzcWBmkmiMUu2npszR6uURqfKzzlLNdZ5Jq3JJdIyJEQwaIij
         XpG5rLmxKL5t83tULZ2xZuKntZYkuFJI4BTjTOzmjRYKRlmvlaK3/aq2A4KObgpziu7w
         ww+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747876097; x=1748480897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80bOzbdxL7OUqgWiAoK5JiHqoOqJ2Cv6sGjVMSznoe4=;
        b=g6sekslNKEssSD2ZGD/U7d8E1lFEYnQOCwFRBT8nYPa/9Y3x501+sv+pmidemRXw/7
         hLON+81ZE/UYyMUvmC1Hdxp23espx3Lr9+7jPm6x5Mm054mgHOnUKwMLUs9rzSYIBpT/
         qUJ+sFqDtYSkki3mSKWfDDJrmxhiMpNoc5eK8YxoW6tcloJCDkqpbodKKGnz194H0mBq
         8j6q0AeuOko9maYeWbjHwuS64rAXqEN/MgC7VN7qMU3nYYJYSml+wKs5ftQqicdqUuQB
         tOFUqrZxNmGXNPPGfQk1+fjsmnJpGC7hkmf/62fifB5vup3iSeX0U4Pllf/bHqpADsKU
         gmxg==
X-Forwarded-Encrypted: i=1; AJvYcCUobh9+qfigMwbxN9aRvUSD/m+QLZn057XawqeTYpPQP1hP7XxGuYEeYH3WnnIQ1lsDmejqWmcq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpfis0OKzVutFyUC64+1xjBn8pixYyyoN7WqgWwa6gUB//SNg+
	xTsNAG6qKop8910aOf85w1r/7PR7s9vrBsGIJbn4AN7zfkkQbvd4NI2QxmtY3EYFM1Q=
X-Gm-Gg: ASbGncsFOi11XGwW5ZLUHwShfTRSidPrsv5xDAWgm0NErNdz+UySHzl5cBXKQuL3xGK
	5nAf21IIYXoJ1HtZlKDI1nnN0jaUlH0OgxDlp4CBi32CpkLNXglD1hve/c372k5EZMzQPgvCTPO
	C3JYgYX6EESPk+MjpeF0F+r32wiLoNGzgmYXB1/lMupdvLGHzkIECSomUFfPpz3ScY3SIbYSEgK
	z0oi8CNL8LsWsrmji2O8w68S7JGkY4N8azePJj4PwTyZWJBibLxycuBS3PCRHzj/RVQobDjpJbL
	RfBAZpArk2DwUZoeXMg73Z9vM6kKDcEgVggw6X/gR3lF+p2K0+ZUCQsMhYEyGdhZFNluNK72y0L
	XOW0S/vEmr/EDdGXI2JlwTBwxvA4=
X-Google-Smtp-Source: AGHT+IGiizUFmBSTpeZJ5dmyXz9YFFa3qF02AbLOspABeMvam78MGL4sGdP0t+teyDu/19rZx2WDqA==
X-Received: by 2002:a05:6a21:20b:b0:218:17c4:247c with SMTP id adf61e73a8af0-21817c4f2a9mr22073258637.40.1747876097268;
        Wed, 21 May 2025 18:08:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365b2d80sm4318016a91.4.2025.05.21.18.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 18:08:16 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uHuPu-00000006Woq-1EHe;
	Thu, 22 May 2025 11:08:14 +1000
Date: Thu, 22 May 2025 11:08:14 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/4] xfs/432: fix metadump loop device blocksize problems
Message-ID: <aC54_ucTlwh189MG@dread.disaster.area>
References: <174786719374.1398726.14706438540221180099.stgit@frogsfrogsfrogs>
 <174786719464.1398726.8513251082673880762.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174786719464.1398726.8513251082673880762.stgit@frogsfrogsfrogs>

On Wed, May 21, 2025 at 03:41:51PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Make sure the lba size of the loop devices created for the metadump
> tests actually match that of the real SCRATCH_ devices or else the tests
> will fail.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/metadump |   12 ++++++++++--
>  common/rc       |    7 +++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/common/metadump b/common/metadump
> index 61ba3cbb91647c..4ae03c605563fc 100644
> --- a/common/metadump
> +++ b/common/metadump
> @@ -76,6 +76,7 @@ _xfs_verify_metadump_v1()
>  
>  	# Create loopdev for data device so we can mount the fs
>  	METADUMP_DATA_LOOP_DEV=$(_create_loop_device $data_img)
> +	_force_loop_device_blocksize $METADUMP_DATA_LOOP_DEV $SCRATCH_DEV

That doesn't look right. You're passing the scratch device as a
block size parameter. 

>  
>  	# Mount fs, run an extra test, fsck, and unmount
>  	SCRATCH_DEV=$METADUMP_DATA_LOOP_DEV _scratch_mount
> @@ -123,12 +124,19 @@ _xfs_verify_metadump_v2()
>  
>  	# Create loopdev for data device so we can mount the fs
>  	METADUMP_DATA_LOOP_DEV=$(_create_loop_device $data_img)
> +	_force_loop_device_blocksize $METADUMP_DATA_LOOP_DEV $SCRATCH_DEV
>  
>  	# Create loopdev for log device if we recovered anything
> -	test -s "$log_img" && METADUMP_LOG_LOOP_DEV=$(_create_loop_device $log_img)
> +	if [ -s "$log_img" ]; then
> +		METADUMP_LOG_LOOP_DEV=$(_create_loop_device $log_img)
> +		_force_loop_device_blocksize $METADUMP_LOG_LOOP_DEV $SCRATCH_LOGDEV
> +	fi
>  
>  	# Create loopdev for rt device if we recovered anything
> -	test -s "$rt_img" && METADUMP_RT_LOOP_DEV=$(_create_loop_device $rt_img)
> +	if [ -s "$rt_img" ]; then
> +		METADUMP_RT_LOOP_DEV=$(_create_loop_device $rt_img)
> +		_force_loop_device_blocksize $METADUMP_RT_LOOP_DEV $SCRATCH_RTDEV
> +	fi
>  
>  	# Mount fs, run an extra test, fsck, and unmount
>  	SCRATCH_DEV=$METADUMP_DATA_LOOP_DEV SCRATCH_LOGDEV=$METADUMP_LOG_LOOP_DEV SCRATCH_RTDEV=$METADUMP_RT_LOOP_DEV _scratch_mount
> diff --git a/common/rc b/common/rc
> index 4e3917a298e072..9e27f7a4afba44 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4527,6 +4527,8 @@ _create_loop_device()
>  }
>  
>  # Configure the loop device however needed to support the given block size.
> +# The first argument is the loop device; the second is either an integer block
> +# size, or a different block device whose blocksize we want to match.
>  _force_loop_device_blocksize()
>  {
>  	local loopdev="$1"
> @@ -4539,6 +4541,11 @@ _force_loop_device_blocksize()
>  		return 1
>  	fi
>  
> +	# second argument is really a bdev; copy its lba size
> +	if [ -b "$blksize" ]; then
> +		blksize="$(blockdev --getss "${blksize}")"
> +	fi

Oh, you're overloading the second parameter with different types -
that's pretty nasty.  It would be much cleaner to write a wrapper
function that extracts the block size from the device before calling
_force_loop_device_blocksize()....

-Dave.

-- 
Dave Chinner
david@fromorbit.com
