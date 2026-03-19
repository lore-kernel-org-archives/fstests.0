Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709CE1662E7
	for <fstests@vger.kernel.org>; Thu, 19 Mar 2026 00:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881551; cv=none; b=dbwnOEoI/sAL9iLw/pqcvKopKXWeXP+3THTcvBG+XwN9BrK5zRCHHiCnkghmbU4sA8l7Xpz+eWXxlzdAQdFPks6o8/MqAFKEIvBTg49XFtvPXTv1uHa+y8IaV7vKmts37QrFW5P1oOT9cAybi5vGP+5WReyJddokQqEoxsY+JN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881551; c=relaxed/simple;
	bh=5WE0FCrdZnzHE8+gdERdkq87YGXFniWHo5PAIoYhJ74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ia4JY/YRhx16HCQ4mzvwhcA5jer/EDXuO7fL2YQ33ojQd0kkzsRUHaEm5opsnkwSbm6XONWkLwz9pRwIsud3mnsqEQXVfQPqd2QfGlHO9CoTgY8UwTjg8yuHMk6NmY/bNmM+ylAQo0OBiG+RzwgoodEFCviNald61EVNXEtr/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VycuFEPG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X3iUBNKM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VycuFEPG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X3iUBNKM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VycuFEPG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X3iUBNKM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VycuFEPG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X3iUBNKM"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F17A4D1CC;
	Thu, 19 Mar 2026 00:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773881548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sWPXj/DW0Ur/vEHhQyfhU5RLlccA3hk3HaFcAXVk7oc=;
	b=VycuFEPGLFer0FoZwevy2GoyrsPWUL4LGewPy7ztl4uwLeGG+WvPcKSbvMiM/nF4g9Zdg1
	5fDYfw5U6SQUXG+3+oHs+/fDSvAnmA+3mK9nlnTyDIQQ8rWUYEwU2PI+l48th8sLe8CAT+
	WVfkws2zXvLz+KNNe8qoNO1iABzLuGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773881548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sWPXj/DW0Ur/vEHhQyfhU5RLlccA3hk3HaFcAXVk7oc=;
	b=X3iUBNKMWf9B74fLRzJzhh+NVqJlWURJK/s01jncNkPfImkfo1wQPfCAPOM58yPs8IFe+z
	l5VjLMRa7yQibiAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VycuFEPG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=X3iUBNKM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773881548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sWPXj/DW0Ur/vEHhQyfhU5RLlccA3hk3HaFcAXVk7oc=;
	b=VycuFEPGLFer0FoZwevy2GoyrsPWUL4LGewPy7ztl4uwLeGG+WvPcKSbvMiM/nF4g9Zdg1
	5fDYfw5U6SQUXG+3+oHs+/fDSvAnmA+3mK9nlnTyDIQQ8rWUYEwU2PI+l48th8sLe8CAT+
	WVfkws2zXvLz+KNNe8qoNO1iABzLuGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773881548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sWPXj/DW0Ur/vEHhQyfhU5RLlccA3hk3HaFcAXVk7oc=;
	b=X3iUBNKMWf9B74fLRzJzhh+NVqJlWURJK/s01jncNkPfImkfo1wQPfCAPOM58yPs8IFe+z
	l5VjLMRa7yQibiAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E47F24273B;
	Thu, 19 Mar 2026 00:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lO4zJcpIu2k8ZgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 19 Mar 2026 00:52:26 +0000
From: David Disseldorp <ddiss@suse.de>
To: fstests@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH] common/rc: add default _udev_wait timeout
Date: Thu, 19 Mar 2026 11:51:54 +1100
Message-ID: <20260319005154.29274-1-ddiss@suse.de>
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
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7F17A4D1CC

If udevd isn't running then "udevadm wait" loops endlessly. With a
--timeout parameter provided, udevadm (udev-254.27) prints to stderr:
  Timed out for waiting devices being initialized.

The error message causes test failure via golden output mismatch and
is easier to debug than an infinite loop.

The timeout parameter is also compatible with existing
args="--removed <dev>" callers.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index fd4ca964..aade0e5b 100644
--- a/common/rc
+++ b/common/rc
@@ -5544,7 +5544,7 @@ _udev_wait()
 	if [ -z "$UDEV_WAIT_PROG" ]; then
 		$UDEV_SETTLE_PROG >/dev/null 2>&1
 	else
-		$UDEV_WAIT_PROG $args
+		$UDEV_WAIT_PROG --timeout 10 $args
 	fi
 }
 
-- 
2.51.0

