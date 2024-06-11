Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCBA17DE1C
	for <fstests@vger.kernel.org>; Tue, 11 Jun 2024 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115845; cv=none; b=cnaIdCyReyPpTDdis9rtDPp5abIpwQkMWh9+2xEAvQnFsf6rQcC2r5s0HlFQAUJvlHuVxWPeVHLpT67fCiFYxrHBPE4S7xZoWg6+a9uGB48SrHKzApgYdK1i4V6H0FXFNr5Aycji0FZAGLVuKHQPYff+RJ4wLbnibdLGmVF/Hkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115845; c=relaxed/simple;
	bh=ot72NZLy1N9AIy1vyjNg61JiC7qo2WphpBb6wMgCKIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BE5ytVU9Zp/odMygkj0GYotb2kM9TjA/xVHjTcdKuE+A47hyDcGh+ZTaj78IRD6UKIT2au37n+6TWsP70BbW/0tf9FBjrYutC0pcF8jcQxlf1htmkWaG3gvdziOKHdzRmovOYQBg1MjjaoZdvLQOS9Jid7FhDp6FZdO2opxKMh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhV48mSr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhV48mSr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5283C4AF1C;
	Tue, 11 Jun 2024 14:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718115845;
	bh=ot72NZLy1N9AIy1vyjNg61JiC7qo2WphpBb6wMgCKIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhV48mSryXdmfCQJQBadX1qL2UV56rL2VKFaJkrSi5j39yMEZlkkZqCKAfxeO1xGh
	 7qgrG+NQoT48mZ50JQsXiUJhxF+xViBzeAsCLL1GSE7+BMe/JC2uVzSPVKsuwY9L/Z
	 vV/IWd2US2mPt/XPoSdn1tDDlgH4ZWVIF1O2sKa6K08HLd29YyIIAJda7kXjXHq7of
	 HfxBp9H0y4ul9b8Ll8OrGv8QwyoS1U7xCoIa56y95SjhXNnmxJUSo4GPEEuGIKh+KY
	 JzwJDREPl5keK23rcCTYG//FRzeY+1tQtrhWa1jVpshChREZ6wZlbhWvMFdnMZDkLW
	 QQTU2xT4GkxNg==
Date: Tue, 11 Jun 2024 07:24:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org
Subject: Re: can we pull in git as a dependency for xfstests?
Message-ID: <20240611142405.GD52977@frogsfrogsfrogs>
References: <ZmfjlWGk04r_R5j6@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmfjlWGk04r_R5j6@infradead.org>

On Mon, Jun 10, 2024 at 10:41:41PM -0700, Christoph Hellwig wrote:
> xfs/073 has been failing for me for a while on most of my test setups
> with:
> 
> diff: memory exhausted
> 
> from the recursive diff.  Switching to the significantly more memory
> efficient implementation in git diff as in the patch below fixes this.
> 
> Would it be ok to pull in diff (including a supported check)?
> 
> diff --git a/tests/xfs/073 b/tests/xfs/073
> index c7616b9e9..85d8ae8d0 100755
> --- a/tests/xfs/073
> +++ b/tests/xfs/073
> @@ -76,7 +76,7 @@ _verify_copy()
>  	fi
>  
>  	echo comparing new image files to old
> -	diff -Naur $source_dir $target_dir
> +	git diff --no-index $source_dir $target_dir

How about

	(cd $source_dir ; find . -type f -print0 | xargs -0 md5sum) | \
		(cd $target_dir ; md5sum -c --quiet)

since 073.out doesn't contain any diff output?

--D

>  
>  	echo comparing new image directories to old
>  	find $source_dir | _filter_path $source_dir > $tmp.manifest1
> 
