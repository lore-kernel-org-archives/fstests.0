Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273604C9B
	for <fstests@vger.kernel.org>; Thu, 23 May 2024 00:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716424618; cv=none; b=H2Jy1mGS7bvW7yOMgFyKhERifitXF38kpEuwgVrbyDyEdZBrZe+cIOig8PmIAcrLesOLl96jjLBGMVRJIv3m7ctaD9clih9UZth7JlyEKMt37ZGW+0KV+7Hv2uWabuonWfSzkAGA/GxcToSJAG6QpSThW2EbKfa3rGwwGqGMKTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716424618; c=relaxed/simple;
	bh=b2pIDafdH7HU0o7ChymhgSNd8jHBxmaFsUxrdhYjY90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOQaBXxTzjRb9Qqgp7hxED6HOWoR/GGonFNKFZXwlHLo5146E42uln9sH7W2bvf3eZC9ltnUNSElBU7jw4Gaz/VJ2tkPFMLGFzEvuu+8mSK3lG604IE1cynh4KovaD9XTsnono17fSZqT0430rC35pEaLqOfyPfWXZ5iTYNQvbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gCY34S1P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eByt1+bf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gCY34S1P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eByt1+bf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gCY34S1P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eByt1+bf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gCY34S1P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eByt1+bf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 25F491FCDC;
	Thu, 23 May 2024 00:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716424614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txX8P5t5zN4/kcirsEPW7yPSc0w2w+8uilpsNM7dr0A=;
	b=gCY34S1Paaeq1BFxEtyuzHXNR36GteL3+ZbcCi+cIwltuNOnhP15CUumBSrAHplW3XWOU4
	T8T5twDi2om67MksF94brdNDJuw+17asQk4Qc5kJLCxMokPnfrDkDkt7gHAxnnmY2TY9Lx
	vlY04S0jMzsbYA3EFjuHsih8YZP04iI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716424614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txX8P5t5zN4/kcirsEPW7yPSc0w2w+8uilpsNM7dr0A=;
	b=eByt1+bfFjXUPDvofgQKcMLFCliRm0v5F9MU1sXLD7eMfrG5AtMRAO7qXUslJM6nNMhlYE
	mzVx0Qd52efHjCBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gCY34S1P;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eByt1+bf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716424614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txX8P5t5zN4/kcirsEPW7yPSc0w2w+8uilpsNM7dr0A=;
	b=gCY34S1Paaeq1BFxEtyuzHXNR36GteL3+ZbcCi+cIwltuNOnhP15CUumBSrAHplW3XWOU4
	T8T5twDi2om67MksF94brdNDJuw+17asQk4Qc5kJLCxMokPnfrDkDkt7gHAxnnmY2TY9Lx
	vlY04S0jMzsbYA3EFjuHsih8YZP04iI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716424614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txX8P5t5zN4/kcirsEPW7yPSc0w2w+8uilpsNM7dr0A=;
	b=eByt1+bfFjXUPDvofgQKcMLFCliRm0v5F9MU1sXLD7eMfrG5AtMRAO7qXUslJM6nNMhlYE
	mzVx0Qd52efHjCBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDF8F13A6B;
	Thu, 23 May 2024 00:36:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0V99GqSPTmajewAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 23 May 2024 00:36:52 +0000
Date: Thu, 23 May 2024 10:36:45 +1000
From: David Disseldorp <ddiss@suse.de>
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] Remove richacl support
Message-ID: <20240523103645.3c8fa90e@echidna>
In-Reply-To: <20240522173048.30558-1-dsterba@suse.com>
References: <20240522173048.30558-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.98 / 50.00];
	BAYES_HAM(-2.98)[99.89%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 25F491FCDC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.98

On Wed, 22 May 2024 19:30:48 +0200, David Sterba wrote:

> There's no support for richacl in Linux and based on information in the
> links will never be. Remove all related files and support code.
> 
> References:
> - https://wiki.samba.org/index.php/NFS4_ACL_overview#Linux
> - https://lwn.net/Articles/661357/ (article, 2015)
> - https://lwn.net/Articles/661078/ (patches, 2015)
> - https://github.com/andreas-gruenbacher/richacl/
> - http://www.bestbits.at/richacl/ (n/a anymore)
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Makes sense and looks good.

Reviewed-by: David Disseldorp <ddiss@suse.de>
