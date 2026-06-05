Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7FD242D65;
	Fri,  5 Jun 2026 04:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780632391; cv=none; b=cLMmiYppKz+5oS4CJNb1tcu3LiCgZEz1sEngF6WeBeExJLRlcPZ+y2m4rqjRnDtTfmVD0ylrF7ri67xoxlzJb4AFcpGPkSzsTarr48SMX8iAwsXWESy25YePcHpPdqnxCn1qxCc4Ehn2oWkY/bB0Y29VwkWauUwXL7Jwe8UB9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780632391; c=relaxed/simple;
	bh=zd9A++4d4HpZwELVNy2FH0564dWY1X/3DdkKPIrtGSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsxkWEtnsbLIAE6D+azvaanEUb1XEx1TjrTmXMAgzIBwBFtkNsjXIlcluHdw7LUGDUZQ/cTfcwgAItOD+HvhzdXTdFAJksMc1RUfCS5YQ6FHAVEQBR/44+8gQ/1q6wpmu0Cadv/mJI83en9GWliB/eK112cCo4NFvNcUGO0eB+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=btr+/3/Q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="btr+/3/Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oBnbDkDQoByc7U2KMi/aU9y6GzY6o6wPWjzKDNNMtKo=; b=btr+/3/QnsFaGcluQQMZ5mR6N7
	XeWaR8ISiXOtlC82cm7fmigRaHdJjHxHFItSl+WfhYhkW4ED5LU+cOjZFG2RfoVjIMNlVIkL30BYi
	0xEDSa2I/3bFyvdCFrWAl/pJIIb9O8N0nYmHgg4+4v2sDAdleeVS0R2xdChhS2tuS4ZweXfZNpdPU
	QZEz/3rVJVxrfSiPCQqVjbOf8Axzex2r9PufAysfI8STQDP979rqm9IbT0Mmeqr7Zjd0obPaCV9Q6
	CYwuwcBM8UhXmnZSxwsBsHDWYlzL1At8pwsgDa78GcM7AUxCojPlnSIsChPkuDtotQ0xKqXV436an
	F+9m7mEw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLpC-00000000466-3H7A;
	Fri, 05 Jun 2026 04:06:26 +0000
Date: Thu, 4 Jun 2026 21:06:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Steve French <smfrench@gmail.com>
Cc: fstests@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: coreutils problem with xfstest generic/452
Message-ID: <aiJLQqOFAQUICPo0@infradead.org>
References: <CAH2r5muhUCkLV7=-YAJuj+HmNHPm3+cokgP36XFkkXF6pk6dYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5muhUCkLV7=-YAJuj+HmNHPm3+cokgP36XFkkXF6pk6dYQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 04, 2026 at 04:33:51PM -0500, Steve French wrote:
> coreutils behavior seems to have changed breaking xfstest generic/452
> which copies the symlink to "ls" to a different directory to run in
> the test.   It works with Fedora and some older Ubuntu but with
> current Ubuntu (26.04) it looks like coreutils has changed breaking
> the test.  Any ideas?

You aren't using corutils, you are using the broken rust
reimplementation in Ubuntu.  I'd strongly suggest you move your testing
to a less broken distribution.

