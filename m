Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED192E337F
	for <fstests@vger.kernel.org>; Wed,  5 Mar 2025 03:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741144258; cv=none; b=DksPVwfmkKTYIcuxw/bVHaO6sMITVBCP9OFmPqvvlK58zQYm+BdTQ9zyfAzpbre7RqxeCysDN1NFsaCShTSKzXDNEEU9rD32Ctxk5+GiFRumpF2B4DrV2JXYC4/W7iR87DRlgVHoIc51UWoW/yEf4hYtn9PBQkVjcYtQpWjv0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741144258; c=relaxed/simple;
	bh=fZtv3/rwidPZy7u1Ep/Sul0S/OHhPs7ycffZT3/N4Do=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPNQlkND28BQkobSAzfCkpkWDF21zJo86UzNd4H8czTtmalnf2rN2AXlfFI0LNuBtXJWeZ4GFBdojV+MiQ+JLCfLirt2Ab0Lmo/Rk33yLDdVjVDpIn4Wo2Ce0JNPBwj8XXlbO4BA6kQcWSy0uXwiOadrItVyu7krwA960rPdxXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D8942211A3;
	Wed,  5 Mar 2025 03:10:54 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A8AA13939;
	Wed,  5 Mar 2025 03:10:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KB+KD73Ax2cqCQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 05 Mar 2025 03:10:53 +0000
Date: Wed, 5 Mar 2025 14:10:43 +1100
From: David Disseldorp <ddiss@suse.de>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/633: add _require_idmapped_mounts check
Message-ID: <20250305141043.31c3eb95.ddiss@suse.de>
In-Reply-To: <20250304234819.783-1-ailiop@suse.com>
References: <20250304234819.783-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: D8942211A3
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On Wed,  5 Mar 2025 00:48:19 +0100, Anthony Iliopoulos wrote:

> Skip the test on older kernels that don't implement mount_setattr and
> open_tree syscalls, instead of failing.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  tests/generic/633 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/633 b/tests/generic/633
> index 3bd18df68ba5..f58dbbf5f222 100755
> --- a/tests/generic/633
> +++ b/tests/generic/633
> @@ -12,7 +12,7 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
>  # Import common functions.
>  . ./common/filter
>  
> -
> +_require_idmapped_mounts
>  _require_test
>  
>  echo "Silence is golden"

Looks good, although generic/696 and generic/697 probably should be
covered too.

Reviewed-by: David Disseldorp <ddiss@suse.de>
