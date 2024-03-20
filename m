Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1435466C
	for <fstests@vger.kernel.org>; Wed, 20 Mar 2024 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950742; cv=none; b=EMwWWuwdK2hYGoqqALmhMDAZEkrRw7DlffcMz13chKGiCb31BEdb0l3ERyZn7IaSn2MfXGfi+8+fLoudGFx9aorHiFN/FgMTaneusXo3aeV/DxmJlyZJq6d4flbieKQvfsVGClDngz7xFD7QQWx+B+SdRxr7q8YJ54SUPIn/HPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950742; c=relaxed/simple;
	bh=eF8JHYaBwWgbmZIWvgRWasX9ldDTybYzyXJzgaAV8VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYHO/ImoF0FcsZkXp0YYvpJX/cicDMGPMglNXEITX3B2RJt67iCVi3ukp1OZp5mvO4JDAJ9kvBIdxy+lrOgpHhlwp2+jFi/+iqP0s9h0zMRpms3f/EIs3DfMzoeffxhSAaKcO4NWrTyh+UFjFlp/ug9HMgW2oppoLQoBquQP0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eAeT1zoy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XpkIgtaS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eAeT1zoy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XpkIgtaS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eAeT1zoy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XpkIgtaS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eAeT1zoy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XpkIgtaS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 86A4D34775;
	Wed, 20 Mar 2024 16:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710950738;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4nSVh08NdlOTo5P7XFQXsM/WwdPHI9nUWADh1h5NM9w=;
	b=eAeT1zoy1LRBnNNMfivLAxEGQTvhN1Kc6BXIJbMoWDib04JC93zSBF3rsdauqR4Pk3yUdB
	nfTE8IXcygxrTi6dY3goISPGaYhElWMfIJrKpxBU0SP+IxX6fWmZ55Oz6EOERQmh920NFS
	o3IBEV2dygI98XgS26SEgAvdlpXhGnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710950738;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4nSVh08NdlOTo5P7XFQXsM/WwdPHI9nUWADh1h5NM9w=;
	b=XpkIgtaStssFBTFe3jHW/LEqC9z/fgNRqXLbzjVlxnLqb4iYLnQtD6Gb45NYhMG1/i6Ttz
	ymOw4LBxV1tLSyDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710950738;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4nSVh08NdlOTo5P7XFQXsM/WwdPHI9nUWADh1h5NM9w=;
	b=eAeT1zoy1LRBnNNMfivLAxEGQTvhN1Kc6BXIJbMoWDib04JC93zSBF3rsdauqR4Pk3yUdB
	nfTE8IXcygxrTi6dY3goISPGaYhElWMfIJrKpxBU0SP+IxX6fWmZ55Oz6EOERQmh920NFS
	o3IBEV2dygI98XgS26SEgAvdlpXhGnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710950738;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4nSVh08NdlOTo5P7XFQXsM/WwdPHI9nUWADh1h5NM9w=;
	b=XpkIgtaStssFBTFe3jHW/LEqC9z/fgNRqXLbzjVlxnLqb4iYLnQtD6Gb45NYhMG1/i6Ttz
	ymOw4LBxV1tLSyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C07B136D6;
	Wed, 20 Mar 2024 16:05:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CKgxGlIJ+2VDYQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 20 Mar 2024 16:05:38 +0000
Date: Wed, 20 Mar 2024 16:58:24 +0100
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 5/5] generic/733: disable for btrfs
Message-ID: <20240320155824.GD14596@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1710871719.git.dsterba@suse.com>
 <094a1bdc304b236ba41aff4da454abe3c93a355c.1710871719.git.dsterba@suse.com>
 <Zfn9DMR8UQQMiyiL@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfn9DMR8UQQMiyiL@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -1.06
X-Spamd-Result: default: False [-1.06 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.06)[61.16%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Tue, Mar 19, 2024 at 02:01:00PM -0700, Christoph Hellwig wrote:
> On Tue, Mar 19, 2024 at 07:12:10PM +0100, David Sterba wrote:
> > This tests if a clone source can be read but in btrfs there's an
> > exclusive lock and the test always fails. The functionality might be
> > implemented in btrfs in the future but for now disable the test.
> 
> Well, this sounds like btrf sis broken and it should fail?

It does not sound like that to me, rather that the test was tailored
for xfs and assumes too much about the behaviour that does not apply to
btrfs. If you look at src/t_reflink_read_race.c it's full of magic
constants used for timing, this itself points to an unreliable test
depending on hardware and other system load.

> 
> >  # real QA test starts here
> > -_supported_fs generic
> > +_supported_fs ^btrfs
> 
> 
> and just throwing random not supported in generic testes is just a mine
> field.  You;d better explain very well why something is not supported,
> and do that by adding a _require_.  If you can't explain the
> _require this probably actually is a bug and not just an exclude..

It is a bug in the test, it should have been xfs specific and never
promoted to generic/ and not affect btrfs unless explained how
in the first place.
