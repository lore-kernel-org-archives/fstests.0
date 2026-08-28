Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DDD1A680B
	for <fstests@vger.kernel.org>; Fri, 28 Aug 2026 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929005; cv=none; b=KsuYDA4AGSXgILBpRMxf7tIJdckuJbXT09TPxllowWKloEh/uwkhxfKcbMVrm6cmkOvgMZR36kyVhCoze3nBEAYT9mc8DsezyQ+F/nrZ8FC+gKZtd23zG6jdQ+myF+OVpSmlaN+r/cM2/7lX0+bJfPTIjh04MvBN2AsZW5V8CH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929005; c=relaxed/simple;
	bh=aXQmdY1hAGmA8mSQQ/AwIFEG3KzyPupc4pngfWs7ysw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sm97ik3LRT3zbYOWEFRHLNpM871LmWuKBabJAW5C8R77pg4C5KAU1pc8qVaQA9mSZ+dLCdoLWFVmqHsWbG6Lbmpj71jEyUFMADvwKmxKh/88NiXkDEK6w1+/OXXwcMQ97HwbjrFRKDvsciXJsO/otMEBnjqqDI64zbhUL0k2xP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=kmpMUne6; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="kmpMUne6"
Received: from macsyma.thunk.org (pool-173-48-113-140.bstnma.fios.verizon.net [173.48.113.140])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 67SEuH0R029746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 10:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1787928986; bh=qIqSN24EC9QHr7sQckeWHeP6f8QnDurgNYJXmfFyIt8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=kmpMUne64wU0HTI/ITeM1N1OjcJ2S15eKU9Zg9rMq2T7CGqe06yjMOFK5QvvKe/P5
	 dp+cY4YmkDL6HbUJ53Bux101q1ffTznbozNFIokhtpbP9CSP1ObJvkEyc5bzLX1XZ9
	 9nP7uTo2DIhfL8CmNy2JVs+1nGMiU5431Jx3rm504LlUBOsGpKUz7OEqBmMg3yeZy4
	 MTJy/l7qfIZQwR+zDLjGjRyaxS7aWAETqvPp8IdVAqRooa9bDbdRUmH9Ts8EwCSmCf
	 FkCFlOWNewLxruQT4395qa9s6L2m0VcTMYbhb3kmkkQ/O16Pq80abUcqr5XRd81Hs1
	 gryQl3TmIcV9w==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 9019412485C1; Fri, 28 Aug 2026 10:55:16 -0400 (EDT)
Date: Fri, 28 Aug 2026 10:55:16 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: NeilBrown <neil@brown.name>
Cc: Matthew Wilcox <willy@infradead.org>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH] fstests: generic: Add test of seek in directories
Message-ID: <apGfAFkNdD5mrASi@mit.edu>
References: <20260827234743.2389778-1-neilb@ownmail.net>
 <20260827234743.2389778-2-neilb@ownmail.net>
 <apEK5uirjyLZUfmA@casper.infradead.org>
 <178791556100.3510150.18132687067056760170@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178791556100.3510150.18132687067056760170@noble.neil.brown.name>

The key requirements come from readdir() and seekdir().  To quote from
readdir() specification:

   If a file is removed from or added to the directory after the most
   recent call to opendir() or rewinddir(), whether a subsequent call
   to readdir() returns an entry for that file is unspecified.

And then from seekdir():

   The seekdir() function shall set the position of the next readdir()
   operation on the directory stream specified by dirp to the position
   specified by loc. The value of loc should have been returned from
   an earlier call to telldir(). The new position reverts to the one
   associated with the directory stream when telldir() was performed.

   If the value of loc was not obtained from an earlier call to
   telldir(), or if a call to rewinddir() occurred between the call to
   telldir() and the call to seekdir(), the results of subsequent
   calls to readdir() are unspecified.

Telldir() is specified to return a "cookie".  It does not have to be a
offset, and the DIR * returned by opendir() and consumed by
readdir() does not have to be backed by a file descriptor.

Historically, jfs implemented an whole an extra on-disk btree in order
to implement the insane POSIX seekdir()/telldir() semantics.  (Meaning
every single directory insert or deletion required at least one extra
disk seek.)  Ext4 returns directory entries in a very sub-optimal hash
tree order, requiring lots of extra disk seeks, in order to provide
this guarantee.  This is also something that historically has been
enforced by Posix Compliance Test Suites (PCTS) for those people who
believed that Posix compliance was relevant.

And, yes we also go through all of this pain and performance hit not
just because of Posix compliance, but also because NFS requires it.
Personally, supporting NFS is *way* more important than Posix
compliance, but people of good will can have different priorities.  :-)

For this reason, I would support having a test to provide the
gaurantee needed for Posix and NFS compatibility.  Not for Posix's
sake, but for NFS's.

Cheers,

					- Ted
