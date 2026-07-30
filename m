Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C113AB273
	for <fstests@vger.kernel.org>; Thu, 30 Jul 2026 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433176; cv=none; b=FQA6xmge9M3ZAOVCgT3qwwoDd5tPq5Amiovn9A2MZME5DZI9aB0kXuzjHqOXGtPYYIxtHf9iPWFAQsj8rsvDmY1/BSBFqV2JXiuDKqJ4mIpIT9Bd6Sq4jvs7FokdkeO62BwMcLLztvo64oeWusIcBGYbD1dYA0XNqHrb2tcpl6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433176; c=relaxed/simple;
	bh=GlyxQ+rB7OcNd3NLMBI2fn2UWwqlVAjCr+8Os9SXtm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDet/H04Pw7cZpc5cFxvzKMbES69yDpqSAsyXpXmWQUH8V7yL2wep4QNCs8trz849szwv+e20RW7ULtHWSwyn8s583meDkR7rwXUl82lJ9/Eh75ZyZbwcQ41FXp1h0nxl8u5m6u1RX/aiqMqXhaTn87UGjnzBHybxEWELKZFlLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSp2Z4sE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSp2Z4sE"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A28981F000E9;
	Thu, 30 Jul 2026 17:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785433174;
	bh=/ijJ+s3fbAHvk39TPv8dI6eBaiM+vqxTpcwLlUPdh8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PSp2Z4sERkd/nEO2idkYoiKozvyOntkm1EW0q37JBBBq1V0Tzow1SsbVwqKq89OfD
	 FnKLu8CIajH0OtnGDSbtq4eJTdTbGiSB8N+0pzieQjmvYSkGzmk8mheU4Y9bFFkOQb
	 VLyXngE+38NC5T4vsvXYofWygZJEcDN3FxXPIoznKHo6JHFzqlVcIoZTa3Cb35jUZE
	 ltZ/tXVwX1MhHgEtdSbLoaMhfxlr1vSvQZABtuIuuSRFRxXU/BNahX+JbGDMwYyAVz
	 gQw8Knpq2zfVo6LW20/c2GLP/6gdygrzYyPpBAO/Rtn21VQrznacm83hDTJ5LpuYEW
	 WWYcDeiSlOuUQ==
Date: Thu, 30 Jul 2026 10:39:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH v2] generic/645: notrun if FS doesn't have enough free
 inodes/blocks
Message-ID: <20260730173934.GK7398@frogsfrogsfrogs>
References: <20260730172207.1937537-1-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730172207.1937537-1-ojaswin@linux.ibm.com>

On Thu, Jul 30, 2026 at 10:52:07PM +0530, Ojaswin Mujoo wrote:
> When running generic/645 with ext4 using 64k block size + bigalloc, the
> test fails with ENOSPC because the filesystem runs out of inodes before
> the test completes.
> 
> The test creates approximately 10,001 files, however, in this particular
> configuration a standard 5G FS only has around ~5100 inodes resulting in
> the ENOSPC failure.
> 
> Parse vfstest output to notrun the test incase we encounter this ENOSPC
> instead of reporting it as a failure.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
> 
> * Changes since v1 [1] *
> 
> - Instead of using a helper, check for ENOSPC in vfstest output
>   (Thanks for Darrick for suggestion)
> 
> 
> [1] https://lore.kernel.org/fstests/20260617054216.3186441-1-ojaswin@linux.ibm.com/
>  tests/generic/645 | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/645 b/tests/generic/645
> index d6eb75e6..6498efe1 100755
> --- a/tests/generic/645
> +++ b/tests/generic/645
> @@ -22,7 +22,13 @@ _wants_kernel_commit dacfd001eaf2 \
>  echo "Silence is golden"
>  
>  $here/src/vfs/vfstest --test-nested-userns \
> -	--device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
> +	--device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP" \
> +	> $tmp.vfstest 2>&1
>  
> +if grep -q "No space left on device" $tmp.vfstest; then
> +	_notrun "$TEST_DEV ran out of free blocks/inodes"
> +fi
> +
> +cat $tmp.vfstest
>  status=$?
>  exit
> -- 
> 2.55.0
> 
