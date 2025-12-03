Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1382F60A2
	for <fstests@vger.kernel.org>; Wed,  3 Dec 2025 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764762224; cv=none; b=W5IeQyk9zsK5ItP+fFKgpM+E58JUWr+ZHswCJp5G6KiZAzrDpYb2RdeJNn5JpwDKZV5bSS0v+sCsWUNCF99Fb9Id3sH5H/mfoPokI0cGBZpYDglGKQexP3wTdEMW2VDAZ1lw5oBbN6T16pGL9AgNwwRaJCMP1ydBpgC7CyEZrdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764762224; c=relaxed/simple;
	bh=oBkvuCBrbfVyaeM5v/bY5mEWKjFvn1fVUN27hwHehX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BfJFEkfO4GUaCqDG/4ggAVvJMAojy1sSfLsk6UhbM6sc/hVzuRh1zEbkdpz9JCCzMkiWSz+1V5rb40slc6aKmob0JFCgRBdnbntIXIkpmaa1o5blxipr1blGo1zeehkDyuQs2izhYwgfH8C35o9b6NtnTPWh9NR8R0HrkUZCD4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcE9i+ID; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcE9i+ID"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aad4823079so5938494b3a.0
        for <fstests@vger.kernel.org>; Wed, 03 Dec 2025 03:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764762222; x=1765367022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmzrPAt9kb7dexvB71oGQlxWay34k4ETfXHiGvlbouI=;
        b=EcE9i+IDiqq/P/K7rUeAZEBFACjDGz+DczOxx2s53yvpZpl8Aup8ma1v7pmlJMyPpB
         UKhzumzt65BsdA9tPlSQTUEzkE8V9KeNQ0HbVSfCRTc9xgWFzKZAd3HkKDm422WAUZwH
         FZZ4EaSI64wya6LF3LJa0HOHjl+g0YvXI7E8+EATXlH/GPWEyLm29J7/Z2NnAytiN7k3
         kC4uFeCty7ECLlp9ct37P9rsiMbsKttgnVbYEBBYY7p3ARJTlZarmCNyRQcqcz8/gBmS
         HFc+bajyPQmhF5Y9V/aq4Pgqgiea6UnONs6CKDHhEVKgu5ArUoyZlEiUkn6f0L3rQM14
         REHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764762222; x=1765367022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmzrPAt9kb7dexvB71oGQlxWay34k4ETfXHiGvlbouI=;
        b=EaMar7yPS1HBWXrLam2fxO5Zm9bV1N4LD6H8ZS0dNNYlNK1Rjw8QI1nAIXUL2/gvGS
         vmDvks5uDxH+FDCBTfwD7ZnChrYKAym/ALd3q6QGJyLbVUUPFolZX5tD0xO6zDBDtwAU
         /CnRCJ2EHR6uqV7fTH+DN58Mq5KQAkVIVltr3Svw5/hUGctDYLWRucVqAZOWhBaJJfrr
         6fIVfwtFaxbWS6IX8Qdv/2gQHxFWdJCW9qtE05FYahWCp7mfIMyRx+62xwKWjRKupMfY
         meqT7qoM9tZjZyP7+AQl3I468nXaWB7wZ0mKFp4tyigear1+/8L7XscEzWq3pHszQIde
         2bLw==
X-Gm-Message-State: AOJu0Yyl7zdtoJ8ssG8pC4uYI3FF84aL06gO5o5l8MIP07I645xwfc5O
	vca9Mytk4Kmtc7TlccKGc/h0LJngcDMs4N4yyc0hqFXraFDv096Gqh2bpLh6uw==
X-Gm-Gg: ASbGncvipc2kJEr920AWykw45P0TYIpR59UB8NFE9okzbklkz9abb4OVLwGWlB0xhYw
	i9/NRqPU11QkdcWYhbZbrfxEnxD3n6YwWY0yb7mx6iF+HKhcTxPL1hAa1jGBlceDCEqAz9zIVnq
	V7vqJFGhweY5DdkT2OkehbpqeFP8lZY20mlW/zeCILr4qgKasNaHWp0qflmmTbPjQVQUJl+y9GS
	OF4jBqs5c6sGnXrUTymO43fLs/ZDlkbxvcpJdlbkmTCkWoW5/u3hcoqXLNzxUWsFUECHbTsnlzZ
	Cc15c09RIxj7EpVqe6ALQEY3Cp+1xpbb68V5yNCSdo2agy2rhRPoplDASqsH34miOum/O5iI4ZY
	f1SMwwgO2XhJzuBXosDGDPwBOhh4Ur3dCjk9L3L7j9iGCt2jBINOrbKQW5Wg8dV9YqtI6DiEpO+
	0E14F84mtkMTIP9IwVC6B05qwlELpUlZkJ9Wq/GqE9FK+SPg==
X-Google-Smtp-Source: AGHT+IHdnFsa4ffMwlnwovXZJPD+rbcRmchS4n60kAyf+dDPYEYAQF73K96zE7yxTNdTWdV8fOAbDg==
X-Received: by 2002:a05:6a20:3942:b0:2ea:41f1:d54a with SMTP id adf61e73a8af0-363f5eb6172mr2466088637.55.1764762222362;
        Wed, 03 Dec 2025 03:43:42 -0800 (PST)
Received: from sidong.sidong.yang.office.furiosa.vpn ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4f5f3416bsm12826672a12.0.2025.12.03.03.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:43:41 -0800 (PST)
From: Sidong Yang <realwakka@gmail.com>
To: fstests@vger.kernel.org,
	Filipe Manana <fdmanana@kernel.org>
Cc: Sidong Yang <realwakka@gmail.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/1] btrfs/339: test receive dump stream for different user
Date: Wed,  3 Dec 2025 11:43:25 +0000
Message-ID: <20251203114328.10386-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test receive to dump stream file from different user.

This is a regression test for the btrfs-progs commit cd933616d485
("btrfs-progs: receive: don't use O_NOATIME to open stream for
dumping").

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2:
- forward to $seqres.full rather than -q
- use $tmp for stream file
v3:
- use _btrfs than $BTRFS_UTIL_PROG
- remove unnecessary cleanup, requirement
---
 tests/btrfs/339     | 32 ++++++++++++++++++++++++++++++++
 tests/btrfs/339.out |  2 ++
 2 files changed, 34 insertions(+)
 create mode 100755 tests/btrfs/339
 create mode 100644 tests/btrfs/339.out

diff --git a/tests/btrfs/339 b/tests/btrfs/339
new file mode 100755
index 00000000..234a9ea0
--- /dev/null
+++ b/tests/btrfs/339
@@ -0,0 +1,32 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Sidong Yang.  All Rights Reserved.
+#
+# FS QA Test 339
+#
+# Test btrfs receive dump stream from different user
+#
+. ./common/preamble
+_begin_fstest auto quick send snapshot
+
+. ./common/filter
+
+_require_scratch
+_require_user
+
+_fixed_by_git_commit btrfs-progs cd933616d485 \
+	"btrfs-progs: receive: don't use O_NOATIME to open stream for dumping"
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+stream=$tmp.fsv.ss
+
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap
+_btrfs send -f $stream $SCRATCH_MNT/snap
+chmod a+r $stream
+_su $qa_user -c "$BTRFS_UTIL_PROG receive --dump -f $stream" >> $seqres.full
+
+# success, all done
+echo "Silence is golden"
+_exit 0
diff --git a/tests/btrfs/339.out b/tests/btrfs/339.out
new file mode 100644
index 00000000..293ea808
--- /dev/null
+++ b/tests/btrfs/339.out
@@ -0,0 +1,2 @@
+QA output created by 339
+Silence is golden
-- 
2.43.0

