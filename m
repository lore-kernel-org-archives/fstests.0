Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6860E5A4FD
	for <fstests@vger.kernel.org>; Thu, 13 Jun 2024 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718315853; cv=none; b=oKFotAD8aMCC8knoPvzmXnatYbgU8uQ92bsMIwR90ZpY3WDI7KjjNMj50dBF2sK2OC7skmeZBa+NpZW96Si1u/07BvY6scaFaTwAquc+Zhl/rA5s0PXhfLJMioZYU/W32YpCC8+WR3FoUqLDqo3m5O05Um2UxHxecjMVt6JiaCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718315853; c=relaxed/simple;
	bh=1H4KUBPxpm8hVaGmrXkqGRToMuoTEDG2zah8EkagM2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAhfg8GB2FkVdnxduoGbHzAFTNF82YLhB5Km2BW2M429aOIiStoghLTQBcI0CS209ZGE7TFjsWdgier+DvO4Wd3XRczeqIXeYEgqCZdPotKe7gll74nGkpMALh50aW42xlYisv/NrTrJu4ftHOySzILUsf0QlxNyLz57Wx6YioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=iS/pjxIw; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="iS/pjxIw"
Received: from macsyma.thunk.org ([204.93.149.86])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45DLuvLw029951
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 17:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718315832; bh=jEzJNwHQDxbRySEdEpZpwvnORAbr8LsWzKdES99EzUw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=iS/pjxIw3aaB+Xl4h+y+yyz3o/3Pd74lA8BsE95EF2RWsy0GF96PtZ5dusXuCYNh0
	 bLS/brjZ+vvnRHmctoiZJgeQPC2m1ClyEQ+pY+m1QwJ/DWQjnPBjAlulwuZsPUT87X
	 RIuU0+rvJQ+Lm2RDxuWmmZ1sc1WjR3DqgC9kI2iJfhO7bEgiPnODsGfl0uxWMN6DLh
	 LiqZ4JX1YZwyxEENWpE3YUG0CNjpJjRKoSGR8qGwcdlOno8F0z6tzUdsviHbrpQ9V3
	 aJ66umICT4RLW4bV1hQ0W9DQWBNWeuGIxiKsvY6uWxmJV7ZF8DWO4V21hevsezr+k9
	 68F7qdHP0AC8g==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id B52F134169C; Thu, 13 Jun 2024 23:56:39 +0200 (CEST)
Date: Thu, 13 Jun 2024 22:56:39 +0100
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        fstests@vger.kernel.org
Subject: Re: Flaky test: generic:269 (EBUSY on umount)
Message-ID: <20240613215639.GE1906022@mit.edu>
References: <20240612162948.GA2093190@mit.edu>
 <20240612194136.GA2764780@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612194136.GA2764780@frogsfrogsfrogs>

On Wed, Jun 12, 2024 at 12:41:36PM -0700, Darrick J. Wong wrote:
> 
> I don't see this problem; if you apply this to fstests to turn off
> io_uring:
> https://lore.kernel.org/fstests/169335095953.3534600.16325849760213190849.stgit@frogsfrogsfrogs/#r
> 
> do the problems go away?

Thanks for pointing out the mail thread; I had a vague memory that
this had been raised as a problem before.  Looking at the discussion
(from August 2023, so over 9 months ago), this is a bug that has been
acknowledged as an io_uring bug, but it still hasn't been fixed.

Using Zorro's sugestion of adding "-f uring_read=0 -f uring_write=0"
to the fsstress options makes the EBUSY umount failures go away.  I've
also created a new test which relaibly reproduces the "fsstress ;
umount" EBUSY bug (as opposed to the existing test failures which only
fail 1-10% of the time).  So with that I can with a clean conscience
suggest that we omit io_uring calls from those tests using fsstress to
thest some non-io_uring related bug if they run into the umount EBUSY
bug, since there is now a new bug which reliably shows off the
problem....

						- Ted
