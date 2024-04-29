Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B045B45017
	for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390255; cv=none; b=fbhlb6S04/mGw57FN2erCKExYNe1KmOFE+r4Y0dqK2yzbEJcdoSdDRNw+ygwMtD/R5Ikh42Qb1zQJw8dJkN6qRWbHjlpYQna7LxIUI7UWLbdUF6eYjSDIAAubsM1xvOcZ2aRhxycvEv9K0jTfS7Ua082cOJ2Jh2gU07MLD08kLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390255; c=relaxed/simple;
	bh=AZGVZHPOsqOTZuN1zYDqO1bwzLRpAH1iXr75ynExPYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNxvQ/Zx6PrHp4gqYADkionDQY0kRBnxmaUOkvizzsPnKFl/yhso9T0MoO6BBBXccZvgtoSUb3ViefmK/JcVy4e1DO0W4wjGsUmkdrXTUtkC3Rb5gEB5RJflaaGUwh9h4sAYv6CToBNf2H/4PymHPJfIpZtGibn5N1L1/iAUDbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HGl34HkD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jjL9ZAV5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HGl34HkD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jjL9ZAV5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HGl34HkD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jjL9ZAV5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HGl34HkD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jjL9ZAV5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4C4E225FD;
	Mon, 29 Apr 2024 11:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714390251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=weUtItYO0UjJZ1FU+2GnKZtp30F/mc/6jfNXcSLN6/c=;
	b=HGl34HkDBnrAWLu5X7DHnSoXATvMtgrxLuc7fI6q4P3l5fGD9OZnk8886q9VTAWTFMbo5x
	2cPKf2rgw3WK/d6mLC+FH9TgxY9OGyeB2olVa8SBG6VezNAUZbJFyonPwV7G6L+XqJ1hFR
	4mPU7iS0Gu7BbTWyRLT/NrD7tWV3g0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714390251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=weUtItYO0UjJZ1FU+2GnKZtp30F/mc/6jfNXcSLN6/c=;
	b=jjL9ZAV56ugG2L78qp8KRacmSV2fgdlXcYr8rDllTQ2o+riwMbsjJjKe1XEO/pvBXBXTIj
	OkFZLpxPtOhP+yAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714390251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=weUtItYO0UjJZ1FU+2GnKZtp30F/mc/6jfNXcSLN6/c=;
	b=HGl34HkDBnrAWLu5X7DHnSoXATvMtgrxLuc7fI6q4P3l5fGD9OZnk8886q9VTAWTFMbo5x
	2cPKf2rgw3WK/d6mLC+FH9TgxY9OGyeB2olVa8SBG6VezNAUZbJFyonPwV7G6L+XqJ1hFR
	4mPU7iS0Gu7BbTWyRLT/NrD7tWV3g0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714390251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=weUtItYO0UjJZ1FU+2GnKZtp30F/mc/6jfNXcSLN6/c=;
	b=jjL9ZAV56ugG2L78qp8KRacmSV2fgdlXcYr8rDllTQ2o+riwMbsjJjKe1XEO/pvBXBXTIj
	OkFZLpxPtOhP+yAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FF6F138A7;
	Mon, 29 Apr 2024 11:30:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m6dgDOqEL2b8SAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 29 Apr 2024 11:30:50 +0000
Date: Mon, 29 Apr 2024 21:28:45 +1000
From: David Disseldorp <ddiss@suse.de>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common/config: export TEST_DEV for mkfs.xfs
Message-ID: <20240429212845.0094c51c@echidna>
In-Reply-To: <20240428053717.qsvzt6jo7w32tfsh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240411063234.30110-1-ddiss@suse.de>
	<20240428053717.qsvzt6jo7w32tfsh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.65
X-Spam-Level: 
X-Spamd-Result: default: False [-3.65 / 50.00];
	BAYES_HAM(-2.85)[99.35%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email]

On Sun, 28 Apr 2024 13:37:17 +0800, Zorro Lang wrote:

> On Thu, Apr 11, 2024 at 04:32:33PM +1000, David Disseldorp wrote:
> > As of xfsprogs commit 6e0ed3d1 ("mkfs: stop allowing tiny filesystems")
> > attempts to create XFS filesystems sized under 300M fail, unless
> > TEST_DIR, TEST_DEV and QA_CHECK_FS environment variables are exported
> > (or a --unsupported mkfs parameter is provided).
> > 
> > TEST_DIR and QA_CHECK_FS are already exported, while TEST_DEV may only
> > be locally set if provided via e.g. configs/$HOSTNAME.config. Explicitly
> > export TEST_DEV to ensure that tests which call _scratch_mkfs_sized()
> > with an fssize under 300M run normally.
> > 
> > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > ---  
> 
> Actually, using "export" in xfstests/local.config for each parameter could
> help too.
> 
> The 2nd patch still has some disagreement, I'll merge this patch at first,
> as it's simple enough and got two RVBs.

Thanks. I'll send an updated 2/2 today following Darrick's suggestion of
_try_scratch_mkfs_sized $* || _fail
