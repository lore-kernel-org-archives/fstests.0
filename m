Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733B61E9B2C
	for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083877; cv=none; b=r1duUO8h1Wpsob79RQKWKH80DD3kfdq8zfJ8oab9mPGFOASQ8DEnH4bIk/VWE0PrSYjsSd8twUxPfnR6SmYydfkSuPXKkFDA3ieYatjpBYMUI7i8tcDHKKY9Nzwp3iKzHiBgNQk/eU/QfPNzKde2bhiM1nOFQBagDp2BTh6ONcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083877; c=relaxed/simple;
	bh=opbZOBhuKWhtX6bgh4MjrKOjxgfp6M8KWd9kkLgFm0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA1yk4rNeWTY/y7JXRrCcI+WOuQ15vkG7oacKNvDJKHn/MUeMAuj7w3Gk1hG3ScTlDPeKL/QvZru3FLjJ+OoMBEToOHyXOpQyDu77btj/Wla+gRX3n4YTX+XN+vwpaBNgVMPvvOUzwCSWQfjHKAAy2r8yJL172qlMPqED/D79ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=orZhqVPM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wVby+dRG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=orZhqVPM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wVby+dRG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="orZhqVPM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wVby+dRG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="orZhqVPM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wVby+dRG"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79F8E1F387;
	Thu, 20 Feb 2025 20:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740083873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FfC6eKZovlQBOWGHL2IzMOes19cvzM1dxxLhCXZLEtQ=;
	b=orZhqVPMBIq99ar1/2LB0/+sogdRK/GzhjqUD9fdoJBh2ufE1BPkOlUXAlaEWOY7a+1HKO
	RnlvFCeapU+rghJ70Y0m/ei4fWNM9e74Zgf1itJAxCuHrVQMrQFvD+GB1jmN0pJNjvKiIZ
	BDBll27KmcwIXcb/3omNfKaUfZXyq8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740083873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FfC6eKZovlQBOWGHL2IzMOes19cvzM1dxxLhCXZLEtQ=;
	b=wVby+dRGpC9gp9uEzBa6TRHTpwheM6wVDdMG4GRtA3L0zDS8appP3LryPzOfX6yThuayd4
	LRR6AWLcz3itIfDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740083873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FfC6eKZovlQBOWGHL2IzMOes19cvzM1dxxLhCXZLEtQ=;
	b=orZhqVPMBIq99ar1/2LB0/+sogdRK/GzhjqUD9fdoJBh2ufE1BPkOlUXAlaEWOY7a+1HKO
	RnlvFCeapU+rghJ70Y0m/ei4fWNM9e74Zgf1itJAxCuHrVQMrQFvD+GB1jmN0pJNjvKiIZ
	BDBll27KmcwIXcb/3omNfKaUfZXyq8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740083873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FfC6eKZovlQBOWGHL2IzMOes19cvzM1dxxLhCXZLEtQ=;
	b=wVby+dRGpC9gp9uEzBa6TRHTpwheM6wVDdMG4GRtA3L0zDS8appP3LryPzOfX6yThuayd4
	LRR6AWLcz3itIfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AEF313A42;
	Thu, 20 Feb 2025 20:37:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QfHoEKGSt2dlTgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 20 Feb 2025 20:37:53 +0000
Date: Thu, 20 Feb 2025 21:37:51 +0100
From: David Sterba <dsterba@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: remove reiserfs support
Message-ID: <20250220203751.GH5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250219221743.20161-1-dsterba@suse.com>
 <20250220202238.6axqgejzk47aay3j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220202238.6axqgejzk47aay3j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Feb 21, 2025 at 04:22:38AM +0800, Zorro Lang wrote:
> On Wed, Feb 19, 2025 at 11:17:43PM +0100, David Sterba wrote:
> > The linux kernel removed Reiserfs support in 6.13 so remove it from the
> > tests as well.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> > 
> > Arguably reiser4 support could be removed as well as there's no recent
> > upstream activity.
> 
> Thanks for doing this :) But even with this patch, I still can find more
> "reiser*" related things as below. How about removing them all?
> 
> zorro@zlang-laptop:~/git/upstream/xfs/xfstests-dev$ grep -rsni reiser .
> ./common/config:330:export MKFS_REISER4_PROG=$(type -P mkfs.reiser4)
> ./common/config:390:       reiser4)
> ./common/config:391:            # acls & xattrs aren't supported by reiser4
> ./common/config:392:            echo $REISER4_MOUNT_OPTIONS
> ./common/config:443:       reiser4)
> ./common/config:444:            export MKFS_OPTIONS=$REISER4_MKFS_OPTIONS
> ./common/config:472:    reiser*)
> ./common/config:540:    reiser4)
> ./common/config:541:            [ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
> ./common/rc:1227:       ext2|ext3|ext4|reiser4|ocfs2)
> ./common/rc:1331:       reiser4)
> ./common/rc:1333:               $MKFS_REISER4_PROG $MKFS_OPTIONS -y -b $blocksize "$@" $SCRATCH_DEV \

This is reiser4, the reasoning would be different as it's an out-of-tree
module but still somehow developed so there's a chance somebody is using
it.
