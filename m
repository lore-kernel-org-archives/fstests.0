Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31DE1E495
	for <fstests@vger.kernel.org>; Thu, 23 May 2024 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471629; cv=none; b=JQU5n/VEb1GWy5DUvjKC/r1iRUyfzDVeAskNCHMR84ANI6ymt7i5W1YAe+yozhkqpkVuPVorGXENLNstFVSp9/wVd9nZzcrZUnj6fyaRUsie4StvWJlvYwI8wdKhL6jzKc4HEGcUVbB4sk7y8eHXC+KhGqdfiLj1MkIS2fM0aOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471629; c=relaxed/simple;
	bh=EU+40jrszV50W/K9NPcWcA59VXQltAbOcopCbtAig4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BonY7rHs/upPwn2Su6l8GfXQ690tTGB4DzjAdcw+upM2bAn4BPs5/Wq8u5a4yQSzyNll2pf6I/6fWGYV8KTKD2yaLIXLV+GKmXk8BBDSVf4YKITa5ANhoDofUh2Zvmj99pfELhgNPg1+79XF2E+n6RNujn5eCkQKGWHMTq84CBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CuoZHmhk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pZTYGsTP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1eW87Nng; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nUmP2qlc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CuoZHmhk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pZTYGsTP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1eW87Nng";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nUmP2qlc"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B33AE20228;
	Thu, 23 May 2024 13:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716471625;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gl8KiUBHufSNBXCsC1aDjFFXIrJvpp0GOuMoLi14J5o=;
	b=CuoZHmhkNeyxtjYeogW4vN+9DelUvzT8HP3KNX2KeQkT0o2jM1xarVjoKqK9X4rKY/W+af
	YXWWkfuMaDKaFHSWARr6RTzgalCUf6ItxvB6ZM+4gWX1S4Y5TXRAKFjur1eW8UvS+GMyuI
	1oduH1SdIa5Q1ke8pqeYfDStqalOsak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716471625;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gl8KiUBHufSNBXCsC1aDjFFXIrJvpp0GOuMoLi14J5o=;
	b=pZTYGsTPurE/N7OMHnBTrp1+FLTjOpN4++LPUDlHuyxHuiynnRkpCIp7oyLWqfLndWjr9t
	8IpU5JdIUmcToVBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716471624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gl8KiUBHufSNBXCsC1aDjFFXIrJvpp0GOuMoLi14J5o=;
	b=1eW87NngQ9/Uz3uZju3cwa3COcSjqMAWNaLHuKpx0JfvZHPZtfnAtF9aPMca3JZRAv35ka
	WeR85Eh9podWQO04PJethy38vLFtemSrO+NfKMVUp2e9j/UEuNu7WHTHbReVMvjimP/0dH
	E8N2M//aVQGz7O4xYSrW1odxIdWBYk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716471624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gl8KiUBHufSNBXCsC1aDjFFXIrJvpp0GOuMoLi14J5o=;
	b=nUmP2qlcTQ2pKo8SvZufweA3LiVayqDtyr0mnPQiWXOZAiUYLoQwP+P9ACrtQgCK03KT44
	j8GqFHBZo6zXIdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A05F713A6C;
	Thu, 23 May 2024 13:40:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2FQDJ0hHT2YpIgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 23 May 2024 13:40:24 +0000
Date: Thu, 23 May 2024 15:40:19 +0200
From: David Sterba <dsterba@suse.cz>
To: Zorro Lang <zlang@redhat.com>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] Remove richacl support
Message-ID: <20240523134019.GB17126@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240522173048.30558-1-dsterba@suse.com>
 <20240523040922.ozy5drxg7w4svrj5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523040922.ozy5drxg7w4svrj5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,lkml.org:url,bestbits.at:url,imap1.dmz-prg2.suse.org:helo,samba.org:url,lwn.net:url]

On Thu, May 23, 2024 at 12:09:22PM +0800, Zorro Lang wrote:
> On Wed, May 22, 2024 at 07:30:48PM +0200, David Sterba wrote:
> > There's no support for richacl in Linux and based on information in the
> > links will never be. Remove all related files and support code.
> > 
> > References:
> > - https://wiki.samba.org/index.php/NFS4_ACL_overview#Linux
> > - https://lwn.net/Articles/661357/ (article, 2015)
> > - https://lwn.net/Articles/661078/ (patches, 2015)
> > - https://github.com/andreas-gruenbacher/richacl/
> > - http://www.bestbits.at/richacl/ (n/a anymore)
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> 
> Thanks! The richacl testing was brought in by:
> 
>   commit 73f9e47abdc58f39b7e39b3729bc88db624c9771
>   Author: Andreas Gruenbacher <agruenba@redhat.com>
>   Date:   Tue Jun 28 14:47:26 2016 +0200
> 
>       generic: Add richacl tests
> 
> Looks like we were too hurry to merge the test things before the kernel
> patchset get merged.
> 
> Sorry I didn't learn about the details. From above links, I can see how
> we tried to implement the richacl, but I didn't see how we denied it and
> never have it in the future. Is there any record (e.g. an email reply) to
> learn about the "history"?

There were many revisions of the patches, talks at LSF and LWN articles
over the years so I'd consider it a common knowledge. Web search leads
me to lkml.org links that does not work today so I can't point you to a
mail where Christop said a clear 'no, never'.
