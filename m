Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED66A2905
	for <fstests@vger.kernel.org>; Sun, 11 May 2025 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746990134; cv=none; b=mYpvVZfoDC7cprXMnhTYe6ddHgaKIArkX7prhlHlw74C1FBpUvinWGphSyK0VhVvz18tGEr+a8XpSHvmxsIxX1h004oGMPl/WwOCpsN0SPJyXGn/oeN6QKZVw27byolLKk1+v+3GtXv5hdwP55qiv5hiYAI6n4vQD5z+fXXNwak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746990134; c=relaxed/simple;
	bh=5N72qniG4Y/amh2M4JiSHVkGnoJ7QApxwxdd+jRAWmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tY8YgMnTq5egRcml43IX+WXNxTNu8qaPuvWvdaT3nHitnrV+JdaJeBgDhEyRluJvls99ST93zvx5QbmqNf1+4EcckHf06a3ZZwAV2cwKQX0l+2W0UPa+mniKpGVHP8Tlc5ujtlDYOEF6FeRbMsqRS96APwwlMu4zTNWnyKBqbXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OLI0fTne; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OLI0fTne; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OLI0fTne";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OLI0fTne"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F5A01F399;
	Sun, 11 May 2025 19:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746990127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IeTirzCDeUpiqhI5zG7SfGedHM30yVCluzFT4XRJWcw=;
	b=OLI0fTneKvfc0jlsu1MWVbEWfqqJWsoN2opMgiqdN0lXEKY2/HwiFc4/uaZXRKOaoP6/PL
	o/JuInfYoPO4zo0T2qpk+x+eYoXSDOELudpSCQfDBHGd1exekhGpnOZxJPuuqhMS1SpaQl
	GjHG4FXH2WPkdEt0Da/QY6CuBY7gnJk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OLI0fTne
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746990127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IeTirzCDeUpiqhI5zG7SfGedHM30yVCluzFT4XRJWcw=;
	b=OLI0fTneKvfc0jlsu1MWVbEWfqqJWsoN2opMgiqdN0lXEKY2/HwiFc4/uaZXRKOaoP6/PL
	o/JuInfYoPO4zo0T2qpk+x+eYoXSDOELudpSCQfDBHGd1exekhGpnOZxJPuuqhMS1SpaQl
	GjHG4FXH2WPkdEt0Da/QY6CuBY7gnJk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4117E137E8;
	Sun, 11 May 2025 19:02:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eoxKDC/0IGgwMgAAD6G6ig
	(envelope-from <ailiop@suse.com>); Sun, 11 May 2025 19:02:07 +0000
Date: Sun, 11 May 2025 21:01:58 +0200
From: Anthony Iliopoulos <ailiop@suse.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/008: fix golden output for 512 fsblock size
Message-ID: <aCD0Jmx_V5bS3klb@technoir>
References: <20250508074102.125013-1-ailiop@suse.com>
 <20250511142954.swhxnifhxvvkg3ty@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511142954.swhxnifhxvvkg3ty@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7F5A01F399
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action

On Sun, May 11, 2025 at 10:29:54PM +0800, Zorro Lang wrote:
> On Thu, May 08, 2025 at 09:41:02AM +0200, Anthony Iliopoulos wrote:
> > commit 97989c9839dd ("xfs/008: use block size instead of the pagesize")
> > changed the test filter, which causes nocrc/512b fsblock configurations
> > to fail due to mismatch of the golden output. Update it to match the
> > expected output.
> > 
> > Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> > ---
> >  tests/xfs/008.out | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/xfs/008.out b/tests/xfs/008.out
> > index 0941e218c7d0..dc999156dab5 100644
> > --- a/tests/xfs/008.out
> > +++ b/tests/xfs/008.out
> > @@ -8,7 +8,7 @@ randholes.2 : -l FSIZE -c 100 -b BLKSIZE
> >  ------------------------------------------
> >  holes is in range
> >  
> > -randholes.3 : -l FSIZE -c 100 -b 512
> > +randholes.3 : -l FSIZE -c 100 -b BLKSIZE
> 
> This change fix the failure on nocrc/512b fsblock, but it causes xfs/008
> fail on all other blocksize xfs.

Indeed, thanks for catching this, I'll send a v2 with the corresponding
filter fix.

Regards,
Anthony
