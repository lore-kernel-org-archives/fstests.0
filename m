Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC78331222
	for <fstests@vger.kernel.org>; Mon,  3 Aug 2026 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756034; cv=none; b=t5guJlVrjlOT+mYBY53nxnh5cpiODCE2qMgqnGVxShOGjce5P+GdRjnpAHaIHTfUsAMdNzikpDC2PrQ00gfOyNkoXI0mCXqZjU3x1mudAgs3DCkvDvlXwf9Nu3EQRDS5+vrHUwI2HN05DAWcDTUZViWfiaz93XOCbCur53W58bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756034; c=relaxed/simple;
	bh=4XEprGjkC20siQ3LZonvEtPYFICVqXUTCjWhwi+g8Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiaBJS6mfH/MXOEpEm3cF3Inqn4nQWFeFGqEQk4LhlFBkPOxX+SaZSNUNxmRyjCResgZUD5Mu251KzveiSQ6nfjmFpFKq9XywZ7WmRSiAEvtYxsUyAtOKjBGt4o9VErBHNCKYRH9xO7H9wXHeN1A2eJZEnC8zchPSxUiCEQG1zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EyhSDft+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h9axmSy+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qDwCB8jc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wau2IzLJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EyhSDft+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h9axmSy+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qDwCB8jc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wau2IzLJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 324207F06D;
	Mon,  3 Aug 2026 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785756027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fesia4adlqEbsTmYy6ULVrgUXS9fQ0uEN++x+srhBJ4=;
	b=EyhSDft+JKnKsab3yji8Rgv1VOUM0r8h+yjH6yakBS0NB5FHzESC8yNIsl45SLu9zCi93n
	Eo8WGG9Cad0w8Fm8g7B4l/rkDb005EnAxqzSRj5mVWelPVc//yoQkvDJt93Ao0Tj9PH84F
	/PrDHwqVU7iA6jj1o78V22WbWFYDI58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785756027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fesia4adlqEbsTmYy6ULVrgUXS9fQ0uEN++x+srhBJ4=;
	b=h9axmSy+Tjk0EyUx25Ya/6p7e0SI+IWf6jpjaNrRx2bDmFQX9SUx+jchI54n7KWwVAh8CM
	1eC2X34xQEYMnbDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qDwCB8jc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wau2IzLJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785756023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fesia4adlqEbsTmYy6ULVrgUXS9fQ0uEN++x+srhBJ4=;
	b=qDwCB8jcvK3/Ac/TqZx2S4ekB6xWGbi/HQ0hU2jKvrFA5YpWz5sUzINv/2Ly4bB9ql/poE
	PJQqrPhpAzhfO9O9ZJqEGE3/34ayQaE4xNw+bEu2T+z3xu5D48NBy3VoZhLYMV1L4fULAi
	W7G5G7PfPAYzo5SbSMyYGScFV12XlO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785756023;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fesia4adlqEbsTmYy6ULVrgUXS9fQ0uEN++x+srhBJ4=;
	b=wau2IzLJ0+pHyBVeJnWpiMuVdnzI9zazjU8g6RYlGyUSvb3Gc30rdTw39pRCL89aYsR6sn
	KBR2tZAjZtAhpOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24D2D779A1;
	Mon,  3 Aug 2026 11:20:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WbyFCHd5cGoECQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Aug 2026 11:20:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BDA04A13A4; Mon, 03 Aug 2026 13:20:22 +0200 (CEST)
Date: Mon, 3 Aug 2026 13:20:22 +0200
From: Jan Kara <jack@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/347: Fix sporadic test failures
Message-ID: <w6jeuw6jilax7u646a6vdxqjpf7bioj4d7v4xdvh5bipitslbd@jby652g3gce5>
References: <20260730151817.4120874-1-jack@suse.cz>
 <anBNLS4JmtT8GHGu@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anBNLS4JmtT8GHGu@zlang-mailbox>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 324207F06D
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Hi Zorro!

On Mon 03-08-26 16:27:15, Zorro Lang wrote:
> On Thu, Jul 30, 2026 at 05:18:17PM +0200, Jan Kara wrote:
> > generic/347 was occasionally failing on ext4 in our QA due to ext4
> > aborting its journal when the filesystem on thinp device was overfilled.
> > I have tracked the problem down to journal checkpointing failing to
> > write a metadata block to its final location due to ENOSPC failure from
> > the thinp device. Modify the test to first preallocate blocks for the
> > files and remount the filesystem which practically makes sure all
> > involved metadata blocks were written and so their further modifications
> > will not fail.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  tests/generic/347 | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/347 b/tests/generic/347
> > index 06df0cf9eddc..56538c160392 100755
> > --- a/tests/generic/347
> > +++ b/tests/generic/347
> > @@ -38,7 +38,17 @@ _setup_thin()
> >  
> >  _workout()
> >  {
> > -	# Overfill it by a bit
> > +	# Preallocate space to avoid failure for metadata writeback
> > +	for I in `seq 1 500`; do
> > +		$XFS_IO_PROG -f -c "falloc 0 1M" $SCRATCH_MNT/file$I &>/dev/null
> 
> Thanks for this fix! Adding fallocate introduces an extra dependency via
> _require_xfs_io_command "falloc", which will limit some filesystems can
> run this test.

I agree the fix has some downsides. OTOH when I was thinking about it I've
concluded that filesystems where you realistically care about behavior on
thinp storage also do support fallocate. So I don't think this it's a
serious test coverage limitation but it's up for discussion.

> Additionally, since the underlying storage is a thinp device, I doubt
> `falloc 0 1M` actually triggers physical block allocation on the thin
> pool (correct me if I'm wrong). If so, I suspect this 1M * 500 preallocation
> might exhaust the 500M BACKING_SIZE prematurely (along with file system
> metadata overhead), similar to the pwrite loop below.

We do *not* want fallocate to trigger the data block allocation. It will
however modify all the relevant metadata blocks and subsequent unmount will
writeout these modified metadata which forces the physical block allocation
for the metadata which is what we need. Physical space for data blocks is
not reserved from thinp during fallocate so we should not run out of
backing device space during this loop.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
