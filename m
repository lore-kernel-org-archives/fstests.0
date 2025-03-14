Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705B1FF5E9
	for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964784; cv=none; b=QqwsOcQw2LZ862mq8uieAPfQCRo2mxZozjpaNXgYXpT4DMPmdNLkjP8NpWGzX+crva9MsXOrT602zHOfDGjiNu+YMOlUmCkXcCrOVa/Tds9sfrkaZOJdhXQ3i7PdO55ESE41K7Pwt53VXKWQS1njgPYaKSyHrVNcU4TTaaew+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964784; c=relaxed/simple;
	bh=3i/+zkv/0t+qnSudfE+eb2qosqR0GH1TXASbHru+IuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhlx03/bSBNOZwU8glEXUWjXnDvTv0Q7F8ysqmET+q92e3ACJMxMh8cEjaj3JBOHP/z02fccw29nX8PO4fQ6KMVsxzFepqcco8l8D9LCZhawb5Yn3XcPBD2Whic1XOMV0JKDHIvvZTaSUiDPCyPsyCTGfJ+vUq2chk+5wAfQLxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aW06apWM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3PxMp2+E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aW06apWM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3PxMp2+E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aW06apWM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3PxMp2+E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aW06apWM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3PxMp2+E"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D47E21180;
	Fri, 14 Mar 2025 15:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741964781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5RLMhVKcxQ0sio5n4ZBDKknkihO1xS/j4Mrk1hl8ZC4=;
	b=aW06apWM8EgEdcXuTvnIJ6F/8Og+q5TMLQ44BpOWkDirsK4aiOwRPY67+zsuLUGS3E5eNz
	sdfZOLD746vD5U+ygdtvky8/CAOyhpjQGW0pCky1csW1mrJl+3qQJ7h8II+/Qb6XzCY9A8
	r7GhzldC9oox4hI2xWnkKuDWkknAaNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741964781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5RLMhVKcxQ0sio5n4ZBDKknkihO1xS/j4Mrk1hl8ZC4=;
	b=3PxMp2+E4ArwI4YKoeDvKPjHN08p86WKm4f/Kznge7acF28d5ol3ppatDK2cNhgTMLK7CB
	ofWlSUEQ2R4ZGYCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aW06apWM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3PxMp2+E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741964781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5RLMhVKcxQ0sio5n4ZBDKknkihO1xS/j4Mrk1hl8ZC4=;
	b=aW06apWM8EgEdcXuTvnIJ6F/8Og+q5TMLQ44BpOWkDirsK4aiOwRPY67+zsuLUGS3E5eNz
	sdfZOLD746vD5U+ygdtvky8/CAOyhpjQGW0pCky1csW1mrJl+3qQJ7h8II+/Qb6XzCY9A8
	r7GhzldC9oox4hI2xWnkKuDWkknAaNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741964781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5RLMhVKcxQ0sio5n4ZBDKknkihO1xS/j4Mrk1hl8ZC4=;
	b=3PxMp2+E4ArwI4YKoeDvKPjHN08p86WKm4f/Kznge7acF28d5ol3ppatDK2cNhgTMLK7CB
	ofWlSUEQ2R4ZGYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20321132DD;
	Fri, 14 Mar 2025 15:06:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mdqFB+1F1GedQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 14 Mar 2025 15:06:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B0DCBA09A8; Fri, 14 Mar 2025 16:06:16 +0100 (CET)
Date: Fri, 14 Mar 2025 16:06:16 +0100
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH RFC] fstests: test for CONFIG_QFMT_V2 in _require_quota
Message-ID: <lua7lxuzgq4x5eogyknefigdptcmgkfaawkny4xcinsrohi7m4@bjwt3mpwskf3>
References: <aaf2e2de-b337-4d7f-81fe-1aa8ef6b6b21@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf2e2de-b337-4d7f-81fe-1aa8ef6b6b21@redhat.com>
X-Rspamd-Queue-Id: 2D47E21180
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 14-03-25 09:36:53, Eric Sandeen wrote:
> When CONFIG_QUOTA is enabled but CONFIG_QFMT_V2 is disabled in the
> kernel config, many quota tests on ext4 will fail in odd ways,
> when in fact they should be _notrun. Add a CONFIG_QFMT_V2 test to
> _require_quota() to catch this for filesystems that require it.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Yeah, makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Backstory:
> 
> I was handed a bunch of ext4 xfstests failures on a system which had
> (accidentally?) been built with CONFIG_QUOTA enabled, but with
> CONFIG_QFMT_V2 disabled. This led to lots of tests failing when in fact
> they should have _notrun due to lack of sufficient quota support, and
> the reason for the failure was not obvious.
> 
> I'm going to just admit that I get lost in the maze of
> quota kernel configs, mount options, and on-disk features:
> CONFIG_QFMT_V1, CONFIG_QFMT_V2, vfsold, vfsv1, vfsv2, usrjquota,
> tune2fs -O quota, etc. I think that requiring CONFIG_QFMT_V2 might
> be a little bit heavy-handed here, but perhaps in the name of simplicity
> this change is reasonable, and I cc'd Jan in case he sees a better
> or more fine-grained approach, or if there are certain quota tests
> which should not require CONFIG_QFMT_V2, or if we should check for
> CONFIG_QFMT_V1 as well...
> 
> (Even on my old RHEL7 hosts, CONFIG_QFMT_V1 is disabled, so I don't think
> it's worth a separate check.)
> 
> There are a couple tests which oddly enough still succeed even with this
> kernel feature off - generic/234 for example. It does quotacheck and
> quotaon - the latter of which fails, but is ignored, then a bunch of
> setquota calls which succeed. I'm not sure what to make of that, I guess
> userspace can happily write to the quotafile without the kernel needing
> to understand it, but the kernel cannot do the accounting ...
> 
> generic/280 is similar.
> 
> So this change would _notrun those tests even though they only exercise
> setquota, and do not require kernel functionality. I'm not sure it's
> worth carving out special cases for them, though.
> 
> Thanks for listening ;)
> 
> diff --git a/common/quota b/common/quota
> index 3bf7d552..237fc115 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -5,7 +5,9 @@
>  # Functions useful for quota tests
>  
>  # checks that the generic quota support in the kernel is enabled
> -# and that we have valid quota user tools installed.
> +# and that we have valid quota user tools installed, as well as
> +# support for the modern on-disk quota format kernel config
> +# for filesystems that require it.
>  #
>  _require_quota()
>  {
> @@ -16,6 +18,7 @@ _require_quota()
>  	if [ ! -d /proc/sys/fs/quota ]; then
>  	    _notrun "Installed kernel does not support quotas"
>  	fi
> +	_require_kernel_config CONFIG_QFMT_V2
>  	;;
>      gfs2|ocfs2|bcachefs)
>  	;;
> diff --git a/tests/ext4/053 b/tests/ext4/053
> index 4f20d217..45747317 100755
> --- a/tests/ext4/053
> +++ b/tests/ext4/053
> @@ -46,7 +46,6 @@ _require_loop
>  _require_command "$TUNE2FS_PROG" tune2fs
>  MKE2FS_PROG=$(type -P mke2fs)
>  _require_command "$MKE2FS_PROG" mke2fs
> -_require_kernel_config CONFIG_QFMT_V2
>  
>  LOG=""
>  print_log() {
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
