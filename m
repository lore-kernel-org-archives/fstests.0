Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DA8F9DF
	for <fstests@vger.kernel.org>; Tue,  2 Apr 2024 04:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033513; cv=none; b=dnZUTEhuIXIB5Zf1TlreC4vpg04S5TPAKIOLchtbk/zvODgyhKJhQ+Kr1a1aBtXKlBm89/aHxH8lB+Gl0Q6NIVi5ehx1g89I/ghc+Xb1XIMeLZ857zL3O/5rXYJnN7rV7hSniQxEmjgqZ/o9MN09bf+/+H6HR+4ATPKvSC5GZUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033513; c=relaxed/simple;
	bh=ZInnicHw687i2Di8v9z2QHoceZGaSfS74hO7RMPPWgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2mQ4Lg7K88xulMVQrMZuYB92946bXiS8+c25b9Bl2Ijc38+LDL5f0GSOSIoOAZP21sRM2UunpAqT5zdoDC7fSm9pDymN8u2nf9EC3Fnf8FH6JRlMyqK6DwJ+l9R9+NlEaigYCT2B37be4LSbr4458LnDI6DzeN0x8ASfZwlsMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cIVEd6Kx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P54MFYko; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cIVEd6Kx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P54MFYko"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E936C20BAD;
	Tue,  2 Apr 2024 04:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712033507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPGglSbWlFQYRmmQALTG0mBolhXPJJZmxb+605Z8mCU=;
	b=cIVEd6Kx5Gd2IfF/RTszt6HVjFw7rrRlBLXilJVxQvpV+FNDV2pKsOE134tiLtlh7NebYc
	PV5TP/imlSnMk4fR9DgAx1dodrjoE+WJByPu332xi0K2MoCv2a7aUQA39uGu+5sAzB12MT
	xpjkv/iNEZ/jcdnQfGhVi7y6W1sQDFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712033507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPGglSbWlFQYRmmQALTG0mBolhXPJJZmxb+605Z8mCU=;
	b=P54MFYko0JXPVf/CSCUiGEsxzqdqXNTRmqBcMewo9McmtfD51DsJxtIUM2FqV/e+pCb9lU
	/qG2cLfghoO9jsBg==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 997B013357;
	Tue,  2 Apr 2024 04:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id P6x5EuKOC2YLIAAAn2gu4w
	(envelope-from <ddiss@suse.de>); Tue, 02 Apr 2024 04:51:46 +0000
Date: Tue, 2 Apr 2024 15:51:35 +1100
From: David Disseldorp <ddiss@suse.de>
To: =?UTF-8?B?6JSh5pmT5paM?= <caixiaobin0807@163.com>
Cc: fstests@vger.kernel.org
Subject: Re: about the format problem at generic/556, and supply a fix patch
Message-ID: <20240402155135.156ab20a@echidna>
In-Reply-To: <5c043f11.244a.18e9c783e59.Coremail.caixiaobin0807@163.com>
References: <5c043f11.244a.18e9c783e59.Coremail.caixiaobin0807@163.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[163.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[163.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[24.44%]
X-Spam-Level: 
X-Spam-Flag: NO

Hi,

On Tue, 2 Apr 2024 09:41:49 +0800 (CST), =E8=94=A1=E6=99=93=E6=96=8C wrote:
...
> From 40ff753ffb3dd4ab8789699dc45a83ece64a3626 Mon Sep 17 00:00:00 2001
> From: "cai.xiaobin" <cai.xiaobin@gd-linux.com>
> Date: Wed, 20 Mar 2024 11:13:29 +0800
> Subject: [PATCH] generic/556: reverse the order of comments to make the f=
ile
> =C2=A0look more like a script file
>=20
>=20
> ---
> =C2=A0tests/generic/556 | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
>=20
> diff --git a/tests/generic/556 b/tests/generic/556
> index 404a3243..ccefbcc4 100755
> --- a/tests/generic/556
> +++ b/tests/generic/556
> @@ -1,5 +1,5 @@
> -# SPDX-License-Identifier: GPL-2.0+
> =C2=A0#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> =C2=A0# FS QA Test No. 556
> =C2=A0#
> =C2=A0# Test the basic functionality of filesystems with case-insensitive

Looks fine to me, although I'd suggest a simpler patch description:
  generic/556: move shebang to first line

Reviewed-by: David Disseldorp <ddiss@suse.de>
