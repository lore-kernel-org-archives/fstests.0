Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7EF4AD4C3
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368360; cv=none; b=d3o7QZxTGCHc1HMArHAGR7O66/aHsyqIALqICAENwQPnNc85b7dmBM+FkAmVe6qttScSSAu91eiz4H7ZmIND8kSKzWwMmxLbepPRa1tC4JBDvqSr8rgjpygxLYHO/Kzadjq9A0poHQSjlRmhKmBKUuQnvbk8Efspu+8JsN1TbLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368360; c=relaxed/simple;
	bh=PGdbLRR8bqRDg9FXSz8lMlPpHAoFuTT2oBmvq2p/6R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKC4YqHqvvpXznKiYzwjGdNj0A7YSHkLRDm1ske/bBDznDWJ6r1VOi5O9nmEXLXgsgfaMFr8cTenzC5p2UB2dfLuGgQcOUbK/vf4PkuCAusEBnS7D4oUqErIw/OjidfwjrSphl+M9I4h2bcbdJPMy5S1R+6l/KnX2e2Did4REFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkiEpN17; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkiEpN17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4BA1F000E9;
	Wed,  2 Sep 2026 16:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788368358;
	bh=l4gqhxN8rnQhJUF3cISnKdYq76jZezwfQK7hLSDhJww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QkiEpN17GHX8G0gIiAs/Leg9rKCdrhlEQewL6ZXP9GbLfOVeaz80T8omvhOaFNPiy
	 JaVDZH15m3yoP+xIi2f73LYuqhjdqlzzYWe3e/ndXugvrG2AhIfJX1kPB8KRJfyYVu
	 VsVw50Ogc6pdtO1u3uqxIVatG1DusFjwKxdDBcz2kplaoMbwzenByLqwSMl41HA6We
	 Bc7V135OiV1VA59qr1G9CVDDSWWHI4ud5NpDELYQUjU6NVekN6iGqWHUFlba+bJs3h
	 eMaebXDmU7nrFmTDwiTVYccohlG1oxMJiEoge9QgZ0L1Q3WMPpyZK8P4xVNQKVkFZP
	 M7SzC02uKjaZA==
Date: Thu, 3 Sep 2026 00:59:13 +0800
From: Zorro Lang <zlang@kernel.org>
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/795: add missing _require_scratch check
Message-ID: <aphTzWxMpDhC7ISV@zlang-mailbox>
Mail-Followup-To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
References: <20260902050139.2426-1-prabhakar.pujeri@dell.com>
 <20260902151316.GJ839663@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902151316.GJ839663@frogsfrogsfrogs>

On Wed, Sep 02, 2026 at 08:13:16AM -0700, Darrick J. Wong wrote:
> On Wed, Sep 02, 2026 at 05:01:39AM +0000, Prabhakar Pujeri wrote:
> > The test runs _scratch_mkfs and _scratch_mount without first requiring a scratch device, so it fails messily instead of skipping when no scratch device is configured.
> > 
> > Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
> 
> Looks ok, though if you're going to write more of these patches you
> might want to put them all under a single patchset...

Yes, I've locally merged your 3 patches that add _require_scratch:

  btrfs/333: require scratch before checking encoded reads
  overlay/081: add missing _require_scratch check
  btrfs/273: add missing _require_scratch check

Are you still working on this progress? If so please consider sending them as a
single patch or unified patchset so I don't have to pick them piecemeal.

If there are no more, I'll just merge this one with the other three :)

Thanks,
Zorro

> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> --D
> 
> > ---
> >  tests/generic/795 | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tests/generic/795 b/tests/generic/795
> > index fa5474c5..4c0e7bdb 100755
> > --- a/tests/generic/795
> > +++ b/tests/generic/795
> > @@ -27,6 +27,8 @@ _cleanup()
> >  
> >  . ./common/filter
> >  
> > +_require_scratch
> > +
> >  fsv_file_size=10000000
> >  nproc_enabler=$((4 * LOAD_FACTOR))
> >  nproc_reader=$((6 * LOAD_FACTOR))
> > -- 
> > 2.55.0
> > 
> > 
