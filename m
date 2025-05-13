Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849261DD889
	for <fstests@vger.kernel.org>; Tue, 13 May 2025 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747112703; cv=none; b=BbMfufy//5y5jbK1oWF6RGGZWaeE/GAn3SmSJyjznM9gho7Q5CmuEZyclh2/lCfYgABPC7DObr3EfcA3Sci8oOdsKKdAsKnHmimjnRDAd+q+QCStGjP9qopS+klDLlpau5T27mfidLZlmP5Gl/II3NRTOoYYP10Dof2p2p19dfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747112703; c=relaxed/simple;
	bh=vqWWnLBxLJIKrnf+iT+a0vYzAHahcCSgLs4PjrCjrN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPuTftlnxhI2ooN7RLpn7ufOu2ssXk2oIpJrrx/pcZNr6NxvM08g9zQGphUsxDi62jWAr/BYhcyo6AafIWnGlbMN2MNddFynAKdEeY0d8i+/tAQVVP1Ngq1/NZF+yBkLzsWlcTfkiKY5sxhHkAQ8T3Rx1u0YLQQwmtRHpCqr7pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JyaTaMBA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EvCDBuOy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JyaTaMBA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EvCDBuOy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JyaTaMBA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EvCDBuOy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JyaTaMBA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EvCDBuOy"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7BB61F387;
	Tue, 13 May 2025 05:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747112699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1w0nmxjfSTrHPkRrAIU4rBHDXg60KKtX6FQe4+/vpsw=;
	b=JyaTaMBAr8UgiCtG5TXKyuD0ygVgrdyW21fCG64vncwJQHPyh276W3ftbpU9cl03qNHAru
	p7dZL0yVCkEpLaAfTZn/UwOo2GITgzu8PUEAU1807u9Q3WL1rxc3lR9WpT9M0I7LC2piCS
	gnT120gY8BGp0aJ/p++5d8zaJ1ke914=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747112699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1w0nmxjfSTrHPkRrAIU4rBHDXg60KKtX6FQe4+/vpsw=;
	b=EvCDBuOy22GeSrafV/M5tqGMSvpz3+q+Wz//0RpeFTH0kVyo81p9FUWJupj3Mrrf9GExvW
	2w5Evof8uwwnpZCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747112699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1w0nmxjfSTrHPkRrAIU4rBHDXg60KKtX6FQe4+/vpsw=;
	b=JyaTaMBAr8UgiCtG5TXKyuD0ygVgrdyW21fCG64vncwJQHPyh276W3ftbpU9cl03qNHAru
	p7dZL0yVCkEpLaAfTZn/UwOo2GITgzu8PUEAU1807u9Q3WL1rxc3lR9WpT9M0I7LC2piCS
	gnT120gY8BGp0aJ/p++5d8zaJ1ke914=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747112699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1w0nmxjfSTrHPkRrAIU4rBHDXg60KKtX6FQe4+/vpsw=;
	b=EvCDBuOy22GeSrafV/M5tqGMSvpz3+q+Wz//0RpeFTH0kVyo81p9FUWJupj3Mrrf9GExvW
	2w5Evof8uwwnpZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 511A81386D;
	Tue, 13 May 2025 05:04:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HDKSAvnSImhrLAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 13 May 2025 05:04:57 +0000
Date: Tue, 13 May 2025 15:04:47 +1000
From: David Disseldorp <ddiss@suse.de>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, Daeho Jeong
 <daehojeong@google.com>
Subject: Re: [PATCH v3] f2fs/013: test to check potential corruption on
 atomic_write file
Message-ID: <20250513150447.70f61c98.ddiss@suse.de>
In-Reply-To: <20250509060754.1677062-1-chao@kernel.org>
References: <20250509060754.1677062-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On Fri,  9 May 2025 14:07:54 +0800, Chao Yu wrote:

> This is a regression testcase to check whether we will handle database
> inode dirty status correctly:
> 1. mount f2fs image w/ timeout fault injection option
> 2. create a regular file, and write data into the file
> 3. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
> 4. write transaction data to the file
> 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> 6. meanwhile loop call fsync in parallel
> Before f098aeba04c9 ("f2fs: fix to avoid atomicity corruption of atomic
> file"), database file may become corrupted after atomic write while
> there is concurrent dirty inode flush in background.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>

Looks good.
Reviewed-by: David Disseldorp <ddiss@suse.de>
