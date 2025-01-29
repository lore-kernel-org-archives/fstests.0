Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BCA33987
	for <fstests@vger.kernel.org>; Wed, 29 Jan 2025 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738128993; cv=none; b=sg0riIO25adhvVfz9sSA9y1hI8hK4C70XLlt8p/xdVBKUq+jFlYtQWZe9wy72LzA0t94TKZt6uSy0RgW/KbGu55Qz3DycDCSCMoshpC7OzRIcPCoMKyD27E+8uc5LQDX1sUADQuTM94bmLjclZw1gsPtRSKlwm2IJzOpMXleBLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738128993; c=relaxed/simple;
	bh=5hC0uHCpU5oBCI95voqHQ4BbF/QBXuZsrdJfaqGT8mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMHgJfFeX7JgFeMyfNho+2j4dODrHpVYf8XRW1rM0faOuQLK+iCXj67fVVwXO2oH+/GPLPO7BDXndlt3B1XV2IAfR91qHMKlWQ6tYTIsBFJpnUSYXpUa0zEga/YYywTGMEUQtOJ6wEmbClIFdOI224lLdQpA08/AZNP4Rur1MLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DA5C068D13; Wed, 29 Jan 2025 06:36:27 +0100 (CET)
Date: Wed, 29 Jan 2025 06:36:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, zlang@kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] generic/418: use min_dio_alignment
Message-ID: <20250129053627.GA28857@lst.de>
References: <20250128071412.676396-1-hch@lst.de> <20250128192147.GS3557695@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128192147.GS3557695@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 28, 2025 at 11:21:47AM -0800, Darrick J. Wong wrote:
> >  diotest=$here/src/dio-invalidate-cache
> >  testfile=$TEST_DIR/$seq-diotest
> > -sectorsize=`blockdev --getss $TEST_DEV`
> > +sectorsize=`$here/src/min_dio_alignment $TEST_DIR $TEST_DEV`
> 
> BTW is min_dio_alignment going to get an upgrade to report
> STATX_DIO_READ_ALIGN ?

Sorta.  For most tests we really expect a symmetic output that
can be used for reads and writes.  But for say fsx we can actually
plug in different read and write sized, and I did prototype that
a while ago.

