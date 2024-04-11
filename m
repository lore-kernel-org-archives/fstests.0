Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C1613B5BA
	for <fstests@vger.kernel.org>; Thu, 11 Apr 2024 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712817172; cv=none; b=qzixQdE7N3shyoet/2N9aPGYs+m3DEH8DlBeSpDhayPmx6sqs94p3lXq8/ZDvsYLm3yeHgvlXJ4wZgFstsiWQP+ErwxRh7O/zvd6xMezGgNOREuy53ub483Cwk3rMUAagOAsg5hFLyZdnp7qu9djYNJ4T0vXTVv9RWeugrEA6OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712817172; c=relaxed/simple;
	bh=EjP9xRENL5PBcsjZly+yNHisSxl3OFpPkFuzX9bn5N8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FmdBQd1sG2O6JiCn3ZYXgeetSExELnma7NAjge0Y5nZ9AUMUt9XrLxqchenv3iDYTsTZvt/xpI8GpOMdJ/+oKIyi3TVrh/X/CjV8zHDJF5Nrhw8wxlmPVyNwLfQN2/FN7wnYspLMZPO+s/NS9YkAy/VzNo16+C87WQfFFRCjbCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CU2U+mf8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9M9KZRnA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kj9NnSVu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iagcotxv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CU2U+mf8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9M9KZRnA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kj9NnSVu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iagcotxv"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4B3D20989;
	Thu, 11 Apr 2024 06:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712817163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gwLxFzeKe267vYXY8Qa7djPHtiF4+o0sAcOZhS4Pyrg=;
	b=CU2U+mf8ATqFfsz98FdOP35rS/IjY+8I8ESVp+DTktbPt0AYhAAuv10r/aIKRtNH69emZO
	QtYum4rgBLshQol7bCO1VJoZrNjwPu5QYVqhFXx5TBM3yyH1yW/Ji3QseZ0W2sOh2FLoAZ
	QDNX/zirY919uvwh+GOj0zRs5ujEyTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712817163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gwLxFzeKe267vYXY8Qa7djPHtiF4+o0sAcOZhS4Pyrg=;
	b=9M9KZRnAYiDfHDXSTKdiC2uSzhwuXkw2QhfArmNgDtr5U131qSOZxTnOfk6kx53W+CDPRT
	6jWsVX5hngbG2iDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712817162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gwLxFzeKe267vYXY8Qa7djPHtiF4+o0sAcOZhS4Pyrg=;
	b=kj9NnSVuaKPo3yvsTdSWOvMJHkv3mRzV3YTfvcz0YWZHCczzETvSSnaaNEfIGG2BRoGpjT
	/oZoZax567fN4k6YHRqce4ANdcyxPbBSDUb4pwndVgqbJ0D+XIisWBfAnfRKXdxXmco2Qf
	gI9cRZ5ryRxnFQUBQpWTv/jceGCLK3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712817162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gwLxFzeKe267vYXY8Qa7djPHtiF4+o0sAcOZhS4Pyrg=;
	b=iagcotxvvRD1jX6/RtTLs5xJK4EU7kbCyzgNN4PigwKiCFT+KbtLoJM4D9ADMMy3kRa6Vz
	u0wEqvRk2SyJ6HBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91CF913685;
	Thu, 11 Apr 2024 06:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mqz4EAmEF2aJIQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 11 Apr 2024 06:32:41 +0000
From: David Disseldorp <ddiss@suse.de>
To: fstests@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
Subject: [PATCH 1/2] common/config: export TEST_DEV for mkfs.xfs
Date: Thu, 11 Apr 2024 16:32:33 +1000
Message-Id: <20240411063234.30110-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 0.13
X-Spam-Level: 
X-Spamd-Result: default: False [0.13 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.07)[62.33%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email];
	RCVD_TLS_ALL(0.00)[]

As of xfsprogs commit 6e0ed3d1 ("mkfs: stop allowing tiny filesystems")
attempts to create XFS filesystems sized under 300M fail, unless
TEST_DIR, TEST_DEV and QA_CHECK_FS environment variables are exported
(or a --unsupported mkfs parameter is provided).

TEST_DIR and QA_CHECK_FS are already exported, while TEST_DEV may only
be locally set if provided via e.g. configs/$HOSTNAME.config. Explicitly
export TEST_DEV to ensure that tests which call _scratch_mkfs_sized()
with an fssize under 300M run normally.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/config b/common/config
index 2a1434bb..4bd5650f 100644
--- a/common/config
+++ b/common/config
@@ -932,6 +932,9 @@ else
 fi
 
 _canonicalize_devices
+# mkfs.xfs checks for TEST_DEV before permitting < 300M filesystems. TEST_DIR
+# and QA_CHECK_FS are also checked by mkfs.xfs, but already exported elsewhere.
+export TEST_DEV
 
 # make sure this script returns success
 /bin/true
-- 
2.35.3

