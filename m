Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEEF175A5
	for <fstests@vger.kernel.org>; Tue,  4 Feb 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688670; cv=none; b=rLm+fZK9KtkzNLemYSvdPwaBaFbDkdUwVu5mT6z3ebyAByTpkypspRpahAMQ0pWDfjx9iWRsFyjFmB7bff9DqcGl13W8onAtA1SAMkLmu8aa9xtwXEDIcAmhlz0ykc0uJr0GVeANB9oy5dFrMP3XoBedZu4w+aWoMXrhsOd/sxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688670; c=relaxed/simple;
	bh=fp2YvRgD0uFv5VWWPsiww4oOfsA5XkzKQKfvhXVawQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuNvhFmZ16AvBhHZsZJOTUPfcXtVcanuztJw+LTfqlVsRKv2bZcW3HRSXm5Q0HKWJ5BRRlhfBEC4I/gPJ6tD1i1ZzOHeg0jiDc9MCopBFN3U9YwnGqQOGtJV8xrXbbn9sN24b3/wYR1I4EbC/yDYa0PoJdEN7Da5Davbo0PQx1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAV/jfry; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAV/jfry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577B4C4CEDF;
	Tue,  4 Feb 2025 17:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738688669;
	bh=fp2YvRgD0uFv5VWWPsiww4oOfsA5XkzKQKfvhXVawQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAV/jfry7Yp3hAKObhfYRDB720mSKa4Myw12IIRmVi81D+Ft54imFvB/3lleJr6MK
	 +ME5uX1w0TVF5GMm6HkmSiQmQ9bDVA7Y6aXFiFHmdxXYgHH4vpW8o6MsU5TVg9eUeI
	 jjGT1l6AZOLVKTka8pI5O3aF7WCKwTeN8Xc9grYTAwOhWKzJiijtP/7t9KIlNABP58
	 /rTRAHg/gPsu68gF3lAQIwtbxXV6kernnxLWohl90l+GqK8Rkw3Ov4zS6j+TkkUDdo
	 s6YYMfFOwKIRMU8fnFMRf1xeCycFUUgkRKBiFNAT3XSvK1wToWlOrwSbRzGuWWnSd/
	 Kt2gH70voS6oA==
Date: Tue, 4 Feb 2025 09:04:28 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] common: fix a spelling error in _require_zoned_device
Message-ID: <20250204170428.GB21799@frogsfrogsfrogs>
References: <20250204134612.2017269-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204134612.2017269-1-hch@lst.de>

On Tue, Feb 04, 2025 at 02:46:12PM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 4658e3b8be74..6840bb1dfa10 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2473,7 +2473,7 @@ _require_zoned_device()
>  
>  	local type=`_zone_type ${target}`
>  	if [ "${type}" = "none" ]; then
> -		_notrun "this test require zoned block device"
> +		_notrun "this test requires a zoned block device"
>  	fi
>  }
>  
> -- 
> 2.45.2
> 
> 
