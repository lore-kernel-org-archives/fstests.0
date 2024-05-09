Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA23175571
	for <fstests@vger.kernel.org>; Thu,  9 May 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272142; cv=none; b=VtEgMWX+YjBOInxvsGTyRPAdPpFOpqRvdFwlf3VKXNoixkw8wlXtEILwrB7BnHF/27f7wPGK3jm2/mBi1MPQRg3TaSqXi+SJg15Pz85d3uLRuqEBnGXC3A8Rh4SFYM770LqJg5ol/7pOIZeCHcpnhKDzOBqhiSmM10Xzg9vILvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272142; c=relaxed/simple;
	bh=+2OzIjUjjOfKej9rLlyuOwAn/ixvMZjqRTsytE0W4gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzbZqqkehvzwAGNatht5J0dFS1Vv3+rR36WsWZxgoFEBPgfdNtsCt/5HMmsHn5bQWC+rtyzLe9TI/SsgD/KwGwE4f5Uxyym3vPL95Ck9H+IbC9ri+GIwRq5EJpr1+ZwMtEwx0PQ0vH9Yi8jpOKirmxcMvPdBx+/GOhWXJtqs72Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ARfDklyH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fja2ESbB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ARfDklyH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fja2ESbB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ARfDklyH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fja2ESbB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ARfDklyH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fja2ESbB"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B8273893C;
	Thu,  9 May 2024 16:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715272138;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cI1q+5cHlv2PD5hvKMRTmJPh0ljcvpn7qcMxiSH2Vg=;
	b=ARfDklyH0povMgkTSDAWjqhHA6WbA5+GG/TTXY6XoylB6B9qMGmLCUPyZoG0bTA8TIyV/v
	McYjhSomwDSxpsebchZqtXC5QzkRYn+hu1f1QFX0jhOcCKNVeI2W/aUbgjOibI0IR2sU3r
	Dz+VbeJDWGCt8gPq71vdUqR3MeIMKLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715272138;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cI1q+5cHlv2PD5hvKMRTmJPh0ljcvpn7qcMxiSH2Vg=;
	b=fja2ESbBFoq/L0tywUk1pN2X4vsJCikZd0naWUPvuaMqzDsX1VSbRztkHqCjFi+kiYw7HZ
	XW4M0JFhIWKbbyBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715272138;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cI1q+5cHlv2PD5hvKMRTmJPh0ljcvpn7qcMxiSH2Vg=;
	b=ARfDklyH0povMgkTSDAWjqhHA6WbA5+GG/TTXY6XoylB6B9qMGmLCUPyZoG0bTA8TIyV/v
	McYjhSomwDSxpsebchZqtXC5QzkRYn+hu1f1QFX0jhOcCKNVeI2W/aUbgjOibI0IR2sU3r
	Dz+VbeJDWGCt8gPq71vdUqR3MeIMKLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715272138;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cI1q+5cHlv2PD5hvKMRTmJPh0ljcvpn7qcMxiSH2Vg=;
	b=fja2ESbBFoq/L0tywUk1pN2X4vsJCikZd0naWUPvuaMqzDsX1VSbRztkHqCjFi+kiYw7HZ
	XW4M0JFhIWKbbyBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E0FB13941;
	Thu,  9 May 2024 16:28:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N/iGIsr5PGa8JAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 09 May 2024 16:28:58 +0000
Date: Thu, 9 May 2024 18:28:55 +0200
From: David Sterba <dsterba@suse.cz>
To: Zorro Lang <zlang@redhat.com>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 0/4] Move test cased from shared to generic
Message-ID: <20240509162855.GI13977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715108589.git.dsterba@suse.com>
 <20240509052901.dna2xq3yd4p2b7m3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509052901.dna2xq3yd4p2b7m3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[]

On Thu, May 09, 2024 at 01:29:01PM +0800, Zorro Lang wrote:
> On Tue, May 07, 2024 at 09:07:28PM +0200, David Sterba wrote:
> > Hi,
> > 
> > as discussed recently, the tests in shared should be in generic.
> > 
> > Based on branch patches-in-queue, commit e098483c662d8f0b7583edca1501d8addd3b7549.
> > 
> > David Sterba (4):
> >   Move shared/298 to generic/740
> >   Move shared/002 to generic/745
> >   Move shared/298 to generic/746
> 
> Thanks David! There're two shared/298 above, I think the former is shared/032 :)

I noticed the wrong subject of patch before sending and updated the
patch manually but not the summary in the cover letter.

> And I foundd that all .out files were not changed properly, so I suppose you
> did that manually. The "mvtest" tool will help you, e.g.
> 
> # ./tools/mvtest shared/032 generic/740
> # ./tools/mvtest shared/002 generic/745
> # ./tools/mvtest shared/298 generic/746

I didn't know such tool exist so yeah I forgot to update the .out too.
Do you want a resend or can you fix that when committing?
