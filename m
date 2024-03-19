Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A3439AC4
	for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872359; cv=none; b=GugknbnOV82UfQ5dIAKtXnVEYuzLm6yrkPfXiw3ZG05kYeHrICfP+I2PzpFABVcFDnwTMnG8+ye9rlSydVRCjQC0n4yJjLYLFTbuRROv2rFSoZ7p3vkfGGm8FDxQKOyKeKssPdBk9Qulzr8+k6gCkaL5DscA8k9P8hlXbGrJ63c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872359; c=relaxed/simple;
	bh=KozunVOiZ05pbNuMLn7q12+RuUGyNkWu1aUIV5smFI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUJ2E6GA9mKzmkbes9E1mQcw7Iq3sMY+6O6YhyZsnsnGKMRCCkFTeDk94kzH3lqdbNfaDtoZH6LUDGj9NDWm3c0f+3dCp0jiTRjwG4KgR0BqcJB34UkKMvtbXOlWY5080RKWPz3HPh2dDs7q0LyUk6an080n+oreIoBfW3i8rso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZG7TFZpo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZG7TFZpo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZG7TFZpo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZG7TFZpo"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D806321CE3;
	Tue, 19 Mar 2024 18:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710872355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfnRs7C5KxW5Uu9Xc6KVyWF1lCgJJxEyXsX0kddv3is=;
	b=ZG7TFZpoLVddp2n5jWUrJJxIG3yn6pwjQxeeTB9YWk3ks/i9RzopAzY+xSp+UolYNtizM6
	LmnlycBzivgolwSEc4O5mtEI9lttCq6JmRqoj4PgU1bwdsXuh4MQj+GCQe8Bn77RuDwh+/
	hppjZLnZdrMphJEfWfT5kXw5H0ZZszA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710872355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfnRs7C5KxW5Uu9Xc6KVyWF1lCgJJxEyXsX0kddv3is=;
	b=ZG7TFZpoLVddp2n5jWUrJJxIG3yn6pwjQxeeTB9YWk3ks/i9RzopAzY+xSp+UolYNtizM6
	LmnlycBzivgolwSEc4O5mtEI9lttCq6JmRqoj4PgU1bwdsXuh4MQj+GCQe8Bn77RuDwh+/
	hppjZLnZdrMphJEfWfT5kXw5H0ZZszA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2344136D6;
	Tue, 19 Mar 2024 18:19:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lclOMyPX+WWKSwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 19 Mar 2024 18:19:15 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 2/5] btrfs/131,btrfs/172,btrfs/206: add check for block-group-tree feature in btrfs
Date: Tue, 19 Mar 2024 19:12:03 +0100
Message-ID: <7e5a4dbefa3edb834560891feec6ecf3382bb9e0.1710871719.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1710871719.git.dsterba@suse.com>
References: <cover.1710871719.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ZG7TFZpo
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: D806321CE3
X-Spam-Flag: NO

From: Josef Bacik <josef@toxicpanda.com>

A new disk format option will make the no-holes option a requirement, so
add a helper to make sure that we aren't creating a fs with
BLOCK_GROUP_TREE by default, and skip the tests that require turning off
no-holes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/btrfs    | 10 ++++++++++
 tests/btrfs/131 |  2 ++
 tests/btrfs/172 |  3 +++
 tests/btrfs/206 |  3 +++
 4 files changed, 18 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index aa344706cd5f81..c1c3c4683a6fe6 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -148,6 +148,16 @@ _require_btrfs_free_space_tree()
 	fi
 }
 
+_require_btrfs_no_block_group_tree()
+{
+	_scratch_mkfs > /dev/null 2>&1
+	if $BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | \
+		grep -q "BLOCK_GROUP_TREE"
+	then
+		_notrun "This test requires no block-group-tree"
+	fi
+}
+
 _check_btrfs_filesystem()
 {
 	device=$1
diff --git a/tests/btrfs/131 b/tests/btrfs/131
index 529ee3e80f87eb..d34fc8d53801b3 100755
--- a/tests/btrfs/131
+++ b/tests/btrfs/131
@@ -20,6 +20,8 @@ _require_btrfs_command inspect-internal dump-super
 _require_btrfs_fs_feature free_space_tree
 # Zoned btrfs does not support space_cache(v1)
 _require_non_zoned_device "${SCRATCH_DEV}"
+# Block group tree does not support space_cache(v1)
+_require_btrfs_no_block_group_tree
 
 _scratch_mkfs >/dev/null 2>&1
 [ "$(_get_page_size)" -gt "$(_scratch_btrfs_sectorsize)" ] && \
diff --git a/tests/btrfs/172 b/tests/btrfs/172
index f2997c047effb0..964251b449de20 100755
--- a/tests/btrfs/172
+++ b/tests/btrfs/172
@@ -32,6 +32,9 @@ _require_scratch
 _require_log_writes
 _require_xfs_io_command "sync_range"
 
+# block-group-tree requires no-holes
+_require_btrfs_no_block_group_tree
+
 _log_writes_init $SCRATCH_DEV
 _log_writes_mkfs "-O ^no-holes" >> $seqres.full 2>&1
 
diff --git a/tests/btrfs/206 b/tests/btrfs/206
index 6ac3d27bbde375..02a5082046f4a5 100755
--- a/tests/btrfs/206
+++ b/tests/btrfs/206
@@ -33,6 +33,9 @@ _require_log_writes
 _require_xfs_io_command "falloc" "-k"
 _require_xfs_io_command "fpunch"
 
+# block-group-tree requires no-holes
+_require_btrfs_no_block_group_tree
+
 _log_writes_init $SCRATCH_DEV
 _log_writes_mkfs "-O ^no-holes" >> $seqres.full 2>&1
 
-- 
2.42.1

