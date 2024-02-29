Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF61D160629
	for <fstests@vger.kernel.org>; Thu, 29 Feb 2024 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232719; cv=none; b=siiQmseBCJcx19LstvkYdcMFVtgUs8cOQxol2WDgLfOrJHo0NixzZyGUyAcoHC2MvmkRCQ9LdQOA5dxk33qySz3gEwvf3auLCOg5nFiVSch/J0tkrDX6uI6lY8dDGM1qe70BGddaShv8tLXRS8gxVK6uecH7NTEuYayrEj0v7lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232719; c=relaxed/simple;
	bh=Dhp6bpENI5/N7YQREct9czCOhoQWxyFqQmjkWHccRaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ed991pFQNOz0xf0Jhpc3LqZYfl2Bfn5yIsMFNuv26njYrn8LaDzfzk3PwYxs7q+zIao86NFyKLZvxiyWNc3gmBYE6c2+jxUUWmIhRFFT4h/npp5LERSLQ/OnKLINc8KlrSA3OZuUe8ZM5ykvk8SwpJvdO8WeH5OdJ+l0Ihh+K6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sUPsa2Wl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GXnrpW9H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sUPsa2Wl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GXnrpW9H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sUPsa2Wl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GXnrpW9H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sUPsa2Wl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GXnrpW9H"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 87B7721F1F;
	Thu, 29 Feb 2024 18:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709232715;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FlvGGlsnc80KSw4WXelHoYIc5Z7c0DE9Iy7c2u6AFM4=;
	b=sUPsa2WlbttGwR630WrSdHPMU2DCuNpShsm+3BothbhSm6lVh4I5rhUrIqyRlve2HmLlPj
	Mx841OuIjLd2UtB3+aoLBROwr/hDUGWrByGZ+/KhQtSyzVV62FEu1SBWneIvpoUfqzifPc
	enB38VmSXE8hJW+3sosDFMuJCMUrSZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709232715;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FlvGGlsnc80KSw4WXelHoYIc5Z7c0DE9Iy7c2u6AFM4=;
	b=GXnrpW9Hq1boisKoSUX/90C4O+i4Q3ezIMtfERaOHb6WPNd2A+UvVoe1KCtIgE4a7afm40
	yBDPMh2rRExF3nCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709232715;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FlvGGlsnc80KSw4WXelHoYIc5Z7c0DE9Iy7c2u6AFM4=;
	b=sUPsa2WlbttGwR630WrSdHPMU2DCuNpShsm+3BothbhSm6lVh4I5rhUrIqyRlve2HmLlPj
	Mx841OuIjLd2UtB3+aoLBROwr/hDUGWrByGZ+/KhQtSyzVV62FEu1SBWneIvpoUfqzifPc
	enB38VmSXE8hJW+3sosDFMuJCMUrSZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709232715;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FlvGGlsnc80KSw4WXelHoYIc5Z7c0DE9Iy7c2u6AFM4=;
	b=GXnrpW9Hq1boisKoSUX/90C4O+i4Q3ezIMtfERaOHb6WPNd2A+UvVoe1KCtIgE4a7afm40
	yBDPMh2rRExF3nCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FCA01329E;
	Thu, 29 Feb 2024 18:51:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id VVvrFkvS4GUBcwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 29 Feb 2024 18:51:55 +0000
Date: Thu, 29 Feb 2024 19:44:52 +0100
From: David Sterba <dsterba@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, zlang@redhat.com
Subject: Re: Dangerous commands (was:[ANNOUNCE] fstests: for-next branch
 updated to v2024.02.04)
Message-ID: <20240229184452.GB2604@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240221140951.GJ355@suse.cz>
 <20240221161358.GM6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221161358.GM6188@frogsfrogsfrogs>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sUPsa2Wl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GXnrpW9H
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 87B7721F1F
X-Spam-Level: 
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Wed, Feb 21, 2024 at 08:13:58AM -0800, Darrick J. Wong wrote:
> On Wed, Feb 21, 2024 at 03:09:51PM +0100, David Sterba wrote:
> > Hi,
> > 
> > reading [1] and how late it was found that effectively a "rm -rf /" can
> > happen makes me worried about what I can expect from fstests after git
> > pull. Many people contribute and the number for custom _cleanup()
> > functions with unquoted 'rm' commands is just asking for more problems.
> > 
> > [1] https://lore.kernel.org/all/20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> > 
> > Unquoted arguments in shell scripts is IMO a big anti-pattern,
> 
> That wasn't even the problem there.  I temporarily forgot my shellfu and
> did the equivalent of:
> 
> <never set FUBAR>
> 
> rm -rf "$FUBAR"*
> 
> The shell helpfully expands the never-set FUBAR to an empty string, then
> globs the star to everything in the current directory.  rm has
> safeguards to prevent you from "rm -rf /" but that offers no protection
> from what happens above.
> 
> The argument was quoted "properly", but what I think you're really
> asking for is "set -u":
> 
> #!/bin/bash -u
> 
> unset FUBAR
> echo -- rm -f "$FUBAR"*
> 
> $ /tmp/a.sh
> /tmp/a.sh: line 8: FUBAR: unbound variable
> 
> Unfortunately you can't just set that unconditionally for all of fstests
> and call it a day because now you have to test every line of shellcode
> to make sure nothing breaks on unset variables that would have been fine
> otherwise.  That turns into a mess of:
> 
> test -n "$FUBAR" && rm -f "$FUBAR"*
> 
> Oh but then there's the other bad shell habit of setting variables to
> the empty string -- sometimes you really want that empty string, other
> times authors seem to have used that in place of unset.  We've gotten
> away with that bit of bad hygiene for ages, likely due to -u being a
> nondefault option.
> 
> > unfortunately present everywhere in xfstests since the beginning.
> > Rewriting all scripts would be quite a lot of work, could you at least
> > provide safe versions of the cleanup helpers?
> 
> I worried about this a long time ago, and tried running shellcheck on
> the entire codebase.  Thousands of error messages about sloppy quoting
> later I gave up.  Later I turned that into a patch in djwong-wtf that
> runs it only on the files changed by the head commit.
> 
> It **didn't notice** the cleanup error!  So that wouldn't have saved me.
> 
> Long term we ought to rewrite fstests in any language that isn't as much
> of a foot gun.  Or someone starts a project to set -e -u and deals with
> the massive treewide change that's going to be.

I see from your and Dave's response that the problems are known and that
everybody tried to fix it in some way. What I also see that it's kind of
futile so that people carry their patches in own branches for testing.
The amount of treewide changes is probably killing the idea or this
would have to be coordinated or done in sprints or idk.

> > For example:
> > 
> > _rm_tmp() {
> >     rm -rf -- $tmp
> 
> Um, isn't this /also/ an unquoted variable?

That was not the best example, I took the existing code and put a
wrapper but yeah quoting should have been there.

> I guess one could make safe(r) wrappers so at least rm won't get mixed
> up by dashes at the start of filenames:
> 
> _rm_files() {
> 	rm -f -- "$@"
> }
> 
> _rm_dirtree() {
> 	rm -r -- "$@"
> }
> 
> But then you do
> 
> moopath="foo bar"
> _rm_files $moopath
> 
> and we've lost the battle yet again.

Maybe if there are known patterns and helpers that avoid the unsafe
constructs this could be avoided. Then go trough all code, fix it one by
one and catch it in newly submitted code. It's too much handwaving now.
I think we'd know what to do but the questions are when and how to get
the changes merged.
