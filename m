Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66BF26281
	for <fstests@vger.kernel.org>; Tue, 21 Jan 2025 03:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737430448; cv=none; b=ugdBUOa+wYBUC0pWIZOg8JcvsYZZOOQfi2DC/3yLshXGSOyJwkPXdXMwRN88Gwm4oIcC0UQmVqD1X8CpdFRi0CcfntH99L/D8wKtBrSrQHJ7LheCIl/ZI1lOtmweu/bgbrUTMLEyjQQwpjWFwl5yh+ym2w2pnApEAZGslAjWlJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737430448; c=relaxed/simple;
	bh=e6X8i9PXFeOQd3sG+TZZtWUPeD7oqofSU/BJ52YOqyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjOjt+5JGRWXWAWedTLIDw/OUjF9+WVlF7ki9onXqEV8VqvyZdrfDXPXIY2ibq8L0HsWoJuwdJCFQPlq4sAhJ2Ccwo4W5brGeUzpo2fEKLtWi7i2JRMFUjLJdn8wMP/ZiYVNkqijH3gxjjBPR2B27Bd0A/Q5Mup6uXGWJ3fTt50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=aYLNxPG9; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="aYLNxPG9"
Received: from cwcc.thunk.org (pool-173-48-114-200.bstnma.fios.verizon.net [173.48.114.200])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50L3XuJp014502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 22:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1737430438; bh=gdvK7FYCXZOwv5Ecg7M6Xi3h73ivwrZICPVyhlT+H7U=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=aYLNxPG9wp1XU8qUt/3oYqmwryXDhRhcrsqBC8JdNtzKYdMsPehDYoQzcsDLMzvFo
	 t6UJIttsG6GSwLzhCpRXeCgnk30iEvGN9jIBruH3Oz0DfnHFO95J+GbpyNEwnQE038
	 EqSMDvGNTzINoOxGe5znJPqcPGaMxPJDVTnO7Ak2UFMVsirVbeg65GEVy2YMXIJhly
	 vG8c/LxUdJguEDyPj3srBzxoh9R0Y7dTUHeaqKSDQrm+2K3OuRiqS+q6M1TyJ3cPzt
	 fEiRVTAXXUXZw8urNWsW0Y2jjshGIjfZaGQEPYoVVvGSGyZIX0w5ramPDeQ7XAjG1z
	 ckNfVaAi/FSHQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 99D9C15C0179; Mon, 20 Jan 2025 22:33:56 -0500 (EST)
Date: Mon, 20 Jan 2025 22:33:56 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH -v2] xfs/32: fix test failure on kernels which don't
 support bs > ps
Message-ID: <20250121033356.GB3761769@mit.edu>
References: <20250117210202.GJ3557695@frogsfrogsfrogs>
 <20250120170109.3770633-1-tytso@mit.edu>
 <20250121023536.dz45c3ustuk3fddu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121023536.dz45c3ustuk3fddu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Tue, Jan 21, 2025 at 10:35:36AM +0800, Zorro Lang wrote:
> On Mon, Jan 20, 2025 at 12:01:09PM -0500, Theodore Ts'o wrote:
> > When trying to mount a file system with a block size > page size on
> > kernel which doesn't support this, suppress the error messages from
> > showing up in the output file lest it cause test failures.
> > 
> > Fixes: 0b66f6efd669 ("xfs/032: try running on blocksize > pagesize filesystems")
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > ---
> > v2:
> >     As Darrick suggested redirect the output of mount(8) to $seqres.full
> >     instead of /dev/null
> 
> Thanks for fixing it.
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>

I just noticed just now that I screwed up the subject line / commit description.

xfs/32: ...

should be:

xfs/032: ...

Sorry for not noticing this earlier!

					- Ted
