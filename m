Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D6C2550D5
	for <fstests@vger.kernel.org>; Mon, 19 Jan 2026 06:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768803848; cv=none; b=Ly/ihtUHnDJ1G9R+tz4FklPWt8quy4lTFzfksyTv5PPFPliQTXRW/pGd1PlS0emQzLF2sSMTjA44SHfjyGvxCB2u5jN8pp5BKU/m/O0PqAyHBEPLULJAP80K8S66+ixdsAE1NqN3/K4YDzZcAMU6zqPAuO93E/UFgO5X7trvQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768803848; c=relaxed/simple;
	bh=IQS7+Bi8YOSjWfXGehp0wo2wViKKsq4vaExMrvUSXbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4O80pz4klwHGHPB+eAgReDAn4beSwGsSvIKDgZn0OkD/ddp+A5SbMWISiXgPhKU0gcFQkvDuM/4c7iWLS4W4kO/jNRXoksFDb+GnahLy+k4dpTdh5dJLJK0aELIKkLqAvHEKgECAq+6vEgCbGXI5yXJcCe+LxSD25yW+R6/0Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tqsFzBZ3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tqsFzBZ3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=vD2uMNnba8OJtdMXyt2EsNsO7axIWSq5XLJ0xlCBnkw=; b=tqsFzBZ3S+lvu1Mcpm/ldh4PQA
	EKd9l51JG344lhG6gsWKICvMK5Oq0Ewr0c220Za+P+Y1KLxKE2UoMicpJiEkS1E+0QPniiiY7nP0c
	HMcsGTRa3k8D/U94N4crrWcNWN89G0h+O8YoQOUlO0Hf6Tv4R6ccCjG+83UWDXhR1/AHIwu/B+Cgd
	6Z/MOiFKnU+srvf1cidOkX8PBbdxf70JEnHPxZMcoSl2GHAfRKFruJklRtGMsrYy691OcBvs2PrMJ
	YDoC6c+88+p8MxP52tWl6vZS9aJJnW6Exwg4aPpkvKnn5aTN/sPXrfr+yfmRPEprsrQLpfGKIR4t4
	W8xt9FDA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhigI-00000001OrO-2OQW;
	Mon, 19 Jan 2026 06:24:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: ebiggers@kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] generic: test that truncate(2) on fsverity is blocked
Date: Mon, 19 Jan 2026 07:24:04 +0100
Message-ID: <20260119062404.3998871-1-hch@lst.de>
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
 src/Makefile          |  2 +-
 src/truncate.c        | 17 +++++++++++++++++
 tests/generic/788     | 37 +++++++++++++++++++++++++++++++++++++
 tests/generic/788.out |  4 ++++
 4 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 src/truncate.c
 create mode 100755 tests/generic/788
 create mode 100644 tests/generic/788.out

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
index 000000000000..02959037e7c3
--- /dev/null
+++ b/tests/generic/788
@@ -0,0 +1,37 @@
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
+_require_test
+_require_scratch_verity
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

