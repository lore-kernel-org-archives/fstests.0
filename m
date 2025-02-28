Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4225E471
	for <fstests@vger.kernel.org>; Fri, 28 Feb 2025 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746039; cv=none; b=b6uOjt0/GsKdeQh48H8rMmoqd6JdKdfjbdTqbbe1Gg4wIJe56jqEj1cZplrvJtrqR/y8QAljWZ2rtdBQN7Yf/0zS7u/OPPt3JSvwmHaS4HsZftdHX9QR9i1BGeGkLcCiHDW1tYk2y6lAoepbIIy03+5yYrAQg8V8WUJjn9lE9Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746039; c=relaxed/simple;
	bh=2HHrrrx4pAILF70wyqYcdGTDPpgzdn7C7Hn5zR9F5gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFENKsSXVKJh3WqQSZOT1cNeHXgZA/A2tr2lOtooGG6NoP+kgpPTt4KnfK2G3ZhU02PypLM9bB9vjwRqJveENFcwH06cYQNKLmC+IYExj/QgzgeeDtI2cyNn2dHhXKxWKqMjSpKosrjuRRWoRLofrEex9n4MAs1Vo8PJDBPlyBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YHSU2vji; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NRQkueU4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FRYkR6cr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C6M9Vm6v; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YHSU2vji";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NRQkueU4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FRYkR6cr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C6M9Vm6v"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ECF561F45A;
	Fri, 28 Feb 2025 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740746036;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t6qY2lel/r4iy38WL2bkEOqeG0zy190SAErqP6myVI0=;
	b=YHSU2vji3XCj1bg1/L8ypDy1hqzyMnX7bCn3t5EH9LfhaKpnDATZOUX2yiEjL67A/g21Rl
	lOmOLj+I/FBY6SXxEHJufcAlnIxRhQuPj+1VhgW6XViI+FB1aVL9ltGOzm2HH9jF10rras
	VpntXFSHOUtzUm75MuaZFfujpGANKgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740746036;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t6qY2lel/r4iy38WL2bkEOqeG0zy190SAErqP6myVI0=;
	b=NRQkueU46OW5S0CH5yi9Zc9gIb3kXgYd7Ab2CKHkjnNyI+3au1LEZ9qMLbBcFM9U6fyz+T
	PQxxraGUqrDLjgDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FRYkR6cr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=C6M9Vm6v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740746035;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t6qY2lel/r4iy38WL2bkEOqeG0zy190SAErqP6myVI0=;
	b=FRYkR6crHs8M+lsupQ7llrdXOdBHaclwx7QPws72ANJGZyVsJclheyKyuC+1enWW+7dfya
	1JOrHdbAE+avEKs9FbuyUtMyFWy8N/uyAWUe81VUr7hPvXm2rthe6hTVwRrpAwm8ZBPjyi
	5AyMmog1FZ4hSuPKjINDGCPnzjeyTzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740746035;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t6qY2lel/r4iy38WL2bkEOqeG0zy190SAErqP6myVI0=;
	b=C6M9Vm6v+eST8KJo+0kFdgH6pnTj1/PcUdQ8Sc6m6qb9lWkp719Xgk/tUdDkM4OW5VteuC
	LMTZppMjgZeQZEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB251137AC;
	Fri, 28 Feb 2025 12:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sYdINTOtwWeADgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 28 Feb 2025 12:33:55 +0000
Date: Fri, 28 Feb 2025 13:33:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
Message-ID: <20250228123354.GE5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c238e76631b086db592f214beaa6fd94@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c238e76631b086db592f214beaa6fd94@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: ECF561F45A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Sun, Feb 23, 2025 at 08:27:43PM +0800, Zorro Lang wrote:
> Hi all,
> 
> The for-next branch of the xfstests repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> has just been updated and tagged as v2025.02.23 release.
> 
> Release Notes:
> 1) There's not new test cases in this release, this's a release for bug fixes
>    particularly.
> 2) Reiserfs part is removed from fstests.
> 3) ltp/growfiles is removed too, I think no one needs it.
> 
> I can't list all updates at here, more details please refer to below.
> Thanks for all these contributions!
> 
> Thanks,
> Zorro
> 
> The new head of the for-next branch is commit:
> 
> 5b56a2d88819 fstests: remove reiserfs support
> 
> New commits:
> 
> Christoph Hellwig (1):
>       [04d0cf3f8909] generic/370: don't exclude XFS
> 
> Darrick J. Wong (35):
>       [cc379f50f3bd] generic/476: fix fsstress process management
>       [ab459c67c5e0] metadump: make non-local function variables more obvious
>       [f428edcec2a2] metadump: fix cleanup for v1 metadump testing
>       [e68a92376165] generic/019: don't fail if fio crashes while shutting down
>       [48a3731b50ba] fuzzy: do not set _FSSTRESS_PID when exercising fsx
>       [543795bf67f2] common/rc: revert recursive unmount in _clear_mount_stack
>       [777732b27e62] common/dump: don't replace pids arbitrarily
>       [81f28acda2f2] common/populate: correct the parent pointer name creation formulae
>       [9b177d92dc65] generic/759,760: fix MADV_COLLAPSE detection and inclusion
>       [241c1c787e5b] generic/759,760: skip test if we can't set up a hugepage for IO
>       [77548e6066fd] common/rc: create a wrapper for the su command
>       [ac2d48f81094] fuzzy: kill subprocesses with SIGPIPE, not SIGINT
>       [c71349150d34] common/rc: hoist pkill to a helper function
>       [91d2880aa029] tools: add a Makefile
>       [88d60f434bd9] common: fix pkill by running test program in a separate session
>       [247ab01fa227] check: run tests in a private pid/mount namespace
>       [949bdf8eae31] check: deprecate using process sessions to isolate test instances

I'm using a setup with a minimal VM system without systemd and such and
dedicate the whole machine to one instance. I'm not interested in the
check-parallel updates and test case separation. All fine if it is
supported and lets me continue using single instance.

But as I read it and the deprecation it's not going to be the supported
use case. After last week update of fstests 100% of cases failed in the
test setup (_seq_run). My workaround is to simply disable it by

check:
HAVE_PRIVATENS=
HAVE_SYSTEMD_SCOPES=

so I don't have to debug changes to the detection of the scope and
namespaces and after each for-next update. I understand that with a
custom system setup I'm on my own but until recently things have been
fine but now after each update either test cases fail or the whole test
infrastructure does not work.

It's not just me who observes that. It seems that BTRFS is not tested
before release as thoroughly as other filesystems (probably just XFS).
