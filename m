Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9ACDDAB
	for <fstests@vger.kernel.org>; Tue,  6 Feb 2024 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240713; cv=none; b=esTXMuoCzEG4qV9+U3SlpX77rDBQq6OOMcCw40vezc64jfL6b1jn7LVkiNG+igiUAZB61ud/H7pCwBN06FRs45T03rk2snHqAy50d8U2Wm08tVr7DkiiHBNvHJxaHGLBoqdP7p9IT3+e7Xdb6p4p5uPohDFjgI/MUhTSf7KLFso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240713; c=relaxed/simple;
	bh=RFImBWq842DPRd4XSe0xxpK+KGwL5bpkfTOQh9/jEqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPnauRBZXh9dpf3F+eF/Obw3YhVcugVhS1vgQ9eUCU13k6BnDthezZSCMn411i7VVkRSzWafhZG/c6joQ9JvWxbySdI0/Ub7JlEX5OXSOB275lt1N7BD3Bga9AkWBcWhJcrp9vov+SYNYw9Tt6GR8u0n2SFhJG9TOLX0zGVQvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UU3RTJho; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UU3RTJho; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UU3RTJho";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UU3RTJho"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7C7E1FB89;
	Tue,  6 Feb 2024 17:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707240707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2DfvkSDb73yGGkzrk4jRqaeZJij+AHWETW2ZfdR3E8Q=;
	b=UU3RTJhoaB578leYvclL9Kwd1p+w6SYu+daORIleaWjCL0qVTLbBlN4rhLVghgKmCgKLK4
	pXf6GG/ySg+e7EOVa+dlBjP/O6MaOFE9YgNEEUUys/jbZg3+OOP4n7wgXnNxLZ5ydFWBR2
	bBaSd2ErmaNUcEjJLMokvpYzAU7xXA0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707240707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2DfvkSDb73yGGkzrk4jRqaeZJij+AHWETW2ZfdR3E8Q=;
	b=UU3RTJhoaB578leYvclL9Kwd1p+w6SYu+daORIleaWjCL0qVTLbBlN4rhLVghgKmCgKLK4
	pXf6GG/ySg+e7EOVa+dlBjP/O6MaOFE9YgNEEUUys/jbZg3+OOP4n7wgXnNxLZ5ydFWBR2
	bBaSd2ErmaNUcEjJLMokvpYzAU7xXA0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64F04132DD;
	Tue,  6 Feb 2024 17:31:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8RUCFQNtwmVKBQAAD6G6ig
	(envelope-from <ailiop@suse.com>); Tue, 06 Feb 2024 17:31:47 +0000
Date: Tue, 6 Feb 2024 18:31:42 +0100
From: Anthony Iliopoulos <ailiop@suse.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/682: update and fix-up golden output
Message-ID: <ZcJs_jsbiTpx6HyO@technoir>
References: <20240201161732.6126-1-ailiop@suse.com>
 <20240201161732.6126-3-ailiop@suse.com>
 <20240202115605.he7ciqxubrlglnzh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202115605.he7ciqxubrlglnzh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=UU3RTJho
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: A7C7E1FB89
X-Spam-Flag: NO

On Fri, Feb 02, 2024 at 07:56:05PM +0800, Zorro Lang wrote:
> On Thu, Feb 01, 2024 at 05:17:32PM +0100, Anthony Iliopoulos wrote:
> > coreutils v9.4 introduced a change in the error output of mv under
> > certain errno values via commit 3cb862ce5f10 ("mv: better diagnostic for
> > 'mv dir x' failure"), which broke the golden output.
> > 
> > Update golden output to match the change, and further add an output
> > filter to avoid having the test fail on environments that ran with an
> > older coreutils release, taken from commit d9323ad7a05e ("generic/245:
> > Filter mv error message").
> > 
> > Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> > ---
> >  tests/generic/682     | 8 +++++++-
> >  tests/generic/682.out | 2 +-
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/generic/682 b/tests/generic/682
> > index a51d18338742..417598804bde 100755
> > --- a/tests/generic/682
> > +++ b/tests/generic/682
> > @@ -54,6 +54,12 @@ repquota -upn $SCRATCH_MNT >> $seqres.full
> >  echo $(ls $scratchdir | wc -l) files in $scratchdir  >> $seqres.full
> >  ls -sld $scratchdir  >> $seqres.full
> >  
> > +_filter_mv_output()
> > +{
> > +	sed -e "s,cannot move .* to \(.*\):\(.*\),cannot overwrite \1:\2,g" \
> 
> Hi Anthony,
> 
> Thanks for this fix, I remember there's a mv filter in generic/245, we
> just merged a patch same with above line:
>   d9323ad7a05e ("generic/245: Filter mv error message")
> 
> I think you can merge the _filter_directory_not_empty() of g/245 with
> this patch into one _filter_mv_output() function, and call it in g/245
> and g/682 (check if there're more cases need mv output).

Make sense, I'll send out a v2 shortly with the filters consolidated.

AFAICT only g/245 and g/682 are affected by the particular coreutils mv
error output change, due to their golden output.

The only other tests are g/{369,419}:

$ git grep 'cannot move' tests/
tests/generic/369.out:mv: cannot move 'h' to 'd7/h': Permission denied
tests/generic/369.out:mv: cannot move 'h' to 's7/h': Permission denied
tests/generic/419.out:mv: cannot move 'SCRATCH_MNT/edir/NOKEY_NAME' to
'SCRATCH_MNT/edir/NOKEY_NAME': Required key not available

but those aren't affected as coreutils commit 3cb862ce5f10 only changed
the error output for specific err codes (EDQUOT, EEXIST, EISDIR, EMLINK,
ENOSPC, ENOTEMPTY, ETXTBSY), while g/369 is expecting EPERM and g/419 is
ENOKEY.

Regards,
Anthony
