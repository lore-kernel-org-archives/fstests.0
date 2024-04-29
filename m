Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0E053378
	for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392041; cv=none; b=qBIoRtgBDVEENvJaRZfZ5z3KGeyzYs46L9kcK6jsRMI6RsKeZnGPUocRHR8yrYH+89/WhF+fVF0QroY3jilX7CH2+ovL1tnBbr9glAxRveeKWFmhsiT2TnysKnGfklCMGAR6w+7KfopNXqpFJgv4gJobdmvMq7qyFcaLRvfUQM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392041; c=relaxed/simple;
	bh=aax5oJ319yELPWk4UsoqNR0nSNOBC5ozvtcWGiNjlMw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BvGaKgwDZcCiU/TueBG5ih9mYY8Tf47N3XOMt3mDmapgWw6vtlZkmw8udeZ+8YQj9jp1YcAg92aN+XgvGyFnkGEXPUo+uDwjuUf/9EiQECNwD2yMtX7TbA450/ac7AuaZBdlQIlM0OQzeQ0/Wo+46m7VBj2wqSI2OIUtv8iWUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OGAv+1ZL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ir4/FYTh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oMuKAb6t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fe5QpaAk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OGAv+1ZL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ir4/FYTh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oMuKAb6t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fe5QpaAk"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F32F21F387;
	Mon, 29 Apr 2024 12:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714392036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TUkIIiVeSCd+y6Mt5zCkOmkXScHonPyjj6mC3Kizhzk=;
	b=OGAv+1ZLfKzYJs5s5i6zBxWaaxxlp5LYPFhE5P3kHNLQio3RXdRfTgV2/A4l2o7K0hHqjZ
	0BQKYWlSFg31e3fGD2uaxsDRS5h626+hVjVFEMlwd1BYiK4aYR1yNYl8F4kVN0KdFm2I8N
	y+bpZZLwHkJRdtXDqrmH1faYRlBR1go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714392036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TUkIIiVeSCd+y6Mt5zCkOmkXScHonPyjj6mC3Kizhzk=;
	b=Ir4/FYThHjldsAXU/oQd8fohrJru0h2reIl8XpRRYVQm75Zu8H0fQZkTSDI8YiMeZYRmO8
	ib4Vv8W9bvaIBOAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oMuKAb6t;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fe5QpaAk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714392034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TUkIIiVeSCd+y6Mt5zCkOmkXScHonPyjj6mC3Kizhzk=;
	b=oMuKAb6thzUZh0GqSrb/eaeHVB1ADktDBNN+RUJYWfAYRsXUi8vP5nj0LAnY+4yJzMB2/Y
	cihDIQthCNtvx3N8PQCdgoaM1AUP8Tb7HiEfub2QVZo721YGS1MC5LfR8bJuU0F17ruwgW
	hNiNJ7u5KHGv8MHNm2j2dKRUXwK7nrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714392034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TUkIIiVeSCd+y6Mt5zCkOmkXScHonPyjj6mC3Kizhzk=;
	b=fe5QpaAkKB5oMB9rDKeX80jzSJ0o/exts3yXNJjqOTs2baSTeDMkITvmmZOlIs/5huI41q
	DWD7W7MY/XKlp3Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66411139DE;
	Mon, 29 Apr 2024 12:00:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KgZbBuGLL2Y+UwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 29 Apr 2024 12:00:33 +0000
From: David Disseldorp <ddiss@suse.de>
To: fstests@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2] tests: _fail on _scratch_mkfs_sized failure
Date: Mon, 29 Apr 2024 21:58:27 +1000
Message-Id: <20240429115826.9171-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F32F21F387
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

If _scratch_mkfs_sized() fails, e.g. due to an FS not supporting the
provided size, tests may subsequently mount and run atop a previously
created (e.g. non-size-bound) filesystem.
This can lead to difficult to debug failures, or for some -ENOSPC
exercising tests, near infinite runtimes. Avoid this by renaming the
current function to _try_scratch_mkfs_sized() and _fail in the parent
_scratch_mkfs_sized() wrapper.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Suggested-by: Darrick J. Wong <djwong@kernel.org>
---
Changes since v1:
- call _fail in a wrapper function, instead of adding failure handlers
  to individual test _scratch_mkfs_sized() callers.

 common/rc | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 56f1afb6..e95070dd 100644
--- a/common/rc
+++ b/common/rc
@@ -968,8 +968,8 @@ _small_fs_size_mb()
 }
 
 # Create fs of certain size on scratch device
-# _scratch_mkfs_sized <size in bytes> [optional blocksize]
-_scratch_mkfs_sized()
+# _try_scratch_mkfs_sized <size in bytes> [optional blocksize]
+_try_scratch_mkfs_sized()
 {
 	local fssize=$1
 	local blocksize=$2
@@ -1111,6 +1111,11 @@ _scratch_mkfs_sized()
 	esac
 }
 
+_scratch_mkfs_sized()
+{
+	_try_scratch_mkfs_sized $* || _fail "_scratch_mkfs_sized failed"
+}
+
 # Emulate an N-data-disk stripe w/ various stripe units
 # _scratch_mkfs_geom <sunit bytes> <swidth multiplier> [optional blocksize]
 _scratch_mkfs_geom()
-- 
2.35.3

