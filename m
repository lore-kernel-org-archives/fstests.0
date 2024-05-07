Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948D16F27C
	for <fstests@vger.kernel.org>; Tue,  7 May 2024 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108872; cv=none; b=Zy/NeyL/l524bg6cy8sOLe8UvcNDrzQ/E96yYetkbE7kQIA3yO6VJbn88QUjPXxzBWKpWIt3JxYSrlPLisAmvu4FpCQ+kBhjF7PDgoyzHUzx5uF9H3ieGaXKUCGMQipQHPsJlrqNSe0IpWE6TqBG/7coJGwuNlhCFkOZKKtecgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108872; c=relaxed/simple;
	bh=tytckNNkvylephPzluVXggJbqrb0scNQnPonPlVJkx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oq2CSSdkrpujJaBn7EWhmR9FPOVSPdndt7sOTPcbjVyd34BEBUatDW2KEXLAcrtzCvsp6g4p7tgfbLqP0rMT+LVsj59TXsvLR97jQqSF3J8pQmY9rmyRT6DBHUq6BuN24S0dmGh3yE06laQYIF8HaCT5GXtDkz1uRD2eqfigprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA1DB20F67;
	Tue,  7 May 2024 19:07:48 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3B7A139CB;
	Tue,  7 May 2024 19:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HjjcKwR8OmZtGwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 07 May 2024 19:07:48 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/4] Remove rest of shared/
Date: Tue,  7 May 2024 21:07:47 +0200
Message-ID: <943757aa0f540938acd3fdbe733133ec1f07edc2.1715108589.git.dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715108589.git.dsterba@suse.com>
References: <cover.1715108589.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: BA1DB20F67
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

All tests from shared/ have been moved to generic/, remove the Makefile
and the reference from the 'check' scripts.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 check                 |  2 +-
 tests/shared/Makefile | 24 ------------------------
 2 files changed, 1 insertion(+), 25 deletions(-)
 delete mode 100644 tests/shared/Makefile

diff --git a/check b/check
index c6dba89b5b506e..d2cd23b7e161b4 100755
--- a/check
+++ b/check
@@ -49,7 +49,7 @@ timestamp=${TIMESTAMP:=false}
 
 rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
 
-SRC_GROUPS="generic shared"
+SRC_GROUPS="generic"
 export SRC_DIR="tests"
 
 usage()
diff --git a/tests/shared/Makefile b/tests/shared/Makefile
deleted file mode 100644
index 2e6aa718446171..00000000000000
--- a/tests/shared/Makefile
+++ /dev/null
@@ -1,24 +0,0 @@
-#
-# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
-#
-
-TOPDIR = ../..
-include $(TOPDIR)/include/builddefs
-include $(TOPDIR)/include/buildgrouplist
-
-SHARED_DIR = shared
-TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(SHARED_DIR)
-DIRT = group.list
-
-default: $(DIRT)
-
-include $(BUILDRULES)
-
-install: default
-	$(INSTALL) -m 755 -d $(TARGET_DIR)
-	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
-	$(INSTALL) -m 644 group.list $(TARGET_DIR)
-	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
-
-# Nothing.
-install-dev install-lib:
-- 
2.44.0

