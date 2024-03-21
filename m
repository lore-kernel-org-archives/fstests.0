Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568FA85265
	for <fstests@vger.kernel.org>; Thu, 21 Mar 2024 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711057961; cv=none; b=jQ2h2M0K9cYgjvF5XGvKJ4lOMS38PjjhkrpvxtrfQL5Pcb0SGy9RI1tPUjGZ281C2BNXvQAyfuZckbsJA6Q3LK+dUVUHTA+PIimTjVkyQT2xM6Ay9u78hMHAUbX68Uf7+ywsF3HGOlultS0soFS/ePaks/6936Vans9pScfey9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711057961; c=relaxed/simple;
	bh=SFT7I/mQlV+cGCSM2WRt4PbAhxOR14W4gxZ5zmRphRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1JFHslh+GzJMK+hq+gwNIkDLqlXjvcQ4baIh79bSWEF6IHnB9agysjPmuh3Ukydvs+dW5B1MrZMTgU6vuzPrLWKo9XetHpCN3I6qYs5fWjPS735b6nP98YXSKPnYTkE2C6TaBQdISJYk5WZbjS0h5KQIFVxSylBsdsqvJFyCno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c8Y8IvLY; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c8Y8IvLY"
Date: Thu, 21 Mar 2024 17:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711057957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xfhX1Zv/6rp02fX/o3lb/6IWJxq/LqZe80g/A8558VM=;
	b=c8Y8IvLYJFlySlIOlfcLdJFyRwU4KMGiuCIMu+1my89U18mFmXWTPzHNnPCGIFa+cSddWp
	MC/RU0GoGJ1SbpHLCTIqIhoE4kdRhBCsYAf5hZCMYPmzRopJAXdQ7TjngQK4UIhvTotSca
	HN80C4RLyrfv+ajzURFqu3ZqyXDQLIo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.cz>, David Sterba <dsterba@suse.com>, 
	fstests@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 5/5] generic/733: disable for btrfs
Message-ID: <xlwjfzviowyls5wnomqzufkfr6zm6mot3rpy6ct7rwyrwixjpt@uf47gsudlhxn>
References: <cover.1710871719.git.dsterba@suse.com>
 <094a1bdc304b236ba41aff4da454abe3c93a355c.1710871719.git.dsterba@suse.com>
 <Zfn9DMR8UQQMiyiL@infradead.org>
 <20240320155824.GD14596@suse.cz>
 <Zfyob_7NV9Kbd9pU@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfyob_7NV9Kbd9pU@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 21, 2024 at 02:36:47PM -0700, Christoph Hellwig wrote:
> On Wed, Mar 20, 2024 at 04:58:24PM +0100, David Sterba wrote:
> > It is a bug in the test, it should have been xfs specific and never
> > promoted to generic/ and not affect btrfs unless explained how
> > in the first place.
> 
> Well, the concept that reflinks are reasonably fast and are not live
> locked by ongoing I/O seems pretty natural.  But I guess we can't
> just asusme quality of implementation everywhere, and do an opt-in
> like _require_non_sucky_reflink.  Either way we need to document
> the assumptions and not add a magic exclude for a single fs.

generic/733 runs just fine on bcachefs, sounds like btrfs folks just
need to fix their filesystem
