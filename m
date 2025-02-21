Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830E420102C
	for <fstests@vger.kernel.org>; Fri, 21 Feb 2025 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740135564; cv=none; b=JSt7UNOf+Nm4nW3UE5qrdxMVl4KB+dmgPVo/nZ+m2lEk9mGb/GV+ezFW/KM1kYL4ij8A5zvSEF0pR5QcYHkcH2ngthD+JM/uwhqZaH+EkxD+0h4Ns6RvYPV2n1mcullvtCSwt8UvhrXLcSPDaN6jo4hDOus2KeE/1/G4mFZXltE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740135564; c=relaxed/simple;
	bh=PEYBx3lX2ksROxBIZC/rNCitIkQQN13gDt2aYjkFU+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPXgPOR5S37K2uBv5VDD7eqT461vEpw9dgiUPbcqLrVVMJOUECSGk5WpcFDUkuY9c194BtdP0pszPRUlaXQ3u7UggXgUkxpCqYsTCrApPN1IgqOwzkzF4x/ogMqxJxQlGpmJ4rdEGznaem1rdsYijN6cCKtLyHY125Jscta0EKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XYJBwufT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VgDKq5CS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XYJBwufT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VgDKq5CS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XYJBwufT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VgDKq5CS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XYJBwufT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VgDKq5CS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6290B1F813;
	Fri, 21 Feb 2025 10:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740135560;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NattjGdEXVVKfY+CmUPtGfn7f6F61abdpYG6eQVy8mQ=;
	b=XYJBwufTEWjvuHcoo6lgcZdY6QbAw1gylln1V+hOD+H6Zr+VoGPGxdzYbndqlMG18zrYPx
	r73NJ+td6LWnCnJH+KRG0DzzFL4eNi5b01GlPxYYmfq9MTTXdqtsfXXQ8J86btjtGo7nnD
	i4xECwT51loB/alihYG7AEZHLixgJ7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740135560;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NattjGdEXVVKfY+CmUPtGfn7f6F61abdpYG6eQVy8mQ=;
	b=VgDKq5CSEtWlhcy020lm84LaEL+gTMd+J4P27KJsb2oWeczaN2SfCNX68OPBpJksp5ZR/5
	bLUNPRSMWDJzTmDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XYJBwufT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VgDKq5CS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740135560;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NattjGdEXVVKfY+CmUPtGfn7f6F61abdpYG6eQVy8mQ=;
	b=XYJBwufTEWjvuHcoo6lgcZdY6QbAw1gylln1V+hOD+H6Zr+VoGPGxdzYbndqlMG18zrYPx
	r73NJ+td6LWnCnJH+KRG0DzzFL4eNi5b01GlPxYYmfq9MTTXdqtsfXXQ8J86btjtGo7nnD
	i4xECwT51loB/alihYG7AEZHLixgJ7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740135560;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NattjGdEXVVKfY+CmUPtGfn7f6F61abdpYG6eQVy8mQ=;
	b=VgDKq5CSEtWlhcy020lm84LaEL+gTMd+J4P27KJsb2oWeczaN2SfCNX68OPBpJksp5ZR/5
	bLUNPRSMWDJzTmDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B06913806;
	Fri, 21 Feb 2025 10:59:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id utfoDYhcuGeqQwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 21 Feb 2025 10:59:20 +0000
Date: Fri, 21 Feb 2025 11:59:19 +0100
From: David Sterba <dsterba@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Cc: David Sterba <dsterba@suse.cz>, David Sterba <dsterba@suse.com>,
	fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: remove reiserfs support
Message-ID: <20250221105918.GJ5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250219221743.20161-1-dsterba@suse.com>
 <20250220202238.6axqgejzk47aay3j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250220203751.GH5777@suse.cz>
 <20250221051902.e7ft6iuvahfvvyza@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221051902.e7ft6iuvahfvvyza@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 6290B1F813
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Feb 21, 2025 at 01:19:02PM +0800, Zorro Lang wrote:
> On Thu, Feb 20, 2025 at 09:37:51PM +0100, David Sterba wrote:
> > On Fri, Feb 21, 2025 at 04:22:38AM +0800, Zorro Lang wrote:
> > > On Wed, Feb 19, 2025 at 11:17:43PM +0100, David Sterba wrote:
> > > > The linux kernel removed Reiserfs support in 6.13 so remove it from the
> > > > tests as well.
> > > > 
> > > > Signed-off-by: David Sterba <dsterba@suse.com>
> > > > ---
> > > > 
> > > > Arguably reiser4 support could be removed as well as there's no recent
> > > > upstream activity.
> > > 
> > > Thanks for doing this :) But even with this patch, I still can find more
> > > "reiser*" related things as below. How about removing them all?
> > > 
> > > zorro@zlang-laptop:~/git/upstream/xfs/xfstests-dev$ grep -rsni reiser .
> > > ./common/config:330:export MKFS_REISER4_PROG=$(type -P mkfs.reiser4)
> > > ./common/config:390:       reiser4)
> > > ./common/config:391:            # acls & xattrs aren't supported by reiser4
> > > ./common/config:392:            echo $REISER4_MOUNT_OPTIONS
> > > ./common/config:443:       reiser4)
> > > ./common/config:444:            export MKFS_OPTIONS=$REISER4_MKFS_OPTIONS
> > > ./common/config:472:    reiser*)
> > > ./common/config:540:    reiser4)
> > > ./common/config:541:            [ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
> > > ./common/rc:1227:       ext2|ext3|ext4|reiser4|ocfs2)
> > > ./common/rc:1331:       reiser4)
> > > ./common/rc:1333:               $MKFS_REISER4_PROG $MKFS_OPTIONS -y -b $blocksize "$@" $SCRATCH_DEV \
> > 
> > This is reiser4, the reasoning would be different as it's an out-of-tree
> > module but still somehow developed so there's a chance somebody is using
> > it.
> 
> Sorry I saw you said "Arguably reiser4 support could be removed as well
> as there's no recent  upstream activity.", then removed reiser4 from
> generic/740 [1], so I thought you want to remove it too :)

Oh I see,

>  -     reiserfs|reiser4)
>  -             preop="echo y |"
>  -             preargs="-f"
>  -             ;;

this was not intentional, I mean to remove only the "reiserfs|" part.

This may bring the question what is the policy for filesystem support.
I've seen "case $FSTYP" with widely inconsistent cases of filesystems,
probably the longest list is in common/rc:_require_scratch_nocheck with
9p, virtiofs, afs, pvfs2 or ubifs.  It would be good to document that in
README, I haven't found anything in that regard.
