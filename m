Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF111E4AE
	for <fstests@vger.kernel.org>; Wed,  9 Oct 2024 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477279; cv=none; b=k8xuykXKzxaZGNM/yDfpCQTabAWOvF573+w3ErjQh/RV9ZyMJlJiaHjP6zhuFutuL3kFUmQVNQGuilpn4sEw6Ev0AtSvdZ16w2nZkMadoi66GOwZbQ69uzFtSjWJTyxjeN08A0hOsENYf/5C8Jd+8avVvwOxO9lZgIFq/b0qvp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477279; c=relaxed/simple;
	bh=xfd/6XvU46jNX3C91IYJrSPhT1V7DrSJ/+oX8J9vMZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeRtpEcz2KPaVFkXUMCEKRyUfxodDdAHdt7O466rddFJh9Z5bhHA9bgdA05ZQxAuTOpEpbAOw8XvZD70uJBNYPb2Bg+5t+iadL/Ncq4oo1L0Js9hEEoD1diGessbfFWaIki1XLlozFqTbZ+mTyFEv3ncoZkIWbXo3XWtoszn0cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1H1txZP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1H1txZP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728477276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NuzskDKWqVKq45sao37XE/sxqtCD9Hn+6SlLq9Sq8pU=;
	b=M1H1txZPF/+0v6y/hda/mLrJiQPE8zlBpjj0lqCF5xELJKFeZndWfLyFiVJxHoGeKfY/BK
	wKlP0aRGQmKPnyEDrs9sa7ff+KJL/0RHw5K0ca5jez3c/urvS6O8Nnc2Jp5wqICgGHPTQA
	ySo4SuCQsowXHvT47EMfUD1dcLVuZks=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-rxRUi-I3NFGZhTTalrJ_mQ-1; Wed,
 09 Oct 2024 08:34:33 -0400
X-MC-Unique: rxRUi-I3NFGZhTTalrJ_mQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03A1819560A2;
	Wed,  9 Oct 2024 12:34:32 +0000 (UTC)
Received: from bfoster (unknown [10.22.32.133])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5DC019560A2;
	Wed,  9 Oct 2024 12:34:30 +0000 (UTC)
Date: Wed, 9 Oct 2024 08:35:46 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, djwong@kernel.org, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: test log recovery for extent frees right after
 growfs
Message-ID: <ZwZ4oviaUHI4Ed6Z@bfoster>
References: <20240910043127.3480554-1-hch@lst.de>
 <ZuBVhszqs-fKmc9X@bfoster>
 <20240910151053.GA22643@lst.de>
 <ZuBwKQBMsuV-dp18@bfoster>
 <ZwVdtXUSwEXRpcuQ@bfoster>
 <20241009080451.GA16822@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009080451.GA16822@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Oct 09, 2024 at 10:04:51AM +0200, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 12:28:37PM -0400, Brian Foster wrote:
> > FWIW, here's a quick hack at such a test. This is essentially a copy of
> > xfs/104, tweaked to remove some of the output noise and whatnot, and
> > hacked in some bits from generic/388 to do a shutdown and mount cycle
> > per iteration.
> > 
> > I'm not sure if this reproduces your original problem, but this blows up
> > pretty quickly on 6.12.0-rc2. I see a stream of warnings that start like
> > this (buffer readahead path via log recovery):
> > 
> > [ 2807.764283] XFS (vdb2): xfs_buf_map_verify: daddr 0x3e803 out of range, EOFS 0x3e800
> > [ 2807.768094] ------------[ cut here ]------------
> > [ 2807.770629] WARNING: CPU: 0 PID: 28386 at fs/xfs/xfs_buf.c:553 xfs_buf_get_map+0x184e/0x2670 [xfs]
> > 
> > ... and then end up with an unrecoverable/unmountable fs. From the title
> > it sounds like this may be a different issue though.. hm?
> 
> That's at least the same initial message I hit.
> 
> 

Ok, so then what happened? :) Are there outstanding patches somewhere to
fix this problem? If so, I can give it a test with this.

I'm also trying to figure out if the stress level of this particular
test should be turned up a notch or three, but I can't really dig into
that until this initial variant is passing reliably.

Brian

