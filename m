Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9ADDDC1
	for <fstests@vger.kernel.org>; Fri,  7 Mar 2025 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319880; cv=none; b=h3OkMJ+YY+O8zMDMXFCescz67XTlsSjFknkmEXhsVLxrimaXU3EaGeTTdWQK4404efGv/Mc0BuAng7sUUYaxcRPV0+qeE1uPPWvNj3XTcgeyUwP4SP70Qat20q0DrscCAueBOSLea32iyFyWmacDZBAonOM3pNBsw7Sf5B2odyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319880; c=relaxed/simple;
	bh=zuturUj1XsQqb0VC7ewHo9nxLt1GY1TPqx5ZCzZjLbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RE5OrmBy/zxAb8EsW2GyybO6EuqvWUuN1FowDwcMJ+YDHX0TpsmwhQ8qwAypmJRPNDkH9pfZNXvMid41jV1YnUtUhLOPclZ37SWEPD6t1k+FEki7d0EfpkaMBSZ4l4UinxRbYHVtHX44U0HvEYRCsQ6Kds3dMPky0fK9batpJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wlht1gpY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E0iA8Hcj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ynvxscYm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6uLa5+62; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wlht1gpY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E0iA8Hcj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ynvxscYm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6uLa5+62"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3CF4211B5;
	Fri,  7 Mar 2025 03:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741319877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4o8aIqRMXFiWv6nSz2UHztvIYHb6zxhdcrhJDENIKyc=;
	b=wlht1gpYnN5SmHI42RDa+AIWQgKo/iKQhaT9yDWLH3yVYh5sksSrxFrOtkq5PRAGMbhN+f
	UHQgjAbiaNo1b6EIW7g9mwCht4nVgI0ZIyI2rFa+v8fGgBZUL//eyQSpogNPrE08cqGNF8
	Kcn6t/y5NJUxOc8O22cmFaaltB7nebw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741319877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4o8aIqRMXFiWv6nSz2UHztvIYHb6zxhdcrhJDENIKyc=;
	b=E0iA8HcjjZZTT0wPyVe+HZYuond7Ve6AIw8sOmbeN+Rche5/Ew0ulQ+dna4eK73dboT0M2
	Cj1/pASzpScehKBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741319876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4o8aIqRMXFiWv6nSz2UHztvIYHb6zxhdcrhJDENIKyc=;
	b=ynvxscYm61TsqdrAMWiGEnDOItLiHtc5A/VOlWigseoGD/mw6We4vfnGCef6lKN39+eL0/
	sE3t23RO420xKRkhp3U3wfPX4u6MpynqKb21MeLPSxFantnE7vPA5T7ujlOYZ12Cfxuo/e
	oTJREtLZjnekc8/FLBp03Bq86d/eAFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741319876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4o8aIqRMXFiWv6nSz2UHztvIYHb6zxhdcrhJDENIKyc=;
	b=6uLa5+624FKsVXx3hGB7aBKNJbOnDofhNn1ZHoZ8J9DnxjA+VUzweKvFI+yctosj5x2RO1
	Zk1sUlTvXFRt3AAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D02C813726;
	Fri,  7 Mar 2025 03:57:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ytCfIcJuymcBaQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 07 Mar 2025 03:57:54 +0000
Date: Fri, 7 Mar 2025 14:57:49 +1100
From: David Disseldorp <ddiss@suse.de>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/4] common/rc: support f2fs in _repair_scratch_fs
Message-ID: <20250307145749.7bda92e8.ddiss@suse.de>
In-Reply-To: <20250306081809.2397527-3-chao@kernel.org>
References: <20250306081809.2397527-1-chao@kernel.org>
	<20250306081809.2397527-3-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.990];
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Thu,  6 Mar 2025 16:18:08 +0800, Chao Yu wrote:

> Support f2fs in _repair_scratch_fs(), and use -f to repair the image
> forcely.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  common/rc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index ca755055..bf24da4e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1500,6 +1500,9 @@ _repair_scratch_fs()
>  	# want the test to fail:
>  	_check_scratch_fs
>  	;;
> +    f2fs)
> +	fsck -t $FSTYP -f $SCRATCH_DEV
> +	;;
>      *)
>  	local dev=$SCRATCH_DEV
>  	local fstyp=$FSTYP

Reviewed-by: David Disseldorp <ddiss@suse.de>
