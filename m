Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A705672
	for <fstests@vger.kernel.org>; Wed, 29 Jan 2025 05:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738129763; cv=none; b=N3E7KHYysGwQxcYCGMVhdSo5oQgIHMmnu08sIjKOqwqSiegE7O+qe7bG7aOb1yokLVAyq8cjfcN3EZQ+lfO7lSCAP2xWUTcudHrINPgdkqcyNBdM0s7LXHLsc10jksQ+HIiU9Gdb9/5fkrRaggvqAzJWkCPQFKM2EPp/CqLsMao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738129763; c=relaxed/simple;
	bh=J6wW7nGzZsYFwFlbeSPvhUWCYtjdDubyC2TDsjiNfYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvJKptMtZSTiKWtUrqWMyiRu126DmJDRJZun7vm0fPurdkrmz1wqbQhSklXZGSpQ6ezsiYEfAVEJeHu7vWI0OIUKaLm/mSzx3YZfuAp+TW50spIg2uYcs098uXJII0bWWt/tp91G4d3PuhJozljupY5lX6U3KbEfJfbPHSNOm9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D9F6968D13; Wed, 29 Jan 2025 06:49:18 +0100 (CET)
Date: Wed, 29 Jan 2025 06:49:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, zlang@kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/541: _notrun if the file system can't mount
Message-ID: <20250129054918.GA29053@lst.de>
References: <20250128071449.676462-1-hch@lst.de> <20250128192506.GT3557695@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128192506.GT3557695@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 28, 2025 at 11:25:06AM -0800, Darrick J. Wong wrote:
> On Tue, Jan 28, 2025 at 08:14:48AM +0100, Christoph Hellwig wrote:
> > A file system created without an RT section might not be able to mount
> > with an rtdev specified if the RT device has a larger LBA size.
> 
> Where does the mount failure occur?  The initial mount (where we specify
> -o rtdev but sb_rblocks is still zero) should succeed because
> xfs_rtmount_init ignores m_rtdev_targp if !rblocks, right?  So it's only
> when you get to growfs and we try to read the device that things fail?

There only is a single mount in the test.

The test only clears the rtdev for the mkfs call, not the mount call.
As XFS doesn't allow adding a new rtdev at runtime, just expanding the
file system to the already passed but not actually used rt device in
growfs that's actually needed, even if it sounds counterintuitive.

(that being said I sent the patch directly from my zoned branch,
so it won't apply as-is due to context issues)
