Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6F73BE17B
	for <fstests@vger.kernel.org>; Tue, 19 May 2026 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195512; cv=none; b=cfBpYB8e4swUesdDbRDRkNHDZBp5UBJZLrDnQbM2Ex4+9Dp1QWWRyGFKeqxfYrTMrDoIyFsRFl9ZuGT1pHLWA4qOE/wUNhXvFSc64NmL+i3J7Gc6Ei7DP3nL2j9BolFSMpZ4gk88oAFgHISpY9t2jC3jPuC2yT2cvK4826SocKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195512; c=relaxed/simple;
	bh=eU/HSDRFgfHYaC5gbuZ58P1aVrnlFtLfxm8DUySh704=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVYwZj5YXRJUUeuUushcG53USU3a0NersdZMjPoU8yIsIFcHQs+xwhn7GZiP97BivzA/xLNT3ObM4/+AWdrU+KY7SNdkHsFdRuUpHwSUq8MxKYaqBxVBV23ogYyHJuGEYEdHCwlWosR0fK//WdjkisWsRrzZlcCBwMIM7DQw3+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=hr8YVPUZ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="hr8YVPUZ"
Received: from macsyma.thunk.org (pool-173-48-82-210.bstnma.fios.verizon.net [173.48.82.210])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 64JCw5Mj005327
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 08:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1779195489; bh=cx8fhXPJjRD1MrEztQZbOQYrXGJoYgT8NYFkGr63vvc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=hr8YVPUZIan0bMNPAtIMG4oelQONcL+hoyfSbr84rlUdZdbqPoh/X1dQFgzg1ZAAq
	 x5s/Rn/tLw37pz5bKxZAw4KeM8at8gTjqbAXlux23G4Ag6h0NEKI4c2glWakKotYe2
	 7GiPL7tr5EvnShZ9wU48SKLlAqNzrAlDAJUfwUfufYCIXCzR0L+dgJ3ZIXuiiNA45K
	 bfvhvK/6xkY+ipz8F4bdKUhkpAILFJK7YwR2WdTqhZtev77enEYNNy0CzivNMH1ks7
	 Hy8koohF6l4dauFQYg/EavtTuyIMm+gPWBUgTo2d2Kk1h1EkYlLGmYdem1ja5WMKDH
	 N9KcFtlYlCyFw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id B63286855F1C; Tue, 19 May 2026 08:57:04 -0400 (EDT)
Date: Tue, 19 May 2026 08:57:04 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>,
        fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] generic: add a test that stresses metadata eviction
Message-ID: <20260519125704.GA30408@macsyma-wired.lan>
References: <20260518062514.506071-1-hch@lst.de>
 <agsEQ9TjHelfbWXr@nidhogg.toxiclabs.cc>
 <agtbqjAxUsCsLwyr@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agtbqjAxUsCsLwyr@zlang-mailbox>

On Tue, May 19, 2026 at 03:03:37AM +0800, Zorro Lang wrote:
> Currently, we don’t have a formal commit trailer to define this
> specific scenario, but perhaps this is a good opportunity for us to
> discuss and agree on one.

My suggestion is that this should go in a comment of the forked test, e.g.

# Based on generic/579 with fsverity-specific bits removed

That way, if someone fixes a problem in generic/579 in the future, a
quick grep might turn up other tests that need a similar adjustment.
The commit trailer doesn't seem as useful to me since it's harder to
find.

							- Ted
