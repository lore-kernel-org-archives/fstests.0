Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1957554BCA
	for <fstests@vger.kernel.org>; Wed, 20 Mar 2024 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948861; cv=none; b=iB0BQAvGnm2IrmqyAsTMLgIKQK9nFhI1xwkkds3zdqp8FmaFuqbRrmErWSmZf4Si9Iy+YU8t2XTTNlXigqbyhyzQjjFhZrDXXKh0pkC+1roicnZKeYfEug+CLY9vusv4AGu2ThxFpdwbiuvklBF4ZDyadFQByeQwQlMMGuFgbJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948861; c=relaxed/simple;
	bh=IobDSOtJXN0NlUz7Ab9+xbg9/jGC5/3KxGWBpusLR/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQqRgyONpk3mC2stVJc+vaP8P7ghw/vBfy1pxz+BRZe5I15X3ZB6xSJx+SAs7GhLUSfbxCUeu3DJ9th7diyMM2yLUYkExD4/cbFM3pC6CjbDqDDjEQyPKZgZF99Fw661QF6cww918pE+vasrlJcODbyJTUSwYI1eoFTUgQeBfZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1pnGcnvw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FZANjgAB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1pnGcnvw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FZANjgAB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1pnGcnvw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FZANjgAB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1pnGcnvw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FZANjgAB"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21624346F7;
	Wed, 20 Mar 2024 15:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710948858;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0VpEoc1dSxvnYkjxPQxYsQcCNX1TNGpaw6RCae/P4Is=;
	b=1pnGcnvwQqcXkAE/+3+/f+DjKQxj+dho1iEM9aWCUISDORA5rISDsg3Ogyfl7P+da++nXv
	Nh/Rdwpc13i93zC+GqSBLHpmzXedsUSUz+JEh1Nnkd0MZLzdFmb/HzBgbU4vaw2i1O9QER
	zsqdAONMPPEayvvxOKdSeFc/im4Rxqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710948858;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0VpEoc1dSxvnYkjxPQxYsQcCNX1TNGpaw6RCae/P4Is=;
	b=FZANjgABO0/OffMhwBMRMDGvQ9cY2KsG5dr+vToHEaRiKQ6/Kw8dOB+tzvbCgVmb1SQf+t
	iFM3sUn/7BuESOCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710948858;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0VpEoc1dSxvnYkjxPQxYsQcCNX1TNGpaw6RCae/P4Is=;
	b=1pnGcnvwQqcXkAE/+3+/f+DjKQxj+dho1iEM9aWCUISDORA5rISDsg3Ogyfl7P+da++nXv
	Nh/Rdwpc13i93zC+GqSBLHpmzXedsUSUz+JEh1Nnkd0MZLzdFmb/HzBgbU4vaw2i1O9QER
	zsqdAONMPPEayvvxOKdSeFc/im4Rxqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710948858;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0VpEoc1dSxvnYkjxPQxYsQcCNX1TNGpaw6RCae/P4Is=;
	b=FZANjgABO0/OffMhwBMRMDGvQ9cY2KsG5dr+vToHEaRiKQ6/Kw8dOB+tzvbCgVmb1SQf+t
	iFM3sUn/7BuESOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15835136CD;
	Wed, 20 Mar 2024 15:34:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CuEeBfoB+2UwVgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 20 Mar 2024 15:34:18 +0000
Date: Wed, 20 Mar 2024 16:26:59 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 0/5] Btrfs fstests fixups and updates
Message-ID: <20240320152659.GC14596@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1710871719.git.dsterba@suse.com>
 <1ff88b4e-1bef-47ef-9384-5a1708ebbfae@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ff88b4e-1bef-47ef-9384-5a1708ebbfae@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1pnGcnvw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FZANjgAB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.60 / 50.00];
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
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 BAYES_HAM(-0.39)[77.38%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -1.60
X-Rspamd-Queue-Id: 21624346F7
X-Spam-Flag: NO

On Wed, Mar 20, 2024 at 03:19:12PM +0530, Anand Jain wrote:
> On 3/19/24 23:41, David Sterba wrote:
> > Hi,
> > 
> > a few more fixup from our repository.  They have been in our CI branch
> > and consider them tested and working for our needs. All of them are
> > btrfs-specific and will not affect other filesystems.
> > 
> > Please apply, thanks.
> > 
> > David Sterba (2):
> >    common/rc: use proper temporary file path in _repair_test_fs()
> >    generic/733: disable for btrfs
> > 
> > Josef Bacik (3):
> >    common/verity: use the correct options for btrfs-corrupt-block
> >    btrfs/131,btrfs/172,btrfs/206: add check for block-group-tree feature
> >      in btrfs
> >    btrfs/330: add test to validate ro/rw subvol mounting
> > 
> 
> Which repo base is this from? Fails to apply without conflicts.

I used for-next (ec5b77f70e602b2312) as a base as it was most up to
date, unlike patches-in-queue.
