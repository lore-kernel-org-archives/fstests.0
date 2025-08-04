Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FDA12EBE7
	for <fstests@vger.kernel.org>; Mon,  4 Aug 2025 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754307626; cv=none; b=cyYwVpwBslSFKWfeLUMwxUkYxoMceAKgITliCKd/7dcbt5jz9TjYlTnh+MiI1iEWcO3d3+p2dmUOlNQoV+S/9fNPQ9o87NYuJcZ9NsXhK+J6bhRh5tjIsdQcwYbtjVOL0rcax8H5dCV8rywygcTwzKVKieN2ZzTq8HTmnka+sOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754307626; c=relaxed/simple;
	bh=x8xm9Hw27AwXkYqTrX/d1rvqsek/A2T33tvsNfwGJ64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAPI1tSCd+TfLzHF/ScKBySHiWF1v+AzubJpyKS57M/xhEkVzG9uyHTACZwe4B4LCKKfdW0upnDeqYnSi8zSMkOYymwHgaTOOia8+ZzUhOvDB+R7LMq85MYnVQXAMeTqLtG7Lgkq632rSi7fa0XzGkmw6nMBOlsd8ni56opesYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI3ZE5u6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI3ZE5u6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CCDC4CEF0;
	Mon,  4 Aug 2025 11:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754307626;
	bh=x8xm9Hw27AwXkYqTrX/d1rvqsek/A2T33tvsNfwGJ64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bI3ZE5u600tNyK4GU2VAclveALX/6epNqsQfU38M8iRWA/e/aCiVawuqBjqrXWpHj
	 pxoI3pbt65T+KmHX9TuZ/gMHTQsHWYl1GcmkXRa2q1dO8vSEvKdiMwnWs11ooqIxEt
	 B45T8T8PZPhUIFQ+vOm7cHPM0Yz1Ax0DXttg359wicBhSJuo+pT47kLuchw6ryIOz0
	 Q3NQb8LAnker9Igs5mIl1963KTpr7zWpqcG7+Kv61Q7RDI9AEJ1ocqhXT6/pQEVTRI
	 gnPn0wbpieLARdA8PdqizlcLqZbg2t0YecVn0zj5nmbMU1I285quPVVK8Rvxlwz2vs
	 nH9C8i1eFVlVg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 2/3] f2fs/016: test special mount options
Date: Mon,  4 Aug 2025 19:40:15 +0800
Message-ID: <20250804114016.2734919-2-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250804114016.2734919-1-chao@kernel.org>
References: <20250804114016.2734919-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As f2fs changes to use new mount APIs, let's add a new testcase
to check mount result for all f2fs supported special mount options
and their combinations, in order to detect any inconsistency during
mount.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/016     | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/016.out | 33 ++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100755 tests/f2fs/016
 create mode 100644 tests/f2fs/016.out

diff --git a/tests/f2fs/016 b/tests/f2fs/016
new file mode 100755
index 00000000..800f75fc
--- /dev/null
+++ b/tests/f2fs/016
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/016
+#
+# This testcase tries to check stability of mount result
+# w/ f2fs special mount options and their combination.
+#
+. ./common/preamble
+_begin_fstest auto quick mount
+_require_kernel_config CONFIG_F2FS_FS_COMPRESSION
+_require_kernel_config CONFIG_F2FS_FS_LZO
+_require_kernel_config CONFIG_F2FS_FS_LZORLE
+_require_kernel_config CONFIG_F2FS_FS_LZ4
+_require_kernel_config CONFIG_F2FS_FS_LZ4HC
+_require_kernel_config CONFIG_F2FS_FS_ZSTD
+
+options=(
+#	mount_option			mkfs_option
+	"inline_xattr_size=400"		"extra_attr,flexible_inline_xattr"\
+	"compress_algorithm=lzo"	"extra_attr,compression"	\
+	"compress_algorithm=lz4"	"extra_attr,compression"	\
+	"compress_algorithm=zstd"	"extra_attr,compression"	\
+	"compress_algorithm=lzo-rle"	"extra_attr,compression"	\
+	"compress_algorithm=lz4:3"	"extra_attr,compression"	\
+	"compress_algorithm=zstd:1"	"extra_attr,compression"	\
+	"compress_log_size=8"		"extra_attr,compression"	\
+	"compress_extension=so"		"extra_attr,compression"	\
+	"nocompress_extension=so"	"extra_attr,compression"	\
+	"nocompress_extension=*"	"extra_attr,compression"	\
+	"compress_extension=so,nocompress_extension=so"			\
+					"extra_attr,compression"	\
+	"compress_chksum"		"extra_attr,compression"	\
+	"compress_mode=fs"		"extra_attr,compression"	\
+	"compress_mode=user"		"extra_attr,compression"	\
+	"compress_cache"		"extra_attr,compression"	\
+)
+
+for ((i=0;i<${#options[@]};i=i+2))
+do
+	echo "Option#$i: ${options[$i]} : ${options[$((i+1))]}"
+	_scratch_mkfs "-O ${options[$((i+1))]}" >> $seqres.full || _fail "mkfs failed"
+	_try_scratch_mount "-o ${options[$i]}" >> $seqres.full 2>&1
+	echo $?
+	_scratch_unmount >> $seqres.full 2>&1
+done
+
+status=0
+exit
diff --git a/tests/f2fs/016.out b/tests/f2fs/016.out
new file mode 100644
index 00000000..a8c96972
--- /dev/null
+++ b/tests/f2fs/016.out
@@ -0,0 +1,33 @@
+QA output created by 016
+Option#0: inline_xattr_size=400 : extra_attr,flexible_inline_xattr
+0
+Option#2: compress_algorithm=lzo : extra_attr,compression
+0
+Option#4: compress_algorithm=lz4 : extra_attr,compression
+0
+Option#6: compress_algorithm=zstd : extra_attr,compression
+0
+Option#8: compress_algorithm=lzo-rle : extra_attr,compression
+0
+Option#10: compress_algorithm=lz4:3 : extra_attr,compression
+0
+Option#12: compress_algorithm=zstd:1 : extra_attr,compression
+0
+Option#14: compress_log_size=8 : extra_attr,compression
+0
+Option#16: compress_extension=so : extra_attr,compression
+0
+Option#18: nocompress_extension=so : extra_attr,compression
+0
+Option#20: nocompress_extension=* : extra_attr,compression
+32
+Option#22: compress_extension=so,nocompress_extension=so : extra_attr,compression
+32
+Option#24: compress_chksum : extra_attr,compression
+0
+Option#26: compress_mode=fs : extra_attr,compression
+0
+Option#28: compress_mode=user : extra_attr,compression
+0
+Option#30: compress_cache : extra_attr,compression
+0
-- 
2.49.0

