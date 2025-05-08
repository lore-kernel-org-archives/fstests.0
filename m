Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1DA27A929
	for <fstests@vger.kernel.org>; Thu,  8 May 2025 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717164; cv=none; b=QDhBoASu7in07DHo4sqfij0Y431LbtmBCUbCvURGPb+l68DWztjZPB9f0cxt/IoyH852Z6pppcsZ8iv6WLzzmoTK26bp6KJOHCAWkETr+92sdWSVtOAKCpkZcn0IA6duWdephz6JpTCFC3UzCYUM+VA6r8gUfkK3JfN3VTBrM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717164; c=relaxed/simple;
	bh=7Bo3XiDqt7E7N9uudDkU/9S2JmFu0i1YhGv2xqIWBRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9FLOiBvBId/Z2Ld/DemApKul4W0hMjL/HXPo57lLXK4+rd4M3Nhfmpa68zDWeU+Y8gzDn5+AQw8IsZ83jmHASwBcA2l4TpXTIOtOU3dKMtsIZIrwZiO9hYMSVfayC46GbP9yn+BiVnjro0u6P4rbzRaEWMEWZRCUZSHJq+5J7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUCUgcRA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUCUgcRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9621C4CEED;
	Thu,  8 May 2025 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746717161;
	bh=7Bo3XiDqt7E7N9uudDkU/9S2JmFu0i1YhGv2xqIWBRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jUCUgcRACpKC0eKNFBt5ak90Gg4+qljXbf4h7MjxsXPKVJAuy27u+rP+nlAxqFc8c
	 deT75su0DY5g27bRTxQjIaW7nrFHbk3pw0jL5AdfoH0ClmwOwtHb1LZ5LrgXhA1qRI
	 xL7xQA9CkvBU5avtHiXAWq4j8SW3vyucrPYqSbyrdA3rybjOzjOGZwxEu75Vdb+aSl
	 lmWF2erJT2ld5q22GSaDkdlbvHwHipkLbCrNCRpQQWu1aInP9qkoOyKAXWHmsEqDn8
	 C2PLJ7HOLctPRd7gTwgRtugr84N2Xen7NVMKPzDNvkCaDtPX0g3Abq7dwMduKBhRVR
	 d3APDi6rxr7lg==
Date: Thu, 8 May 2025 08:12:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/008: fix golden output for 512 fsblock size
Message-ID: <20250508151241.GQ25667@frogsfrogsfrogs>
References: <20250508074102.125013-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508074102.125013-1-ailiop@suse.com>

On Thu, May 08, 2025 at 09:41:02AM +0200, Anthony Iliopoulos wrote:
> commit 97989c9839dd ("xfs/008: use block size instead of the pagesize")
> changed the test filter, which causes nocrc/512b fsblock configurations
> to fail due to mismatch of the golden output. Update it to match the
> expected output.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>

Looks good to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/xfs/008.out | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/008.out b/tests/xfs/008.out
> index 0941e218c7d0..dc999156dab5 100644
> --- a/tests/xfs/008.out
> +++ b/tests/xfs/008.out
> @@ -8,7 +8,7 @@ randholes.2 : -l FSIZE -c 100 -b BLKSIZE
>  ------------------------------------------
>  holes is in range
>  
> -randholes.3 : -l FSIZE -c 100 -b 512
> +randholes.3 : -l FSIZE -c 100 -b BLKSIZE
>  ------------------------------------------
>  holes is in range
>  
> -- 
> 2.49.0
> 
> 
