Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43631E9B0C
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 05:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741670036; cv=none; b=gV1oeg4e2Ay7GAO2u+yvQ9PaML1W+UJ+6AGk1JoGfUg7qVV+c6F8DKl4Wf3DL/edsmDDREBYUsbTQsdajcdQF7rfajZzfn2n6V4ozeI0hsFoY/pZFEZAF5KywI7C++NzLVZIx2K4x3WoOzR++LtnguKKtW/yQU+bp227kinu6Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741670036; c=relaxed/simple;
	bh=Kdtd7GDuedk6f67DA2y3LJrUpLih8LI3njPS0fDSYFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDQUtYmakzcnQnPZnNdliOTJuYGNBDtksDhuS3LNfhipXmTH9GKaHeITJGpgDgIdxZPzWGgEcMAUcT0TiIvtstp2+pr0aTlf0B31E3RcPMWOIgHhOhYCfWJKjS42UYobxElGyjNGR9vkUDtmIQEDZo1R3GBNvc8JHvMFXufcEAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qfP3leYy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w2N/cHcA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qfP3leYy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w2N/cHcA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qfP3leYy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w2N/cHcA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qfP3leYy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w2N/cHcA"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C062B1F38A;
	Tue, 11 Mar 2025 05:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741670032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TtB655I4ppmu9duiMZHEJPi/QnzqdH4nupHcceh6cD8=;
	b=qfP3leYyouwbeGQfWBVy2ZPYkWWweWvN3XOX4iEm8LAHUgWha6jksvbEky9py/CHHtFFgq
	Y0IUwC8l/QbDgbIIIUYbeFXtv3H8JH/dB6ISL2mFnMMxaAza2VFmFTe4RsKwrbBVtz/0JZ
	aP9Gy4TclLpD6yTw3yoJB81bgRgzeXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741670032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TtB655I4ppmu9duiMZHEJPi/QnzqdH4nupHcceh6cD8=;
	b=w2N/cHcASfjcDhgct1q1ch9RaBMyZ6aLOueHg7X/Lh3Ad5zuIGCviaSmraziWOJhHpv6Ny
	jQy4F+HuVXX54qCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qfP3leYy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="w2N/cHcA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741670032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TtB655I4ppmu9duiMZHEJPi/QnzqdH4nupHcceh6cD8=;
	b=qfP3leYyouwbeGQfWBVy2ZPYkWWweWvN3XOX4iEm8LAHUgWha6jksvbEky9py/CHHtFFgq
	Y0IUwC8l/QbDgbIIIUYbeFXtv3H8JH/dB6ISL2mFnMMxaAza2VFmFTe4RsKwrbBVtz/0JZ
	aP9Gy4TclLpD6yTw3yoJB81bgRgzeXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741670032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TtB655I4ppmu9duiMZHEJPi/QnzqdH4nupHcceh6cD8=;
	b=w2N/cHcASfjcDhgct1q1ch9RaBMyZ6aLOueHg7X/Lh3Ad5zuIGCviaSmraziWOJhHpv6Ny
	jQy4F+HuVXX54qCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1DB313874;
	Tue, 11 Mar 2025 05:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uy2OKY7Gz2duKAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 11 Mar 2025 05:13:50 +0000
From: David Disseldorp <ddiss@suse.de>
To: fstests@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	jaegeuk@kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH] f2fs/008: avoid endless wait
Date: Tue, 11 Mar 2025 16:03:47 +1100
Message-ID: <20250311050346.5868-2-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C062B1F38A
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

"udevadm wait <dev>" without a --timeout=SECONDS parameter will wait
endlessly. Endless wait can be triggered in f2fs/008 by e.g. using a
zram device as a SCRATCH_DEV, where "device type is unknown" failure
sees the /dev/mapper/$vgname-$lvname node never appear.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
It might make more sense to add a default timeout to _udev_wait(), but
that could also call udev{adm }settle.

 tests/f2fs/008 | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/f2fs/008 b/tests/f2fs/008
index 47696f2b..fdb0b0c2 100755
--- a/tests/f2fs/008
+++ b/tests/f2fs/008
@@ -35,9 +35,12 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-$LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1
-$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
-$LVM_PROG lvcreate -y -L 1024m -n $lvname $vgname >>$seqres.full 2>&1
+$LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1 \
+	|| _notrun "unabled to create LVM physical volume"
+$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1 \
+	|| _notrun "unabled to create LVM volume group"
+$LVM_PROG lvcreate -y -L 1024m -n $lvname $vgname >>$seqres.full 2>&1 \
+	|| _notrun "unabled to create LVM logical volume"
 _udev_wait /dev/mapper/$vgname-$lvname
 
 _mkfs_dev /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
-- 
2.43.0

