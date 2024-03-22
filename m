Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F9B664CA
	for <fstests@vger.kernel.org>; Fri, 22 Mar 2024 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132124; cv=none; b=ijLsvNcfnVFZpBg8M9EL3ldPajkKKePXzWWKyq+7WaL+DP6JGVWwC8libmXYZDsDAO3CqCpluElVwk5BSNZPchpujTKMy5Pp8Ey3v3Dus8GuVdTtdFsURWg5GVkyTZC4GYZVvDyPgVGSnxTwfP3CKlmfLaFL1S68WOeOHYttvng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132124; c=relaxed/simple;
	bh=xfNyht6zn2+gFr5Z3sOaOZh/nFNZN2hgvgh1UQY2bpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HD8QOiJ0pPmJUn2rsY+V0EEjBnVEnoOX6IT9fjZcQv+/kQE/w8d/lifJ1EJaO5CYS7WAyLFOFGh2wrwdKqYRnE9avhrAwIlX1y6BsCuEipoTPiax2CPPkyphZK7hgRpnLA7BCdc5Tuwmk5kxSPdIQmwVTDjoZXu8m+CjAVwmwgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b+lM9ObN; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b+lM9ObN"
Date: Fri, 22 Mar 2024 14:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711132120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0gxqzSRBMHN56kuDfFnQoTeE3+D2UwXrbXUzOy2WZg=;
	b=b+lM9ObNS4Sw9grsNQw9TrOENMt5+EQoQ4kxZ91KOK/jy9elYKv3fo/acPohnAHfs/oq+g
	u4CVwbiEVM/Qwzq8W3T3lonUVK97prgQv3WcCs7l1hteq/UIIM0q6WlhT9WBwCPEmwVKkd
	cKdVsLxFTFJ8foRxDaED8c3alrkX4oc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>, David Sterba <dsterba@suse.cz>, 
	David Sterba <dsterba@suse.com>, fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 5/5] generic/733: disable for btrfs
Message-ID: <wnpr4jzuwtcjcnxcm2irktlm2bk4zcdvqvp4d2x227p7ckakyd@lp3qusnpdc5c>
References: <cover.1710871719.git.dsterba@suse.com>
 <094a1bdc304b236ba41aff4da454abe3c93a355c.1710871719.git.dsterba@suse.com>
 <Zfn9DMR8UQQMiyiL@infradead.org>
 <20240320155824.GD14596@suse.cz>
 <Zfyob_7NV9Kbd9pU@infradead.org>
 <xlwjfzviowyls5wnomqzufkfr6zm6mot3rpy6ct7rwyrwixjpt@uf47gsudlhxn>
 <20240322150800.GB3202449@perftesting>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322150800.GB3202449@perftesting>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 22, 2024 at 11:08:00AM -0400, Josef Bacik wrote:
> On Thu, Mar 21, 2024 at 05:52:33PM -0400, Kent Overstreet wrote:
> > On Thu, Mar 21, 2024 at 02:36:47PM -0700, Christoph Hellwig wrote:
> > > On Wed, Mar 20, 2024 at 04:58:24PM +0100, David Sterba wrote:
> > > > It is a bug in the test, it should have been xfs specific and never
> > > > promoted to generic/ and not affect btrfs unless explained how
> > > > in the first place.
> > > 
> > > Well, the concept that reflinks are reasonably fast and are not live
> > > locked by ongoing I/O seems pretty natural.  But I guess we can't
> > > just asusme quality of implementation everywhere, and do an opt-in
> > > like _require_non_sucky_reflink.  Either way we need to document
> > > the assumptions and not add a magic exclude for a single fs.
> > 
> > generic/733 runs just fine on bcachefs, sounds like btrfs folks just
> > need to fix their filesystem
> 
> Neither of these comments are particularly helpful or relevant to the
> conversation.
> 
> Btrfs range locks the extent during the clone operation, and also range locks
> the area that it reads.  This doesn't make it "sucky" or "worse", simply
> different.  I'm not entirely sure why protecting a range of extents that's
> currently being modified is considered "bad" or "broken".
> 
> In any case, I can accept that we need to have a different option for skipping
> this test, but this is sort of an argument for the shared/ directory or some
> other mechanism, or at the very least validating the test passes on all the
> major file systems before including it as a generic test.
> 
> Adding an opt in _require feels like the best option, or we can simply keep
> excluding it in our own fstests branch and ignore the upstream branch.  I'm good
> with either solution.  Thanks,

Well, if you really don't intend to change btrfs that's fine; if it was
me I consider performance bugs to be bugs - not cases where we're off by
some small ratio, but if it's significant I'd want to fix it.

But if it's just that you're doing range locks (not locking the whole
inode, as was my previous impression) - that makes sense, there's a read
vs. write atomicity tradeoff there.
