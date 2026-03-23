Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A35173
	for <fstests@vger.kernel.org>; Mon, 23 Mar 2026 02:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774231427; cv=none; b=eLzgtQpYqYnYUH9UaY9PI55gAobOpyxsZr2OOvlWs+u2nolsRCabpt5aPufWObrCFwougzPhVzh4g+P9AyXHz+lxzk849ao2PH02NB7szFJZOK8Y2ciS+hITHpJkMGs90+KiPw4kjXWnGRvI8C8IToLeTlk6Y1OKX+RygoDHC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774231427; c=relaxed/simple;
	bh=QOqixWp7rQ4OlXbd8lVugUF17W/ORHlHwcpnQ7apr60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWl9C0oXejjKu565ZOLpyFWJeqBTpIdwVng2m8eYVef21XR9ia1XjpungxFetTe8XA1pW9e89Iqcfuh5CH6IwFTxjXn/GiInJW4wjVhHipEvkHYRL2Qa7m5mGyc1kK+MR/kvKYAWrJGvMTW9yxA+IxPRZi1gf3PuQyuOylD4NBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlIWDGWJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlIWDGWJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641F4C19424;
	Mon, 23 Mar 2026 02:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774231427;
	bh=QOqixWp7rQ4OlXbd8lVugUF17W/ORHlHwcpnQ7apr60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlIWDGWJw78F4dTCHMjOuh0tUir08xMWlFJleewNLb3gw8hdz68sCMkS0KSfM5zzN
	 ndRnWbV0GF5DjqMgUHZ/tm2eUwjeoc58xyhP9lk/qTRhJqxShPyFT6g13sBXMjWecw
	 970/ln4utr7V/dXvLu3UfspY9Cu/LFLjliQnNmepqIXkV+ZqFxY8NIJBAwMhtUCSJL
	 7tHQyoY85zXU9+UKB/YRUs5uThibe44DFQ08Y0u2GdToC28rlpOgm8n11XD1mutlQU
	 be5p9VM3M1NnIHiMhwn5D+IpprjxV01qjcmVjgXUkTcps/EFYDXxX6doQ4/1scA5yz
	 ciN+gqzT7lCVw==
Date: Sun, 22 Mar 2026 19:03:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common/rc: add default _udev_wait timeout
Message-ID: <20260323020346.GC6254@frogsfrogsfrogs>
References: <20260319005154.29274-1-ddiss@suse.de>
 <20260319153843.GI6023@frogsfrogsfrogs>
 <20260320103736.40f275b8.ddiss@suse.de>
 <20260320144413.GA6212@frogsfrogsfrogs>
 <20260323125421.62c9cede.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323125421.62c9cede.ddiss@suse.de>

On Mon, Mar 23, 2026 at 12:54:21PM +1100, David Disseldorp wrote:
> On Fri, 20 Mar 2026 07:44:13 -0700, Darrick J. Wong wrote:
> ...
> > > I normally have udevd running, but sometimes mess it up. My latest screw
> > > up came from ommitting a "/run" dir in the initramfs test env, which
> > > causes systemd-udevd to die on "/run/udev" creation. The error message
> > > is hard to spot amoungst the other boot messages...  
> > 
> > Oh, ok.  For some reason I thought you were trying to run fstests
> > without udev.  What if instead ./check looked for udevd and refused to
> > proceed if it isn't running?  AFAIK even the anti-systemd distros ship
> > eudev.
> 
> I've added the extra udevd sanity check to my test env, so I shouldn't
> need anything in check. I'd expect NFS, SMB, CephFS, etc. may still want
> to run without udevd.

<nod>

> > > > > The error message causes test failure via golden output mismatch and
> > > > > is easier to debug than an infinite loop.
> > > > > 
> > > > > The timeout parameter is also compatible with existing
> > > > > args="--removed <dev>" callers.
> > > > > 
> > > > > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > > > > ---
> > > > >  common/rc | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/common/rc b/common/rc
> > > > > index fd4ca964..aade0e5b 100644
> > > > > --- a/common/rc
> > > > > +++ b/common/rc
> > > > > @@ -5544,7 +5544,7 @@ _udev_wait()
> > > > >  	if [ -z "$UDEV_WAIT_PROG" ]; then
> > > > >  		$UDEV_SETTLE_PROG >/dev/null 2>&1
> > > > >  	else
> > > > > -		$UDEV_WAIT_PROG $args
> > > > > +		$UDEV_WAIT_PROG --timeout 10 $args    
> > > > 
> > > > ...a system running udevd that's taking forever to process rules can hit
> > > > this 10 second timeout, at which point the test moves on and might just
> > > > fail due to unconfigured /dev nodes.  
> > > 
> > > The 10 seconds is arbitrary. If there's a concern that the timeout will
> > > prematurely fire on a regular systems then I'll gladly raise it up to a
> > > minute or so. I just want to get an explicit failure instead of a
> > > never-ending test.  
> > 
> > <nod>
> 
> I'd still like to see a timeout added, as a failed test (with timeout
> msg) is IMO a far better outcome than an endless wait. Any objections if
> I send a v2 patch with 60s timeout?

Nope, 60 seconds should be enough for anyone. ;)

--D
