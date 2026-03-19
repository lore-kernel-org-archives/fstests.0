Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD82C364EB8
	for <fstests@vger.kernel.org>; Thu, 19 Mar 2026 03:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773891417; cv=none; b=YJQkP00MWVJZccJedga8HfRdbQckCqrhDdc5RGde4E1cD+jQhBQDLm1BrqTU7yuSDT7MIjG/wGSV2TZ3+6oSvwpTNsLpJg/VuUO1rtKcEdpEb0pm3bNdIX++wuEZlUG4QDd5ycmAq0KNSbivliqNUzHjzvKBpH+nRWG/Bmch6v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773891417; c=relaxed/simple;
	bh=SFgmrhQD4XWfAN7LIRQdIH3qJq/LH5M8QlxFWmI3+IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDldP7XiraTkP0TkYnCcA/7H+vX21dzaBdxKK+3+m4f73X9E+w69nsMSsVjIVcg8RSEMhsb7lXyYVeTmrbO7iPUJrH9TigCx5ir27yaeW2i7vRT6U2SX4i1yU4W1jp8yu9yVDbfJslDEyUNSxIOUMLAXODZVKWbNodSs36BSP2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asrApveq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asrApveq"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso335073a91.3
        for <fstests@vger.kernel.org>; Wed, 18 Mar 2026 20:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773891416; x=1774496216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipsFlYVfOKCr6YOZKvfWrNWgXcDy5diQv/ooGkEria8=;
        b=asrApveqxooZ/1ozEF9ZZhLLhU5Mn/Ye0CLJXEcpR1IjKRbi6/nRyqL4iATQAnP5OB
         NM6+RSOtaY4141VvIwSVmEvHut1OcRm15MWEI0Vv9aICqT6zJZHhPO7d2aMd1uaN9xHP
         wBEZQym+V0Zg9BscY87yBNVhr/blMb3ctcvPtWw82POB4jBPvIPGUv/xuaxEGbIYyPdY
         GTw0kReayft2/5i6fACI1dRR7aE+Y9q1QEP7UfKaKj5CcVEIWTxTt/ohfQzR1kK9gFwU
         MomnO+v+6hZhs+t71Ue3mbXopkX/CvwEEqs/Uy21Tk/ucGRPZz0kPbW2foeFSqJjEC+1
         JYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773891416; x=1774496216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ipsFlYVfOKCr6YOZKvfWrNWgXcDy5diQv/ooGkEria8=;
        b=n4LtBY0sQh0n33sKZzTe5dvxhyVkr097nJlBgqrFgBml16KF/NcCQ65guc3/GJ1kza
         kRg1I910kZmG7A9iBC8XrrSnRS4eFZi+Evaon3uQgpNFcGPBsVq88AG8NILbVocjfdxs
         OFi9hj31NC6jREZ2wrNSual2kpDsUPYe4folu9hfdkmBhU7nykkEUl8wXKb62HZLZW1Z
         Q+An9tzvgllIOpHFQ+HCYLYSpsBELp5yydtAgWxfh8vTZHHyGAv0uHCemYO6r2C+O1TA
         C1UKUgiLbzRs1DdhQbU9VQsfC8EVhyBlXV3iEwub/bOPQw8clBmhWXdpYETxOmRQfXwF
         mZow==
X-Gm-Message-State: AOJu0YwR5i35APmdYEYC8XUgxYki49LcCQ419pdgk1MLbwi8govh0+qx
	c5M8KkYvwrwJlSDZc1hWTDFC0Ref4J9dmLz5jvty/71UrqMdFDC+Ompr
X-Gm-Gg: ATEYQzzNT+SRiAoet4agAehVK9xBUzrzFhH3P0szOaZtRRzRzLLydIvg0XcE6A8jYVV
	TAPpYqOFMYIPOdiqlRk0LhwLLwSSGTNdRkj4Jk8MqEpzG8jh8tMKsYln6IIxO7wS5qAHz2BrFlI
	wQrSmLbBJho0hf3n2Zni8dSlepn8ow3bujNmdGkXP2NDHgg3AFec9JZx07YlZ0QiPPjuUF+xFHx
	Cqo3L+7KLVRgjADyEnnDFfZhZRKraSwt2bfm1nCRdJuwIMzlWddbSHdqa8tQdsg13HFQwTflPg6
	qStEZqW62ZOjSotNaxMRDdV9HH1ELb9LNNFJyZz6VsSmgmloYmZt325KHafYAnhBxxGKjk4R7/h
	OjDDpmQBzEitXPsIFyOYJSlVE1qXupW6MeMLPTtoi50YZqOYarZJaqZjORxvytAHoXyan3ZrvjC
	OTD4WivEkhrVce/E+rKE+cuRAiEpjPPTY=
X-Received: by 2002:a17:90b:4fd0:b0:35b:952c:43c8 with SMTP id 98e67ed59e1d1-35bb9e4f933mr5047549a91.8.1773891416015;
        Wed, 18 Mar 2026 20:36:56 -0700 (PDT)
Received: from zyy.mioffice.cn ([2408:8607:1b00:8:de2a:6d3a:185:22cf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bbabae770sm1994294a91.1.2026.03.18.20.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 20:36:55 -0700 (PDT)
From: Yangyang Zang <zangyangyang66@gmail.com>
X-Google-Original-From: Yangyang Zang <zangyangyang1@xiaomi.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Yangyang Zang <zangyangyang1@xiaomi.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs/024: add testcase to check resize corrupting root inode
Date: Thu, 19 Mar 2026 11:35:19 +0800
Message-ID: <20260319033519.3954784-2-zangyangyang1@xiaomi.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260319033519.3954784-1-zangyangyang1@xiaomi.com>
References: <20260319033519.3954784-1-zangyangyang1@xiaomi.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a regression test to check whether the f2fs root inode
is corrupted after the resize operation.
During the resize operation, SSA data blocks are migrated and
zeroed. This process may incorrectly zero out the main area
blocks, leading to root inode corruption.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Signed-off-by: Yangyang Zang <zangyangyang1@xiaomi.com>
---
 tests/f2fs/024     | 39 +++++++++++++++++++++++++++++++++++++++
 tests/f2fs/024.out |  7 +++++++
 2 files changed, 46 insertions(+)
 create mode 100644 tests/f2fs/024
 create mode 100644 tests/f2fs/024.out

diff --git a/tests/f2fs/024 b/tests/f2fs/024
new file mode 100644
index 000000000000..1ca7ee27c18b
--- /dev/null
+++ b/tests/f2fs/024
@@ -0,0 +1,39 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Yangyang Zang.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/024
+#
+# This test case tries to check whether resize.f2fs can correctly
+# zero out ssa blocks without corrupting the main area blocks.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_fixed_by_git_commit f2fs-tools xxxxxxxxxxxx \
+	"resize.f2fs: fix to avoid zeroing main area blocks in migrate_ssa()"
+
+# magic size
+target_fs_size=$((2*1024*1024*1024+4*1024*1204))
+
+_require_scratch_size_nocheck $(($target_fs_size/1024))
+_require_command "$F2FS_RESIZE_PROG" resize.f2fs
+_require_command "$DUMP_F2FS_PROG" dump.f2fs
+
+# remove all mkfs options to avoid layout change of on-disk inode
+export MKFS_OPTIONS=""
+
+_scratch_mkfs_sized $((512*1024*1024)) "" "-g android" >> $seqres.full
+
+sector_size=$(blockdev --getss $SCRATCH_DEV)
+target_sectors=$(($target_fs_size/$sector_size))
+
+$F2FS_RESIZE_PROG -F $SCRATCH_DEV -t $target_sectors >> $seqres.full 2>&1 || \
+        $F2FS_RESIZE_PROG $SCRATCH_DEV -t $target_sectors >> $seqres.full 2>&1 || \
+        _fail "resize fs failed"
+
+echo n | $DUMP_F2FS_PROG -d 1 -i 3 $SCRATCH_DEV | grep "dump_node:" | sed 's/^\[[^]]*\] //'
+_scratch_mount
+
+status=0
+exit
diff --git a/tests/f2fs/024.out b/tests/f2fs/024.out
new file mode 100644
index 000000000000..a7a553f0681b
--- /dev/null
+++ b/tests/f2fs/024.out
@@ -0,0 +1,7 @@
+QA output created by 024
+Node ID               [0x3]
+nat_entry.block_addr  [0x1a00]
+nat_entry.version     [0x0]
+nat_entry.ino         [0x3]
+node_blk.footer.ino [0x3]
+node_blk.footer.nid [0x3]
-- 
2.43.2

