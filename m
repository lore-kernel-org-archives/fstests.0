Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FBB47988D
	for <fstests@vger.kernel.org>; Tue, 18 Aug 2026 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062418; cv=none; b=NeoG+GlZ18XLIEDWOiauZSpm/Lx5mtV8HwyxPD9fHg8F7XJBE0ULeOmiU3naclebz5SSrqXtWg22s9xquQL+e9XanMv4KB4Px3QKUB1UwpLRdeDrcrRi3av4pH0R9tXXu0zJpSGDwaydZGaiwFW/oD+h8NKMvzvm4yHnTd+opyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062418; c=relaxed/simple;
	bh=Wk+VBaI4C3jjC6GdTE19ldM3BPARjT4g55N1bgBlN5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVwi8rBPw0veBxU9cEgaFNTBLICDQ+w5gsIcYSkdMENdAHIm5MlMlW0jaZviPZfj5WKb+hQUfhG/4+KeX48TqEmHTPCsS9QamX3Qv6rdU5zdPJnGvqd4K5FnWkGJ2nzGEUyAhtdfuVYX58C9fvckO+yaFhDUSRe5idf6VD9lLTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y+ezTdkw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=25TeWMQ5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gwE/2fUW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PWknC8EP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y+ezTdkw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="25TeWMQ5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gwE/2fUW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PWknC8EP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D5F43E03;
	Tue, 18 Aug 2026 14:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787062411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YZFrcVQ/8jEab/z3GO+9DB0olvuQ3UGXC8EgkiXpMkU=;
	b=Y+ezTdkwCtYwYnwEjsqTUB66DZAx/O5zH9W1h7M7rceK/WhQwCC3Ftzer7b6CCRAaYPhM7
	RNRSlUAaWZ06rS8yQ+IXRwMc0zoBQSzxnpTSU5/gweI8fgW9wqeMmLM6udwr8CUxtTHnwi
	mhRLIJfabPgpkRXpcCpz1aRTKaYJnwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787062411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YZFrcVQ/8jEab/z3GO+9DB0olvuQ3UGXC8EgkiXpMkU=;
	b=25TeWMQ5SPQeRVvJxGq3wE9eCrbgiGX3H3r7NZvMzn3Rw6cjTQfKI1hnQk/4h8bWLk+EFA
	b93AkTsTAimek/Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787062407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YZFrcVQ/8jEab/z3GO+9DB0olvuQ3UGXC8EgkiXpMkU=;
	b=gwE/2fUWSo1E3JvK/ETUPFnu4M9FZ0hDy37pvnM2ljoVncZCmAyHlA8ghixiVSdxRddiaV
	taD3/3c8NWRLkzYDwmalif6VGUA567a9XGpKQmz1/tHJvlXShoQ+1Ie9Klelqww2njBAx8
	6BdnEUxxjVYUP8RZNWf6lIn2mpbKSIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787062407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YZFrcVQ/8jEab/z3GO+9DB0olvuQ3UGXC8EgkiXpMkU=;
	b=PWknC8EPjeRaGf/qIdL/N7Cbz5YWzLnM8MbWWcEy7t9bw5U0PSQgf8LnNdfmho2rWRN4TZ
	RASCWdOJpgHP4hCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33594362E;
	Tue, 18 Aug 2026 14:13:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gqd9DIdohGoIcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 18 Aug 2026 14:13:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C2005A13AB; Tue, 18 Aug 2026 16:13:26 +0200 (CEST)
Date: Tue, 18 Aug 2026 16:13:26 +0200
From: Jan Kara <jack@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/347: Fix sporadic test failures
Message-ID: <vrvi6rqzklajkzyon4c6fl63gm6mdjolr27bbzdtslq7pp3qik@ubmqf4z7sddh>
References: <20260730151817.4120874-1-jack@suse.cz>
 <any5dTHB0lLr40Id@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <any5dTHB0lLr40Id@zlang-mailbox>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu 13-08-26 02:23:36, Zorro Lang wrote:
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
> 
> Since there're no further review comments/objections so far, I'll merge this
> patch with one small addition: "_require_xfs_io_command falloc".
> 
> Reviewed-by: Zorro Lang <zlang@kernel.org>

Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
