Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A422B9A7
	for <fstests@vger.kernel.org>; Tue, 21 May 2024 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316207; cv=none; b=tafAq0RhgRcWoZuvKscW0xqLp2G1cOfVtoalxSAdtVX3COpb/siRg3oZuGgU71U+UMk+LV1/Sl2jVybuBoyKWy2BaPCTW23wEkDXAOaDztgmxoHALey4RQpiqJDH3LVUpAqF8K90P4KwAmSnBgEP9l/3tQV0QPTAZpeHbApWQvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316207; c=relaxed/simple;
	bh=lCiPf7BHukCiIwrq9n1wBhdUyoJl1XciLrcb6fSIJ1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ud/0k9lLCQe1azJyHBeJd85XCm+kULsnp5tOorDqyndOmro5/SE9XEHPsMLMgRBMd6+byGoRRBk63W1BcbVIJBikqQ5+tWclPTrS1iKzUE1xM3xz1aZbeXFB1VbjtIj2JMk7FE4a0Hl/nfWo9LtXZS+O6vH4ccKsbZGiKPJuT/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kPfumN2w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lRkURuA0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZPRhPdmY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U3mSJL1o; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kPfumN2w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lRkURuA0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZPRhPdmY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U3mSJL1o"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD4CB5C357;
	Tue, 21 May 2024 18:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716316204;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qCmmJX758N2ckgfBFpLZ95+d90Y8IODAoKLGOVCc/w8=;
	b=kPfumN2wAMqDqs+z7HSQVHwoWo0rQyUzssmKGS6zpQGVAUB+fVS4YG9mUR2Wl38Kijru8p
	XDfACWNMT2DDl43SRYV6n/nYLRyt1y0LT612BDT0tNXpXJSKjOQ/3WD8geZSe9zwczED9t
	jg7riS4jFmYH7UDSe5WM+DQCQ427gbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716316204;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qCmmJX758N2ckgfBFpLZ95+d90Y8IODAoKLGOVCc/w8=;
	b=lRkURuA0Y8PMVY+pCw9ZniUlq8TG8/S9hQGErqWezGBfruNuwdBitfDMU5A55kNw6QalmA
	JwGkRXPS8pJFWRBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZPRhPdmY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=U3mSJL1o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716316203;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qCmmJX758N2ckgfBFpLZ95+d90Y8IODAoKLGOVCc/w8=;
	b=ZPRhPdmYqD7OwYpCSGa7CZRMw8PE0zmsWW0xQAezMuKvSQZBVJVHYQ3L5wDUCWsOK3W6wX
	xQh9hU/5Miqtas4ZdlmMSlqEv4eRlW9ScWuO9hwvNbZshALLVQ92wgAMgbbWyRDj2rbd/w
	k+4rotvof/hpAQ8vyJI+85k5MHd7BT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716316203;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qCmmJX758N2ckgfBFpLZ95+d90Y8IODAoKLGOVCc/w8=;
	b=U3mSJL1oUez6ScoUWO0ph10ib8qFrrlCYfuLpiCG0lMZSeShY5CYrdgM6pWNdQ+76IUtkB
	/0l7xkbkdwD+LGAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFEB013A1E;
	Tue, 21 May 2024 18:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EXHKKivoTGb7YAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 21 May 2024 18:30:03 +0000
Date: Tue, 21 May 2024 20:29:54 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org,
	josef@toxicpanda.com
Subject: Re: [PATCH 4/6] generic/269: require no compression
Message-ID: <20240521182954.GU17126@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715896529.git.dsterba@suse.com>
 <ea5a2c054381fccd48bdf5dd987247a0c6bd55fe.1715896529.git.dsterba@suse.com>
 <1ac790bb-4afa-417d-8e1e-e8539b48b8dc@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ac790bb-4afa-417d-8e1e-e8539b48b8dc@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CD4CB5C357
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]

On Tue, May 21, 2024 at 08:37:48AM +0800, Anand Jain wrote:
> On 5/17/24 06:12, David Sterba wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> > 
> > This is meant to test ENOSPC, but we're dd'ing /dev/zero, which won't
> > fill up anything with compression on.
> > 
> > Additionally we're killing dd and then immediately trying to unmount.
> > With compression we could have references to the inode being held by the
> > async compression workers, so sometimes this will fail with EBUSY on the
> > unmount.
> > 
> > Make it easier on us and just skip this if we have compression enabled.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   tests/generic/269 | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/tests/generic/269 b/tests/generic/269
> > index b7cdecd94f219a..6ee0cb04581632 100755
> > --- a/tests/generic/269
> > +++ b/tests/generic/269
> > @@ -11,6 +11,9 @@ _begin_fstest auto rw prealloc ioctl enospc stress
> >   
> >   # Import common functions.
> >   . ./common/filter
> > +
> > +_require_no_compress
> > +
> >   # Disable all sync operations to get higher load
> >   FSSTRESS_AVOID="$FSSTRESS_AVOID -ffsync=0 -fsync=0 -ffdatasync=0"
> >   _workout()
> 
> 
> Can we use _ddt to fill the file with partially compressible data?
> On a laptop, with compression, it takes 63s (otherwise 45s).
> If we're ok with this, I'll sort it out here. Git diff below.

Yeah the incompressible data would be better. According to the changelog
the async workers could block umount but I'm not sure this actually
happens, umount should wait until the IO is done and all inodes closed.
