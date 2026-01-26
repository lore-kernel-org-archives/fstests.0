Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E83382C1
	for <fstests@vger.kernel.org>; Mon, 26 Jan 2026 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432973; cv=none; b=EvtiFkghs2/UoCTTvovAZCHe+1IrIPIG154fv54tqpARAioQQajdpqfuGEFDUTddbfcnYgLkWjjGJN8huhiTlhPn/I2Lf+Aukr4OvQTW4svmhLf0BP4rvUXDecfZZLCg5lDhVsfjsqsLGSjLUB/TNkK2CfiN+3LJexziSm3qbQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432973; c=relaxed/simple;
	bh=vuKC4x0CkRXjsDRUvpBqpCPgQyBaJLHouTqm21ZpoiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c8RWOODEVeQ4lFKxzdPmMmriWuhY/00YyYA7fxz8VwWzc2WDoX90HYWEHrNG1EzI3l0J4PtG7OWT7KqCdc/OlTmBF73icBTwDGpE8jcBNI5yqIks5VP57zlgeXw3o1RRCtqyLB5QeCOButwkD8T7WpSISIw6zNND0biIi5pZuTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gc1KgmLv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gc1KgmLv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=mct1qclYMfw8pC/lLRsx/a5JxG7LudorCgVajJUPxD8=; b=Gc1KgmLvadixxVITut476CcYgn
	fXaaKauZRW6ubRsaZRLR9jcNw3Ijy5sLjgUTuPfSgCqF9OtJMr5pYvFP4giS5WAnIxQNDWpt/g6vg
	5DVINfSq9HYzej56wrBSBA1tt3RXCrRl3TZV4/m24pcfCCiQijpfISkHq0pPc2rfWVN2mauc3VBfW
	UAhNsOIoXMdSUTxN6vctahUkzfn7pr0O3noG91uc9TdQU+cble514BizDMycDLuGoUZJ7FioLcBSt
	hDiZt0+/vSBOIh4XzV7ftFIHHDlip9vXpcR64ioMMbqa6lKI3N6bAONyZYAu5ma6L2ebPfzKVVsKM
	4hsxgt3A==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkMLS-0000000CazB-2Ooz;
	Mon, 26 Jan 2026 13:09:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: ebiggers@kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2] generic: test that truncate(2) on fsverity is blocked
Date: Mon, 26 Jan 2026 14:08:43 +0100
Message-ID: <20260126130927.11585-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

truncate(2) doesn't go through open and needs special code to block
it on fsverity files.  btrfs was missing this check.

Note that truncate(2) in current core utils uses openat and ftruncate,
so add our own little test program for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - add the new binary to .gitignore
 - add a _require_test_program "truncate" call
 - drop the _require_test call

 .gitignore            |  1 +
 src/Makefile          |  2 +-
 src/truncate.c        | 17 +++++++++++++++++
 tests/generic/788     | 38 ++++++++++++++++++++++++++++++++++++++
 tests/generic/788.out |  4 ++++
 5 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 src/truncate.c
 create mode 100755 tests/generic/788
 create mode 100644 tests/generic/788.out

diff --git a/.gitignore b/.gitignore
index 82c57f415301..2b5bedd59fce 100644
--- a/.gitignore
+++ b/.gitignore
@@ -212,6 +212,7 @@ tags
 /src/dio-writeback-race
 /src/unlink-fsync
 /src/file_attr
+/src/truncate
 
 # Symlinked files
 /tests/generic/035.out
diff --git a/src/Makefile b/src/Makefile
index d0a4106e6be8..577d816ae859 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -21,7 +21,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
 	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
 	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
-	dio-writeback-race unlink-fsync
+	dio-writeback-race unlink-fsync truncate
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/truncate.c b/src/truncate.c
new file mode 100644
index 000000000000..4c106d26f29e
--- /dev/null
+++ b/src/truncate.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Christoph Hellwig.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+int main(int argc, char **argv)
+{
+	if (truncate(argv[1], 0) < 0) {
+		perror("truncate");
+		exit(1);
+	}
+
+	fprintf(stderr, "truncate succeeded\n");
+}
diff --git a/tests/generic/788 b/tests/generic/788
new file mode 100755
index 000000000000..ac4720d740f0
--- /dev/null
+++ b/tests/generic/788
@@ -0,0 +1,38 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Christoph Hellwig.
+#
+# FS QA Test 788
+#
+# Test that truncate(2) is blocked on fsverity files.
+#
+. ./common/preamble
+_begin_fstest auto quick verity
+
+_cleanup()
+{
+	cd /
+	_restore_fsverity_signatures
+	rm -f $tmp.*
+}
+
+. ./common/filter
+. ./common/verity
+
+_require_scratch_verity
+_require_test_program "truncate"
+
+_disable_fsverity_signatures
+
+_scratch_mkfs_verity &>> $seqres.full
+_scratch_mount
+
+fsv_file=$SCRATCH_MNT/file.fsv
+
+_fsv_scratch_begin_subtest "Using truncate(2) on a verity file fails"
+_fsv_create_enable_file $fsv_file
+$here/src/truncate $fsv_file
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/788.out b/tests/generic/788.out
new file mode 100644
index 000000000000..11074b71f3eb
--- /dev/null
+++ b/tests/generic/788.out
@@ -0,0 +1,4 @@
+QA output created by 788
+
+# Using truncate(2) on a verity file fails
+truncate: Operation not permitted
-- 
2.47.3

