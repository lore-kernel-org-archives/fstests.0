Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFB61E4A8
	for <fstests@vger.kernel.org>; Sat, 27 Apr 2024 05:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714197503; cv=none; b=MZHU/Z9ewLa+MoXT6xdMnXvnxgWzM30k7LK+bESGg/uepx2/h7Rz3zAYhgSYwXL2/yhMe/I6VBdxwWO3rLoCWQHfOnGeZm0NOMeiBZVzgt4TLCFoJAVrDGX0DJhYefEyaV1gq1vEM9aRAg1nIMFyzQCZw45Y9J/djr4vIRPr88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714197503; c=relaxed/simple;
	bh=dSt44fxaReMIGVztzvdyi6naJhI0CGcGFaGITCEvPZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Le44hxw3W+wbUQeCUiTaCQW5aqvEGDJgua10KgictzPZ0LMPp7j9UDSsmbcovJGKyeEagZXjrNmj0Vr71QqWB8oCGkyfNSXVedvH2Kg4rJ8hIwQj33ZCUw6N2IANMltXfKuUFJaJJEG+WJfRuttdo8lLT3XL9bUFbUIwewVMQ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2XXDAlKA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2XXDAlKA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6+3pL1i7rFBwxV8kUik2mU6M5j8NvPctDbrTDkOuhks=; b=2XXDAlKAgXIeQAkWwTbjbtipAQ
	qXex3q/BRAUNPo1Bk6aOsSNtyDw/9eucWFQLJkl9lNGXl3jJKNfqXtasL+K9Do9YyNrqBh5qCkMiq
	Cr1Xdtn6GBYEASFjZCe3n2BaGaFpPjfuVR2l70aOVy5rVxnvYIZnRD1sxQLSn8hrmv8wqiJBnl7cn
	VQClqDGyE2oXQiDy0ML8qUXQBsOXzbBMVmkQv8SnMMCZd3W/wwNIslh+CFO7H/vDDHJ7N+HcVy+GV
	0HwqC2iO4gzxUCk/C+GxpGAScpSPZTq9EH4BrFPDy19tuqIIqxq47Y92G8Ru3Lz152lnIZiyvZcv9
	QjkAJ8RA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0b4n-0000000Evgq-18qZ;
	Sat, 27 Apr 2024 05:58:21 +0000
Date: Fri, 26 Apr 2024 22:58:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, David Disseldorp <ddiss@suse.de>,
	fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] tests: _fail on _scratch_mkfs_sized failure
Message-ID: <ZiyT_a4b5RJIgZ5u@infradead.org>
References: <20240411063234.30110-1-ddiss@suse.de>
 <20240411063234.30110-2-ddiss@suse.de>
 <20240412154856.GB11935@frogsfrogsfrogs>
 <20240412192831.untkqteorxsycrfw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412192831.untkqteorxsycrfw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Apr 13, 2024 at 03:28:31AM +0800, Zorro Lang wrote:
> > I wonder, how many tests should keep going if _scratch_mkfs_sized isn't
> > successful?  Would it be simpler to make a _try_scratch_mkfs_sized for
> > those callers, and make the main _scratch_mkfs_sized simply do
> > 
> > _scratch_mkfs_sized()
> > {
> > 	_try_scratch_mkfs_sized $* || _fail "_scratch_mkfs_sized failed"
> > }
> > 
> > ?
> 
> I agree with this. Actually I don't know what's kind of historical reasons
> make _scratch_mount _fail directly if mount fails, but _scratch_mkfs
> doesn't like that?

Agreed.  Unsupported mkfs should absolutely fail by default.  For some
tests instead of _fail it should be _notsupported, but that would be a
separate helper and between the two of them we'd cover almost all uses.
