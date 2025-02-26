Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419F9218AB4
	for <fstests@vger.kernel.org>; Wed, 26 Feb 2025 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580876; cv=none; b=HouaOG2JZ+dhd+BBgSxLXt9Xec5k72XBLaBf9mvqTLxOSxuHry0JnOsYOSxA1ZKk7nLH7qT/TzUDqTF6G1Nc1y+uU8AxjBbI7NBMgwC3eky8P7/zOoRkR97otefHTLixd9BJvv0gCLqpKGBA0QFCehcTuXo0WF1AQVoSDF7v4BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580876; c=relaxed/simple;
	bh=ay0u/XXcDCvLRQei7dNjtfMDxY+UcImMbvJUVIiDBCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNVa91l0T3h6ZrIxLcGsXBp28f3BiBYT4K+qF/T5Ph5gZKa9F1TrM0FFE+D+NjHO38cgrC7XBd3owy5nANQY2TmKVM7iXX08CWLeI+JIaU5TAm2cUty9l9fFsoOWjDkgfrWk3a4zN44BRHINW3viYCHY/bdoDKa/KeehphqlwYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X6kizwMk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w4YEm8dH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X6kizwMk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w4YEm8dH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X6kizwMk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w4YEm8dH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X6kizwMk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w4YEm8dH"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B2DA1F387;
	Wed, 26 Feb 2025 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740580873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SPzzTMd0g67/GZBaBmX/Lo8nG+z6Mp1KTlQ7wqbqLjs=;
	b=X6kizwMk0MenUewSuNSuHK7xgMUA9YLHWGTd+n72Ydcnv8bVzUq5BSTaGk1CAYGR3bZkn9
	207PM6FJVMnypHHNyayv85Gig2LthPDbW8rYGF8iaGoLtX/xVk0UBBw24iZHF0Xf6XU+Gs
	RLSEvVsfAINVnpn9nNUIFoktBYEXV9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740580873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SPzzTMd0g67/GZBaBmX/Lo8nG+z6Mp1KTlQ7wqbqLjs=;
	b=w4YEm8dHhKNJgp2AYVT4X283RD6H5WxQtsKuLDLVI5hC4MMSRt7WmZ6cNGKF7qiQ1+PL8F
	jBW2CdLZfoW598CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X6kizwMk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=w4YEm8dH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740580873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SPzzTMd0g67/GZBaBmX/Lo8nG+z6Mp1KTlQ7wqbqLjs=;
	b=X6kizwMk0MenUewSuNSuHK7xgMUA9YLHWGTd+n72Ydcnv8bVzUq5BSTaGk1CAYGR3bZkn9
	207PM6FJVMnypHHNyayv85Gig2LthPDbW8rYGF8iaGoLtX/xVk0UBBw24iZHF0Xf6XU+Gs
	RLSEvVsfAINVnpn9nNUIFoktBYEXV9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740580873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SPzzTMd0g67/GZBaBmX/Lo8nG+z6Mp1KTlQ7wqbqLjs=;
	b=w4YEm8dHhKNJgp2AYVT4X283RD6H5WxQtsKuLDLVI5hC4MMSRt7WmZ6cNGKF7qiQ1+PL8F
	jBW2CdLZfoW598CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C12A1377F;
	Wed, 26 Feb 2025 14:41:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PcmiBgkov2cuSQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 26 Feb 2025 14:41:13 +0000
Date: Wed, 26 Feb 2025 15:41:07 +0100
From: David Sterba <dsterba@suse.cz>
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, David Sterba <dsterba@suse.com>,
	fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: remove reiserfs support
Message-ID: <20250226144107.GU5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250219221743.20161-1-dsterba@suse.com>
 <20250220202238.6axqgejzk47aay3j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250220203751.GH5777@suse.cz>
 <20250221051902.e7ft6iuvahfvvyza@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250221105918.GJ5777@twin.jikos.cz>
 <20250221154531.ttch34qic7zsxyzv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221154531.ttch34qic7zsxyzv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 3B2DA1F387
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Feb 21, 2025 at 11:45:31PM +0800, Zorro Lang wrote:
> > This may bring the question what is the policy for filesystem support.
> > I've seen "case $FSTYP" with widely inconsistent cases of filesystems,
> > probably the longest list is in common/rc:_require_scratch_nocheck with
> > 9p, virtiofs, afs, pvfs2 or ubifs.  It would be good to document that in
> > README, I haven't found anything in that regard.
> 
> Good idea, maybe we should have a list about that.
> 
> There's not a limitation about what filesystems are supported or not.
> Especially the generic test cases, some "not in list" filesystems might
> run generic tests too. So we don't exclude any filesystem which wants
> to try fstests.
> 
> Generally when someone wants to help fstests to support a new filesystem,
> there're 3 phases:
> 1) Check if fstests can mkfs, mount, unmount and fsck on this fs natively.
>    If it can't, add the fs to the "case...esac" list, to do special treatment.
> 2) Run generic test case on the new fs, fix some test failures which are
>    not suitable for this fs.
> 3) Add more test cases for this fs, might need a new tests/$FSTYP directory
>    and more common helpers.
> 
> Actually some of filesystems which are "supported" by xfstests, just satisfy
> the phase#1, or a few phase#2. That depends on how deeply that fs list
> would like to use xfstests.
> 
> But everything is still changing. For example, we don't support nfs much,
> just in phase#1. But as more and more nfs folks start to use xfstests,
> it's good to run on nfs now, even reach to part of phase#3. In contrast,
> although cifs is in the list, and xfstests can be run on it, but too
> many test failures, no one from cifs would like to care about that.
> 
> So about the "support list", what's the standard to count in a fs :)

Thanks, this is useful, can you please add this text to the README?
