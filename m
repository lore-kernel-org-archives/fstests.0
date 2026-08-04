Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BA333FE15
	for <fstests@vger.kernel.org>; Tue,  4 Aug 2026 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845805; cv=none; b=JbUsHQE/icgnps3g4dZfZhVpr6YRNg+jPPMlCdYS0pWn7WZqeotiPZEaiZXhhTEvWUibk+2czhgz1HjYE+Dg+BpZynI/0f0/k1YdkLUkIap6+w91Cn/QrGPPUzIxS9hqKjLdrL9FqH3RChEikaeFuOsi0FwP9eZaEmn4PSHTUdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845805; c=relaxed/simple;
	bh=9GssKbEx/DKlYYxzUg7xBi6wbt23eV3SQ2I57yTh5mk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ij/58f1dfA04LKDOEiJ9LRPqwg5Ph3rt/wWXS+39rIP956RMDgb74hH3QQOZmYaP1oX/7cbJr0lftBV7Uu6JgGgWdawg2GgGxo9OYWBW/y3CDgoqE03xndh9IZHLA6Afwr5NLfWil44K8HqjUwjY0QxmTtCfdiNVZj3pjhXMJg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u7BEg95p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wXSWIGkb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b3goLrag; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bQVv+th1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u7BEg95p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wXSWIGkb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b3goLrag";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bQVv+th1"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A45D3FBB;
	Tue,  4 Aug 2026 12:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785845795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OyrEhPNdu87U6Xrof56kU5t3PZ1KxuGk3h8QCRJ7qU4=;
	b=u7BEg95pdbObpt4hYQ7G5t0tgEkIcVq/noCY8Dd9M+tkwGzdKr8E7QCRCHOuVvrap1CJtP
	dhh8xllRP6VQOsn5IsBH5RoEibdc4xgnsm64N5AyYwLr0EOuxl1iPWl/3YBIqmtnc/zd9s
	wfjmkF6IRNzd/jHfgUQG2xsAHy7nCnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785845795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OyrEhPNdu87U6Xrof56kU5t3PZ1KxuGk3h8QCRJ7qU4=;
	b=wXSWIGkbX26p5DaQjK2RlYa3myEZpaBesGUxx4YT2x52rRACbE32N6jqsCYTgDKhfE4oaJ
	OMKg/9Ysf8l0IKAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=b3goLrag;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bQVv+th1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785845791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OyrEhPNdu87U6Xrof56kU5t3PZ1KxuGk3h8QCRJ7qU4=;
	b=b3goLragu0kyI9xSeR2UAdObJ5FJLqLYIGwJPSUPB5j+R0ZUI8WeAqIoV1abFt3G/Esa3c
	bSLN3TUlzmYgqh+bBTqnFhIi6UfnuNgGjjj9LBjjMAudNccYO6dPbKgL8BNh9ugzbBAJea
	7uy79JkFATsFpmWBrAcijJcOV/2HqpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785845791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OyrEhPNdu87U6Xrof56kU5t3PZ1KxuGk3h8QCRJ7qU4=;
	b=bQVv+th1wlsi4hev1eGXQGimKgzbLMPCRR6zTWBTU+0CiVztiafPHMbXkCZJ+16f2Zg+xe
	59oi3CZALDGvCkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C490779BB;
	Tue,  4 Aug 2026 12:16:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5M7NMh3YcWoaPwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 04 Aug 2026 12:16:29 +0000
Date: Tue, 4 Aug 2026 22:16:03 +1000
From: David Disseldorp <ddiss@suse.de>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs: use -w instead of --path for man program
 portability
Message-ID: <20260804221603.0d48ad17.ddiss@suse.de>
In-Reply-To: <20260803115819.17110-1-ailiop@suse.com>
References: <20260803115819.17110-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9A45D3FBB
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:email,suse.de:dkim];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Looks fine.
Reviewed-by: David Disseldorp <ddiss@suse.de>

On Mon,  3 Aug 2026 13:58:19 +0200, Anthony Iliopoulos wrote:

> Some implementations of man(1) do not support the long option --path to
> display the actual location of a man page, which can cause these tests
> to fail on systems using alternative man packages, such as mandoc.
> 
> Switch to using the more standard -w flag across these tests to improve
> portability while maintaining the same behavior

The mandoc man.options.1 page seems to do a pretty good job of
tracking where the various flags appear across man utils.
