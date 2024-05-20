Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AA4134CC
	for <fstests@vger.kernel.org>; Mon, 20 May 2024 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232693; cv=none; b=GCyehaXg93k9dbe7fnxmKaXYrSUIpV2Lq3cMZ6CO2uWqwN5nRO2dg7KrEI1BcnbperoiWwVcnVdROqzgh/GHmtEalQy2GyP2i9F4tonXCHrJXFc3h2gWrivAEDA+ZLh6IHYlJ8cGFOkhHi8Vp/7bOb8B3ocEDrstL0SC4F6cKc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232693; c=relaxed/simple;
	bh=YgPOpc+hQuOhgzMhvwzfbQu7hzLyn9ED4+X+Pa/sjzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSq1g2u5JaexBuXGkUBi5QSA3kbPwb4R9CVHLR5hkH+Ao7X23Ac8JL3Idwn9XA6pGWwrPzskAxBrBqR1lwCOOG8wE4Q4UdTwg4F5odx6iZSZTxnKnOdnnobHq3jK163NVQBNkuQW3dBGWPFiaVqqLPDbXhmqnLR5lr8QiaclT4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oIdaZBDY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uUjlETEF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oIdaZBDY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uUjlETEF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oIdaZBDY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uUjlETEF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oIdaZBDY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uUjlETEF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2880921AEC;
	Mon, 20 May 2024 19:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716232689;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CS977Ql7iGQKyrJREY3DKh4ClzIgBsZcG59WJK6od+o=;
	b=oIdaZBDY2Vgyq7useTggRuU2Sl9V3FXgyRtgiCwSHyghH7qhiAcI3pL7C8YSk5IXF0H2Ji
	pUOgd4sd2ZQ/MiSTULNvjy9ylVv1btMZtxFlzVG/oJ5heiNNLOz8/TV/JyKOvM43xqcOS+
	hrssq/yq13RGuCWYTqcNWNkyQghq+Kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716232689;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CS977Ql7iGQKyrJREY3DKh4ClzIgBsZcG59WJK6od+o=;
	b=uUjlETEFkoCEZJ793G7l60f/Z7+siiaRr4wdvlSVvk7MLZKsi46pRVOLarFd7L1gaFpDn3
	AKBqttZo+1KZfbBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oIdaZBDY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uUjlETEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716232689;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CS977Ql7iGQKyrJREY3DKh4ClzIgBsZcG59WJK6od+o=;
	b=oIdaZBDY2Vgyq7useTggRuU2Sl9V3FXgyRtgiCwSHyghH7qhiAcI3pL7C8YSk5IXF0H2Ji
	pUOgd4sd2ZQ/MiSTULNvjy9ylVv1btMZtxFlzVG/oJ5heiNNLOz8/TV/JyKOvM43xqcOS+
	hrssq/yq13RGuCWYTqcNWNkyQghq+Kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716232689;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CS977Ql7iGQKyrJREY3DKh4ClzIgBsZcG59WJK6od+o=;
	b=uUjlETEFkoCEZJ793G7l60f/Z7+siiaRr4wdvlSVvk7MLZKsi46pRVOLarFd7L1gaFpDn3
	AKBqttZo+1KZfbBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 016FB13A6B;
	Mon, 20 May 2024 19:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XR93O/ChS2YgRwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 20 May 2024 19:18:08 +0000
Date: Mon, 20 May 2024 21:18:03 +0200
From: David Sterba <dsterba@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org,
	josef@toxicpanda.com
Subject: Re: [PATCH 5/6] btrfs/011: mkfs the scratch dev before exiting
Message-ID: <20240520191803.GG17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715896529.git.dsterba@suse.com>
 <19804c4e3c319678768d5d24a15b000e05dd0af2.1715896529.git.dsterba@suse.com>
 <20240517153754.GJ360908@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517153754.GJ360908@frogsfrogsfrogs>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2880921AEC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Fri, May 17, 2024 at 08:37:54AM -0700, Darrick J. Wong wrote:
> On Fri, May 17, 2024 at 12:12:50AM +0200, David Sterba wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> > 
> > When testing encryption I started getting failures because the scratch
> > dev didn't have a valid fs at the end of the test.  This is because for
> > encryption we have to disable raid5/6, which changes how the test is
> > run.
> > 
> > Normally with raid6 we end up cancelling the device replace, and thus
> > $SCRATCH_DEV has a valid file system on it.  However with raid5/6
> > disabled we end with a normal DUP profile, and the replace doesn't end
> > up cancelled, so $SCRATCH_DEV is wiped.  Then when the test finishes we
> > do the normal fsck and see that there's no fs on the $SCRATCH_DEV and
> > error.
> > 
> > This test does all the fsck'ing during the workout period, so we don't
> > need the final scratch check, simply re-make the $SCRATCH_DEV at the end
> > as it could have been replaced during the test.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  tests/btrfs/011 | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/tests/btrfs/011 b/tests/btrfs/011
> > index bf63a72b11c42f..d99624fb941cce 100755
> > --- a/tests/btrfs/011
> > +++ b/tests/btrfs/011
> > @@ -258,6 +258,11 @@ for t in "-m single -d single:1 no 64" \
> >  	fi
> >  done
> >  
> > +# If we exclude certain RAID profiles we can end up where the scratch dev
> > +# doesn't have a valid fs on it because it was replaced during workout, so mkfs
> > +# the scratch device so we don't get _check_btrfs_filesystem errors
> > +_scratch_mkfs > /dev/null 2>&1
> 
> /me wonders why the_require_scratch_nocheck at the top doesn't shut off
> the post-test fsck?

I think Josef did this when adding encryption support and tests and had
a reason for that, but I don't know why or what was the error.  This
patch can be skipped in case the rest is OK, we'll keep in our local
branch and reevaluate it again before sending.
