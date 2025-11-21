Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B1F3002A3
	for <fstests@vger.kernel.org>; Fri, 21 Nov 2025 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763752886; cv=none; b=K4s/HTVosyCGacGGFZ8xti5/lppXAgkA6ALUSCQA/ZZrOeLgTfam8rzCMDDa/fWJw9lQNJtUXOu7dXQl5zmdjkHZvPIWvlV9AZYRs1WC5rLMY9QzN510YrPAjOCvbFxPMke5DoRMJhT9AyJagTw1oKAkPJXII2BVgWAnIzbj7Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763752886; c=relaxed/simple;
	bh=6WOWolbnzEc71LcGZucLz77+MMCv2MIiRMvUSECtlMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwjpI1/WU/FWVRpB4co6eHTn35a/7s7BXMRAWwp/CjL6S2RyCxlhs8RYVWMGxN7yVCTQx11qWokrb5VCTJ8qr88QblvE1xu7Wcm6r9FtCcg+mn69MosqKzJufDa3SbsLqFLKG6Ypo/mhXcJCnnu7Mo8KSd2ZRLTn0ls/+80LSv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5yytl6+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5yytl6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39602C4CEF1;
	Fri, 21 Nov 2025 19:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763752886;
	bh=6WOWolbnzEc71LcGZucLz77+MMCv2MIiRMvUSECtlMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5yytl6+zPJp3UuCH4NhfZHL4VPzO7V4tflUlJW4IONIfP4wp6zW34stKkZHV5KMO
	 zmokBfTFCqCkjqQrgZlNh0Z105PgVefU/kK1BQ2fBeW87RwLN17ZU7Rn7UVFJ5x5QS
	 V3CYdq9P1T44J0rph7110mc2uhkjAZPjD833s85enGp8CL/Tx0gu1qtedIf9aTT/iu
	 VAICcNxh7Q6Q3hQmkGvPxbUQ88XKZPsGdAQrbZhweZYMgXxhaRXmgx5wMfKkemP4cn
	 9QMhWCY/KakGFqpxodd+1z+F0MjtPMG+D5wmeIAuVe2YAgEKwRT8+xJCa6cNN4Fisb
	 1c51VTZgM14fA==
Date: Fri, 21 Nov 2025 11:21:25 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: fix bug with _check_dmesg "some pattern"
Message-ID: <20251121192125.GP196366@frogsfrogsfrogs>
References: <16110e3dac5c7476dd5c74bfb50efb4dc1aac5f0.1763747729.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16110e3dac5c7476dd5c74bfb50efb4dc1aac5f0.1763747729.git.josef@toxicpanda.com>

On Fri, Nov 21, 2025 at 12:55:34PM -0500, Josef Bacik wrote:
> I've been rigging up Claude to run fstests via an MCP, and part of this
> means it mounts a 9p file system to save the fstests results. This was
> giving me occasional ENODATA errors, which I dug into. Turns out it's a
> race between truncate and read on 9p which is completely normal for 9p,
> but it's uncovering an actual bug in _check_dmesg. The way bash works is
> when you do
> 
> cat foo | whatever > foo
> 
> bash will setup the various communication channels first, which is the |
> and >, and then it will execute the commands. This means that it
> truncates foo FIRST, and then it launches cat. Which means we'd race
> with truncate and sometimes get data, sometimes get nothing. And even
> worse on 9p we'd get ENODATA because we get a 0 read back when we
> thought the isize was reasonable.
> 
> Fix this by changing this case in _check_dmesg to redirect to another
> file, and move that file over $seqres.dmesg to be checked later.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  common/rc | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index a10ac177..947685df 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4844,7 +4844,14 @@ _check_dmesg()
>  	# test failures. Custom filters are then applied afterwards.
>  	_dmesg_since_test_start | _check_dmesg_filter > $seqres.dmesg
>  	if [ -n "$1" ]; then
> -		cat $seqres.dmesg | $1 > $seqres.dmesg
> +		# We use $seqres.dmesg.tmp because shell will setup the
> +		# redirections first, which means we would truncate
> +		# $seqres.dmesg before cat'ing it. This is racy so sometimes it
> +		# would work, but othertimes it would silently fail, or in the
> +		# case of 9p you'd get ENODATA. We must redirect into a
> +		# temporary file and then move it.
> +		cat $seqres.dmesg | $1 > $seqres.dmesg.tmp && \
> +			mv $seqres.dmesg.tmp $seqres.dmesg

I wonder if this would be simpler put:

	if [ -n "$1" ]; then
		_dmesg_since_test_start | _check_dmesg_filter | $1 > $seqres.dme
	else
		_dmesg_since_test_start | _check_dmesg_filter > $seqres.dmesg
	fi

Fewer tempfiles, etc.

--D

>  	fi
>  
>  	grep -E -q -e "kernel BUG at" \
> -- 
> 2.51.1
> 
> 
