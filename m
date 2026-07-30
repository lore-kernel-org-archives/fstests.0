Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CCB41D625
	for <fstests@vger.kernel.org>; Thu, 30 Jul 2026 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424714; cv=none; b=q7CYLfXrn3grMw6aNB5ejD/qCX3OmAtMe+gB9nm8Mj7xrfIJn59ql3U+B3eE2VOTOKOOFUzJ/mWotcNhtEiKDWeu0Yx87G6LolpI/bkUQ6GZySavyxpjoGQLNvi41qhGIZlnLA5mF/algvK6Ep1eLwxOu1JujQYvkYENwYWp3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424714; c=relaxed/simple;
	bh=u/25T2bQ2WJkBsxuZKA7eeaNHeOPrDNRWdkLzYx8NW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gphf9L4yAFQxw3O0ro9rAhGwegw2VTnG/zNriXQqkiGFj64xhgbwcpWp0Hn+Vl3bvM4jfEiL+kG9NhTFYPG+F4VhY8EI6ufVYYNveByCGHH0l1THyiwrp1zXA0NonF5ADVRjURiO4uxd7ZHs7NVCmell1iWvbF7yPT6JzJ3zmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DuLwwiPI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=50RC2ThL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=On2knv6e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4njU99Te; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DuLwwiPI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="50RC2ThL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="On2knv6e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4njU99Te"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA2EB3E9D;
	Thu, 30 Jul 2026 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785424706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/Za8ur7w2XoUuP4q06Oa0MgRM2bsWApnZ+HtwB5CzZE=;
	b=DuLwwiPIxJFKAsSYiAQQwi9eSiB2sACfQ5a/l3ZiUidAVEyC2TMZMnOcrNwZPF1v289XQJ
	+lmYPhKbMA2ejDHxcVbC+q/EzaMtBrujxT70EfEe0cUYrV+IsDhAWuMhC1Xi42OWgRfFpo
	e4gcvMvicUaOnFO/Wwq4MK5h2AKI2Ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785424706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/Za8ur7w2XoUuP4q06Oa0MgRM2bsWApnZ+HtwB5CzZE=;
	b=50RC2ThLd1FGpyPr0hEvW/vr9n6A2wNOdvKR1E9M13ZzLZGklNPnh86lyySfHi4iT+8YAl
	tw9tOpH//FObLdAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=On2knv6e;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4njU99Te
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785424702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/Za8ur7w2XoUuP4q06Oa0MgRM2bsWApnZ+HtwB5CzZE=;
	b=On2knv6e1mR3j1Vn3+3ojh4mPdDTbHckDJIOm1snvjU7zYGC7i/PR9u44u35B1oP6r/seC
	va0hWLLWtSqF0Ip2S8TwyRoEoXz1vzHJS+83p4R1Y3/F0O3wsx/VJTfSrFi36A8y7C8RCu
	b84J/oIi6HTRaPWyj1rjumo+KgH9xn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785424702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/Za8ur7w2XoUuP4q06Oa0MgRM2bsWApnZ+HtwB5CzZE=;
	b=4njU99Ten8AafAsLgu2/l86DHJBTu27DXRquqtAlsrndoq+iPIDIynpH0ZMBlzB402hn3D
	Y/I++T0P9hXdnrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC6DA779CC;
	Thu, 30 Jul 2026 15:18:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sOSkKT5ra2raUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Jul 2026 15:18:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 42D3CA13A3; Thu, 30 Jul 2026 17:18:22 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] generic/347: Fix sporadic test failures
Date: Thu, 30 Jul 2026 17:18:17 +0200
Message-ID: <20260730151817.4120874-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: BA2EB3E9D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

generic/347 was occasionally failing on ext4 in our QA due to ext4
aborting its journal when the filesystem on thinp device was overfilled.
I have tracked the problem down to journal checkpointing failing to
write a metadata block to its final location due to ENOSPC failure from
the thinp device. Modify the test to first preallocate blocks for the
files and remount the filesystem which practically makes sure all
involved metadata blocks were written and so their further modifications
will not fail.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/347 | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tests/generic/347 b/tests/generic/347
index 06df0cf9eddc..56538c160392 100755
--- a/tests/generic/347
+++ b/tests/generic/347
@@ -38,7 +38,17 @@ _setup_thin()
 
 _workout()
 {
-	# Overfill it by a bit
+	# Preallocate space to avoid failure for metadata writeback
+	for I in `seq 1 500`; do
+		$XFS_IO_PROG -f -c "falloc 0 1M" $SCRATCH_MNT/file$I &>/dev/null
+	done
+
+	# Unmount and check the device to make sure all metadata is written
+	_dmthin_check_fs
+	_dmthin_mount
+
+	# Write the data blocks to force thinp space allocation.
+	# Overfill it by a bit.
 	for I in `seq 1 500`; do
 		$XFS_IO_PROG -f -c "pwrite -W 0 1M" $SCRATCH_MNT/file$I &>/dev/null
 	done
-- 
2.51.0

