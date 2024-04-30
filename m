Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D4F623
	for <fstests@vger.kernel.org>; Tue, 30 Apr 2024 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714436725; cv=none; b=RjrnR41xIMUUTWL/UeES6vc5VvfENUNrcHPxoJ2Ac06K3FUUAiNKDtYdFxu/VJDYCVVrLzi2AJndzrUVXBAA+ikc4Kbm9bAmlZrDLUkMbYtbHfcq5XoGu9Hl75EQX5SyobV+C4TD9+Cl5MvLPixFAIUHr/GpPvyNFm496skgdUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714436725; c=relaxed/simple;
	bh=E7yeTsQ05YaKQnBQ++5sGcFFglnr1Eq0KvlRV+EUs7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhtGgRsH7tkK8Upyey6ibT9AkxIKLwg8dZCQz5bn3YIA5yx655h80aIu28VAUKmNUT7l05Jril53dQLidsgiO/zzv6z2aSva61lyY2u7/ZL+jtwPZDE6Vav0IINRydyh27b5f1bFLSYwcZYaMnCw0bS6yF0OAzwSwcfs5RCrpwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=horPz0+X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XxQ4GRhM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=horPz0+X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XxQ4GRhM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="horPz0+X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XxQ4GRhM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="horPz0+X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XxQ4GRhM"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 701251F79A;
	Tue, 30 Apr 2024 00:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714436720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9qADJVbY7IHPqLtvmsGihBptkOd9eYSS4aKaMED5HE=;
	b=horPz0+X0ECqcQPbjOHwHkY19HbIUii7WJJzKO0AVbWLFJ1bCRqWVv503rfUboHRbiOd40
	8ZUfR9jjD5+4pBL0W9sxOVcswy822CsfcD8fLbZEQv97GiCmQAt+F4j6t135xiozci1RV9
	hSxmjjkIqPjBv+BxDJRlsyMcLv1PK74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714436720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9qADJVbY7IHPqLtvmsGihBptkOd9eYSS4aKaMED5HE=;
	b=XxQ4GRhMeHtyjJN/FoL+l/LVGBXZAuM1NbJh7tHcsuCt4OlgSUNDBDZFZbDkUP3xtm5N/l
	9ST8TRQmJRXj5wCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=horPz0+X;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XxQ4GRhM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714436720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9qADJVbY7IHPqLtvmsGihBptkOd9eYSS4aKaMED5HE=;
	b=horPz0+X0ECqcQPbjOHwHkY19HbIUii7WJJzKO0AVbWLFJ1bCRqWVv503rfUboHRbiOd40
	8ZUfR9jjD5+4pBL0W9sxOVcswy822CsfcD8fLbZEQv97GiCmQAt+F4j6t135xiozci1RV9
	hSxmjjkIqPjBv+BxDJRlsyMcLv1PK74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714436720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9qADJVbY7IHPqLtvmsGihBptkOd9eYSS4aKaMED5HE=;
	b=XxQ4GRhMeHtyjJN/FoL+l/LVGBXZAuM1NbJh7tHcsuCt4OlgSUNDBDZFZbDkUP3xtm5N/l
	9ST8TRQmJRXj5wCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7B6213889;
	Tue, 30 Apr 2024 00:25:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D/H+HW46MGYOOgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 30 Apr 2024 00:25:18 +0000
Date: Tue, 30 Apr 2024 10:25:02 +1000
From: David Disseldorp <ddiss@suse.de>
To: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH v3] tests: _fail on _scratch_mkfs_sized failure
Message-ID: <20240430102502.3167c16a@echidna>
In-Reply-To: <20240429190244.lr2xg74pzk2erwji@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240429153751.23515-1-ddiss@suse.de>
	<20240429160516.GD360908@frogsfrogsfrogs>
	<20240429190244.lr2xg74pzk2erwji@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 701251F79A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.01

On Tue, 30 Apr 2024 03:02:44 +0800, Zorro Lang wrote:

> On Mon, Apr 29, 2024 at 09:05:16AM -0700, Darrick J. Wong wrote:
...
> > > +_scratch_mkfs_sized()
> > > +{
> > > +	_try_scratch_mkfs_sized $* || _fail "_scratch_mkfs_sized (size=${1}) failed"  
> > 
> > I wonder if you ought to dump all the arguments, but the maintainer did
> > say to print the *size*. :)  
> 
> Sorry I didn't say that clearly, I mean the arguments related with size :-D

No worries :) I'm fine with it either way.

> 
> If both of you don't have more suggestions, I can help to change this line to:
> 
> _try_scratch_mkfs_sized $* || \
> 	_fail "_scratch_mkfs_sized failed with ($*)"
> 
> when I merge it.

Sure, works for me.

Cheers, David
