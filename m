Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA597FD
	for <fstests@vger.kernel.org>; Wed, 29 Jan 2025 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738128289; cv=none; b=ZgNeFCbHLSo72Vm6/TCoyjc5sn7icxkwxv3dJWSq7OVU43M7m1W2WSZ2kqoDIcfGGgt+pwhtv+lEvZe7tUHHHF3iMeRIRdKNDI00qjaO0H6BMv+vEXeb+/bU515pQ+aqjD129WlfjB6J7Qrsn8naVydE6Pbl20JllVwaCVweQ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738128289; c=relaxed/simple;
	bh=6BV4PDzpoDtt4JWx2xJ70jA24uxa1HqKt9mOARB+1Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHinD6li4gpId6H2IKlYXSCaCvABG5koKjcKJ53Gb4qGXiUWOUoumixvYkEfTeZb4yGR6ud0zLgQry9LqsaEi15lReQyEgRZuh7ALc5D4E7Z3hDbyXmy/VnEJRE989pmjqsNoGRor89HgaUVOoL4VwAj2xEg9fuPrxX4WV7xQFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1537268D13; Wed, 29 Jan 2025 06:24:44 +0100 (CET)
Date: Wed, 29 Jan 2025 06:24:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, zlang@kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] common: skip tests using LVM when the device is no
 known
Message-ID: <20250129052443.GA28621@lst.de>
References: <20250128071609.676581-1-hch@lst.de> <20250128193122.GU3557695@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128193122.GU3557695@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 28, 2025 at 11:31:22AM -0800, Darrick J. Wong wrote:
> Should this get turned into a common helper?

> I guess the downside is that pvcreate on my system (Debian 12) will trip
> over any existing disk label and ask if you want to wipe it.  If you say
> no then it returns nonzero, and if you say yes then it goes into an
> infinite loop.
> 
> You can of course $WIPEFS_PROG -a $bdev but ugghh.

Honestly, for now I just want to avoid the tests failing due to lvm
stupidity.  If someone has the time to do something more elaborate
(I don't right now), the proper thing is to stop using lvm and replace
it with something less stupid.  That might be direct use of dm,
or simulating failures with null_blk or scsi_debug.

