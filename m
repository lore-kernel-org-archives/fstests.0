Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29082139D
	for <fstests@vger.kernel.org>; Thu, 22 May 2025 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747876893; cv=none; b=Ovg3yaiDFWbgovfE4A3bCImy5nomu78BbOV4Qz+pgLd9Hn3++Uo5OHFaavviHXsPd5wcP5erRosyExnz7lzY1H7IhoSyOigdtmJ1aex5Bhx/6nNvU9GtxQY8pP/6ZrZ4nFsC13j5vHaM2R0FlGRRlNlVJp4lLx9rq8IukTV/GUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747876893; c=relaxed/simple;
	bh=mdihEtmmSw/HdsUV2hO/TYx6yugmHjTDRmcxARJ+gX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkN5843uHATlcbWCIiXXrMBgih7V8islthZZ6xVwYxJHshqscC76p2GQqOx4k1228NXG7Rh2bWGBct76swNtAOg+MZ22tcW26xMDv0MPhVLLPDthY1Jj0tUTVb5Og3AVEIgdRgozmuNWOtkX+eHOYsADzopOvzlMm2hPQWw/oeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=1ZQkzZRz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="1ZQkzZRz"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2320d2a7852so39276335ad.3
        for <fstests@vger.kernel.org>; Wed, 21 May 2025 18:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747876890; x=1748481690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WrQxKdEM/Zq30kTjdODCeXquXiL443EVNnmiydPOhsM=;
        b=1ZQkzZRza/KKZ3+7fFxMJURrK9bnq7Jzv9WrYjHcoH9Wf9/bpzNsB6uV3drEEi8sim
         VuMuAq0J2vfCH1JeXrpAnXaa+wNWYjkACsxO0IPSkGIL23CgRpHa+6736iODI7STtNlS
         tF5naJlfF5ZYr+bv6EPf80s+y6KHFk6JOF72JBMU09gSkbesQqKMhLifwKysFvLKdX59
         OhE+7JpD/dHn8Ht1EMY5VYV0Lrftkx6XO4w5n+C5/1eSucdTxhiOwk184KJQN8WLqGr1
         oPzgeLh/9ysHzs1iTn1maU3qOfxjzRmmiYsumcJa3iXQ0wrF6aTFIwsAXPdIkZLSndP4
         AJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747876890; x=1748481690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrQxKdEM/Zq30kTjdODCeXquXiL443EVNnmiydPOhsM=;
        b=g07gDlOrYp805e6yCoDkkKKZsL294VUZv/GoA/Qza+9RGxROAyj/0k5F2nDOSM7P7T
         QxX/7lRYkGhxByAQQjfGuLaVcvp9vzc7VMAcjJ7x2Ngf6m0Gk2o7UEghNEZVllG32fCd
         bCy8DqnFAb1TXwF8yf8dTPtFby4Z+Syt9KTsFu8FyPmQgqSjfvcetoCXv1N7YQttP/rc
         ZoZe8wKquSRPopGPHxC3aidw5yvLbjHMWSnMAtPxCBNfXgBP1RqAo5a0DGeB+4cUoncd
         Gwoms1dOMYohut8Bk3DHLYJIZo41NOMB47x3GoA5lJW107FbdioUOzAtCZrZpYJv/ghM
         ceRw==
X-Forwarded-Encrypted: i=1; AJvYcCUVvay+NgainQm8uKlyrKL1jxRehD5/GeNJAdvvA9EEUDcWVfz5B7hgAYseAMGJjqkglav/ibbY@vger.kernel.org
X-Gm-Message-State: AOJu0YykUX39JGbeYLVZpg9V0VYVW75DUMlwHTqofKlxy8DJuwQZpsnO
	y6Ti7YjYvyuUNu3TrtuGKPyMV+NuMFXtWw3pln+HPHENNJ5G1vt+rWkuIiSDkPOfkb4=
X-Gm-Gg: ASbGncuCfoHxJj9mckH5THiT1gOhFm79YdnTkEaH+SxlXfWiyrmII1uJu64qcJwD4fg
	GuvXRPH+ktumB8UKNkgWppdmxRlfNujGYTHg9gYWjNAVUjhb2ClcJ1bVrSyhLD6WdFF/kN6ugX7
	ghVaJbashFyqQ7VmbMbIvsDdeYi8yGZTTWFvBbvaPEF+4E4u3mZTcs1oe6210Jcvxelmi4oy43C
	rtvkSMUBJ1vWu2EU1q0D9ddcL+J7M+PVoQ6OosyZ9fLOXdJP081iugcid0QteEDSKzNyd9dBSyL
	kqxNU+m6gHQN4elmz8OxbY49PwWzZwrpnXBsXBZ8MfMYWmU+yh16E3MdqFZ6Xl1d4oZLDTkm4jW
	/ifd3toBCN1yT8lwf3AcJffCl5UY=
X-Google-Smtp-Source: AGHT+IHFXgfHhNmecD00UDOVa1X9Fzo8Pcr7d8ZHq8vZmT2cCyx8Od/WStNeZN8ld4GjQBPIOK95Jw==
X-Received: by 2002:a17:902:ce87:b0:220:e924:99dd with SMTP id d9443c01a7336-231de3ace9emr326814095ad.34.1747876890237;
        Wed, 21 May 2025 18:21:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac95cbsm98575145ad.45.2025.05.21.18.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 18:21:29 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uHucg-00000006WxE-3bJx;
	Thu, 22 May 2025 11:21:26 +1000
Date: Thu, 22 May 2025 11:21:26 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/4] xfs/259: try to force loop device block size
Message-ID: <aC58FjhTGEDAQiGb@dread.disaster.area>
References: <174786719374.1398726.14706438540221180099.stgit@frogsfrogsfrogs>
 <174786719445.1398726.2165923649877733743.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174786719445.1398726.2165923649877733743.stgit@frogsfrogsfrogs>

On Wed, May 21, 2025 at 03:41:36PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Starting with 6.15-rc1, loop devices created with directio mode enabled
> will set their logical block size to whatever STATX_DIO_ALIGN on the
> host filesystem reports.  If you happen to be running a kernel that
> always sets up loop devices in directio mode and TEST_DEV is a block
> device with 4k sectors, this will cause conflicts with this test's usage
> of mkfs with different block sizes.  Add a helper to force the loop
> device block size to 512 bytes, which is implied by scenarios such as
> "device size is 4T - 2048 bytes".
> 
> Also fix xfs/078 which simply needs the blocksize to be set.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/rc         |   22 ++++++++++++++++++++++
>  tests/generic/563 |    1 +
>  tests/xfs/078     |    2 ++
>  tests/xfs/259     |    1 +
>  tests/xfs/613     |    1 +
>  5 files changed, 27 insertions(+)
> 
> 
> diff --git a/common/rc b/common/rc
> index 657772e73db86b..4e3917a298e072 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4526,6 +4526,28 @@ _create_loop_device()
>  	echo $dev
>  }
>  
> +# Configure the loop device however needed to support the given block size.
> +_force_loop_device_blocksize()
> +{
> +	local loopdev="$1"
> +	local blksize="$2"
> +	local is_dio
> +	local logsec
> +
> +	if [ ! -b "$loopdev" ] || [ -z "$blksize" ]; then
> +		echo "_force_loop_device_blocksize requires loopdev and blksize" >&2
> +		return 1
> +	fi
> +
> +	curr_blksize="$(losetup --list --output LOG-SEC --noheadings --raw "$loopdev")"
> +	if [ "$curr_blksize" -gt "$blksize" ]; then
> +		losetup --direct-io=off "$loopdev"
> +		losetup --sector-size "$blksize" "$loopdev"
> +	fi
> +
> +	#losetup --raw --list "$loopdev" >> $seqres.full
> +}

I think it would make more sense to use a
_create_loop_device_blocksize() wrapper function and change the call
sites to use it that to add this function that requires error
checking of the parameters even though it is only called directly
after loop device creation.

_create_loop_device_blocksize()
{
	local file=$1
	local blksize=$2

	dev=`losetup -f --show $file --sector-size=$blksize`

	# If the loop device sector size is incompatible with doing
	# direct IO on the backing file, attempting to turn on
	# direct-io will fail with an -EINVAL error. However, the
	# device will still work correctly using buffered IO, so we
	# ignore the error.
	test -b "$dev" && losetup --direct-io=on $dev 2> /dev/null
	echo $dev
}

-Dave.
-- 
Dave Chinner
david@fromorbit.com
