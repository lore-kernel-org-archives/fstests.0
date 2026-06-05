Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3A8242D65;
	Fri,  5 Jun 2026 04:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780632414; cv=none; b=K24b7AWZiFNllG8oo+2yshMshSW8KB4B7gudU+/n+gjwI1Gdr18CGFX0GPxA21GRHdbuofSZPK13Lx9CtU0xI10JdCtFesf3Ueet9DowR8iq5R1I59IbHfXbE9btJ7cmlM2TQYweirjvlvaUXdm/mkVToReMR83TP4tZ0iwXERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780632414; c=relaxed/simple;
	bh=BrDRAcrhj+GJCyCq/6t5CQ5pLHmCS1bezF+tFD9CdMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKqA96p+yADt8OD/kCu90rxkeMGKyt5pKJh5980gyK0j5fYmXjKCGH0c5WQM0Dw5abuLWOhPNzS9HhHh574EIdqHzZ08S08+PNjsVw1lVPWXwTUgIjWaTjENGAcFd2QEDgzoWxM60pUZHP1bobcEt8yFpgdU1psKWwgogssVRg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2P9fOu6v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2P9fOu6v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5PCicz5vrtXF4RcAVTQdmWJXsyGYlBH1XotW9Ragw50=; b=2P9fOu6vKPMbfzRjq9qufUEnLI
	PnqZNd08OQrmxEap3Zm0hzA0KXA/gwFH2dJKORUhglJZKb7n8KTE0X2qawL3oyFDT3zUhi8Qwb2EQ
	H0eXgRSGJPF84s3vWrP65sqRCB6OKNyQSUQLvJ80PmuydirLwO01jYhqWZXgqVaQYPG6q/7MI2lU4
	DPhgXJ9NavRukGCPrL7kn1YLQxjYzYr2CVXIpqzGlKrJFTmSBvShaJvx1bfj9Evw9ZGz62BcIOIZx
	iBCjtcpqDtyZ/w29dIoEyFVWMsK/og+o+mSbFceTak0Yt5SRen1GP+nWmU32MMy5V/DjgKGDKbCXh
	U+MYziLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLpc-0000000046a-2gZB;
	Fri, 05 Jun 2026 04:06:52 +0000
Date: Thu, 4 Jun 2026 21:06:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Steve French <smfrench@gmail.com>
Cc: fstests@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Capitalization change in linux tool breaks xfstests
Message-ID: <aiJLXNi_T98YKh3Q@infradead.org>
References: <CAH2r5mv2nhiBHJ3y71SvcQ0O4tqxJGrNRU7eRaSGfDrsvd_Cww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mv2nhiBHJ3y71SvcQ0O4tqxJGrNRU7eRaSGfDrsvd_Cww@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 04, 2026 at 07:03:26PM -0500, Steve French wrote:
> xfstests generic/029, generic/030 and generic/031 now break with
> current Ubuntu (26.04) due to a change in capitalization of hexdumps
> in some tooling.  See below.  Has anyone found a way to workaround
> this?

Again this is not coreutils, but the broken rust version.

