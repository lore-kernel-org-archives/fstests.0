Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C81DF258
	for <fstests@vger.kernel.org>; Wed,  7 Jan 2026 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767773883; cv=none; b=Kp3TfiBTVRlP71m35G6QTCx0ZI8J334eueU9Z4Yh4/VGytYRWAac1V14iuoEeLfdfiFgosD7zWHFeIaMasro1uHnapAaqR4ZoYqxLUUdxH9C86ACXR9LY89YbtqYFOn92K2zFPDQUWymVqG1EEFyOcodiHpTKOHZ6/Tn8k5MZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767773883; c=relaxed/simple;
	bh=JtFOFlI1YymBA5n4WILM5PZf27zCrDL+rKvAbOh/XO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDilf0Rj6S/v1qRNu3ZnK7Lp0iMqnJjgpn//fgAtWZI9zK5Lmcfn49uswykmHERn3difvHIjdOWqDYMHTtGf+1C/js71V7wCqSjFr9agay0Nlfr2xVGPgOFiML0mqeqZSjZP7dl4HjbQyrg/eJuBns/4XxKx1rwgwpcd7XrmPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TomsHyvY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TomsHyvY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=5zuInJ7HAsYwAb0wNDVepC+ziu1s/ezU57ZH+9ZEPCY=; b=TomsHyvYOFZLaH7VoXe5oFPz40
	YU5osO6dCmvK4wW0UPoZxYeQPe1n/cJk6MwtW84yjwkDIC7quo7O7jZLukbioAuTIJ2kCAB6bBmR4
	EWGd0LePalJjJD81ku+lcPYkKxugrOVShXfu5R17cr1PJ0VqhMhMC4X0VVfjy3069Go1o1mhhnNcy
	XpbJuN3Wz9tu6NpOs3Cbx1Wz97BbzTvb4CS0UChH39wlU0nosRQ4OC3e403WPypkjACS6jGva7ka6
	FTyIbwUVIPtsiOik5BZ9FLUqvC/+DF8/GMXV72+3W3CTsstEJDyFhzPGLn9QgD5NzAjPMeci5k5Fw
	wZn7IP/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdOjw-0000000ENqi-3Em2;
	Wed, 07 Jan 2026 08:18:00 +0000
Date: Wed, 7 Jan 2026 00:18:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Chang <joannechien@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] common/rc: add _require_blocks_in_file helper
Message-ID: <aV4WuCaMl7I2TQAd@infradead.org>
References: <20251229023145.1806877-1-joannechien@google.com>
 <aV34aGUeU0pQkwj2@infradead.org>
 <CACQK4XCF-Hex_H31evMu8Zpv_OLtV0QBU0MpajOSHcfaREMAKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACQK4XCF-Hex_H31evMu8Zpv_OLtV0QBU0MpajOSHcfaREMAKw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 07, 2026 at 04:12:44PM +0800, Joanne Chang wrote:
> On Wed, Jan 7, 2026 at 2:08 PM Christoph Hellwig <hch@infradead.org> wrote:
> > I still don't understand why we can't do this programmatically.  I guess
> > it would be simply too slow?  In that case that should probably be
> > documented here in the commit log.  Otherwise this looks good to me.
> 
> I used a constant to avoid masking bugs that cause the maximum file size
> to shrink on filesystems that should support this test. I can add the
> reason to the commit message if that would make it clearer.

That would be great, thanks!

