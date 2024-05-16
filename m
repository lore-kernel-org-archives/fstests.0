Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B923FE4
	for <fstests@vger.kernel.org>; Thu, 16 May 2024 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715897569; cv=none; b=gOJAeUBBki2efgBTQ7X3/5EH4HKNRp0p4834272z9xqipuZsz2dS+kfOZ++ZNfDjHJnhEvcEIMRdssCAVFYQ54lYAeBGTCC9AB0aGbcv4rcT5aXsLTiPz6T6w9OPe2JsyrAjKn/D75HjZMKtvqwqzTJVcq4oks6O0hTYjty/dQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715897569; c=relaxed/simple;
	bh=4vSt2u+c6Cfnyg3pxIWneUlqocZbcANNQk67zio07WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeXdr/YxYUQ7Rm6Rg/7jdd77BL/Tl/KvUMbkUHhEEH4MtFLxznq/HzeC7/clKrWomZbESkAmqgavgeHA5BzNtHM0GOZXpy6HkTmwUeytSE1KeoNW/+pAug2F/NoPztkb44LwxWw6A7YVi3FK9pSsKgHCxWOrChXuDyKAM2tyVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 557665CBEF;
	Thu, 16 May 2024 22:12:46 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F452137C3;
	Thu, 16 May 2024 22:12:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZppYE96ERmZNZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 16 May 2024 22:12:46 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: josef@toxicpanda.com,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 3/6] generic/027: require no compression
Date: Fri, 17 May 2024 00:12:42 +0200
Message-ID: <9d61a72884ab0c7233ebfcc172407b465e372735.1715896529.git.dsterba@suse.com>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 557665CBEF

From: Josef Bacik <josef@toxicpanda.com>

This test creates a small file and then a giant file and then tries to
create a bunch of small files in a loop to exercise ENOPSC.  The problem
is that with compression the giant file isn't actually giant, so it can
make this test take forever.  Simply disable it for compression.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 tests/generic/027 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/027 b/tests/generic/027
index 47f1981d4e51b7..eace1b358cdf34 100755
--- a/tests/generic/027
+++ b/tests/generic/027
@@ -33,6 +33,10 @@ _supported_fs generic
 
 _require_scratch
 
+# This takes forever with compression because we don't actually fill up the
+# disk, simply disable it if we have compression enabled.
+_require_no_compress
+
 echo "Silence is golden"
 
 _scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1
-- 
2.45.0

