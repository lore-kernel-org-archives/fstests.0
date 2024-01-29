Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413F515698A;
	Mon, 29 Jan 2024 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561847; cv=none; b=OsYAf75B6gKDAOjPzpsCbeg6Qsbca94xBXxLJs4NgxWhfkrKzxqoffn1EoNfxFXSvJ100XUqcrgcfhlNv/syuZ1329oWhqsxKA5qlNXIK1iuvPUSfFGuey7HpEPqOLVWy33icNbXfV2oNcS4Z9DD5FGIDIWMlnIhlXecnuRrXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561847; c=relaxed/simple;
	bh=lr2QZxKDH29T7+ONXPoW3ppj8a/edx4HNjlV9ic/r+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBb7yl6LUP/NlDOktKaiTt2EzQLIVHQRVZZMOCpTZGH4d5f7rijwWtfK5MGhti1TiGT/6kT3We9eNTp0Tp7s/ClwTE/xZZYxdP+t30IKgX+h+LiT6RwH92Uwm0VvLQLy2sYPojH7rFW7zd/xeVdrX5r07qemdAVs6LcgRDL9tQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R4ja1PBx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R4ja1PBx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C0Ne3/7s7WpC4x5jscOGWVYhvMm7ZY17cm5WGkzYOsg=; b=R4ja1PBxYhRZPMzmy2Y2ChoCE0
	IYldh/DSrhU919uL7cedN+58b5tpZkMfuyNEj1meiNn4nyV+pN8Wh6JtSY8z1WGlSiA2fMQxDOgHE
	X0U6b2FcgQGAijHCsS79MfcpWldHegueDcOIfkjkAl6LQC7wJOKsyIPKS1aUqEH7Hqo4z3LPCmpuy
	wotkIgVsU33AfPuWJ/nwxyYQUjFx7j4mbDSm1a1cgO6ezD6gamf2CPMVzz0dyLKVnBJ0T1Xhef3LW
	8QyfUUVKVe5cvskhNLpbSudPzzZwmZHHBqv17dXyxFyvKTqPDvgPUuv4TcgL7Wu4jrOEdbdTW/ELJ
	TQa2Q7VA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUYh2-0000000EJJT-3PI4;
	Mon, 29 Jan 2024 20:57:24 +0000
Date: Mon, 29 Jan 2024 12:57:24 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>,
	Frederick Lawler <fred@cloudflare.com>
Cc: kdevops@lists.linux.dev, Chandan Babu R <chandan.babu@oracle.com>,
	Amir Goldstein <amir73il@gmail.com>, p.raghav@samsung.com,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	zlang@redhat.com, Daniel Gomez <da.gomez@samsung.com>,
	Dave Chinner <david@fromorbit.com>, djwong@kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	fstests@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH kdevops] fstests: provide kconfig guidance for
 SOAK_DURATION
Message-ID: <ZbgRNL-o4sEogmK-@bombadil.infradead.org>
References: <ZbLcXWI9bCdc9PZO@bombadil.infradead.org>
 <ZbLtyg9YUyQkdFPV@casper.infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbLtyg9YUyQkdFPV@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Jan 25, 2024 at 11:24:58PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 25, 2024 at 02:10:37PM -0800, Luis Chamberlain wrote:
> > The kdevops test runner has supported a custom SOAK_DURATION for
> > fstests, however we were not providing any guidance. This means folks
> > likely disable this. Throw a bone and provide some basic guidance and
> > use 2.5 hours as the default value. There are about 46 tests today
> > which use soak duration, this means if you are testing serially it
> > increase total test time by about 5 days than the previously known
> > total test time.
> 
> Do you have any stats on how much more effective it is to soak for 1
> hour vs 5 hours vs 24 hours?

Heh no, we just went for the high value of 2.5 hours for our LBS
testing. Note that the soaking is *per* test and hence the summation
of *all* 46 tests need to be considered. Unless of course we run 46
guests all running each respective soak test separately.

> Presumably there's some kind of
> exponential dropoff, like 20 bugs found at 1 hour, an extra five found
> by four hours and three more at 24 hours?

I suspect you might be right. We *may* be able to experiment more with
this once resource scaling can be done automatically for us, ie with
something like k8.

  Luis
