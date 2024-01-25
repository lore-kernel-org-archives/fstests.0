Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FBE11185;
	Thu, 25 Jan 2024 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706225109; cv=none; b=FBL9S2HRKMAOAX7vNEzwYxSa88XQ7fh4lE3B2z1gedtMAT371+ms09dchg48YvDp8Qht8TS4mbniewvk9PEEA2mO1GB/50XPQxPlvUX4NAP9UetimRDoIwFOkWHZ59Mn2iXEe0tFDsOGVGhlb43cdrLk62Cg8Gq10v2TEh3yLx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706225109; c=relaxed/simple;
	bh=WZmH1xbMfBtnzELQIcZ1Vre69fkDOw1D6aPuxHCB2gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUF36adysyxzn01Ta0y+3P0S6uKXUwMQxMz4jzAIwgxhCmaImMpMDt+n3PSrtGJFGpYSKVt1UZe3xM+ivnQFbEk9qCH07yOuLyk9ffYuXWaZ4O0wOJXnk5buFEKqwFMQEK41QmDUOhlBarLh7Pnc7nuQTvFlRbzPM++TprHNJcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AHXX50uD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AHXX50uD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TpqR66gqGoXEbvJJYHSdPd8VBNSMjTrc9nIck7whXyA=; b=AHXX50uD5GKF9rnPN+JMVGxOSM
	u4SrWXIsMe4Lcqk9fiVPKnvfsLoQixVixsbj1HaLlkY75fjWB1P70C1YlEsQ9v8tzBDEh7hNiY80y
	9L/o2dY/ULiXfLmDi9TqMnCyeB4p348rI+/JstRzRvyCC2YI5Qswhnur0yvtFu8hrGM9j2CdfWFVe
	F2ODgqo7ThnBgO/hliNI1EOws70GFZzfX8xePacbXvbwyFUqjw6UgEm73k8SRH+FA9Jqgm286mcxD
	Ueh60KyLsl6RIoGhDNQAefXZ7ElYXSHtpa0W/G2IVcK5P8LW6sh6VowrWBf0bdsYwkD+Ev9Z8J6SZ
	xPiv+NeA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT95e-0000000Bf77-3M7y;
	Thu, 25 Jan 2024 23:24:58 +0000
Date: Thu, 25 Jan 2024 23:24:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: kdevops@lists.linux.dev, Chandan Babu R <chandan.babu@oracle.com>,
	Amir Goldstein <amir73il@gmail.com>, p.raghav@samsung.com,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	zlang@redhat.com, Daniel Gomez <da.gomez@samsung.com>,
	Dave Chinner <david@fromorbit.com>, djwong@kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	fstests@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH kdevops] fstests: provide kconfig guidance for
 SOAK_DURATION
Message-ID: <ZbLtyg9YUyQkdFPV@casper.infradead.org>
References: <ZbLcXWI9bCdc9PZO@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbLcXWI9bCdc9PZO@bombadil.infradead.org>

On Thu, Jan 25, 2024 at 02:10:37PM -0800, Luis Chamberlain wrote:
> The kdevops test runner has supported a custom SOAK_DURATION for
> fstests, however we were not providing any guidance. This means folks
> likely disable this. Throw a bone and provide some basic guidance and
> use 2.5 hours as the default value. There are about 46 tests today
> which use soak duration, this means if you are testing serially it
> increase total test time by about 5 days than the previously known
> total test time.

Do you have any stats on how much more effective it is to soak for 1
hour vs 5 hours vs 24 hours?  Presumably there's some kind of
exponential dropoff, like 20 bugs found at 1 hour, an extra five found
by four hours and three more at 24 hours?
