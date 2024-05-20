Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D0137C58
	for <fstests@vger.kernel.org>; Mon, 20 May 2024 19:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232875; cv=none; b=WqZ1uIlE+PibfvUjACQbrLXsvmsQk7kp90YaddqonelzEfSvR4p3Je1TaLUj4953K42ucnxhUh9sU0PnAyuW/aspRLo55vTHiRW149d2vghheGm8s/7iDoD++1Ug05sIQcQ/jU3Wvn8961KMFDcLKOPPZdjDikAgDI7deFeP4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232875; c=relaxed/simple;
	bh=sYa4013KTlN+Hca8CXoFu4EJI0HZ2uNji29VCvzGVqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUR/4fvDYeUTCq4G1q8X69fCfXw8BJ01IF0V7OFEMvIckEF6+ar3J2RVOeQZAepOvylcWx8BLZNh547/u+kOD54d+OQ4+dhw1EZODshsKTaQMRf2HxB5digXyCiBnQ/aneniaoxeqSnESLgqwUkHabcVxKbwHtSxDnU4FSM5em8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JNEtpTsu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CkVo3Gbr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JNEtpTsu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CkVo3Gbr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JNEtpTsu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CkVo3Gbr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JNEtpTsu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CkVo3Gbr"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DDF13428C;
	Mon, 20 May 2024 19:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716232872;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VWcoEPhOi9ILHtMNA1Dt/d+VEgLxwy56hexiFFpjefo=;
	b=JNEtpTsuuJwol7Rj7mnONLisZIic1L7tLFXmp6Cejfo8JTGzJq8VN15cR2qIRzPKT4xU0F
	WKJ/7pk8ud9XxnXtPfw8pQDdcRw1FM7o12pvHTp5S+mJpLpj1Ye7NQ3++BRfF4byNnkWLe
	AZk2QiGhwXt5BfAemCzIv5FIW8HJQVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716232872;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VWcoEPhOi9ILHtMNA1Dt/d+VEgLxwy56hexiFFpjefo=;
	b=CkVo3Gbre5LLk43F72vQeMcdssC53u8L/p4JxuS4UqzI68r9r9IwIMRv9GvKRx79gMaFNE
	kZ6/rvm3TdawrCCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716232872;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VWcoEPhOi9ILHtMNA1Dt/d+VEgLxwy56hexiFFpjefo=;
	b=JNEtpTsuuJwol7Rj7mnONLisZIic1L7tLFXmp6Cejfo8JTGzJq8VN15cR2qIRzPKT4xU0F
	WKJ/7pk8ud9XxnXtPfw8pQDdcRw1FM7o12pvHTp5S+mJpLpj1Ye7NQ3++BRfF4byNnkWLe
	AZk2QiGhwXt5BfAemCzIv5FIW8HJQVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716232872;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VWcoEPhOi9ILHtMNA1Dt/d+VEgLxwy56hexiFFpjefo=;
	b=CkVo3Gbre5LLk43F72vQeMcdssC53u8L/p4JxuS4UqzI68r9r9IwIMRv9GvKRx79gMaFNE
	kZ6/rvm3TdawrCCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E12CC13A6B;
	Mon, 20 May 2024 19:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zvXSNqeiS2Z4fwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 20 May 2024 19:21:11 +0000
Date: Mon, 20 May 2024 21:21:10 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org,
	josef@toxicpanda.com
Subject: Re: [PATCH 1/6] common: udev settle before _scratch_pool_mkfs
Message-ID: <20240520192110.GH17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715896529.git.dsterba@suse.com>
 <b8e39744f98bde6484d222c6e90240f074df1eaf.1715896529.git.dsterba@suse.com>
 <30c274a6-adc1-42a7-91cf-8a386884106f@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30c274a6-adc1-42a7-91cf-8a386884106f@oracle.com>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]

On Sat, May 18, 2024 at 05:57:12AM +0800, Anand Jain wrote:
> On 5/17/24 06:12, David Sterba wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> > 
> > There are some btrfs tests that do _scratch_pool_mkfs in a loop.
> > Sometimes this fails with EBUSY.  Tracing revealed that udevd will
> > sometimes write to /sys/block/device/uevent to make sure an event
> > triggers to rules get written.  However these events will not get sent
> > to user space until after an O_EXCL open as been closed.  The general
> > flow is something like
> > 
> > mkfs.btrfs /dev/sda /dev/sdb /dev/sdc /dev/sdd
> > mount /dev/sda /mnt/test
> > <things>
> > umount /mnt/test
> > 
> > in a loop.  The problem is udevd will add uevents for the devices and
> > they won't get delivered until after the umount.  If we're doing the
> > above sequence in a loop the next mkfs.btrfs will fail because udev is
> > touching the devices to consume the KOBJ_CHANGE event.
> > 
> > Fix this by doing a udev settle before _scratch_pool_mkfs.
> > 
> 
> 
> 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   common/rc | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 0fe56382a6a497..5d38571ffe87eb 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -903,6 +903,12 @@ _scratch_pool_mkfs()
> >   {
> >       case $FSTYP in
> >       btrfs)
> > +	# For multi-disk file systems udev can queue up events on the device
> > +	# when we mkfs the device, and thus tie up the device after we've
> > +	# unmounted.  Tests that _scratch_pool_mkfs() in a loop can sometimes
> > +	# trip over udev trying to do the updates after the umount, so make sure
> > +	# we settle before we try mkfs'ing so we don't get an EBUSY
> > +	$UDEV_SETTLE_PROG >/dev/null 2>&1
> >           $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL > /dev/null
> >           ;;
> 
> 
> Just curious: have we seen this issue even after the btrfs-progs commit 
> below?
> 
>    e54514aaeab6 btrfs-progs: fix stray fd close in open_ctree_fs_info()

That's a good question, I don't know but I can revert the change and see
if things break. This may take time as triggering the udev/mkfs race is
not reliable.
