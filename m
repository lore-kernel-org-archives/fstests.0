Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6137D3FE4
	for <fstests@vger.kernel.org>; Thu, 16 May 2024 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715897572; cv=none; b=iMr97WRuHMQrRq4g7YsHQzEum6ueCF5jy+Yned7rwyv/7g5r0iSNIuSPVfyLLo+lsbQMbt9T2HjRJA6fQxbiLjlpbIYdznxjzyJZu/F05xJdHrHmiCqCvHaSwLqT2RdtBfIxYjzV2i/i/iWHaWxTDqDKkM/FqlYPBrvUdTHLhBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715897572; c=relaxed/simple;
	bh=Ae0ZoTRVdIvMjS4oMpnl/QFpwKih8AA+Nro/wpllR1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbgOT+Fvc1db4cvBsaft5nmeyqVZtvviyjfJ5ttOOqjyNxAHqqaG4FkwgKazOHzUMfnjBA9ZSPQM7MJWRGScoFLTcgZWibe627Hs43Fkn1umMkgNQ/YvozYlm/+U/UBVyAwD6BAU/CJYtk4GtcSC2nh/lhNKrKZmCRwdceKhqkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BQGFy3+R; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BQGFy3+R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BQGFy3+R";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BQGFy3+R"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB70C35053;
	Thu, 16 May 2024 22:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715897568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Cfr8qAtafzBxCcrlf+Nd8rvoFxCDMHxcdO9en3nkdQ=;
	b=BQGFy3+ReBYWcDACmx3Eq3Z4TuD1dGhVL8ZsxkD6Cy5exL/32PHJhJ7nbODCTrXdXRgPcJ
	dyxI/CIBoEIEqoy0tv8xqNI8DghLHhd0AitQBEla4ZZDb+94UUrC8gw3D75inDuapCz7yj
	s+KK59ghEE6udWeezmWw5GE0WVPClnU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715897568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Cfr8qAtafzBxCcrlf+Nd8rvoFxCDMHxcdO9en3nkdQ=;
	b=BQGFy3+ReBYWcDACmx3Eq3Z4TuD1dGhVL8ZsxkD6Cy5exL/32PHJhJ7nbODCTrXdXRgPcJ
	dyxI/CIBoEIEqoy0tv8xqNI8DghLHhd0AitQBEla4ZZDb+94UUrC8gw3D75inDuapCz7yj
	s+KK59ghEE6udWeezmWw5GE0WVPClnU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A52AE137C3;
	Thu, 16 May 2024 22:12:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9wxRKOCERmYdaAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 16 May 2024 22:12:48 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: josef@toxicpanda.com,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4/6] generic/269: require no compression
Date: Fri, 17 May 2024 00:12:48 +0200
Message-ID: <ea5a2c054381fccd48bdf5dd987247a0c6bd55fe.1715896529.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1715896529.git.dsterba@suse.com>
References: <cover.1715896529.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

From: Josef Bacik <josef@toxicpanda.com>

This is meant to test ENOSPC, but we're dd'ing /dev/zero, which won't
fill up anything with compression on.

Additionally we're killing dd and then immediately trying to unmount.
With compression we could have references to the inode being held by the
async compression workers, so sometimes this will fail with EBUSY on the
unmount.

Make it easier on us and just skip this if we have compression enabled.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 tests/generic/269 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/generic/269 b/tests/generic/269
index b7cdecd94f219a..6ee0cb04581632 100755
--- a/tests/generic/269
+++ b/tests/generic/269
@@ -11,6 +11,9 @@ _begin_fstest auto rw prealloc ioctl enospc stress
 
 # Import common functions.
 . ./common/filter
+
+_require_no_compress
+
 # Disable all sync operations to get higher load
 FSSTRESS_AVOID="$FSSTRESS_AVOID -ffsync=0 -fsync=0 -ffdatasync=0"
 _workout()
-- 
2.45.0

