Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C95264617
	for <fstests@vger.kernel.org>; Fri, 20 Feb 2026 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771619630; cv=none; b=Mp7D6Mwtu/z48HdtRlIzZIdLK29s2gOPBdrjI/pvelP1+l/YIPUe5JQmPyx6CtBUkVketMQKvvGtIgzkFgWVTmFZGTaBiap8nZVwvBjcxaMMlF4u4pcbrPdBiFwzFIf5LGbkXuFVauxqhvZ1r2UF7+zRnCflIWedaRnQ6shwFhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771619630; c=relaxed/simple;
	bh=ZN7hzIky3RsaGoODk3Ivv33ZmjEOb5DwDXXYJymgYSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5n9ZW6Lq2yzNbC0W7VW/RTgOsoZUJvNMvgleron8EaeH08a+TI7SlzEmaQJKuo+7iQD1hmeX3bD5MketmTvwOkgd3hUGvyvZ9IA8HtmpSdmyhnDjfebAcW+E6yz+4zeqbXMqM68bLCnHjqmYCBz7mzk3B6TmEN3AT6RXZiWBms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IHXnQtT3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8rLW04dy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IHXnQtT3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8rLW04dy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IHXnQtT3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8rLW04dy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IHXnQtT3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8rLW04dy"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 013495BCDF;
	Fri, 20 Feb 2026 20:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771619627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j5sFPnFTEC0R+m1adqkH9ENpjvDiZjFPjzLlf/Aj2I4=;
	b=IHXnQtT3RWnMGe59c8HiMqfGSli1qJhNfbzjO1EPH+WICeKTK6SYZiSrsNTKw7CYGUMSOQ
	/E8szB2yU/VhquVV4zYGN8H22W73iiHEVh3U8RZOAxb7RLnyyVzZkguo1q34wqIJcc4WcB
	YaP99CH2U0gBCUJLvACHGWNfb71Tz9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771619627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j5sFPnFTEC0R+m1adqkH9ENpjvDiZjFPjzLlf/Aj2I4=;
	b=8rLW04dyUPMwT4l2JRDdZwbHqKHQFETVRZekv6MHp3mVGHEraxxecQJ6PVfdSZjIfNbbHC
	nsEh2cDJK/uWqiCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771619627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j5sFPnFTEC0R+m1adqkH9ENpjvDiZjFPjzLlf/Aj2I4=;
	b=IHXnQtT3RWnMGe59c8HiMqfGSli1qJhNfbzjO1EPH+WICeKTK6SYZiSrsNTKw7CYGUMSOQ
	/E8szB2yU/VhquVV4zYGN8H22W73iiHEVh3U8RZOAxb7RLnyyVzZkguo1q34wqIJcc4WcB
	YaP99CH2U0gBCUJLvACHGWNfb71Tz9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771619627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=j5sFPnFTEC0R+m1adqkH9ENpjvDiZjFPjzLlf/Aj2I4=;
	b=8rLW04dyUPMwT4l2JRDdZwbHqKHQFETVRZekv6MHp3mVGHEraxxecQJ6PVfdSZjIfNbbHC
	nsEh2cDJK/uWqiCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E14E43EA65;
	Fri, 20 Feb 2026 20:33:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1YL5NirFmGnpGwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Feb 2026 20:33:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9F313A0A4A; Fri, 20 Feb 2026 21:33:42 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] tests: Fix failure in nojournal mode
Date: Fri, 20 Feb 2026 21:33:08 +0100
Message-ID: <20260220203308.6256-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Several tests use fs shutdown. Without journalling the filesystem isn't
guaranteed to be consistent after shutdown. So for tests that don't make
sure data makes it to the disk using fsync/sync we cannot really test
much. Skip such tests without journalling.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/ext4/051    | 1 +
 tests/generic/536 | 1 +
 tests/generic/622 | 1 +
 tests/generic/635 | 1 +
 tests/generic/646 | 1 +
 tests/generic/705 | 1 +
 tests/generic/722 | 1 +
 tests/overlay/087 | 1 +
 8 files changed, 8 insertions(+)

diff --git a/tests/ext4/051 b/tests/ext4/051
index 728ad19bfcec..9fbf0404fec9 100755
--- a/tests/ext4/051
+++ b/tests/ext4/051
@@ -16,6 +16,7 @@ _exclude_fs ext2
 _exclude_fs ext3
 _require_scratch
 _require_scratch_shutdown
+_require_metadata_journaling
 _require_command "$TUNE2FS_PROG" tune2fs
 
 echo "Silence is golden"
diff --git a/tests/generic/536 b/tests/generic/536
index 726120e67c8e..56a8ced2f8da 100755
--- a/tests/generic/536
+++ b/tests/generic/536
@@ -17,6 +17,7 @@ _begin_fstest auto quick rw shutdown
 # Modify as appropriate.
 _require_scratch
 _require_scratch_shutdown
+_require_metadata_journaling
 
 # create a small fs and initialize free blocks with a unique pattern
 _scratch_mkfs_sized $((1024 * 1024 * 100)) >> $seqres.full 2>&1
diff --git a/tests/generic/622 b/tests/generic/622
index a67931ad877f..e8ead300e362 100755
--- a/tests/generic/622
+++ b/tests/generic/622
@@ -78,6 +78,7 @@ _cleanup()
 # rather than the test filesystem.
 _require_scratch
 _require_scratch_shutdown
+_require_metadata_journaling
 _require_xfs_io_command "pwrite"
 _require_xfs_io_command "fsync"
 _require_xfs_io_command "syncfs"
diff --git a/tests/generic/635 b/tests/generic/635
index 4a811630a621..018b868cb6ce 100755
--- a/tests/generic/635
+++ b/tests/generic/635
@@ -26,6 +26,7 @@ _begin_fstest auto quick atime bigtime shutdown
 
 _require_scratch
 _require_scratch_shutdown
+_require_metadata_journaling
 
 _scratch_mkfs > $seqres.full
 _scratch_mount
diff --git a/tests/generic/646 b/tests/generic/646
index b3b0ab0ace56..1e3f0cd54087 100755
--- a/tests/generic/646
+++ b/tests/generic/646
@@ -19,6 +19,7 @@ _begin_fstest auto quick recoveryloop shutdown
 
 _require_scratch
 _require_scratch_shutdown
+_require_metadata_journaling
 _scratch_mkfs > $seqres.full 2>&1
 
 _scratch_mount
diff --git a/tests/generic/705 b/tests/generic/705
index 9c27fbbc389b..23f06d699dfa 100755
--- a/tests/generic/705
+++ b/tests/generic/705
@@ -12,6 +12,7 @@ _begin_fstest auto shutdown
 
 _require_scratch
 _require_scratch_shutdown
+_require_metadata_journaling
 _require_command "$FILEFRAG_PROG" filefrag
 _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount
diff --git a/tests/generic/722 b/tests/generic/722
index b9c608713c37..10869bc7aabf 100755
--- a/tests/generic/722
+++ b/tests/generic/722
@@ -18,6 +18,7 @@ _require_test_program "punch-alternating"
 _require_xfs_io_command exchangerange
 _require_scratch
 _require_scratch_shutdown
+_require_metadata_journaling
 
 _scratch_mkfs >> $seqres.full
 _scratch_mount
diff --git a/tests/overlay/087 b/tests/overlay/087
index 2ad069dbf78f..25d021095b6f 100755
--- a/tests/overlay/087
+++ b/tests/overlay/087
@@ -34,6 +34,7 @@ _begin_fstest auto quick mount shutdown
 # Modify as appropriate.
 _require_scratch_nocheck
 _require_scratch_shutdown_and_syncfs
+_require_metadata_journaling
 
 [ "$OVL_BASE_FSTYP" == "xfs" ] || \
 	_notrun "base fs $OVL_BASE_FSTYP has unknown behavior with syncfs after shutdown"
-- 
2.51.0

