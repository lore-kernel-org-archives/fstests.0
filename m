Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7EF37E5F5
	for <fstests@vger.kernel.org>; Tue,  6 Oct 2026 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324087; cv=none; b=g5WvMXRiVCNgq/76rcQB6s3mrSFltlpHCUWHBxfmGrjQTSWbBT4eTnQOyLXdvGO/CnV/NFigJCe0sW7lzxR4REp9FyacEt2pABZpIah8ZN78EAFdL7Yp3HIXDhe92ZF2Va5bh//szQu3qNdVWWcY+33QK4F72gf6LD+IVfM7Ivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324087; c=relaxed/simple;
	bh=NPeKkyoF2Y6dA/L+Dbwvmw55Af9wKV4+2bP9R1l29tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTcoWXpbH/exwGeKcpp6/PgFwfQehev+6j5wLFOknk+lWuoS3DzoLcfbHXVy9EPbrHKhUtCndj0Zo7v7BeAD8Q9RipECpFP3sXDdx/LjUHl8WZPI/HeDfb4q47U0nWNXTwcknkg5SdovvH0mse67PjoPx8j8AETGY/U9uNjAva8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Kfjqw7LB; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Kfjqw7LB"
Received: from macsyma.thunk.org ([151.240.45.83])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 696M0xdX021287
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Oct 2026 18:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1791324063; bh=bWUSQ4/Ooaok5Uqrrd6l6TyNVUnbPrMFXOVCzVnZjm4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Kfjqw7LBV0mAdA8puprSypW8hjZ6P/Cau4I5Vv1pYoOuMWCJhiEEuwYB30UMncoNn
	 wAt+dXIEIVA+ECwBcR1R5RVX2iQ3YK8nBYtMaMfMjhwncyl7mNHbW1SLOJYBiH/PD+
	 tGS17sP+bMNLjxke4ulJYDBQKJarWVQta8n3xUEIevsEeTMHWzvdL+HIuDUrP6cEne
	 kKvZiWzp8CFl05DiyTDXhTQ4AlOHW4wBQb3MPmyzLrg2wM3gPrtRvI51/gDcsZ/Ldo
	 QXELTl4nUgLsx970JXZB3BxReLZPy4SLd2r9T200Q3LvcKTp8sZQ0tlbbleN4/9+Yi
	 3RgXOsk3m9IHg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 378B11F4ACC7; Tue,  6 Oct 2026 18:00:59 -0400 (EDT)
Date: Tue, 6 Oct 2026 18:00:59 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, fstests <fstests@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Zorro Lang <zlang@kernel.org>
Subject: Re: many many fstests configurations
Message-ID: <asVu-z9fSYe4xWpC@mit.edu>
References: <20261006182109.GP1615495@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006182109.GP1615495@frogsfrogsfrogs>

On Tue, Oct 06, 2026 at 11:21:09AM -0500, Darrick J. Wong wrote:
> Hey, since you guys asked,
> 
> Here are my current fstests configurations for doing XFS QA and enough
> ext4/btrfs QA to check vfs changes.

Thanks!  One thing that is not clear to me is which file system(s)
each test config is for.  I assume the ones with a MKFS_OPTIONS that
begin with "-m autofsck=1,uquota,gquota,pquota..." are for xfs, since
those are mkfs.xfs options.  There are somoe that don't have an
MKFS_OPTIONS specifier, so I *assume those are either for ext4 or
btrfs?  But it's not clear which.

Thanks,

					- Ted
