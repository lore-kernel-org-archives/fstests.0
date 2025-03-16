Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DA2187FFA
	for <fstests@vger.kernel.org>; Sun, 16 Mar 2025 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742143235; cv=none; b=OkOtBNSAFJAHEGbCFytqAW4G/PEZ9dMPt9ASp/cY2KMRyDLkxK4xnU6eomgqbC3bQ0uT/7V48/pTyHmHjMLDZdn4pA9bArdkQuH5NMv/v0hrIofYvFDyh6rOcolVIYc/UhLiTt5r9e8UjaDpLJdz3+fr6bQbPj2brZ+LrnZ1dNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742143235; c=relaxed/simple;
	bh=gopT7atwMvfviaTEDB7PkWQNYrPj8Ru3H2u5kZyl8pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srTXOgVcuFUYQ6705K75wzHHEmps+pzhKDViAP6q34P48+thfVKAzaxUFjeQmrw3cvixImq9rjsqY/WuDfkDSvfUmAizoM6Z+JHaHmMf7iUZQsJa/QeS5jWBAEYO33IxkG8n05a4OQV/BPwU4MBpVEQVYW5NBjRz1y/gYsajrFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtuL9BXa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtuL9BXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE4EC4CEDD;
	Sun, 16 Mar 2025 16:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742143235;
	bh=gopT7atwMvfviaTEDB7PkWQNYrPj8Ru3H2u5kZyl8pE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QtuL9BXaBkMf9WxB2JlNapKGJa9XBJqrR7kJ6g7SeeGxI2liGc4ZAukwYMjrgy+up
	 r4O+yZVwk6gjxhd/bsDnd0vU7tXOKA6E/rfd8hUP8SlRnNqtJd0zk645BuS4Froccx
	 9e1JpxOhm9XFtUuSphy+jvatmX8DGDXV09ZJHWc6mPdUfANJ6GV+fY87eW8MoEPP2m
	 baSGypZuMyH8s45KHO5Hc1EG9n9f8e+iL0zv/qpogJWXY32eXa7jQv9fiOe5LTc5JC
	 38q5lPFWq1IEsGv99hzYwKqhzG5XldQCFb9WcEM2FxSJ/J/iBTnLJv97R6h0AHlrl2
	 elsbIbGR6lt5w==
Date: Sun, 16 Mar 2025 09:40:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	hch@infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 7/7] lib: remove random.c
Message-ID: <20250316164034.GO89034@frogsfrogsfrogs>
References: <20250310182954.1396724-1-sandeen@redhat.com>
 <20250310182954.1396724-8-sandeen@redhat.com>
 <20250316145423.c2ws6hhrozl33czv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ce0de787-1017-4b5b-8876-bff6adf4952a@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce0de787-1017-4b5b-8876-bff6adf4952a@redhat.com>

On Sun, Mar 16, 2025 at 10:48:50AM -0500, Eric Sandeen wrote:
> On 3/16/25 9:54 AM, Zorro Lang wrote:
> > On Mon, Mar 10, 2025 at 01:29:09PM -0500, Eric Sandeen wrote:
> >> sparse points out that lots of things in random.c could be static,
> >> and upon doing so we realize that nothing in this file is used.
> >> Which is unsurprising since these are all part of the standard
> >> C library ... so just remove the file.
> >>
> >> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> >> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >> ---
> > 
> > Hi Eric,
> > 
> > When I did the fstests regression test this weekend, I found a regression
> > failure on generic/007 (diff output):
> > 
> >   --- /dev/fd/63	2025-03-15 13:31:35.044534292 -0400
> >   +++ generic/007.out.bad	2025-03-15 13:31:35.002455111 -0400
> >   @@ -14,9 +14,9 @@
> >    .........................................................................
> >    .........................................................................
> >    ....................................................
> >   -creates:  18736 OK,  18802 EEXIST  ( 37538 total, 50% EEXIST)
> >   -removes:  18675 OK,  19927 ENOENT  ( 38602 total, 51% ENOENT)
> >   -lookups:  12000 OK,  11860 ENOENT  ( 23860 total, 49% ENOENT)
> >   -total  :  49411 OK,  50589 w/error (100000 total, 50% w/error)
> >   +creates:  18839 OK,  18890 EEXIST  ( 37729 total, 50% EEXIST)
> >   +removes:  18783 OK,  19951 ENOENT  ( 38734 total, 51% ENOENT)
> >   +lookups:  11858 OK,  11679 ENOENT  ( 23537 total, 49% ENOENT)
> >   +total  :  49480 OK,  50520 w/error (100000 total, 50% w/error)
> >  
> >   -cleanup:     61 removes
> >   +cleanup:     56 removes
> > 
> > By bisecting, the first failed commit is this patch. After removing
> > the fstests internal lib/random.c, the output of src/nametest.c is
> > changed too, that breaks the g/007 (xfs/188 maybe too) test.
> > 
> > It fails on all filesystems (e.g. xfs, ext2/3/4, btrfs, tmpfs, nfs,
> > cifs etc). I'll defer the release of this week (03.16), hope we can
> > fix this regression next week :)
> 
> Oh no, I'm sorry. I thought that if this stuff was never used it'd
> be safe to just yank, but I clearly must have missed something.

Ahahaha, it's linked into libtest.a, which is then linked into every
fstests binary.  Therefore, any binary calling srandom and random get
this bespoke version instead of the one in the C library.  From the
looks of it, the RNG code itself runs the same operations in the same
order every time, which is why you can pass a seed to fsx/fsstress to
get the exact same sequence of operations.

Maybe lib/random.c should have its comment updated?  Clearly two
reviewers, myself, and the patch author missed this point:

/*
 * modified by dxm@sgi.com so that this file acts as a drop in replacement
 * for srandom and random.
 */

Because that doesn't really explain /why/ the code is needed as a drop
in replacement.  How about:

/*
 * modified by dxm@sgi.com so that this file acts as a drop in replacement
 * for srandom and random.  fstests programs rely on the exact sequence
 * of integers generated by these functions for reproducibility and the
 * golden output, which is why we override the C library.
 */

--D

> It's probably best to just revert/remove this patch for now, so it
> doesn't delay any release.
> 
> -Eric
> 
