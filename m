Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835204AEC1
	for <fstests@vger.kernel.org>; Fri, 22 Mar 2024 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122333; cv=none; b=PyXUV/L3NVcchr1r1rJ+68clf5wtBOkIRuINWwsy1IW+kZTxyKKCsvhmRvTa9I1uLSwAuWe6Ov0bdLGJgQXIq5Uof1zu4tnJ2Jcqk5N/LsPF0xoIMX3veklMwT4FGEnt2R2m6G9AOTH60tEmK0k87EN7w5XbS9bb710BURmtbCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122333; c=relaxed/simple;
	bh=SpWffDsOiYfe9UAVwKDajs0WKLC62KTKWwjb2G1it6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoM/ddeco0cYKfp2r8P+hQn2DRr5um4+e2SGQeF67m8nKpLy4GIojkPCdNiNli3i76llvFAPyciqYB3Oe/g750KY2GBVw+jSeJhA0FBUfoGaiNN3bmpmxwX+g7fP8o7BTmY975ftblOAS1AswicUJsuuwPKTmh9wD7hurJDO/w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWhQl2Do; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWhQl2Do"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E876CC433F1;
	Fri, 22 Mar 2024 15:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711122333;
	bh=SpWffDsOiYfe9UAVwKDajs0WKLC62KTKWwjb2G1it6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWhQl2DoddYv45S0tfCHzvZS85kaY+se3bFK/ASGZgvaUNlls5uC8MnlJTs8zdgQx
	 LPEzUWyWKsYVQNasVVBSzkO3Jt0WKV7RBwAAE0W2qXBDBdmNxCeWRQG1GrVpZA61b6
	 VXlEw7ylCK4G6H5hAIyVAD+jvUBD9ZOQ+OMIA2jrfZB/bZqhR7sbe1KgUqx5ynOfqe
	 ZWXJ0T/CMqpwmt+f+tDtP0chLostjAKjhD3Y5vTftmwNh4ScQXb7Q0EIJ0EqRkiSDP
	 9JVuD0ONeWRsHRB96oSuyZINT6J5XPmxTHqAAzBKYGxK82jtbu3tzStvDos45l/G5P
	 PPqwERPjqJGgw==
Date: Fri, 22 Mar 2024 08:45:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	David Sterba <dsterba@suse.cz>, David Sterba <dsterba@suse.com>,
	fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 5/5] generic/733: disable for btrfs
Message-ID: <20240322154532.GA23679@frogsfrogsfrogs>
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

Frankly I'd have been ok with a per-test exclusion with some
documentation:

test $FSTYP = btrfs && \
	_notrun 'FIXME: btrfs does not support concurrent read+ficlone'

There's nothing in the FICLONE spec about implementations needing to
support concurrent reads and clones on the source file.

--D

> Josef
> 
