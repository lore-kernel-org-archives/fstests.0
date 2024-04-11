Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F857F9
	for <fstests@vger.kernel.org>; Thu, 11 Apr 2024 01:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712800402; cv=none; b=LAYCRvwcTRkTZv5Z2T9DKb/XwHv5Ua5CAvmuD+mk8EU+YEs2T0DCfnmAU4swdBojmU6EU+MZFTXGMHD6k0dl/M+vHCqv+U7rUZFhpFU/o0Kk/6X+KrqTi91FZ4b6A97+CUIzkUyTmA9oVdeSn74Sy1/iOYqHK7q3WLJp0WgmdtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712800402; c=relaxed/simple;
	bh=k5YAWDhg1y/vYKMik1yWZtZ86FJZwSvxP72809MaOeA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkE6YCBo6r6rUSqKp+WwSjp64+D6eTXHdLp74BKLEvXUcDAcH7p3/JOmRhFFaCegqMC+Lj9+Goa4tPCbS2tSYYgRn4L2FyAqK3SoX30VO56lvaiT2i4okR0G8wzpPEAu38YzJocxXj95lFYqrP0ujVAZ0CiUvC4Z6xk1evv43PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aInnzxPM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MtDJtIvY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aInnzxPM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MtDJtIvY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aInnzxPM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MtDJtIvY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aInnzxPM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MtDJtIvY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2FBBA22DBE;
	Thu, 11 Apr 2024 01:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712800399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtL/LdKg/3s7bkuVeR5qPNDNY+Vnm1vecryRm9sepdw=;
	b=aInnzxPMQRNXgxSL+ibDKD3FkUrPjeKY+tfDIIId2+8kdA7g2Fdajq7XTWCUM23/s/W9ky
	9M3qbbCk2RnN1/LP+m+cu/1hWr5RPtBOE2x+eHs/wDkgBTC4gYEqrWQjSMoyrJWRYTa5VU
	GyJgmu1EhXqrToVJXo+hDAAqF6d2qE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712800399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtL/LdKg/3s7bkuVeR5qPNDNY+Vnm1vecryRm9sepdw=;
	b=MtDJtIvYmoFyXg/7VufMXWz+72Q5UF+TnzeKukxQ17OQ06SSOG1iTMLcOfCZYynFD2vnam
	3o5jmCEwlQF7A3Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712800399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtL/LdKg/3s7bkuVeR5qPNDNY+Vnm1vecryRm9sepdw=;
	b=aInnzxPMQRNXgxSL+ibDKD3FkUrPjeKY+tfDIIId2+8kdA7g2Fdajq7XTWCUM23/s/W9ky
	9M3qbbCk2RnN1/LP+m+cu/1hWr5RPtBOE2x+eHs/wDkgBTC4gYEqrWQjSMoyrJWRYTa5VU
	GyJgmu1EhXqrToVJXo+hDAAqF6d2qE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712800399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtL/LdKg/3s7bkuVeR5qPNDNY+Vnm1vecryRm9sepdw=;
	b=MtDJtIvYmoFyXg/7VufMXWz+72Q5UF+TnzeKukxQ17OQ06SSOG1iTMLcOfCZYynFD2vnam
	3o5jmCEwlQF7A3Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E225E13929;
	Thu, 11 Apr 2024 01:53:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jrGCJI1CF2ZNVgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 11 Apr 2024 01:53:17 +0000
Date: Thu, 11 Apr 2024 11:53:10 +1000
From: David Disseldorp <ddiss@suse.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/027: use 300M FS to accommodate XFS limits
Message-ID: <20240411115310.6de56970@echidna>
In-Reply-To: <20240410152806.GH634366@frogsfrogsfrogs>
References: <20240410070720.9035-1-ddiss@suse.de>
	<20240410152806.GH634366@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.40 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.60)[81.76%];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -1.40
X-Spam-Flag: NO

On Wed, 10 Apr 2024 08:28:06 -0700, Darrick J. Wong wrote:

> On Wed, Apr 10, 2024 at 05:07:20PM +1000, David Disseldorp wrote:
> > As of xfsprogs commit 6e0ed3d1 ("mkfs: stop allowing tiny filesystems")
> > attempts to create XFS filesystems sized under 300M fail.
> > 
> > Lacking MIN_FSSIZE configuration, failure of _scratch_mkfs_sized() in
> > generic/027 doesn't halt the test, leading _scratch_mount() to mount any
> > previously created (full-size) filesystem. As a result create_file()
> > may loop near-endlessly awaiting ENOSPC.
> > 
> > Use a 300M sized filesystem to support XFS' limit, and explicitly check
> > for _scratch_mkfs_sized() failure to avoid endless loops if the limit
> > changes again in future.  
> 
> Hmmm.  Does your test environment export (as in, the bash keyword)
> TEST_DEV and TEST_DIR?  mkfs.xfs is supposed to detect fstests and allow
> sub-300M filesystems for testing.

Ah, I missed that getenv() logic in xfs_mkfs.

> The detection breaks if TEST_{DEV,DIR} are set but not exported in the
> config file; perhaps fstests ought to be exporting them like it does for
> the <cough> other detection key.

Yep, in my case I have a configs/$hostname.config environment and
common.config doesn't explicitly export TEST_DEV. I'll rework this
fix.
