Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED32ADDC1
	for <fstests@vger.kernel.org>; Fri,  7 Mar 2025 03:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319800; cv=none; b=dR6RCYd7Om8j1xDPQ+9DFWrcBugo2OiiPlQuTpDdtxS5tpeua2K932+Rzr6x2LkCbZsHKx6K+Bv05Q5Lc0RSwWQZ2veKseUHn/nLW+ksz1pD7cY8Z9cpGuUoR3ZHH1IkZWGTqzD/iBz1+eRaWgjzTDhrEMm4DZ5WilLRMf0Up0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319800; c=relaxed/simple;
	bh=fbpny7B6cPhpmWAe8upZ83Lb2MUODZ58FkgKWcwtJ+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INRcPpKTSrLO+SJ14vbubSj+7g5Zk0pfJLg4k0Ws24lU9Sqcphof5RlHTHwf3kAakZHggPMBGA6mMw4ttl7hRkW4ncihk88IwEUXTB/FQurYC4djX5zOurcLLDJlydM5sGGbA+3MTf2yVaEygtfaU2L52s4cZc5WyKBc8DGWrVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=a6KCZfB9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UfZ1jDqC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kSxt5XVU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JmXk7oxa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="a6KCZfB9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UfZ1jDqC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kSxt5XVU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JmXk7oxa"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CA3A71F38E;
	Fri,  7 Mar 2025 03:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741319797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXRRShev6vTIjqzuTlfZDSUJqBlzGhmjGP2Qbs2uAOM=;
	b=a6KCZfB9meAFCrl6em7fD2lAvvLOZ8GsGkVjoKTC3m2ATz4dPqoG1S8T7r2NoiBh8EFVmf
	pztDaqPvYrP0CYZjPeaaTObkAkHSi+gRYNLemVI4Uxy2858cQFp0pwwboF2Ky7qUzawmjb
	8ogbEe52C+38kXyYoMgC+/6OKqablNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741319797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXRRShev6vTIjqzuTlfZDSUJqBlzGhmjGP2Qbs2uAOM=;
	b=UfZ1jDqCRM+chmwYJmnoLWyXaa24Rza/ufkyPxuxdxPiDgVTzp2TXpoMFlZZkDlTm+hwid
	kyegrbNrzQ9tY1Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kSxt5XVU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JmXk7oxa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741319796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXRRShev6vTIjqzuTlfZDSUJqBlzGhmjGP2Qbs2uAOM=;
	b=kSxt5XVU/VFzp2zvyGqCXHVfLBFnpNc8ZoIZNMNg/zKCGtIwHxEIfaNh/DNglRoTd3daXs
	va2ai4yo2KVOhgeqKCQV0FzQD6DQPsVSIlI34aKqxG3aPPep/LN9QKC3xHCXojH48Ksrmr
	my/G/sGvd+0OWQO0Ib/qTPU0q+AABec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741319796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXRRShev6vTIjqzuTlfZDSUJqBlzGhmjGP2Qbs2uAOM=;
	b=JmXk7oxa3TADKx+HCffF/TRKQGhISVza8WBoE6qmtYfBe79Oz6J2d8PkgyOPpNrSbNYkEp
	0lKAobXcrO/4asDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B92F713726;
	Fri,  7 Mar 2025 03:56:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 29CUG3JuymeTaAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 07 Mar 2025 03:56:34 +0000
Date: Fri, 7 Mar 2025 14:56:29 +1100
From: David Disseldorp <ddiss@suse.de>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/4] common/config: remove redundant export of
 F2FS_IO_PROG
Message-ID: <20250307145629.2b2c6e99.ddiss@suse.de>
In-Reply-To: <20250306081809.2397527-1-chao@kernel.org>
References: <20250306081809.2397527-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CA3A71F38E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Thu,  6 Mar 2025 16:18:06 +0800, Chao Yu wrote:

> F2FS_IO_PROG was been exported twice, remove the redudant one.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  common/config | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/common/config b/common/config
> index 2afbda14..8d3047a5 100644
> --- a/common/config
> +++ b/common/config
> @@ -191,7 +191,6 @@ export XFS_COPY_PROG="$(type -P xfs_copy)"
>  export FSTRIM_PROG="$(type -P fstrim)"
>  export DUMPE2FS_PROG="$(type -P dumpe2fs)"
>  export RESIZE2FS_PROG="$(type -P resize2fs)"
> -export F2FS_IO_PROG="$(type -P f2fs_io)"
>  export FIO_PROG="$(type -P fio)"
>  export FILEFRAG_PROG="$(type -P filefrag)"
>  export E4DEFRAG_PROG="$(type -P e4defrag)"

Looks good. @Zorro, might as well squash in removal of the duplicate
TIMEOUT_PROG export too.

Reviewed-by: David Disseldorp <ddiss@suse.de>
