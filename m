Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC53179BC
	for <fstests@vger.kernel.org>; Fri, 14 Jun 2024 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718389697; cv=none; b=S8S9TsabqTPnGE6VwCBWFNAha6gJwQgWGwFqEl2WoNQ0y7aTp24bF/xE1UKq/wPcLSffkoxqAYeIsI1lWdZAqIK/Mala0yqn6INAkVV/1bGsB+vQmDowJiAMr3TpS12dKcXDFd1E+nFebAsYLrKTg6+6mA+TzWQv4MoLo+KpiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718389697; c=relaxed/simple;
	bh=n0nzYbuEKsP5CR5izx9tmUeBzNZs6Dv9llNLoXFas/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2c2lYS/tJ7MEZf0pNokWitnVoj+R1CcFFqg8x9zBly6vv4ayOlMHAYxTku3KVpQvmuRdQGgA0ufBjq+s9zjMMt53qIhHnvkNyfNL6YmisDCLTAFxjJLzXx15DstbAwANu/d3lATtrj2TxsKfrmVpBPzjDsr/Iyanm9W1M8QXJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TqXSAAeH; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TqXSAAeH"
Received: from macsyma.thunk.org ([84.247.112.25])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45EIS5YI006182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 14:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718389688; bh=UBuv+ACn7yY6Imbu4MZetpHQlIo5F19TevPQHO1PRME=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=TqXSAAeHFlrvMmoGgZH7vuDT4FIZLDOG5CjnIarT1J/2KgJ33AoaKNyF9aTPSjsdg
	 z2pZApE6L/0/Noj6HkpsOoe6TxwHQP3VfYckNz7JsKPCDQ03IVG+P1Pv3/ErLF62mx
	 IrO6Q9nPNfEilnUPnisqpWJqQKdHtynPXxBeEUO0Twjs9yRJgughiqswvrbVvSDxYx
	 AKv1wza3b/pFX+AG6GkTBmdIJmEbeutduj+Y/Cr55hF9Bp/LF1F37yXOTD0AYtHIM5
	 w0pwSNvMsEA5wLvPG5Eqx27g4uzw8iC65XTZGFUzSiouj9cWEoAr60X3aXLanMqzYN
	 O3iIlVmFuv6kg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 4C9A7340F4A; Fri, 14 Jun 2024 20:27:59 +0200 (CEST)
Date: Fri, 14 Jun 2024 19:27:59 +0100
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        fstests@vger.kernel.org
Subject: Re: Flaky test: generic:269 (EBUSY on umount)
Message-ID: <20240614182759.GF1906022@mit.edu>
References: <20240612162948.GA2093190@mit.edu>
 <20240612194136.GA2764780@frogsfrogsfrogs>
 <20240613215639.GE1906022@mit.edu>
 <20240614041618.GA6147@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614041618.GA6147@frogsfrogsfrogs>

On Thu, Jun 13, 2024 at 09:16:18PM -0700, Darrick J. Wong wrote:
> 
> Amusingly enough, I still have that patch (and generic/1220) in my
> fstests branch, and I haven't seen this problem happen on g/1220 in
> quite a while.

Remind me what your fstests git repo is again?

The generic/750 test in my patch 2/2 that I sent out reproduces the
problem super-reliably, so long as fsstress actually issues the
io_uring reads and writes.  So if you have your patch applied which
suppresses io_uring from fstress by default, you might need to modify
the patch series to force the io_uring, at which point it quite nicely
demonstrates the fsstress ; umount problem.  (It sometimes requires
more rounds of fsstress ; umounts before it repro's on the xfs/4k, but
it repro's really nicely on ext4/4k).

xfs/4k:
  generic/750  Failed   3s
  generic/750  Failed   1s
  generic/750  Failed   33s
  generic/750  Failed   1s
  generic/750  Pass     33s
ext4/4k:
  generic/750  Failed   3s
  generic/750  Failed   2s
  generic/750  Failed   7s
  generic/750  Failed   2s
  generic/750  Failed   7s

							- Ted
							
