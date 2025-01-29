Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4057081B
	for <fstests@vger.kernel.org>; Wed, 29 Jan 2025 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738184786; cv=none; b=VEc6YCJICv6nsFJiNtgR63c/3PpmKT/FPLQZA8INrKPAKEdEoDHpsrtPvgZtJAf2E2iNkz8f2gl4iy+hRXKnx0siRzFfqF/75oxQnEmmAq2KygD0ZR2felsts4/st9AH9VuEDjOpSpC5f+51N4qCr3k+r7QyyiiU3vmTuWH3ttQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738184786; c=relaxed/simple;
	bh=UAOIOLaien8ucwYlofDp4qUSe+Cw/YQyERLn/QQlbpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4NtLr+IjYJKbk3JaMVWAmjAro/bm+D3trUoFi1nNehFau/vIA+XsnrP+al6k7DQHmLyJJmzIfxbIh95C01YbCMigLwqzTpPM09Xhw5s3AdrIcfmtPmTKNVP2vDgGTwTTlorC5BbUaaGdBTn65Zkhump4p0/mAf7GDUDuPmiPmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUu9P3lM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUu9P3lM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A040C4CED1;
	Wed, 29 Jan 2025 21:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738184785;
	bh=UAOIOLaien8ucwYlofDp4qUSe+Cw/YQyERLn/QQlbpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUu9P3lMHs3r/9odM1SR5QR0/Xuhbe23SOnaLjfODdtaz/GPXvftoXW0PytOuYADH
	 awuEsofnlVLCG5WXrkFsTiHBxS5ODCXPfFEGqrpae3v55IxgtsPArPqAuHRwcvZMcn
	 GWBQ1RNACOhDvLTzYzOGNHlPdxHZB2DVe6FiH/D0HaL/2QCjMADRyCW2RgAHlPD+C5
	 Bu3MhrarvtT0ICwGTa3fi+kF7jKYZQr2jg0nRCdFOKWccvtfgMdoPUvRP7hc71lC0B
	 RQ8rnnnBjisv8FnBPzqvJVUkCG8Cff9R3FQx969d4RuLKjTFaXjH8nN6P9mU68lDDO
	 Vh09HzXnz2VQw==
Date: Wed, 29 Jan 2025 13:06:24 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/541: _notrun if the file system can't mount
Message-ID: <20250129210624.GZ3557695@frogsfrogsfrogs>
References: <20250128071449.676462-1-hch@lst.de>
 <20250128192506.GT3557695@frogsfrogsfrogs>
 <20250129054918.GA29053@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129054918.GA29053@lst.de>

On Wed, Jan 29, 2025 at 06:49:18AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 28, 2025 at 11:25:06AM -0800, Darrick J. Wong wrote:
> > On Tue, Jan 28, 2025 at 08:14:48AM +0100, Christoph Hellwig wrote:
> > > A file system created without an RT section might not be able to mount
> > > with an rtdev specified if the RT device has a larger LBA size.
> > 
> > Where does the mount failure occur?  The initial mount (where we specify
> > -o rtdev but sb_rblocks is still zero) should succeed because
> > xfs_rtmount_init ignores m_rtdev_targp if !rblocks, right?  So it's only
> > when you get to growfs and we try to read the device that things fail?
> 
> There only is a single mount in the test.
> 
> The test only clears the rtdev for the mkfs call, not the mount call.
> As XFS doesn't allow adding a new rtdev at runtime, just expanding the
> file system to the already passed but not actually used rt device in
> growfs that's actually needed, even if it sounds counterintuitive.
> 
> (that being said I sent the patch directly from my zoned branch,
> so it won't apply as-is due to context issues)

Gross, it's the set_blocksize call in xfs_setsize_buftarg that trips
everything up.  But, it makes sense that one cannot mix sector sizes nor
mount an rtdev with a larger sector size than what's configured on the
data device.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D
