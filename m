Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8C91DE4FF
	for <fstests@vger.kernel.org>; Fri, 13 Dec 2024 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090204; cv=none; b=KxQFBHcpT9Kz46YEEL/mz0qbV+W55590ZNBo1LhP7kreK4as0P4MfWA4FkIwLebd9FuG0oIio7yFFgPYYKa5utLL7xxaU4OS3aumxVRCk+9fXls4ImrLeN2DuRayXGMZZ28zRyHPWL1sHrOfnEbeaqA/0KYjx7ao9rVqGmFKGKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090204; c=relaxed/simple;
	bh=eW9nwW7lK1ifSKW/eKk9RryFq4CF13eTC66o1Cw75RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ0USP6j7GK5jUYJx1ficzYuTJdsPjSBcYuFjmvNGCUM5UzVRlOZybfz+kGV2GhHW6X1DPyCsg/B4vNG/Fu5/gw99vDeLoC/0wl0fpPhTJtvkwQOXH3+EVrh1VUiiLj7A5HEAN4z8fVzEb/45gcGtosm9RHR8c2DjTd6L3jX6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2d2SdLc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2d2SdLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226BBC4CED4;
	Fri, 13 Dec 2024 11:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734090204;
	bh=eW9nwW7lK1ifSKW/eKk9RryFq4CF13eTC66o1Cw75RQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t2d2SdLc/I3z1Hn5mw7jYhrKOmGSuMwQD4W/WHer4G8hRBU0IZJlyVCBZOk+BNkf/
	 SnZfWdxPLhgs/KhEkLI3OPv8QCbKjk5EZ/hY1Ns/Gl8hr6mkT6g2vtBQ1FXkYWZCWu
	 ztKzdKnDDEcgBAxTOyJ2QO4DD9gZpNTXyY/EJ3wKRpXJ8ebX+9DSnmHTX0HONxofLR
	 f+dcwGvTuH+r1YG4/gRagonoPUAIyn/M9TMdInMPcbTc3irFSOoPQP7oDT7Bnzgqlf
	 sbnroCzUJf5ENRyXR3RRB9ZUf9kMT0LHQZ/XbkjMkgHS7I8rkw7iUjIWrivwx6WrYR
	 g1MsAwRfQUrlA==
Date: Fri, 13 Dec 2024 19:43:20 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org, cel@kernel.org
Subject: Re: [PATCH] common: call _require_scratch_dedupe from
 _require_scratch_duperemove
Message-ID: <20241213114320.hm74x7v5yhxe7hem@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241210065346.1234550-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210065346.1234550-1-hch@lst.de>

On Tue, Dec 10, 2024 at 07:53:15AM +0100, Christoph Hellwig wrote:
> _require_scratch_duperemove doesn't check if the scratch file system
> actually supports dedup, so add the proper call for that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Btw, I wonder if we should simply stop using dupremove in favor of the
> xfs_io dedup command which seems lot less cumbersome?  For now this is
> a quick fix, though.
> 
>  common/reflink | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/common/reflink b/common/reflink
> index 22adc4449bc6..9177c45e70bb 100644
> --- a/common/reflink
> +++ b/common/reflink
> @@ -83,6 +83,8 @@ _require_scratch_duperemove()
>  
>  	_scratch_mkfs > /dev/null
>  	_scratch_mount
> +	_require_scratch_dedupe

Thanks, it makes sense to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

I brought in "duperemove" just for giving dedupe feature a random stress test.
I never thought the duperemove project can't be stable long time. If anyone
knows any other tools can replace duperemove, I can change duperemove to
others.

Thanks,
Zorro

> +
>  	dd if=/dev/zero of="$SCRATCH_MNT/file1" bs=128k count=1 >& /dev/null
>  	dd if=/dev/zero of="$SCRATCH_MNT/file2" bs=128k count=1 >& /dev/null
>  	if ! "$DUPEREMOVE_PROG" -d "$SCRATCH_MNT/file1" \
> -- 
> 2.45.2
> 
> 
