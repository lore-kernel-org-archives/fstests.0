Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E114E2EF
	for <fstests@vger.kernel.org>; Tue,  7 May 2024 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108862; cv=none; b=lpdspYOPwx8M54yB0YyFa1oxqtZu7FR6cOzT5VAlUBz9ezPZIas9eeoP/noTsbyrG2Cw/zRsOJiqUl7hsctlcozJ/Dhdmti98SOvfDbH1/SvC8uNHBKemw8oeuYn/agY2orgPRy/q+9E1NsrSDimN8itYmHirOqUow91VoiqjTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108862; c=relaxed/simple;
	bh=wxPK/4AD+k1jetfimDtAld4bz0aRchuxfSE5P8wC2vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxavQj7Rbi1GCCiyrBEY7YnVBw6j+tQSNNEUKKIPj8vpwVblXgQGx5SlDNVGITU43VTATJRRnvUWcLepxnDMGz6WU9RlOZQ5LRI7rsL4xDXvc/YRqz2IVsB7yI/tYdlHOnlpcxhyhi8FGB3BcrgmHgAbsYMkNKnxm5ccjox5GQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9827D20F65;
	Tue,  7 May 2024 19:07:37 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9157A139CB;
	Tue,  7 May 2024 19:07:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ynZ6I/l7OmZeGwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 07 May 2024 19:07:37 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/4] Move shared/032 to generic/740
Date: Tue,  7 May 2024 21:07:36 +0200
Message-ID: <8dcb7d564180452eec0c2888740c1b0919e171d3.1715108589.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 9827D20F65
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

The shared/ directory was supposed to host tests that apply to a subset
of all supported filesystems but this is not utilized much and creates a
split from the generic tests. Move the test to generic.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 tests/{shared/032 => generic/740}         | 2 +-
 tests/{shared/032.out => generic/740.out} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/{shared/032 => generic/740} (99%)
 rename tests/{shared/032.out => generic/740.out} (100%)

diff --git a/tests/shared/032 b/tests/generic/740
similarity index 99%
rename from tests/shared/032
rename to tests/generic/740
index 131323ab5b0ff8..6ed248617eaa6b 100755
--- a/tests/shared/032
+++ b/tests/generic/740
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.
 #
-# FS QA Test No. 032
+# FS QA Test No. 740
 #
 # cross check mkfs detection of foreign filesystems
 #
diff --git a/tests/shared/032.out b/tests/generic/740.out
similarity index 100%
rename from tests/shared/032.out
rename to tests/generic/740.out
-- 
2.44.0

