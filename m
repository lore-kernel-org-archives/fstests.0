Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179CE137775
	for <fstests@vger.kernel.org>; Thu, 29 Feb 2024 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234783; cv=none; b=I+WDVSg1blUCod5YzuLiv1nJcKhRculqOge+Kxa3BteplHIAEoJcn8+QShnxVVyTyoDu+CTTozFnSjeDyu0a3iEf9TBxQMlIb7+yHk1jo8tsMJH/lojIKj2cMt94qkF9o44uiqR4nX1RyQmTLRB6NL4IkiAjq7K47LHKshZwojI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234783; c=relaxed/simple;
	bh=ADl+OZgwhRc0AiS6t7p8fV/pHs5iAAJ/VwbdkEM8zv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDAKoqcwPSZhKNYMQkKEP3ACKC7Lt+JnnT7s0lACoUCDDzugin7XILBisD25qaNn1avbHaz47SSNgaQfx5p+kILYCtex+2eccbvu+OObrcu/wnqvCJ+3khNO62eOlwVlGQtGUKEXQrM/IyiPBE4R9KCJvdAQvzYLVErMTM+vNAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sOcVtL8K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ryIA66lu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m4rchdMO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oIDjR5um; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sOcVtL8K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ryIA66lu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m4rchdMO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oIDjR5um"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E807D228D5;
	Thu, 29 Feb 2024 19:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709234779;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pe4noE0Tu20cpLlEyNVhPt6geI2Rn+mIfSa6685b2FQ=;
	b=sOcVtL8KnYw/82/jFkNf/nXHODOAZHwCDN1L2UITp4BRW2U8UNZFSv9DvYbw8ZWhUX6Yiq
	rBOTeOg+huOJ5LUeDKXEDLk3wOcoEHBeR+0fQ/B04qEX9AhYkwgtZi924Vk9Fi7boZ9Q4v
	5QjqxADn6e1OXfgaxIclaLLkIGq/dKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709234779;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pe4noE0Tu20cpLlEyNVhPt6geI2Rn+mIfSa6685b2FQ=;
	b=ryIA66luSal3Y7/qzEMaZbvO93/LC8RTTqFoT8sqs9l3Kw+Yg5drao//9MwYQ+rsYKujfY
	zYRNsqp35QCaKfBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709234778;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pe4noE0Tu20cpLlEyNVhPt6geI2Rn+mIfSa6685b2FQ=;
	b=m4rchdMOgCy+HjTT8HfI1Ky5WA8dMjRGXod3KbXvnMW+wydRE79wPc4CnHVH3V0oZ6IARb
	te4Yg4vmnB1bnI7cvi6MmFwAWpbC3IuyER1aaYbZ30CSIvQ3rEZmrlap6pCiSYsBNvVROj
	ClENcX6o8F/ChBsdzdhDJ7+qhEOZrsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709234778;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pe4noE0Tu20cpLlEyNVhPt6geI2Rn+mIfSa6685b2FQ=;
	b=oIDjR5um19k8S+rpdSMa5+zqj4fDfkI7Hu/FGtxhrl5evqYdP5B41Y1MR9R/LBAdLs8Llm
	pxoSL7nJ/9x4GZBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D11761329E;
	Thu, 29 Feb 2024 19:26:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id iFLmMlra4GUleQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 29 Feb 2024 19:26:18 +0000
Date: Thu, 29 Feb 2024 20:19:15 +0100
From: David Sterba <dsterba@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, zlang@redhat.com
Subject: Re: Dangerous commands (was:[ANNOUNCE] fstests: for-next branch
 updated to v2024.02.04)
Message-ID: <20240229191915.GC2604@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240221140951.GJ355@suse.cz>
 <ZdgWt8gz4815Nr/F@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdgWt8gz4815Nr/F@dread.disaster.area>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On Fri, Feb 23, 2024 at 02:53:27PM +1100, Dave Chinner wrote:
> On Wed, Feb 21, 2024 at 03:09:51PM +0100, David Sterba wrote:
> > Hi,
> > 
> > reading [1] and how late it was found that effectively a "rm -rf /" can
> > happen makes me worried about what I can expect from fstests after git
> > pull. Many people contribute and the number for custom _cleanup()
> > functions with unquoted 'rm' commands is just asking for more problems.
> > 
> > [1] https://lore.kernel.org/all/20240205060016.7fgiyafbnrvf5chj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> 
> I started down the _cleanup() path a couple of years ago and one of
> the reasons for that was getting rid of all the open coded rm
> commands that were often just plain wrong. That start was here:
> 
> https://lore.kernel.org/fstests/20220524073411.1943480-1-david@fromorbit.com/
> 
> But I got little interest except for one person picking at
> irrelevant details and wanting unnecessary API and naming changes
> that did nothing to really further the cleanup work.

The patches and the direction is along what I had in mind and would be a
good start for sure.

> It did seem like anyone was interested in having this code cleaned
> up and so I basically couldn't find the motivation to slog through
> hundreds of tests trying do stuff that nobody really seemed to care
> about....
> 
> Shame, this whole problem would have not existed if that work sort
> of infrastructure technical debt reduction was encouraged, and if it
> did there'd only be one line of code to change... :/

Agreed and that's too bad it did not go anywhere, from the replies here
I think we all know we need it. I don't know how feasible it is given
your previous attempts and how it was received upstream, I'm kind of
disnclined despite my previous enthusiasm.

> > Unquoted arguments in shell scripts is IMO a big anti-pattern,
> > unfortunately present everywhere in xfstests since the beginning.
> > Rewriting all scripts would be quite a lot of work, could you at least
> > provide safe versions of the cleanup helpers?
> > 
> > For example:
> > 
> > _rm_tmp() {
> >     rm -rf -- $tmp
> > }
> > 
> > and used as
> > 
> > _cleanup() {
> >     _rm_tmp
> > }
> >
> > I can send patches at least for btrfs and generic as this affects
> > me but first I'd like to know that this will become standard
> > coding style requirement in fstests.
> 
> I think it would adress this specific issue, but I think it doesn't
> address the bigger problem that fixing cleanup behaviour requires
> touching a couple of thousand tests. i.e.  it doesn't reduce the
> maintenance burden of this code at all.
> 
> The vast majority of cleanup functions are identical and/or
> unnecessary, so the right thing to do is to only have cleanup
> functions for tests that need them, and for those that do need to
> clean up to only have to clean up their own mess.
> 
> i.e. the test harness itself should be responsible for cleaning up
> $tmp stuff and doing stuff like returning to the correct directory
> after the test completes, not require every test to duplicate the
> same cargo-culted behaviour...

Yeah, I picked one specific issue, the bigger problems would emerge once
I'd try to fix it.
