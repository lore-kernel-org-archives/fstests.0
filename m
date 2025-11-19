Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB49728C849
	for <fstests@vger.kernel.org>; Wed, 19 Nov 2025 02:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520057; cv=none; b=XNnKXaQmxycv3q3lc5PlTuBAKIenOUVsXAIBa9aih5RS9xOzN5kG1YGWuuoNnQKVFVvk9M89w5PqFm03aNzEANhkF8dtKQiup4O4KanvsOZ9A6X7B8BQ8OpUVUEAPlY2a+wfjN1DP2cJ9zBWL4REakGMYhO7cW9pzknaVTo3kus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520057; c=relaxed/simple;
	bh=WcZ1SJZovo6vbYl4x5xl9cGb55bFggqGblbxVvcCB/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmdpoLczn8cB5OfdQQ+mLcjQNtvxlGn5U2C6evL9j+HnOsfEaoZnvcCeyrtNWSelTqeC0JgKRxzQYF75BopGli+7rH2uRNDz+lO2Ga0aubd2VP9AhedxGsBsItB0bGLtPu5jT6FdCsGtmH0071ahDWiyYCPwL+5LjpSDYXv4vXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cY13bT0k; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY13bT0k"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2957850c63bso4997865ad.0
        for <fstests@vger.kernel.org>; Tue, 18 Nov 2025 18:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763520055; x=1764124855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7fJ64B3l2aZ8gg+aOT2cGtK2HK8RXnbetEVCcCDXMm8=;
        b=cY13bT0kcvj7BwG06KxeuTfeojxyX63Aif/xm8CN4N5xx15KTmwAQCRiBoWuVR9Gko
         v4M7U8iao/hN/njIs0+eh5R/85NR4E49ElKMsJ1BXmHCxnaX8ei45e2+WmuQcNiwCHAN
         1nyp1RvcT1+I2Wq5jLvarF5VKEPZKlcm9n6eAVHWZsqezhuyJuyeMkYl7FTvxcoJgkqi
         HZdwuHlZB0sYAkFiw3T6OfwpStFvYhx5LoD7vqPyT6mqw0rDzAVP/Ut/1KsvWtvK2e75
         1LL/iobD4kSwosf+KHjqqK45mGK2cLWpRqcgI0SOeUMSDUNAAqyvw7XufFaz9rEQVsc8
         xTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763520055; x=1764124855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fJ64B3l2aZ8gg+aOT2cGtK2HK8RXnbetEVCcCDXMm8=;
        b=BAngsdgLd96RJNpcFhvg2b/JtEoReoyP71U9oZcTB/ajYPOD3Q9PCteJcegJeMiA0e
         GxlvxmvFabRjySmu5dWLRw2z6YanD8rXmTb/0/W9Rp942xapeTNWdiEQ6vRI1ZkOtt44
         zu8vHoHuyo6GDj4L/NyXIKjRenCcylDCjUVjKdScwX9RG7vdHVRwLEbpub13E9BYinJf
         tNSsBs1AL1ZYneeI/4MDGDXqQue2SxTjzbfJRuCs3m1ZP76MSeNCFsHktmpFz7/EXQKa
         yeXZWlnRd+3PnOHbJgba2Y7u9dCvCh5lsQmixrkSv+F4L6OzbNvgu6Mw+Kr5Ahhn9c5J
         sAIQ==
X-Gm-Message-State: AOJu0Yz1zNKJetAm2a5fTBo5PqD+sCnvdk0eJqxp+LQB8h8/5jVwjIQT
	Hf02p+GJBkW7qQltlUXca6aCcjAB1A/O021Q/WpwQQzxztX7enLQPzO7Af4deQ==
X-Gm-Gg: ASbGncvcBwZiKE9N1O8n3tCJ+Qh9h/2Vw8bA/bdm8IdeZ7sVN2vnOFHuPxVLC/219bR
	YfQyzpQTQTwO2JVN9LDKdPOtgCyXiCJx4F7dQWyP7xUxuKSd1w/I3/+wttBy9p81pesSA7vjdUO
	+Pql9hY7Gbbk7VDpVFPkv2vy4VtRt37sjem2yJboLt168Bjo9EEPexRRmaQ4UFzGsVOl6+hTXh9
	KtLPaq46jMgldPEcRHHLQbNByUYv+g2M8U9UzggXaeWZKnE2BseSy6szO65M/QwQxQ4J3c8ZTwx
	g8O+pgUku+aZX6fJ2iY7Q0Jj2pe7//sXqpf3Fm8dagdZpB8qJIvOKgukU8xEoBxk1uSlyoBInWP
	+b2ZCQldB1ywWIIk8QTtZivVx/qc6DQ19y8AWfPwCqneQp41uQAHg06gSPUCIdUdmiN6IlQ4ema
	i0CeibJosx/G0OmC1QP+x3Rp8zviCMYz1lVXRjYW/7zSIoG30FJDp3fI/mUm0Mxyhg8xI=
X-Google-Smtp-Source: AGHT+IGfBVibuqYhqYVtXIJ3JNQvz06IGlQMOVGqvS7Uxt4SrnGIovbeo5VyrSVjvp93rozUMKYM9w==
X-Received: by 2002:a17:902:da48:b0:297:e897:6f6d with SMTP id d9443c01a7336-29a05ef321bmr8996875ad.9.1763520054753;
        Tue, 18 Nov 2025 18:40:54 -0800 (PST)
Received: from sidong.sidong.yang.office.furiosa.vpn ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0c9dsm187861255ad.67.2025.11.18.18.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 18:40:54 -0800 (PST)
From: Sidong Yang <realwakka@gmail.com>
To: fstests@vger.kernel.org
Cc: Sidong Yang <realwakka@gmail.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 1/1] btrfs/339: test receive dump stream for different user
Date: Wed, 19 Nov 2025 02:40:30 +0000
Message-ID: <20251119024034.23861-1-realwakka@gmail.com>
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
 tests/btrfs/339     | 32 ++++++++++++++++++++++++++++++++
 tests/btrfs/339.out |  2 ++
 2 files changed, 34 insertions(+)
 create mode 100755 tests/btrfs/339
 create mode 100644 tests/btrfs/339.out

diff --git a/tests/btrfs/339 b/tests/btrfs/339
new file mode 100755
index 00000000..728f3d9d
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
+. ./common/quota
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
+$BTRFS_UTIL_PROG -q subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
+$BTRFS_UTIL_PROG -q send -f stream $SCRATCH_MNT/snap
+chmod a+r stream
+_su $qa_user -c "$BTRFS_UTIL_PROG receive --dump -f stream" >> $seqres.full
+rm stream
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

