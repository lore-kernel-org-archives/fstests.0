Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890E28640A
	for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264031; cv=none; b=MkVh47MNxwi+ciLnp6hMhMmurEMcNfyW8cYp4Mps+KgfspfFU6CzrPJNwfwwKTC8hVEASjFWYpdNLNQ2X9GImyzRc/6+syTuroc5RGAkreLFP450Jqk2cG45FDJ5gqLNcZxGJmlkP2cXi8i2TxEOgrJ4JsrRyC+bQ0JRXXb7zKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264031; c=relaxed/simple;
	bh=n1ZX1uAt41rGaC8tt0s51SRjyXrzMQfkU3rbALn4k5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjB6sL5DlC8xRf6bhkikY98q0EDsSOhVOURHHqsDMC8I4eX+oZFYghgMRDCk2ZiL5t4t7qoUwSnuhdtnVNoasohwJ/+9/YtUrhafvXWy1z8C2E2K8/RjRgOIG+6gXTVLR7GKWCARienXQMBLLmHvXfihPiJ5eKC7xwa4H5voosQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFgf+XJ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFgf+XJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF65CC4CEE7;
	Wed, 18 Jun 2025 16:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750264030;
	bh=n1ZX1uAt41rGaC8tt0s51SRjyXrzMQfkU3rbALn4k5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFgf+XJ3ysLoIxA2T+u7AhbIXHWzMlgtXT38FVT0WFSxh8dmYKv8PReSh1dPCpZRP
	 bCLOcVGg+T2EmfK7q5XVMZ4OiWkQbuoXNwhJwJJyy375lBxsj7yCvmnNwwHZ/wRIMZ
	 cwR/gKxI2onUEk41RNih3v7U8lVmQqGnl4e0kydx3nmHmylkmomCIr4OHGu22GuvPp
	 U1eZFOXilBnSsW2Ll8sSVNBNraRMG/rFh5YLLVhf3slsQKWhb22u8CTCZTGOoeB1sG
	 lnomvaw0CkEqBsDrUn1h6ERgkVI0mcQ78s1f/9pbrex1VcaqRNvCLD73ebmlw0/1wn
	 hBXprRm6xEJew==
Date: Thu, 19 Jun 2025 00:27:05 +0800
From: Zorro Lang <zlang@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/740: move checking for a scratch device up
Message-ID: <20250618162705.uxkavyt75n4m7yyg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250613061417.2794099-1-hch@lst.de>
 <20250613145655.GV6143@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613145655.GV6143@frogsfrogsfrogs>

On Fri, Jun 13, 2025 at 07:56:55AM -0700, Darrick J. Wong wrote:
> On Fri, Jun 13, 2025 at 08:14:17AM +0200, Christoph Hellwig wrote:
> > Commit 3ae8a19f97d0 ("generic/740: enable by default") moved these checks
> > down accidentally.  Move them back up to make the test exit gracefully
> > when no scratch device is provided.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Looks fine,
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Weird, I didn't get this patch in my mailbox, I just got your reply.

> 
> --D
> 
> > ---
> >  tests/generic/740 | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tests/generic/740 b/tests/generic/740
> > index c0a634f2302b..ce55200f7bc3 100755
> > --- a/tests/generic/740
> > +++ b/tests/generic/740
> > @@ -21,13 +21,13 @@ _exclude_fs jfs
> >  _exclude_fs ocfs2
> >  _exclude_fs udf
> >  
> > +_require_scratch_nocheck
> > +_require_no_large_scratch_dev
> > +
> >  _require_block_device "${SCRATCH_DEV}"
> >  # not all the FS support zoned block device
> >  _require_non_zoned_device "${SCRATCH_DEV}"
> >  
> > -_require_scratch_nocheck
> > -_require_no_large_scratch_dev

This change looks better than latest version, thanks for fixing it :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

> > -
> >  echo "Silence is golden."
> >  for fs in `echo ${MKFS_PROG}.* | sed -e "s:${MKFS_PROG}.::g"`
> >  do
> > -- 
> > 2.47.2
> > 
> > 
> 
