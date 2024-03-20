Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA3524C0
	for <fstests@vger.kernel.org>; Wed, 20 Mar 2024 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948656; cv=none; b=K+GcGS8afuKLVFaZZqgNBPB80atPTl7CaQgVT+YgpDhJOkCrZOwvYL/U2fMejmShr053sbaj3a9w3vJ2yTvaZAIxJWTvTdSuI2d5E9tWKfEky+KzvuBcH3KpbrnojMxJdABTsn9NP/ppyvSR4gF4fGojVMau6bIIb9lnKJP/AOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948656; c=relaxed/simple;
	bh=MJ/cg+k3ZMn4Pc9Q1JXiq9eqNSYWBTFGI7wpPeOM+/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBNd+bW8ConL/487j2rELxy8mpVDWblmpUimgZN2njtwlZ5AzX1FaFIwKgAH4dibF8jKgsBTUiTErMsnWIVeg748yq5wNw1IePJ819P5nhqdCHo9wAIiIzIlwXRhYkw1LXBUvjcMfBM65kBQlsJgrsj6WuVtgYfcV2N0PbU5Wp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xc6RjxQo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tw2g3BpB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B55iCBX2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WUJb+1TB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xc6RjxQo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tw2g3BpB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B55iCBX2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WUJb+1TB"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C06E2346EF;
	Wed, 20 Mar 2024 15:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710948651;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSC98k7IK5UEadOz8S3EUWeueltq9gewI0/L5GwAsBU=;
	b=xc6RjxQopuT8+sM8ZwPbJxUi1pk0FgHMHAC3dyujAJnUU0vjVcrczF8pxjsY5OVvjndR77
	d00Up9qIRFXaKQZVRZsdO/4iKKzMUshdrx9MmiuB7Cd/ZJMaVHDKObP61vK1jR3jkjTwbY
	3JJFg5/+cSeSXVPQIg+XtZ608qY2nhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710948651;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSC98k7IK5UEadOz8S3EUWeueltq9gewI0/L5GwAsBU=;
	b=Tw2g3BpBrUMZotPWZiAZmUqpPKH8M3+HzDBglDRL/3MvP9rQCzzKKZ3eEOVfsut+JPJZag
	pQWYsPdQHCd2QEBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710948650;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSC98k7IK5UEadOz8S3EUWeueltq9gewI0/L5GwAsBU=;
	b=B55iCBX2zO7RoCaxdEz8jfkK8yQVPPPDM5fzqljEKkNEU3+14P4yEzT3Cu0EvlnDCqkkN/
	FCk2SshK3JsCdJLneSb8qcP0yShsiWqMSqCD+M5Q29hu1QqJDq//ET3fMrhlAYklzpkMPp
	XgOe5T8n+bFoAOrDB1Czw7t0tInh/vA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710948650;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSC98k7IK5UEadOz8S3EUWeueltq9gewI0/L5GwAsBU=;
	b=WUJb+1TBq+CsWJ6oYhJYIL3JFJ39kFNSVmOVbc77iiFInJIOYIbiNOHHu5ZU/gJdgjjzmg
	ZiPK9ngic6xLR7Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2FC2136CD;
	Wed, 20 Mar 2024 15:30:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mJ+JJyoB+2UPVQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 20 Mar 2024 15:30:50 +0000
Date: Wed, 20 Mar 2024 16:23:32 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 1/5] common/verity: use the correct options for
 btrfs-corrupt-block
Message-ID: <20240320152332.GB14596@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1710871719.git.dsterba@suse.com>
 <0b2ef42d6fb3e3b6ebe91c84b9a5e698af13d80b.1710871719.git.dsterba@suse.com>
 <d8e9d153-aff6-4f47-888b-b2ab91f7eb5b@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8e9d153-aff6-4f47-888b-b2ab91f7eb5b@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -1.15
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.15 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 BAYES_HAM(-0.00)[20.05%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.14)[-0.724];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=B55iCBX2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WUJb+1TB
X-Rspamd-Queue-Id: C06E2346EF

On Wed, Mar 20, 2024 at 03:28:52PM +0530, Anand Jain wrote:
> On 3/19/24 23:42, David Sterba wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> > 
> > A long time ago we changed the short options to long options in
> > btrfs-corrupt-block, so adjust the helper to use the correct options so
> > the verity tests pass properly.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >   common/verity | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/common/verity b/common/verity
> > index 03d175ce1b7a18..0e5f0d75e746a8 100644
> > --- a/common/verity
> > +++ b/common/verity
> > @@ -402,7 +402,7 @@ _fsv_scratch_corrupt_merkle_tree()
> >   			# in the default filesystem tree (-r 5) and corrupt one byte (-b 1) at
> >   			# $offset (-o $offset) with the ascii representation of the byte we read
> >   			# (-v $ascii)
> 
> > -			$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 -v $ascii -o $offset -b 1 $SCRATCH_DEV
> > +			$BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 --value $ascii --offset $offset -b 1 $SCRATCH_DEV
> 
> 
> Can we still make it work with the older btrfs-corrupt-block?
> 
> How about..
> 
> corrupt_block_value_opt()
> {
> 	$BTRFS_CORRUPT_BLOCK_PROG -h 2>&1 | grep -q -e "--value"
> 	if [ $? == 0 ]; then
> 		echo "--value"
> 	else
> 		echo "-v"
> 	fi
> }
> 
> And to use,
> 
> $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 $(corrupt_block_value_opt) 
> $ascii --offset $offset -b 1 $SCRATCH_DEV
> 
> 
> I will make this change before submitting the PR if no objection.

Thanks, that would be great. The option changed in btrfs-progs 5.18
which is still relatively recent so both options should be supported.
