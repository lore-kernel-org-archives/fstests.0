Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E600028373
	for <fstests@vger.kernel.org>; Wed, 10 Apr 2024 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712732854; cv=none; b=MabN9PstLnX0Xzl4eHl3a5N1wY4O/c4S8jEBMcKMbpbmB24g4W0tM6b5ciRKBlcvl7Rxa0/mPeLrJ+PyO1zQw/MWmC/dumIyX2r9cjcauBezsomBPcEpYvRGS95eugoFEpZybkQb/Qe1HS/5KxMKSpffFaPX+otOZiN+NZGzrOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712732854; c=relaxed/simple;
	bh=VZmfs1I/yX7ECBx0Pwf6yDSWQhRGmKmJZvKc4hyFHGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BcChZ5tXaum21+w52MLHRMumWYhSv3pfvAccZ4EayLAGml8t5nczq/7ZZmB9ZykNvQ0ZHHTQzpeCR0dOvZxiZTVXTZqoz76U23xleu0ub+L8dpWuVjn/V+M4shn7x5GBO8suNWuRSRtNgMV8P+0sJjqgB1bZmZ3yjiXfcnvMhMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XTG59qwr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f48NdzBn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mE2oJBnd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p5zeVril; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XTG59qwr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f48NdzBn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mE2oJBnd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p5zeVril"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC93C34ADB;
	Wed, 10 Apr 2024 07:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712732851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cVL3iTWiR5e9AjOAjUBTstG8YyLM7zmiC7Bf25+Q6Ys=;
	b=XTG59qwrwSnhi02dDrxRAGnoQN5JmGi1b0ku4z9ZqZvvXqeZudX3cRqcdqNyXomPiuEg3B
	lG3RJwr/odm3dEULIrIa/w9nqIhYc40qFRY9junaFkmM1QUUmutxO1/WBT3Tij0uilS7kr
	7sGeyToj+EQvp9IFYelkA4/ysdVEd4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712732851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cVL3iTWiR5e9AjOAjUBTstG8YyLM7zmiC7Bf25+Q6Ys=;
	b=f48NdzBnoRZmtkO5OVdpHP8oStOyeG+jGvdtQazu5gQQ3Xwypc+PwymAaMouKPF2VD5pOd
	SD3pOLJOf2WjwRBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mE2oJBnd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p5zeVril
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712732850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cVL3iTWiR5e9AjOAjUBTstG8YyLM7zmiC7Bf25+Q6Ys=;
	b=mE2oJBndPUUdy6yTdtJgeTINYNWsiq8UaRAZImpXAntd5tQFUZ9GATZfmFNElMc/v8Th77
	s7WLxaDIyWHqBbUmVsCpXh/3vCn0FIU7O4Cf49H7WlUCu0VeNgn/8DB4xJ0G3OpTvHKXRv
	BPf+pt54zjxB9qRB+aNygr6vBYGZK7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712732850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cVL3iTWiR5e9AjOAjUBTstG8YyLM7zmiC7Bf25+Q6Ys=;
	b=p5zeVril9lX1e9CiSFlucCINBbsEj5EWLc4ogH5cN3PDf92hhhPfQDkeo6mjzvDO5deAms
	kiy+5IJyX3PRFPBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 972FB13691;
	Wed, 10 Apr 2024 07:07:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ifQkErE6FmbiJAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 10 Apr 2024 07:07:29 +0000
From: David Disseldorp <ddiss@suse.de>
To: fstests@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
Subject: [PATCH] generic/027: use 300M FS to accommodate XFS limits
Date: Wed, 10 Apr 2024 17:07:20 +1000
Message-Id: <20240410070720.9035-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	BAYES_HAM(-0.00)[31.20%];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Spamd-Bar: /
X-Rspamd-Queue-Id: DC93C34ADB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

As of xfsprogs commit 6e0ed3d1 ("mkfs: stop allowing tiny filesystems")
attempts to create XFS filesystems sized under 300M fail.

Lacking MIN_FSSIZE configuration, failure of _scratch_mkfs_sized() in
generic/027 doesn't halt the test, leading _scratch_mount() to mount any
previously created (full-size) filesystem. As a result create_file()
may loop near-endlessly awaiting ENOSPC.

Use a 300M sized filesystem to support XFS' limit, and explicitly check
for _scratch_mkfs_sized() failure to avoid endless loops if the limit
changes again in future.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 tests/generic/027 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/generic/027 b/tests/generic/027
index 47f1981d..4f8cf6d8 100755
--- a/tests/generic/027
+++ b/tests/generic/027
@@ -35,13 +35,14 @@ _require_scratch
 
 echo "Silence is golden"
 
-_scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1
+_scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1 \
+	|| _fail "_scratch_mkfs_sized failed"
 _scratch_mount
 
 echo "Reserve 2M space" >>$seqres.full
 $XFS_IO_PROG -f -c "pwrite 0 2m" $SCRATCH_MNT/testfile >>$seqres.full 2>&1
 echo "Fulfill the fs" >>$seqres.full
-$XFS_IO_PROG -f -c "pwrite 0 254m" $SCRATCH_MNT/bigfile >>$seqres.full 2>&1
+$XFS_IO_PROG -f -c "pwrite 0 298m" $SCRATCH_MNT/bigfile >>$seqres.full 2>&1
 echo "Remove reserved file" >>$seqres.full
 rm -f $SCRATCH_MNT/testfile
 
-- 
2.35.3

