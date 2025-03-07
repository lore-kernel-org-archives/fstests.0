Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3918DB3A
	for <fstests@vger.kernel.org>; Fri,  7 Mar 2025 04:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741320270; cv=none; b=KDVaJFPe6quxzfpp7M8LTWvmPB9AW0yNubSdv1ZkylEE18akDlPLVb5gTA7rhZEouhp5WvR9ipcEtQJTyif8uNXNuxc5A0wjwVfcDTjjPHUOt0FxsqO54llW08Gm4wTTR4oPchQLN+yZetcSWlWUcp22vvc/MOgX14nHoY+eBmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741320270; c=relaxed/simple;
	bh=mexwXOOGZEWFtaVep5N4+9e7U/D/bvfUpLrW7WNbYSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSDKg0qbR3bpB+8KiT4jABrLMxQFCPwFNX5LHXePtfhxZgWsxnmiyRSMuI2TITpJsQMaV/4xjLb4tjc8yp0OjGmMvelUNEhWhGbt+XUGHipI09jRbSdV0TECGGTKai1/C93ZSAEJS9v+rVxFeMI1wffGfz7JLYoD7AXJholXxhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BdyUl0QT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hS74Wif5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BdyUl0QT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hS74Wif5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BdyUl0QT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hS74Wif5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BdyUl0QT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hS74Wif5"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4C4B21193;
	Fri,  7 Mar 2025 04:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741320266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fsdef/Q34xmF6k+hmNqaO0zc1hZhJuOuDXccUfsdpzk=;
	b=BdyUl0QTmQkz7bSm1EYXxPMNbPYXltkdkleVfukctqF1XC33a/Nr1X4ePrI9bO5w7HiPiB
	ZjyPWj57pELk18o7P88Z6Ion3XNQrke8TMlgMhE8DDugL4AGwyfLCekomXnQKT8wQvxaOL
	y2Iadx5sYdyxIeCWM+qUClBc/9NOccc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741320266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fsdef/Q34xmF6k+hmNqaO0zc1hZhJuOuDXccUfsdpzk=;
	b=hS74Wif5tobYhz0JJmejiCrRT0aK2YL82tknojQaD15fOvmS7zBQSTfjSClT3lnpXuzy6a
	lUHP8fU5D/TltxAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741320266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fsdef/Q34xmF6k+hmNqaO0zc1hZhJuOuDXccUfsdpzk=;
	b=BdyUl0QTmQkz7bSm1EYXxPMNbPYXltkdkleVfukctqF1XC33a/Nr1X4ePrI9bO5w7HiPiB
	ZjyPWj57pELk18o7P88Z6Ion3XNQrke8TMlgMhE8DDugL4AGwyfLCekomXnQKT8wQvxaOL
	y2Iadx5sYdyxIeCWM+qUClBc/9NOccc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741320266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fsdef/Q34xmF6k+hmNqaO0zc1hZhJuOuDXccUfsdpzk=;
	b=hS74Wif5tobYhz0JJmejiCrRT0aK2YL82tknojQaD15fOvmS7zBQSTfjSClT3lnpXuzy6a
	lUHP8fU5D/TltxAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6885B13726;
	Fri,  7 Mar 2025 04:04:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BtHpB0lwymfLagAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 07 Mar 2025 04:04:25 +0000
Date: Fri, 7 Mar 2025 15:04:20 +1100
From: David Disseldorp <ddiss@suse.de>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 0/5] fstests: remove old SGI QE scripts
Message-ID: <20250307150420.738c4d28.ddiss@suse.de>
In-Reply-To: <20250306213921.3769440-1-david@fromorbit.com>
References: <20250306213921.3769440-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri,  7 Mar 2025 08:34:45 +1100, Dave Chinner wrote:

> Hi folks,
> 
> The scripts this patchset removes are historical relics. They
> haven't been maintained, in many cases they don't work, and in a
> couple fo cases they are reliant on test machines that SGI
> decomissioned almost two decades ago.
> 
> There is no point in trying to maintain these scripts, but they
> still create dependencies on common fstests code that is now getting
> in the way of making changes to fstests infrastructure.
> 
> Hence we should simply remove them and get rid of all the technical
> debt they contain with them.

For the series:
Reviewed-by: David Disseldorp <ddiss@suse.de>

Thanks
