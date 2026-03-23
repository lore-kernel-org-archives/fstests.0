Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEDA2609EE
	for <fstests@vger.kernel.org>; Mon, 23 Mar 2026 05:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774242770; cv=none; b=K6JbNeonrr8mK8Yd6fWchODffReiPSaqXZx8iiHxI5h73aUvN9GVuBU9xGziYbxAMgorzGUjMWg1yZrOhmhKufndH5ih6q8Bmb3YnYxbu7ZxyKkcalUculcpGY+oQteWSb+5cdUQRxgGTzbU/yq9zwfSFZYR0a+8DRp69sY3L/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774242770; c=relaxed/simple;
	bh=fiNx+cQ1GLDwBvgpCt8FIazP0RrY27qXpxdu2X/YShc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cBMQMrQez41+6SoBv5PB89nqtLZ3Qda/OTKba19nNhX3201SUbow7YudTltGM4maK1GnDKTozI76++kbUj2diJlsErNXuOK2hE8kYyQ3xBpDroJQ7ChXiEVYAZPv1e8J4G9CgwYGZVKx96TCUt1Z7sMZmirOoZNH/JQtw2mpW9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XwkgheAH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F4/Lo4WW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hoL4UHvz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GyVMHb9j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XwkgheAH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F4/Lo4WW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hoL4UHvz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GyVMHb9j"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE5BB4D356;
	Mon, 23 Mar 2026 05:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774242760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dRTVmRWSCgI+NysHxuDgkqfyyohq9ODoQR6Qce90rR0=;
	b=XwkgheAHrwwGtyHFxaW3OxltNPxNXXdg3+U/ouzBSoR2R6j6JNwn0wOTiWpPM5GQ/L4cAb
	WuZjIBdklUnLpunEamwhafPkiiuY6uxYaF00SqUifPw+RWUjUqprTkZorg0wC/G8aaAgFv
	pUKKBVXdeYVbXDE8zcRHJ/GUZr2OCeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774242760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dRTVmRWSCgI+NysHxuDgkqfyyohq9ODoQR6Qce90rR0=;
	b=F4/Lo4WWet47KnYduBU4O3+rp+Qqb9lqGs/qMub/KCsDBGSU1tsV/LazFE2VQve1d6iy2Q
	VnwWzOidl7L22CAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hoL4UHvz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GyVMHb9j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774242759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dRTVmRWSCgI+NysHxuDgkqfyyohq9ODoQR6Qce90rR0=;
	b=hoL4UHvza1qtq/ik3dAKQcxy4uQkxyKgg0SdaNmDGAlS+ZiDV1SHGXEVWQyoFtT+FKDcEk
	8iY8INB2VDLDiMY3GY8GfJnYkx4N8zCl22YmIb6rBTt2wdePPKfqHkpv2nNOCPDMGl/QgZ
	GvTbzvG1QEhuUAuROdty6czrr6hAnAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774242759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dRTVmRWSCgI+NysHxuDgkqfyyohq9ODoQR6Qce90rR0=;
	b=GyVMHb9jeAzWbF/ABy0cC/sJADv4xKUiL8EZ+FxJYiRukZbhp1+YwgsojwtCDCXUvGPm3g
	EF0RsN+lm6lZGYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53E90436DC;
	Mon, 23 Mar 2026 05:12:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G+rHAcbLwGmgWQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 23 Mar 2026 05:12:38 +0000
From: David Disseldorp <ddiss@suse.de>
To: fstests@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2] common/rc: add default _udev_wait timeout
Date: Mon, 23 Mar 2026 15:45:58 +1100
Message-ID: <20260323044557.2668-2-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Queue-Id: DE5BB4D356
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

If udevd isn't running then "udevadm wait" loops endlessly. With a
--timeout parameter provided, udevadm (udev-254.27) prints to stderr:
  Timed out for waiting devices being initialized.

The error message causes test failure via golden output mismatch and
is easier to debug than an infinite loop.

The timeout parameter is also compatible with existing
args="--removed <dev>" callers. 60 seconds is relatively arbitrary, but
should be long enough to avoid premature timeout on regular systems.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
Changes since v1:
- increase timeout from 10 to 60 seconds

 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index fd4ca964..a490893f 100644
--- a/common/rc
+++ b/common/rc
@@ -5544,7 +5544,7 @@ _udev_wait()
 	if [ -z "$UDEV_WAIT_PROG" ]; then
 		$UDEV_SETTLE_PROG >/dev/null 2>&1
 	else
-		$UDEV_WAIT_PROG $args
+		$UDEV_WAIT_PROG --timeout 60 $args
 	fi
 }
 
-- 
2.51.0

