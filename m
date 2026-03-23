Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C84222599
	for <fstests@vger.kernel.org>; Mon, 23 Mar 2026 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230899; cv=none; b=mD6cbfqprYIEZ06eELLGhE7xjZCHU/B0qYy2OEb/k8ulCe0t8kx9ti0tfOLeC6y2m2rhV1mcRyQBj7fbzr0XdBACMkZ6283oVScnMMUccFWZFaw1VX2gX6BGMAak7cf+lgoFUE+gA9OyWouPBXeFc8hy8pJhckJvOB0ZeYDJKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230899; c=relaxed/simple;
	bh=61R6pw+cUvHKmFsWm7GoLgjxxiFvilW6mdqwhAeQ/wU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2fCtDiEFseq+tnQ0U898hwczgy9ZhkYDsTmfOMm6S3h1L3xMTKNHAbumtXdeEtebK7DqvqEdRvgSZ4vq75h2G1GQh4c+g+2rQID2teIwyCoKzIfd+aciYxiph2lQALiu8zHKGa0VbPO4YuJPAyvlQ+3bcjTZQPkPOvVMEoZp5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0MqHcUfj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SSki3JH7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0MqHcUfj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SSki3JH7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0MqHcUfj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SSki3JH7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0MqHcUfj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SSki3JH7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 917305BD0E;
	Mon, 23 Mar 2026 01:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774230885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrCCXxjaoDMFok9NHVqoRYHUPJ85sw4vlSq0sNAruJc=;
	b=0MqHcUfj3TCIzHS3DAugL+dq7gXw3fflv5eFSSzg3FIpqhIgcuxwqAMNf4CunqmY8h2x9+
	fmst7PamPw6BqpInG7bSyBb1EBu4gDIfciJHGNvR/jtAYWXr0jQOeZ4+uIJ0MEjbi+JdaR
	cRh24QC+sUSIlL3CUWQWBZm84bJu4D0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774230885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrCCXxjaoDMFok9NHVqoRYHUPJ85sw4vlSq0sNAruJc=;
	b=SSki3JH7i532WsDeoS/hsppO6KsO38qgfvorACNSSM8RS3T7ji/XW205N/cOIQ7zPx8jJE
	uno1Pa1x3MdeaRAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0MqHcUfj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SSki3JH7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774230885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrCCXxjaoDMFok9NHVqoRYHUPJ85sw4vlSq0sNAruJc=;
	b=0MqHcUfj3TCIzHS3DAugL+dq7gXw3fflv5eFSSzg3FIpqhIgcuxwqAMNf4CunqmY8h2x9+
	fmst7PamPw6BqpInG7bSyBb1EBu4gDIfciJHGNvR/jtAYWXr0jQOeZ4+uIJ0MEjbi+JdaR
	cRh24QC+sUSIlL3CUWQWBZm84bJu4D0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774230885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrCCXxjaoDMFok9NHVqoRYHUPJ85sw4vlSq0sNAruJc=;
	b=SSki3JH7i532WsDeoS/hsppO6KsO38qgfvorACNSSM8RS3T7ji/XW205N/cOIQ7zPx8jJE
	uno1Pa1x3MdeaRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24BC143617;
	Mon, 23 Mar 2026 01:54:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9EWmM2OdwGlSGgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 23 Mar 2026 01:54:43 +0000
Date: Mon, 23 Mar 2026 12:54:21 +1100
From: David Disseldorp <ddiss@suse.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common/rc: add default _udev_wait timeout
Message-ID: <20260323125421.62c9cede.ddiss@suse.de>
In-Reply-To: <20260320144413.GA6212@frogsfrogsfrogs>
References: <20260319005154.29274-1-ddiss@suse.de>
	<20260319153843.GI6023@frogsfrogsfrogs>
	<20260320103736.40f275b8.ddiss@suse.de>
	<20260320144413.GA6212@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 917305BD0E
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Fri, 20 Mar 2026 07:44:13 -0700, Darrick J. Wong wrote:
...
> > I normally have udevd running, but sometimes mess it up. My latest screw
> > up came from ommitting a "/run" dir in the initramfs test env, which
> > causes systemd-udevd to die on "/run/udev" creation. The error message
> > is hard to spot amoungst the other boot messages...  
> 
> Oh, ok.  For some reason I thought you were trying to run fstests
> without udev.  What if instead ./check looked for udevd and refused to
> proceed if it isn't running?  AFAIK even the anti-systemd distros ship
> eudev.

I've added the extra udevd sanity check to my test env, so I shouldn't
need anything in check. I'd expect NFS, SMB, CephFS, etc. may still want
to run without udevd.

> > > > The error message causes test failure via golden output mismatch and
> > > > is easier to debug than an infinite loop.
> > > > 
> > > > The timeout parameter is also compatible with existing
> > > > args="--removed <dev>" callers.
> > > > 
> > > > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > > > ---
> > > >  common/rc | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/common/rc b/common/rc
> > > > index fd4ca964..aade0e5b 100644
> > > > --- a/common/rc
> > > > +++ b/common/rc
> > > > @@ -5544,7 +5544,7 @@ _udev_wait()
> > > >  	if [ -z "$UDEV_WAIT_PROG" ]; then
> > > >  		$UDEV_SETTLE_PROG >/dev/null 2>&1
> > > >  	else
> > > > -		$UDEV_WAIT_PROG $args
> > > > +		$UDEV_WAIT_PROG --timeout 10 $args    
> > > 
> > > ...a system running udevd that's taking forever to process rules can hit
> > > this 10 second timeout, at which point the test moves on and might just
> > > fail due to unconfigured /dev nodes.  
> > 
> > The 10 seconds is arbitrary. If there's a concern that the timeout will
> > prematurely fire on a regular systems then I'll gladly raise it up to a
> > minute or so. I just want to get an explicit failure instead of a
> > never-ending test.  
> 
> <nod>

I'd still like to see a timeout added, as a failed test (with timeout
msg) is IMO a far better outcome than an endless wait. Any objections if
I send a v2 patch with 60s timeout?

Thanks, David
