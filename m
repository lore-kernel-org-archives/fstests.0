Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FDF3C8721
	for <fstests@vger.kernel.org>; Fri, 20 Mar 2026 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017854; cv=none; b=qFsMcJS9mErHuiAzueLKqQcW17bUBixTuywY2u0jd82H0iCENOx9kPn/dGAMgxnw23jwZF2wzwI24ly/5MIr/Z0ydA6jnntHPr6cxVXN+ZsuJe7Qp0XEE/7cQcPjlV5xeDOzBfMmAFdwCO1QP8I7EdXdnBaGgCCBhdCSTevFgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017854; c=relaxed/simple;
	bh=073zPReyGXt9R/bgwVe5viJKnk+HRB4pGiePqBVML2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckAXaejpNHG+PwCXlqNfoAo+eNnTpiAlEgxdCpbCLorFUFMBa5BN3v5Kg6rQ21W6Vhg+UryLhmekGpjlJZmdDnYkcjCNus3mv2s9BpabezNnKViG5jb1sx8f79FCLD5ZmWs6bjcMCm5wAmJkoCQB0pOzhozw2KwGTt1nYgqANCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7JnABjx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7JnABjx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C850C4CEF7;
	Fri, 20 Mar 2026 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774017853;
	bh=073zPReyGXt9R/bgwVe5viJKnk+HRB4pGiePqBVML2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7JnABjxiKX9c8sJacp6TtX19wCSumqqLkeqOz+fypnRoNnI711LIrWv0+VOyMuot
	 rV09T5OICvdeLU9ykzKboGVN12/q63xC4bVdvNk6FJhPm8k+im+hF5GOEIzvyYflzc
	 Bq/bzI0uFfHrJUdGudfSRhh8bun/A2DjYchtpdBkU6VGg4UPfcUU+/uqvMwsBsuaaA
	 t1mb0KJ+fc3HeF06wN9fwURNXLwV2bYqkKYH38QRVkAoH7vcG8B9Th7yKsa7xE8PgX
	 H2gmLkvcVw10tqvTAxdXNsHw7Poxvamf6d+prRQR9urMP5NR6jJMyttoDZFLEnTCcn
	 ioSTD8EXTKWCQ==
Date: Fri, 20 Mar 2026 07:44:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common/rc: add default _udev_wait timeout
Message-ID: <20260320144413.GA6212@frogsfrogsfrogs>
References: <20260319005154.29274-1-ddiss@suse.de>
 <20260319153843.GI6023@frogsfrogsfrogs>
 <20260320103736.40f275b8.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320103736.40f275b8.ddiss@suse.de>

On Fri, Mar 20, 2026 at 10:37:36AM +1100, David Disseldorp wrote:
> On Thu, 19 Mar 2026 08:38:43 -0700, Darrick J. Wong wrote:
> 
> > On Thu, Mar 19, 2026 at 11:51:54AM +1100, David Disseldorp wrote:
> > > If udevd isn't running then "udevadm wait" loops endlessly. With a
> > > --timeout parameter provided, udevadm (udev-254.27) prints to stderr:
> > >   Timed out for waiting devices being initialized.  
> > 
> > If you don't have udevd running, then perhaps we should detect that and
> > directly call "sleep 10"?  Because otherwise...
> 
> I normally have udevd running, but sometimes mess it up. My latest screw
> up came from ommitting a "/run" dir in the initramfs test env, which
> causes systemd-udevd to die on "/run/udev" creation. The error message
> is hard to spot amoungst the other boot messages...

Oh, ok.  For some reason I thought you were trying to run fstests
without udev.  What if instead ./check looked for udevd and refused to
proceed if it isn't running?  AFAIK even the anti-systemd distros ship
eudev.

> > > The error message causes test failure via golden output mismatch and
> > > is easier to debug than an infinite loop.
> > > 
> > > The timeout parameter is also compatible with existing
> > > args="--removed <dev>" callers.
> > > 
> > > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > > ---
> > >  common/rc | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index fd4ca964..aade0e5b 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -5544,7 +5544,7 @@ _udev_wait()
> > >  	if [ -z "$UDEV_WAIT_PROG" ]; then
> > >  		$UDEV_SETTLE_PROG >/dev/null 2>&1
> > >  	else
> > > -		$UDEV_WAIT_PROG $args
> > > +		$UDEV_WAIT_PROG --timeout 10 $args  
> > 
> > ...a system running udevd that's taking forever to process rules can hit
> > this 10 second timeout, at which point the test moves on and might just
> > fail due to unconfigured /dev nodes.
> 
> The 10 seconds is arbitrary. If there's a concern that the timeout will
> prematurely fire on a regular systems then I'll gladly raise it up to a
> minute or so. I just want to get an explicit failure instead of a
> never-ending test.

<nod>

--D

> > /methinks this could be done like so:
> > 
> > 	if [ ! -S /run/udev/control ]; then
> ...
> 
> That's a good idea as a udevd sanity check. I'll add it to my test env. 
> 
> Thanks, David
> 
