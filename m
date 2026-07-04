Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E592D3A60
	for <fstests@vger.kernel.org>; Sat,  4 Jul 2026 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783185332; cv=none; b=CRd6ESdTlkNz3OhSfo5aK6ZlyPqGLubQ7I0apmL2wQZrDMgJ3LYv1SKKSMsYfw00Whza5vUD0M6+M2IjQZSHdhgQgvDMZcLGWbs4ZjqcOhrMa1IIIBhLMydd6eSZEz1uz9bU8BqkUlMcyQh/9QXpSgoWOA3wZFPi0yn3F31T5XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783185332; c=relaxed/simple;
	bh=s8f7PVSNHjwn4yKrSWpspUHS/hQKinFS3Kxizl7hsNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AW3jhjC7qgtvFSYCNfzLUZQO5jgN4I23j3cBazl/uiVd4hkMnN19hvhcgSDx6kxz40DZ0n4a1yZzMJPooy/CxZrPbkXttpmnxU3G9kG9hNiFHkhitOI1zD83sO9/WxbBceGn9dVLH26uoxJZ3Ov4LFtMryiYv/Hlr2KTEObnQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0v4IkHe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0v4IkHe"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C8BE91F000E9;
	Sat,  4 Jul 2026 17:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783185330;
	bh=r/jT6uR4kGlVEW51lmEJc1ZVmSYSBor1gMA0mn1uUeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d0v4IkHe8Y00eGz90Co5kvjdaYNacOSv+py4ugC46f/Bnn4L+gahY3cDQ5UxZeBnr
	 F+skPTJFZcblNxQ9yZDzKIs+LU891f9Ncc/0jdNpZegZmTM07lNQy+McGIm/G2D65k
	 +mI04WxgUvKlEqSupcqoqwzP8q2Sc7vr6AVhAWxJEW3AECK5SNT+6rJCKciyY4cghb
	 gzGc0Idzg/H7hHxjAkJa7bDrnOpwBVUj5VGuzwq/s0dQcp/dPQym9ZdusuYDA9eDCW
	 nqV+sYPlytmcCSqzUdfM9/sZQHEbG6wMIhid4GBY6zdVDdiu6ZfWgKitwT5IuCdKu4
	 sZiM+IVoNEwSQ==
Date: Sat, 4 Jul 2026 10:15:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] common: log mkfs output in _test_streams
Message-ID: <20260704171530.GD9407@frogsfrogsfrogs>
References: <20260703134459.4075731-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703134459.4075731-1-hch@lst.de>

On Fri, Jul 03, 2026 at 03:44:38PM +0200, Christoph Hellwig wrote:
> Log the mkfs output to allow debugging the mkfs paramters,
> especially when mkfs and thus the test fails.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Changes since v1:
>  - append to  $seqres.full instead of overwriting it
> 
>  common/filestreams | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/filestreams b/common/filestreams
> index 459de8c6b6a6..c40b33e4b0b8 100644
> --- a/common/filestreams
> +++ b/common/filestreams
> @@ -89,7 +89,7 @@ _test_streams() {
>  	# Skip these tests on zoned file systems as filestreams don't work
>  	# with the zoned allocator, and the operation below would force it into
>  	# the tiny data section only used for metadata anyway.
> -	_try_scratch_mkfs_xfs >/dev/null 2>&1 || _fail "mkfs failed"
> +	_try_scratch_mkfs_xfs 2>$seqres.full 2>&1 || _fail "mkfs failed"

                              ^^ this still truncates seqres.full

What you want here is:        2>>$seqres.full

--D

>  	_scratch_mount
>  	_require_xfs_scratch_non_zoned
>  	_scratch_unmount 2>/dev/null
> -- 
> 2.53.0
> 
