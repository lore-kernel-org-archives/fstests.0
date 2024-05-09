Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2001A2C0A
	for <fstests@vger.kernel.org>; Thu,  9 May 2024 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272450; cv=none; b=ZbfiPLzjE5sgnA64eFq837mhGH0hrIeEETKIImYK6179jj/Aqk0VThpZUiGDmWGAoytG8frajSQCIOHFZoIdmKmpjXZTLX0qgNviiVUKr45EATXC5awj89o9U5IAKc3We2FV2uVibVGRIiDLTAWdZ5And1yRhmQSU2+BnO+wk6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272450; c=relaxed/simple;
	bh=6wMdOz544FTb662cZQUdpalbrOwhMPIQcXqCvAAR28M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrLDaSZuxwWH7cqWyOA3O0uBN4+2z55EBGqsHvvk0+h1iTSHvxy5vjh3jmkjSv28XUO8XUxdZmiEm/dL/71RsbtR3KLp3LAshqtKVbayElHz8MZaA3nthvpqkiZAg8r8YkhkFVqQKe2MREe7LcOUd7AymOFMUA0u3zUstozkUlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BVQhvQiy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1QOV66Co; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fvQbefw9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rbw/YOtX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BVQhvQiy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1QOV66Co";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fvQbefw9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rbw/YOtX"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7FF4346C2;
	Thu,  9 May 2024 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715272446;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6wMdOz544FTb662cZQUdpalbrOwhMPIQcXqCvAAR28M=;
	b=BVQhvQiyyzs+NRmP8pUxIEmbrCOsMkh8tr1VfuR72SF2PkHyDJRwXADR2bZXRrtDWh5Vfx
	KmF+L3BbcQpjv0lFPY8qvVfv1qlJrkOQTLLGHS1XM9o1ATZy7E4n10FkXr01DlHl4Mwq7f
	JLbamf9SGg7dAleqTddWTc8ipJFA3GE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715272446;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6wMdOz544FTb662cZQUdpalbrOwhMPIQcXqCvAAR28M=;
	b=1QOV66CoPlQMsEFOnZ2orfTnALlT3fmbZh0frMO9m4LHu2HgZ6B4MtNOLlqiM7bUCcSBba
	EjW4InCsovMhAiBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fvQbefw9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="rbw/YOtX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715272445;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6wMdOz544FTb662cZQUdpalbrOwhMPIQcXqCvAAR28M=;
	b=fvQbefw9sJuGEghn7T5PujhoTFz2kLpA3nlrg3HQQoRH14Y3LK6JFolozkbdt6hg6/JxL9
	yUwiP9YI44kC2TcrpNF+z6inkBClPQY2tgNurn4RqZmfoX1dKH/PjgfYtTEkHxdbZJ9dLo
	HmdlHR2m53bYtLfkl2IaK3V/QP4UOVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715272445;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6wMdOz544FTb662cZQUdpalbrOwhMPIQcXqCvAAR28M=;
	b=rbw/YOtX0ffYr9ZNfk4XnW9Kk5XfJwTzsg8ore/8EAOJ8YVOubgZxTyziY248LVv5bQnb3
	0eVxFgCmVGc95EBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5EED13941;
	Thu,  9 May 2024 16:34:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F2rtK/36PGZ2JgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 09 May 2024 16:34:05 +0000
Date: Thu, 9 May 2024 18:34:02 +0200
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/4] Move shared/002 to generic/745
Message-ID: <20240509163402.GJ13977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715108589.git.dsterba@suse.com>
 <ddb9dd4eabcb5c6695c2c0ea7e257d0b615814e9.1715108589.git.dsterba@suse.com>
 <Zjxh6wwyUIA8d-Na@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjxh6wwyUIA8d-Na@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C7FF4346C2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Wed, May 08, 2024 at 10:40:59PM -0700, Christoph Hellwig wrote:
> Same comment as last time - please add a common helper to check
> one. e.g. a max_xattr_values or max_xattr_space helper.

I agree that adding the feature checks is the right way but I want to
keep minimal changes when files get moved.
