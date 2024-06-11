Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B76118EAB
	for <fstests@vger.kernel.org>; Tue, 11 Jun 2024 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718144836; cv=none; b=kn/RaNHv9szlmYV2gafPeaZFyLwPtFRjgKrCpnhDQf/rsG835QMBgCmIW1BHr7F8HIcoc2Nf1DQb8JuEXp1G94MDMQgPQZnrnq3X1WmhVY3FonenFd7vxtVs7QlwaXnCRluSYbMAmWweK5xaPnoA7gtf0ojHE3bLjlgS07emnxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718144836; c=relaxed/simple;
	bh=5xhaItbTf2MNVEwHseKzP3sHJGX2cxTcbQvyZr0lpkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBgGSaNMBOQ9zDn6vLx60CT4QMeGsOD9Fsctl0Mhvm5j7LNY4D+q55IFmhta6/KYV5A4AZw5CkzbibOWQwJZvlHBONrFdOqhVBl8rhQzyw9TUb4Qesypl4Arsc0eVPM4Z8qy5H1WB/lGaKChYM2K601IjKpmyeZsfHJmH4QhHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gLmzCNde; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gLmzCNde"
Received: from macsyma.thunk.org ([84.247.119.26])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45BMQoCS005799
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 18:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718144826; bh=G5YC68zjEOJAtM6LT60/15mS82kWCmX9dgDdpu/sd64=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=gLmzCNdeRx0p/w3ZU54BZcFqfuYb/9TRGL1HqhOQZhTFACnY/eEShOblisHdoErhl
	 ewxXiWHSYCoeqfljJigXnlADQ+C/+wgVMUv6i22GP0AYaZVF0TiME6nF8MaOdu//TL
	 KsKgnZjnkg9A5sZkTC7jQU7ZpoZwxI9BjIHHTbY+2lntISPcPj7OPe4sdD5kKnQMZm
	 4iWvBZ9aJBqVJ35xlXVmmRaMTwcAX058twYqyXNdI2N35lcdFW9zp5uBTHRkOCthq7
	 GihKnIZHk1CQs6+u+wDKXufFbt+Qck3dqduI8dOA8eGq7HoIimZKacjVS2ax1rnSTk
	 veVWg7HbOOAaQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 44AAD34160E; Wed, 12 Jun 2024 00:26:46 +0200 (CEST)
Date: Tue, 11 Jun 2024 23:26:46 +0100
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/455: skip the test if the file system
 doesn't support journaling
Message-ID: <20240611222646.GA1906022@mit.edu>
References: <20240611085853.200102-1-tytso@mit.edu>
 <20240611085853.200102-2-tytso@mit.edu>
 <20240611142701.GE52977@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611142701.GE52977@frogsfrogsfrogs>

On Tue, Jun 11, 2024 at 07:27:01AM -0700, Darrick J. Wong wrote:
> 
> _require_metadata_journaling $LOGWRITES_DMDEV ?
> 
> afaict the _cleanup() function will call _log_writes_cleanup ->
> _log_writes_remove for you.

Good point, I had forgotten that rely on the _cleanup handling.  I'll
fix that in the next version of these patches.

						- Ted
