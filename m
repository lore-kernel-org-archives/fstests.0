Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A226345CAA
	for <fstests@vger.kernel.org>; Thu, 19 Mar 2026 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773963471; cv=none; b=gBSrhAv4v4iX8c7WNa8U+kbHxZe5xayO+x5GRt/us733/Iaipn73NSzsfDPiI+sXCT1lOj2kGHJM6+Z7PwJtNggm7z+y7OS2pf//gwBdJkQc6qe+zegC/gia4dD2FjJT+lHf+qVRhY6gWmfGmMAJFVEixgJNa/wp+hrgdIcpcaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773963471; c=relaxed/simple;
	bh=Yfir71knXHs/lmojdZi0cRZIgBrp91o2AJjmQjlpl5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2ZofbVlkzKf0BsPvw7qH01H10HFb9D8eWlg6UaqKxMOyUu9Crso01/Bl0QjQWSjaQDsIS6ozdatZ0PdbES0imnT0JRsSV8D95XU6TGMfGUcMCgM9RlDh97Njh6DmEuopsBAnO1Vr1n+pNT1a4Dlva7GgqFT4cKcMsDu8IzyrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uMDn7Oor; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K+8zEXmx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uMDn7Oor; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K+8zEXmx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uMDn7Oor";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K+8zEXmx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uMDn7Oor";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K+8zEXmx"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F95E5BD2D;
	Thu, 19 Mar 2026 23:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773963468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tBVVWcVsGd7lPbptvxNeeNYtPd9tDImtdpsE5qzlPA=;
	b=uMDn7Oorrqtc3RNbyj7Se40Q2T7onb8qnqO78mJJIs6Xw1zcLW+7gEcgchW6awIXlAJRfV
	LwMXxECflcd0EhFfcyByuFMCDjo3QSU5KLXLWFdXZ1ElGsD7cIhBbrmGYt9A9IzKZhAhkU
	/vu/1aYYLadFIe9KcyItwNNL6KqHvd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773963468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tBVVWcVsGd7lPbptvxNeeNYtPd9tDImtdpsE5qzlPA=;
	b=K+8zEXmx13JT4spstpEDmS7eRPW/w2DPRuTywFXQ1yfcPbjoAac7N7Y2pbFKPCNP47K+np
	mbpy8wOF6uP2mZBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773963468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tBVVWcVsGd7lPbptvxNeeNYtPd9tDImtdpsE5qzlPA=;
	b=uMDn7Oorrqtc3RNbyj7Se40Q2T7onb8qnqO78mJJIs6Xw1zcLW+7gEcgchW6awIXlAJRfV
	LwMXxECflcd0EhFfcyByuFMCDjo3QSU5KLXLWFdXZ1ElGsD7cIhBbrmGYt9A9IzKZhAhkU
	/vu/1aYYLadFIe9KcyItwNNL6KqHvd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773963468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tBVVWcVsGd7lPbptvxNeeNYtPd9tDImtdpsE5qzlPA=;
	b=K+8zEXmx13JT4spstpEDmS7eRPW/w2DPRuTywFXQ1yfcPbjoAac7N7Y2pbFKPCNP47K+np
	mbpy8wOF6uP2mZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA33D4273B;
	Thu, 19 Mar 2026 23:37:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m5yCIsqIvGl1LAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 19 Mar 2026 23:37:46 +0000
Date: Fri, 20 Mar 2026 10:37:36 +1100
From: David Disseldorp <ddiss@suse.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common/rc: add default _udev_wait timeout
Message-ID: <20260320103736.40f275b8.ddiss@suse.de>
In-Reply-To: <20260319153843.GI6023@frogsfrogsfrogs>
References: <20260319005154.29274-1-ddiss@suse.de>
	<20260319153843.GI6023@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Thu, 19 Mar 2026 08:38:43 -0700, Darrick J. Wong wrote:

> On Thu, Mar 19, 2026 at 11:51:54AM +1100, David Disseldorp wrote:
> > If udevd isn't running then "udevadm wait" loops endlessly. With a
> > --timeout parameter provided, udevadm (udev-254.27) prints to stderr:
> >   Timed out for waiting devices being initialized.  
> 
> If you don't have udevd running, then perhaps we should detect that and
> directly call "sleep 10"?  Because otherwise...

I normally have udevd running, but sometimes mess it up. My latest screw
up came from ommitting a "/run" dir in the initramfs test env, which
causes systemd-udevd to die on "/run/udev" creation. The error message
is hard to spot amoungst the other boot messages...

> > The error message causes test failure via golden output mismatch and
> > is easier to debug than an infinite loop.
> > 
> > The timeout parameter is also compatible with existing
> > args="--removed <dev>" callers.
> > 
> > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > ---
> >  common/rc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index fd4ca964..aade0e5b 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -5544,7 +5544,7 @@ _udev_wait()
> >  	if [ -z "$UDEV_WAIT_PROG" ]; then
> >  		$UDEV_SETTLE_PROG >/dev/null 2>&1
> >  	else
> > -		$UDEV_WAIT_PROG $args
> > +		$UDEV_WAIT_PROG --timeout 10 $args  
> 
> ...a system running udevd that's taking forever to process rules can hit
> this 10 second timeout, at which point the test moves on and might just
> fail due to unconfigured /dev nodes.

The 10 seconds is arbitrary. If there's a concern that the timeout will
prematurely fire on a regular systems then I'll gladly raise it up to a
minute or so. I just want to get an explicit failure instead of a
never-ending test.

> /methinks this could be done like so:
> 
> 	if [ ! -S /run/udev/control ]; then
...

That's a good idea as a udevd sanity check. I'll add it to my test env. 

Thanks, David
