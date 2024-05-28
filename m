Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909634594A
	for <fstests@vger.kernel.org>; Tue, 28 May 2024 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887579; cv=none; b=S9uG+E2Ty8fC/jEyf9DMrKhBryMgg8PKNF/d8TTzXUbnzeDf8/beKHLQexZsAnU29LnlJJZNloxKenCoOWrIk3EIvARdFDl+DlyDyGEJqHygpGa792pWvDnhryNLt7brhC0O4vb3ZZw2BCGWQDeJW063WgtdFIT6bPWIPovwsNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887579; c=relaxed/simple;
	bh=gk4aEToWV8iii650E/G9VaB/3Hxhag8GMleXPPp4DoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l44t+EJ7FnkO5pbMRKh33vD/KDA/RngEC6QsXO7C8x9gmU8wn7TF8qvAO6fG/tefrgPfJvj1VSbZLtf7n2iqoVLNVnbGnq9S/3XFejRTAkSmrDbT7sc1JuMmYjoLcdv8Z6YDxQXjd8z/iEW2jNENdc7rXlPuUrccwAg8yk8F6is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=WHlJaAMk; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="WHlJaAMk"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VpRcc3RRTz9smQ;
	Tue, 28 May 2024 11:12:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716887568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2UuvJZAQi6kK8eh9oMUcFM7LzKyGH0d0430isgnKuuo=;
	b=WHlJaAMkM+cldoRQimsMmphck+4IO7FEJr/N6J0k4g+D1Cy071H1QYTF+igFECsGZHV8/6
	OHOve7QSVJUGSLWXns9HiIsIw2rjJz3/dAT6t4jLr+0sLr2syIPf+dLC6VrHHxNJ4VVhYu
	Q2HI8NfRG3QMfP2yoe5c/TEGFiQ9sIifKoC236EunHYpvE1jdSGW+WmR6Dj15KRjS93LMi
	gdRSPoRvbtmrYvB33jdGwzMj76OZVbwqcHAoccvs7FlfAzfhVjGhtxKZST45NW5uVoS/5X
	lHRiddQ5veK6x8YCy+6mwmCjPXJqK6HwKaGQI3qPxFt0nJT3DBd4YrA5Kph6bg==
Date: Tue, 28 May 2024 09:12:46 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, ritesh.list@gmail.com, djwong@kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 2/3] generic/436: round up bufsz to nearest filesystem
 blksz
Message-ID: <20240528091246.jsicflatb6ndsc5g@quentin>
References: <20240527114834.167521-1-kernel@pankajraghav.com>
 <20240527114834.167521-3-kernel@pankajraghav.com>
 <20240527130111.hyoigq32xaxxpc5x@quentin>
 <20240527132637.3ncfgfpun374ygib@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527132637.3ncfgfpun374ygib@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Mon, May 27, 2024 at 09:26:37PM +0800, Zorro Lang wrote:
> On Mon, May 27, 2024 at 01:01:11PM +0000, Pankaj Raghav (Samsung) wrote:
> > On Mon, May 27, 2024 at 01:48:33PM +0200, Pankaj Raghav (Samsung) wrote:
> > > From: Pankaj Raghav <p.raghav@samsung.com>
> > > 
> > > SEEK_HOLE and SEEK_DATA work in filesystem block size granularity. So
> > > while filling up the buffer for test 13 - 16, round up the bufsz to the
> > > closest filesystem blksz.
> > > 
> > > As we only allowed blocksizes lower than the pagesize, this was never an
> > > issue and it always aligned. Once we have blocksize > pagesize, this
> > > assumption will break.
> > > 
> > > Fixes the test for LBS configuration.
> > > 
> > > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Looks like I missed the RVB from Darrick [1].
> > 
> > @Zorro could you fix it up before you commit?
> 
> Sure, if there's not more review points, I'll merge it with this change.

Sounds good. Thanks!
