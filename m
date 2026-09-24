Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2387420465
	for <fstests@vger.kernel.org>; Thu, 24 Sep 2026 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241231; cv=none; b=a0IN7bz3HFO8PuiVys9AxjT+2JIZ5Gc1qgVxqR0lSYQoILuJhkGszhiJkSBoQQojGTYEcOfNBDjO77Po1+w5dN5xfOhWs+I4iLiDBVGGhjC+hkTSE5fJH2dpMaKo8FboEXCJMkNn/k2HORp8fNzV0L+fK3Q7wOHbgrGWq8Neztw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241231; c=relaxed/simple;
	bh=juyi4OjVWA80iRkJ3ycXk+GZZld7CzggVm97TSrxBK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4oZbqtdFfGCffMiVBEdFQmvrlRjyzeisHwtomIwd+6e1x2C5yKlASTISahxcagqZIzj249oi6lKbGTIWarqcFeps6ARlJAPzo6pYE+uaoXfGq99bYM38Ht5nkSrm6JjK1u18IBXHK2KRNgE45ZlLfdMiYISnNuIrx+WH8xXvB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T92mBs52; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T92mBs52"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49e73611928so4406885e9.1
        for <fstests@vger.kernel.org>; Thu, 24 Sep 2026 02:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790241228; x=1790846028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xPVKV8/dlbuxm2O8DaNNJgk0/9BiC4IkG7M+UZS5G88=;
        b=T92mBs52lSvyTObT4fQGpGdwPQ5AbYdghWZ4SqTb5jDdcJSWGwvMsQ09wFHOb4T7nx
         tCn/HefmTkAsT9b7xLL9uEF7er7F3lxNfS5tkzgiWgUPdAxmVlLwDA+wtnR4qirs8Fea
         SUygNF/6W7hOmKM5wPiHdzcw5T12SFgMEZky3ycMTHtmNjXsVvvYbplFSAP0NXmOfRw7
         xfS5fxaowX0BmAzaP/G2eobMoE+qrmHE0/Auj84txPhwtiYarnwgAvk4FESoK8zb++Ft
         V5PfdMSOp0VnSl7cZPpPUaCVfvZGPT/n+Cpp81VS6/5+mh4IxScXvdP6aM4GuannbsYE
         4aYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790241228; x=1790846028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xPVKV8/dlbuxm2O8DaNNJgk0/9BiC4IkG7M+UZS5G88=;
        b=W3Nv8TOtZsxoVFvx2QODnnXaa4N/3mKPmdoIw6RodCja73quh6YZIW4VNYAFXj379i
         AlJWtPlgRc+Cw4PTUfBBVYIDI3INKNWIXDjJDzumS21ovtp1/CRWCVMokVpKaYdPPS7a
         QjWViDauMtBSgxlA9uVJRv/ekatQxR6X2jpN3ZMEct+uD5Smv7aQFY4qE9OR8y5bjgQ7
         JoxpvzSRJLRfQngP4i00e42iC5ZRs9q7xoAK+drnavqmMQ2ArCW//oVbXotVp7M47FMR
         J4jJvpEjwl7DJqbBmh0d/kIH+fNDzGr73eizOIGoQqPCRYXpFRQkcxBrHjHwM+wQM01l
         54CQ==
X-Gm-Message-State: AFuF++n9ba/GGazN09t1IK3ceJ9rxAWlQEj/rzi3BewVZrOFeYLP68+i
	SytG7GI1Vp4d10JugvAR6vdZEjjW8Pe/axZThcLMI5wr5Brlf7k54XbhsLuXxE6TXCQ=
X-Gm-Gg: AYBFou35l4XpZV+pJVe8xqMh9c0AZwtrJ0O4XRktrkkQui4XkfB7Y3dSg9JJfUTzEWl
	DKUGpogDdeHd1i5cLvIEkH+PPD28OeQNg+NFP/yFldozcj5HHo3pZUYgR05vCCHnFd4WOcj2QHr
	CyKNbedtMWus922I29tqM4wkZL/3SpFMUMUlfe4vAkTfpC4wAEyYff+j06OS70AUGTEoghCAS1b
	qE45wpogamBSRMRkGaxzlwNwjtCN01Bcv4j1UzvezPBB94Y8zeE0k1LYR/LJS+V+e/pvRMhjddC
	wEXYkW3hrtqYC0gx9fIQe7fc4AhfZJmfvw4AZ4raA7LJunxvb0kxStGZUMC9ouDFPvA/y7YxLsL
	0lUjANIJqu89kbAjT7mRHeU0dsGvbZbs+AsS4ZdIlXbq2yHvvr3QQwkr3IUDlAK8ovOijNJuEns
	bUqfZIX1rSmaPEWe6sioO1ZQa1hsMfQlgbVhvTfTdaeT8gSra564epTd9eP7oYqQ4h49Lpmquq1
	g6SFDxyUVbHU81iN3v2lzkx7Izi0SE+J+OHgn5W4cEmoIk7TU8JycnKbKZytWILoIWV3byycIDk
	NU0ge+f1fShGydQ=
X-Received: by 2002:a05:600c:c101:b0:49d:27ee:79c9 with SMTP id 5b1f17b1804b1-49fe66d63fcmr25086305e9.8.1790241227757;
        Thu, 24 Sep 2026 02:13:47 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868779472sm13583550f8f.23.2026.09.24.02.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:13:47 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: fstests@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Zorro Lang <zlang@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-xfs@vger.kernel.org
Subject: [PATCH] xfs: exercise a failed CoW conversion during writeback
Date: Thu, 24 Sep 2026 11:13:36 +0200
Message-ID: <20260924091338.198407-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iomap_add_to_ioend() submits the pending ioend through
->writeback_submit() before allocating a new one for the current
range.  For XFS, xfs_writeback_submit() converts the ioend's CoW
extents via xfs_reflink_convert_cow() before submitting the bio; if
that conversion fails, ->writeback_submit() completes the ioend with
an error and returns it.  A kernel bug left the stale ioend behind in
wpc->wb_ctx, which iomap_writepages() then submitted a second time,
corrupting XFS's ip->i_ioend_list.

Exercise this path with the wb_cow_convert_error error tag: reflink a
file, dirty several widely separated ranges of the shared extent so
that a single writepages() call has to build and submit more than one
ioend, inject the error, and let writeback run.  On a kernel without
the fix this reliably hits a "list_add double add" WARN from
xfs_end_bio(); on a fixed kernel writeback just fails cleanly.

This requires the wb_cow_convert_error XFS error tag; the test cleanly
not-runs on kernels without it.

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 tests/xfs/842     | 70 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/842.out |  7 +++++
 2 files changed, 77 insertions(+)
 create mode 100755 tests/xfs/842
 create mode 100644 tests/xfs/842.out

diff --git a/tests/xfs/842 b/tests/xfs/842
new file mode 100755
index 0000000000000..c15760a4c7f89
--- /dev/null
+++ b/tests/xfs/842
@@ -0,0 +1,70 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Andrea Parri.  All Rights Reserved.
+#
+# FS QA Test No. 842
+#
+# Regression test for a failed ->writeback_submit() call leaving a stale
+# wpc->wb_ctx behind.  iomap_writepages() then resubmits whatever
+# wpc->wb_ctx points to, i.e. the ioend that ->writeback_submit() already
+# completed with an error.  For XFS the second bio_endio() lands back in
+# xfs_end_bio(), which list_add_tail()s the already-linked ioend into
+# ip->i_ioend_list a second time, corrupting the list.
+#
+# The only in-tree way for XFS's ->writeback_submit() to fail is a
+# failing xfs_reflink_convert_cow(), so this uses the
+# wb_cow_convert_error error tag to force that on a reflinked file whose
+# CoW extents are dirtied in several widely separated ranges, so that a
+# single writepages() call has to submit more than one ioend.
+#
+. ./common/preamble
+_begin_fstest auto quick clone
+
+# Import common functions.
+. ./common/filter
+. ./common/reflink
+. ./common/inject
+
+_require_cp_reflink
+_require_scratch_reflink
+_require_xfs_io_error_injection "wb_cow_convert_error"
+_require_kernel_config CONFIG_LIST_HARDENED
+
+blksz=65536
+nr=8
+sz=$((blksz * nr * 2))
+
+echo "Format and mount"
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+echo "Create reflinked file with several CoW extents"
+_pwrite_byte 0x58 0 $sz $SCRATCH_MNT/file1 >> $seqres.full
+_scratch_sync
+_cp_reflink $SCRATCH_MNT/file1 $SCRATCH_MNT/file2
+
+# Dirty several widely separated ranges of file2's CoW extents so that a
+# single writepages() call has to submit more than one ioend.
+seq=0
+while [ $seq -lt $nr ]; do
+	off=$((seq * blksz * 2))
+	_pwrite_byte 0x59 $off $blksz $SCRATCH_MNT/file2 >> $seqres.full
+	seq=$((seq + 1))
+done
+
+echo "Inject wb_cow_convert_error"
+_scratch_inject_error "wb_cow_convert_error"
+
+echo "Trigger writeback with CoW conversion forced to fail"
+_scratch_sync
+
+_scratch_inject_error "wb_cow_convert_error" 0
+
+echo "Remount"
+_scratch_cycle_mount
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/842.out b/tests/xfs/842.out
new file mode 100644
index 0000000000000..72c9c67e7d5fb
--- /dev/null
+++ b/tests/xfs/842.out
@@ -0,0 +1,7 @@
+QA output created by 842
+Format and mount
+Create reflinked file with several CoW extents
+Inject wb_cow_convert_error
+Trigger writeback with CoW conversion forced to fail
+Remount
+Silence is golden
-- 
2.53.0

