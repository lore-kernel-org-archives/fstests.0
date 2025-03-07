Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5830DDC1
	for <fstests@vger.kernel.org>; Fri,  7 Mar 2025 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319839; cv=none; b=RxZSe5csFwELjQ3HSspupvDvpqfsfsRq+FAugEU3FDO3rB9YgHNtsZm9Z/yxzNfKN7qUWCteN6xWTaa4JH2cBmd5+HkLJ/WRXxm9xpYIwn2GSdPF2NnzzYV/FH4q4soqQZhGN5T++99cEBbf/Hj6v79stz2ywCZRbpwOpp+xTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319839; c=relaxed/simple;
	bh=RyRDFxt807tU+oi3TofsXnenHsHu7L29ZnEaNHWjids=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtrtEFfD+cyxIq98ZfnjEZUBXMwef6UZJXYHE11BN1QPLjMTBHUKmh+3cxRxZAfg289ywMIlq06fqrdhI0TJjVsn7FZbRwxsLsU7E7I++NrtLUgEdlQMlTvywz2UBhvxVoAKOvzTSDo8+vGzwv/C70RHVPId8TzEyrKSPv8OQOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rR/AWl5Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NmG3PqUH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NtHfIdNt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Pl38iTOt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rR/AWl5Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NmG3PqUH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NtHfIdNt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Pl38iTOt"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE469211B5;
	Fri,  7 Mar 2025 03:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741319836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EqZiiZ+ozrGjSz/52JKPoRDB4+ZJlXZJl90Ra/Iwqk=;
	b=rR/AWl5ZKqoN+5REtULvSYyI3QD+hiMLnWIc953AHhrBqdVqBef4zSrRvuIiwIyL8p87kx
	5U80e7B2WnhP6GzEdnuwxLZbzLNxc0ofQanScyVmXx7R2l0SSTWMT5lrMWsWY7inAVXi+o
	xcv1fSc43rMfj9H2uADEG/cXCCyG7aQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741319836;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EqZiiZ+ozrGjSz/52JKPoRDB4+ZJlXZJl90Ra/Iwqk=;
	b=NmG3PqUHOG/gElZS3aoXB0ayujHyotRawvpk/QtDuyDCgGSUCn3E5/avYFHqMgrHZuuW7f
	884u2AeXJNqax/Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NtHfIdNt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Pl38iTOt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741319835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EqZiiZ+ozrGjSz/52JKPoRDB4+ZJlXZJl90Ra/Iwqk=;
	b=NtHfIdNt5/ve51A4lGurC9eolmseMxD3F/EEP6H3cOkLInqowwls3nvVI70cFxK4/8TbMw
	vKWSxNJmTAD81FF5eLCYcyLOVLaHNs8i15hP+jwoZzJqat9dSoq5akfCOiyXzFwAfH/d0T
	9xKnGi7G8WiZGlGO3wuTFtgHOeMTAvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741319835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EqZiiZ+ozrGjSz/52JKPoRDB4+ZJlXZJl90Ra/Iwqk=;
	b=Pl38iTOtVXYr3ej2bIJsRi3Gdth6zi0Xns067VcrO3AVfi2mKSzxcgSPERsBa53QA+l3iK
	7dbYuUtMNe8G6KAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3FB613726;
	Fri,  7 Mar 2025 03:57:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A0R/JpluymfOaAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 07 Mar 2025 03:57:13 +0000
Date: Fri, 7 Mar 2025 14:57:01 +1100
From: David Disseldorp <ddiss@suse.de>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/4] common/config: export F2FS_INJECT_PROG
Message-ID: <20250307145701.3676d880.ddiss@suse.de>
In-Reply-To: <20250306081809.2397527-2-chao@kernel.org>
References: <20250306081809.2397527-1-chao@kernel.org>
	<20250306081809.2397527-2-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EE469211B5
X-Spam-Score: -3.51
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu,  6 Mar 2025 16:18:07 +0800, Chao Yu wrote:

> export F2FS_INJECT_PROG w/ inject.f2fs, it can be used for fault injection.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  common/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/common/config b/common/config
> index 8d3047a5..05f192ea 100644
> --- a/common/config
> +++ b/common/config
> @@ -317,6 +317,7 @@ export MKFS_BTRFS_PROG=$(set_mkfs_prog_path_with_opts btrfs)
>  export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
>  export DUMP_F2FS_PROG=$(type -P dump.f2fs)
>  export F2FS_IO_PROG=$(type -P f2fs_io)
> +export F2FS_INJECT_PROG=$(type -P inject.f2fs)
>  export BTRFS_UTIL_PROG=$(type -P btrfs)
>  export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
>  export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)

Reviewed-by: David Disseldorp <ddiss@suse.de>
