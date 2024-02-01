Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9E25556
	for <fstests@vger.kernel.org>; Thu,  1 Feb 2024 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706819809; cv=none; b=EquEXhIr1ZOvnccoCtec6eJyfG/z7sZF/v3XHNSiml/HIiY5+++PwDrPGg08ZUJEFxJyoCxWTkGVsi82Ys8fT3ym6/nuJrUUPaPup0aXhh/foT00nRR2WFUhoJ9qC08ch1VwVzlsvRpFUIVDiaxJJwDlCFKxyAPzUmtVZKTC6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706819809; c=relaxed/simple;
	bh=hOA+OqTHVoRrZpUdFgVMuDqxWyxUquXib6M3GSPf09A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Akgyu2GXIclxGDzoRFL0HCIKlgi0WzX58hj8nb+jwcQuR9iwgQboWxN8veYU+11LgoIkepTUufkbdH5VwfNY2P5oNiWDzc2jz3laEHL0eQwLfVdwVnck2pN9tyMgw1Gk+Yv0jhuh7EmG1bpOeIqS6ZpFfwZaqQOOhlmmVUceujU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=PnKlcKL0; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="PnKlcKL0"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-602d222c078so13452437b3.0
        for <fstests@vger.kernel.org>; Thu, 01 Feb 2024 12:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706819805; x=1707424605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5yM7gCeTxtrHaCpqgRrs/cEvnVMk67WLvsx3JX08QAg=;
        b=PnKlcKL0ZZbGK0qDYz6NMvBKfo+0Co8ytUdTDI8q77vz/qoeIvG5WzErBHGK4VYOyq
         7W84RnH2ZQcgO98xWRtXWphkZpvi/x6Of/KPrMplXXcGf0/vKUVgLm7RzC9VdOYBN7dj
         KCM1sQTH8jaL48GUMA1SPFkKoYeC5Y5AZLr9U3EVC01ayzMoVm9PguztGCVG5smtxoEd
         sHzV7O5IRzk+8n+edcTu+klZVGKEKyIY4iG1KjCY0sP2UUbGlCjepZYUVqaCCius5az7
         IDrRcLZsqKQZUEA0F86weVNohYKiPDtazpj80tuk+ver15wJQG+RxKUZIlKy5AybbWzF
         CGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706819805; x=1707424605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yM7gCeTxtrHaCpqgRrs/cEvnVMk67WLvsx3JX08QAg=;
        b=mKcc53vic281HRORe8XX4cjl4DYCEZ2LJVOXbGyVRYRESxdW1unDIp6a1wnWVVpnLE
         3S4GnHP/KH/wY0Pwu37B+mFZNizrocJPSFgtsLy9eaDodMgy0PX612uzG8OxNt3kUF0Y
         9QAegYnq1SuQFeMa2GCmwIU3sPDjK7aWTy8x3vUtMHL6EVyY7zFyVmYdL+nH80TjtyCJ
         Kuo+7KaUmNuG57uI33gkcrgGbVP3isJOvjIdtdPUU+FmFVp8BfR3Xf2adYMksj4KCAD+
         zXID5xkcCWMQCxUkKoWSkIbIr4rr38YSNt/B4V+5fh+hMs19Fld1eFtxwT5+1xGNb7gY
         fMNQ==
X-Gm-Message-State: AOJu0YxRuTBiMQwVijjPRAumU71BUS9lyY4BH8uJ7bNap18ODdLuvCja
	k8/gUJmyuWHcSN7Fc8D8bqrt0WYQBwRHgO7Qahze8v/pG9CmJwPOOC9duWpgAAY=
X-Google-Smtp-Source: AGHT+IEDqvOw6Ns/a0TXI2U+6KlGKwX9dBb1buV1RIGKKHILLx2GXXAhGD4YZgstHVt+LYA1tGfTlA==
X-Received: by 2002:a0d:d957:0:b0:603:cbe0:465e with SMTP id b84-20020a0dd957000000b00603cbe0465emr340893ywe.20.1706819804773;
        Thu, 01 Feb 2024 12:36:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXwzWU6S2dwKu2cdEnlvsBsuCxjHbNLNnFOj0r0u1xeRqVQzVjUzrWrYZCL2r24JKxgQK0+r3/SNhU6SBZFaFSsIiQr/4ItqW8t5HlcWRG0b9MKL21b4KOF7uH2
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id mb3-20020a056214550300b0068c6d732303sm104721qvb.117.2024.02.01.12.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 12:36:44 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] fstests: add a regression test for fiemap into an mmap range
Date: Thu,  1 Feb 2024 15:36:38 -0500
Message-ID: <795fcb629a2bbfeaf39023d971b7cb3a468aa87f.1706819794.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Btrfs had a deadlock that you could trigger by mmap'ing a large file and
using that as the buffer for fiemap.  This test adds a c program to do
this, and the fstest creates a large enough file and then runs the
reproducer on the file.  Without the fix btrfs deadlocks, with the fix
we pass fine.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 src/Makefile          |  2 +-
 tests/generic/740     | 41 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/740.out |  2 ++
 3 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 tests/generic/740
 create mode 100644 tests/generic/740.out

diff --git a/src/Makefile b/src/Makefile
index d79015ce..916f6755 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -34,7 +34,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
 	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
-	uuid_ioctl
+	uuid_ioctl fiemap-fault
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
diff --git a/tests/generic/740 b/tests/generic/740
new file mode 100644
index 00000000..46ec5820
--- /dev/null
+++ b/tests/generic/740
@@ -0,0 +1,41 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 708
+#
+# Test fiemap into an mmaped buffer of the same file
+#
+# Create a reasonably large file, then run a program which mmaps it and uses
+# that as a buffer for an fiemap call.  This is a regression test for btrfs
+# where we used to hold a lock for the duration of the fiemap call which would
+# result in a deadlock if we page faulted.
+#
+. ./common/preamble
+_begin_fstest quick auto
+[ $FSTYP == "btrfs" ] && \
+	_fixed_by_kernel_commit xxxxxxxxxxxx \
+		"btrfs: fix deadlock with fiemap and extent locking"
+
+# real QA test starts here
+_supported_fs generic
+_require_test
+_require_odirect
+_require_test_program fiemap-fault
+dst=$TEST_DIR/fiemap-fault-$seq
+
+echo "Silence is golden"
+
+for i in $(seq 0 2 1000)
+do
+	$XFS_IO_PROG -d -f -c "pwrite -q $((i * 4096)) 4096" $dst
+done
+
+$here/src/fiemap-fault $dst > /dev/null || _fail "failed doing fiemap"
+
+rm -f $dst
+
+# success, all done
+status=$?
+exit
+
diff --git a/tests/generic/740.out b/tests/generic/740.out
new file mode 100644
index 00000000..3f841e60
--- /dev/null
+++ b/tests/generic/740.out
@@ -0,0 +1,2 @@
+QA output created by 740
+Silence is golden
-- 
2.43.0

