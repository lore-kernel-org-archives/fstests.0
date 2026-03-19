Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D823B62C
	for <fstests@vger.kernel.org>; Thu, 19 Mar 2026 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881728; cv=none; b=Fk630ar6NiyUhIffVCZHpJAez6KNe65nI06ossRQqfkvMpVGsg1c72HGNstOee79Hrnc7QLkOgfpSB1TmmZkAAN9632P9WL1cfLgPmLPHIAQKIooiJN8vqxFenmwEvxNdP/G7zuaAq1Prip2Z94optctIgz+2YNnDbfivsrQe8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881728; c=relaxed/simple;
	bh=Y9sV/jc+Hyd2YuRe1/do7sJQIjaAm3OMxCwXTQplcJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qB6p2Sbrn1q3iJFnN1JFuW/vkOlSv6UMkJDQPK7YAGe1rZ1u633sbKDAV5dM1ROne02db3cIIFmLoXh8KYFanMPf5wYW6X6X9sRWDB8kDRHMhq74SBzzXBnk8+36DQLsTvDzQnMbXKC/ZtzSuRdrmhOO+xwHJvceUGm4fSaA9zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sn7h9sMY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0CLg7dW5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sn7h9sMY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0CLg7dW5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sn7h9sMY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0CLg7dW5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sn7h9sMY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0CLg7dW5"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 42D8E5BCE4;
	Thu, 19 Mar 2026 00:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773881725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Je+IG2kA/DgiSRSX+toW6iRKmlkG0avbFDYejbYerF8=;
	b=Sn7h9sMYrpWCz6pzYsoqiflU3t6NPFKmvv2YU/Z2CCbSLx3HVKJ6X6Zs6ShMFg5sLBZqoZ
	O2wWEu9cfBYcoJF0VZLg5/tPSZ7mrPx6hUchqH6SjK7oFDJZQJy9LD5/Ko+rEnnZBCphA4
	KDVIUF6ctHMiP+G9JL38TvvKVEFv5eU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773881725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Je+IG2kA/DgiSRSX+toW6iRKmlkG0avbFDYejbYerF8=;
	b=0CLg7dW5kA0gUVMLB+u4bNZ9UfQdiBiT9WRdzWiJZzPeny/+c699BYpR79vlIduYmdjGWZ
	kq2vURhHlyZK7jCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773881725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Je+IG2kA/DgiSRSX+toW6iRKmlkG0avbFDYejbYerF8=;
	b=Sn7h9sMYrpWCz6pzYsoqiflU3t6NPFKmvv2YU/Z2CCbSLx3HVKJ6X6Zs6ShMFg5sLBZqoZ
	O2wWEu9cfBYcoJF0VZLg5/tPSZ7mrPx6hUchqH6SjK7oFDJZQJy9LD5/Ko+rEnnZBCphA4
	KDVIUF6ctHMiP+G9JL38TvvKVEFv5eU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773881725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Je+IG2kA/DgiSRSX+toW6iRKmlkG0avbFDYejbYerF8=;
	b=0CLg7dW5kA0gUVMLB+u4bNZ9UfQdiBiT9WRdzWiJZzPeny/+c699BYpR79vlIduYmdjGWZ
	kq2vURhHlyZK7jCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 023E24273B;
	Thu, 19 Mar 2026 00:55:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8FyWKXtJu2kdaQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 19 Mar 2026 00:55:23 +0000
Date: Thu, 19 Mar 2026 11:55:12 +1100
From: David Disseldorp <ddiss@suse.de>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] avoid endless udevadm wait
Message-ID: <20260319115512.57246b59.ddiss@suse.de>
In-Reply-To: <Z9Chs5qdOg7rXevY@dread.disaster.area>
References: <20250311050346.5868-2-ddiss@suse.de>
	<Z9Chs5qdOg7rXevY@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

[digging up an old thread]

Hi Dave,

On Wed, 12 Mar 2025 07:48:51 +1100, Dave Chinner wrote:

> On Tue, Mar 11, 2025 at 04:03:47PM +1100, David Disseldorp wrote:
> > "udevadm wait <dev>" without a --timeout=SECONDS parameter will wait
> > endlessly. Endless wait can be triggered in f2fs/008 by e.g. using a
> > zram device as a SCRATCH_DEV, where "device type is unknown" failure
> > sees the /dev/mapper/$vgname-$lvname node never appear.
> > 
> > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > ---
> > It might make more sense to add a default timeout to _udev_wait(), but
> > that could also call udev{adm }settle.  
> 
> One of the points of moving to _udev_wait was to explicitly wait for
> the specific device to appear or disappear, indicating that the
> previous admin operations have completed. 'udevadm settle' does not
> do that - it waits for the global queue of events to drain and
> dev config failure doesn't generate udev events.
> 
> Hence tests that silently fail dm/lvm device setup will continue to
> run on something they shouldn't have, and nobody will realise that
> the LVM setup did not run correctly.
> 
> OTOH, _udev_wait() will hang in that situation because it's waiting
> for the device node to appear (or disappear) so it can be
> immediately used. We don't need udev to finish draining queues - we
> only need to wait for the device node to appear and the test is good
> to go.
> 
> This behaviour provides obvious failures when device setup/teardown
> fails in some way. This should not happen, and when it does
> _udev_wait hanging forces that failure to be triaged and fixed
> immediately....
> 
> If we add a timeout to _udev_wait(), then we're back to the old
> behaviour where device config failures get ignored and the test runs
> incorrectly. Except now it is worse because we have to wait a
> timeout before the test is then run....

I've revisited this, as I manage to break udevd once a year or so in my
minimal initramfs-based xfstests env. I find a timeout with
golden-output breaking error message much easier to debug than an
endless loop. Please see:

https://lore.kernel.org/fstests/20260319005154.29274-1-ddiss@suse.de/T/#u
