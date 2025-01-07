Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123BE1E0DE6
	for <fstests@vger.kernel.org>; Tue,  7 Jan 2025 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736292161; cv=none; b=WzLzpuRCpbE4kfobOLaRU5kKjluwjw5WfNLmptNj/JGfo74k6Klo0DUwjRGgHwf2QOnQxgYH/uS5hZH/xzhJZdnlfEIt0VFnF0BsXlG/J+d5L84TxkcUYdYpRKQq+2k0Jz0GpbRTxzDxwzWM2DRXE/gnMdjMhmC2gqxsmvSZZtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736292161; c=relaxed/simple;
	bh=IUNnW/inX3/7Bnlm51AtyuSBLv1e0zNCTC/D0JSCA6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+0RYugWav5dkSe9+TNwiqwJR3/GlUHJNR5h1Xy6XfmqGKwY+LBQcKeGKkVw7FhmZq+6xRgdrxe0aCKQdwrTYSKnXKqDdsmRI7qqlMhB4GHchGUuVc746LZx/EQUafKr+uxLBOCCGUHooIYaRgLT1k63b+zvQ5h875DfUTICM0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gopslC4h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gopslC4h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCD0C4CED6;
	Tue,  7 Jan 2025 23:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736292160;
	bh=IUNnW/inX3/7Bnlm51AtyuSBLv1e0zNCTC/D0JSCA6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gopslC4hLNPQdmslcj37pcvSCiV1mRsXP6zCUqBtXwHS2cxZ0q4yEOKqY6US5iBz5
	 cCOb76AMqUfnUA5T0YekMRkOLeggwMtDqJd6971BF/w8vNHSkE9QWLmvg9NltmQwCM
	 rgSIHUW9nQ4YKctDl/ok/1OVjEZWoMKD2IXKVD97lIEAQxvj3xiHQtkymYBZrYblXC
	 2qZ+bjwno1mx5pM2p3LYAi58oy88XYRORtBprUsAN7T8zxGzQ/KUD2Agp2w7BLHQSF
	 9rwH7r+3W/QNx+MyrcxYzGIVusdhrgoEImGynEKIxK707JAHl7V80VdvAamteTiBdm
	 QOEJG9RCu/SAA==
Date: Tue, 7 Jan 2025 15:22:40 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] fsx: add support for RWF_DONTCACHE
Message-ID: <20250107232240.GT6160@frogsfrogsfrogs>
References: <20250107160617.222775-1-axboe@kernel.dk>
 <20250107160617.222775-3-axboe@kernel.dk>
 <20250107181920.GS6160@frogsfrogsfrogs>
 <98b65811-dec5-44e7-8b8e-c6f65ab1ee0c@kernel.dk>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98b65811-dec5-44e7-8b8e-c6f65ab1ee0c@kernel.dk>

On Tue, Jan 07, 2025 at 11:24:13AM -0700, Jens Axboe wrote:
> On 1/7/25 11:19 AM, Darrick J. Wong wrote:
> > On Tue, Jan 07, 2025 at 09:05:15AM -0700, Jens Axboe wrote:
> >> Using RWF_DONTCACHE tells the kernel that any page cache instantiated
> >> by this operation should get pruned once the operation completes. If
> >> data is in cache prior to the operation it will remain there.
> >>
> >> Add ops for testing both the read and write side of this. At startup,
> >> kernel support for this feature is probed. If support isn't available,
> >> uncached/dontcache IO is performed as regular buffered IO. If -Z is
> >> used to turn on O_DIRECT, then uncached/dontcache IO isn't performed.
> > 
> > Huh.  Does the kernel reject RWF_DONTCACHE for directio?  And, if a
> 
> It doesn't, it simply ignores it. Not sure why you ask? It's buffered IO
> after all, falling back to just clearing the flag seems like the most
> sensible solution here.

I was curious, because your code does has_dontcache=0 when -Z is used to
select directio mode.  So I wondered if it that was because the kernel
would return EOPNOTSUPP for directio + RWF_DONTCACHE? :)

Then I wondered if there was actually a good usecase either for letting
userspace specify it, or for filesystems to add it for buffered write
fallback.  At this point I would wager there's a stronger case for
adding drop-behind automatically because userspace shouldn't have to
communicate "write this without accessing the page cache, and don't
leave file contents in the page cache that I already told you not to
do."

Anyway the fstests change satisfies me now so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> > directio implementation falls back to the pagecache (e.g. xfs when doing
> > a sub-fsblock cow write), do we:
> > 
> > (a) want RWF_DONTCACHE to propagate through to the buffered io
> > implementation (which I think xfs does) and
> 
> Maybe? The current implementation keeps things simple and doesn't touch
> any of that stuff, but conceptually it'd make sense to mark those
> buffered ranges as uncached, if instantiated as buffered IO on behalf of
> direct IO.
> 
> > (b) should filesystems *turn it on* any time they fall back, even if the
> > original IO request didn't set DONTCACHE?
> 
> Same answer :-)
> 
> -- 
> Jens Axboe
> 
