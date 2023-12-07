Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EKlH9VGo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PDvSxD86"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF9810C2
	for <fstests@vger.kernel.org>; Thu,  7 Dec 2023 05:49:15 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0ADEC21B3D;
	Thu,  7 Dec 2023 13:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701956954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3yqzIpfk4tW7oRiQjz5OLluc6v3BUjDnldmkuuvyXM=;
	b=EKlH9VGo1SXji9Z4B56+azdYWitfOL2odqv87xp9zTXtJdFwGQb1lGlqMJCizGbxWOgE9t
	1bGVlU6mKV7qTLxsnmPnu/K10RrcEpkzi/XczM2ElPHwZ/djLvZtOXB4mVmZMjoTqboR++
	C7k58+xaI8EYefnMI6XC7jx1lGhrU/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701956954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3yqzIpfk4tW7oRiQjz5OLluc6v3BUjDnldmkuuvyXM=;
	b=PDvSxD86Jw8k+2J5SNbTodmGf1xfipS7eRxrQwF+b+zmZfQf2L+BYRfr+RSG1QGfOxZG27
	nmm1cqsoyS9re4Bw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EE39B13907;
	Thu,  7 Dec 2023 13:49:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wEyaIlfNcWU3GgAAn2gu4w
	(envelope-from <ddiss@suse.de>); Thu, 07 Dec 2023 13:49:11 +0000
Date: Fri, 8 Dec 2023 00:49:02 +1100
From: David Disseldorp <ddiss@suse.de>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 0/5] btrfs/282: resolve intermittent failures
Message-ID: <20231208004902.3df2bed2@echidna>
In-Reply-To: <949dd5fe-560f-4986-b653-c84aa9afd778@gmx.com>
References: <20231207072056.14588-1-ddiss@suse.de>
	<949dd5fe-560f-4986-b653-c84aa9afd778@gmx.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[24.23%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.40

On Thu, 7 Dec 2023 20:19:00 +1030, Qu Wenruo wrote:

> On 2023/12/7 17:50, David Disseldorp wrote:
> > btrfs/282 fails intermittently under some circumstances. This patchset
> > adds dmdelay to make storage latencies more uniform and slightly
> > increases throttled rate tolerances.  
> 
> My concern using dm_delay is, is the delay per-merged-bio or something else?
> 
> If the delay is only per-bio (after merge), then I'm afraid it would not
> be good enough.

The dmdelay device presents itself as a regular block device, so I think
delay_map()->delay_bio() handling comes after any merges.

> The bio plug we use in scrub can have much higher chance to result a
> difference in the scrub speed.
> 
> We may want a delay behavior which can take bio size into consideration
> at least.

Should we manipulate it a bit by fiddling with queue/max_sectors_kb and
queue/nomerges?

Thanks, David
