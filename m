Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1393C33F59C
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788140656; cv=none; b=WvZTkhew0B47WRcz6mv6fA6/e1UZriLUkOhjvzGuE4P0vAfGoejVCIQGQQEg1/vToJhYBGiYRZgeRoXfU791a9mLCFh4lieFu4QNRGz3tkctPiKOhgwQSeZhE+by46CRgrfI7uHs27KCf1TZ48To0uA+Mel5hjieqV/U0wLknd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788140656; c=relaxed/simple;
	bh=N3SxOXDxqIZpSuNF3O3pltZGSJF1dS/splDua73TgM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acqbH5Sq949lpdfeDVtD/9YDYwQpSHnsHfW2Qi/BGJdA+w4v121k1g7s02N2PcQtxxpkS8iSfh4iO+mkHsrfjkGXHkz7HxlTQi7PqK4+pVf9ZRuhTUW6pbBKFnC14WYU9DSAm5HLoB1KctMwPnCW8TxpEJdrn8CLqsSk2YnoY9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=pmCUIHio; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="pmCUIHio"
Received: from macsyma.thunk.org (pool-108-26-156-67.bstnma.fios.verizon.net [108.26.156.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 67V1cXjn001816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Aug 2026 21:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1788140316; bh=RCR5S19ATwvjEbuGYYFZbN3IvLES8GyxgToyyoGWn1s=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=pmCUIHioAd/lbeV+yFIicx4WnIb2hrDl1xaxpyS6mcJvp56vkF+5f25X0qNKumJHA
	 xNn8DfTkYXocP1dfrc+gZc3BBUYUz/i6RHggeB5UCRw24ceLgCOTCRmjH0H05cV4bf
	 316V0fXdxN1dokWaaiz+JXWcrx4ROZxEjlf8p58AHFue6QAPu37xtBaf60KQqTvBgH
	 r7J67MBhVH0O3sYqPNAm6CKFUepoRnRQT/Nzy5cgqgxpdUvHwAh+2x8AWxqwUjK3fs
	 pN0Jujp7Vm0oz4Mjr4jO5ih1QRGnhrFTW9wN+tFcOKMGEmk8cVJaAOr+GRB9H/kC6b
	 B6YMgNNRRpYeA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 67806129CC87; Sun, 30 Aug 2026 21:37:33 -0400 (EDT)
Date: Sun, 30 Aug 2026 21:37:33 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: NeilBrown <neil@brown.name>
Cc: Matthew Wilcox <willy@infradead.org>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH] fstests: generic: Add test of seek in directories
Message-ID: <apTQqcuR7bI6qY54@mit.edu>
References: <20260827234743.2389778-1-neilb@ownmail.net>
 <20260827234743.2389778-2-neilb@ownmail.net>
 <apEK5uirjyLZUfmA@casper.infradead.org>
 <178791556100.3510150.18132687067056760170@noble.neil.brown.name>
 <apGfAFkNdD5mrASi@mit.edu>
 <178812852153.3510150.11411436066299613954@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178812852153.3510150.11411436066299613954@noble.neil.brown.name>

On Mon, Aug 31, 2026 at 08:22:01AM -0500, NeilBrown wrote:
> Given that the requirements predates the htree design, isn't this "pain
> and performance hit" a deliberate design choice?  Or maybe an
> unfortunate design omission?  Such things can be fixed.

The requirements assumed that the directory was a linear structure,
much like the V7 and BSD FFS structure.  That's why
telldir()/seekdir() interface used a 32-biit cookie --- e.g., a seek
offset.  This doesn't deal well with a b-tree or equivalent structure
where when you insert an item into the tree, the tree might require a
node to be split or the tree to be rebalanced.

> ext4 already has two indexing schemes - indirect and extent-based.  How
> hard would it be to add a third that effectively moved the current
> directory index blocks out of the "file" and into the "file-index"?
> Obviously the 32 block address in dx_entry would need to become a 48 bit
> device address etc, and there are bound to be details I've glossed over,
> but this approach would amortise all metadata access of a lot data
> access, and would allow read-ahead.

The primary detail that you've glossed over is that the tree would
have to be a B-tree.  Ext4 currently uses a b+tree which means that we
don't need to store the file name (key) in the index nodes.  The index
node in the htree is a fixed size, and compact, and this allows for a
much greater fanout (340 nodes in each node).  This makes the tree
much shallower, and reduces the number of seeks when doing lookups.

Switching to a b-tree would almost double the size of the overhead of
the tree, and the tree would be deeper, and thus require more seeks
when doing a lookup.

So it's a tradeoff, and it depends on whether you think readdir or
directory lookups are more frequent.

Cheers,

						- Ted
