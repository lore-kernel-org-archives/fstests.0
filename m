Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4DB134406
	for <fstests@vger.kernel.org>; Mon, 20 May 2024 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716224452; cv=none; b=D6EiGVjiGNZPU/wm+v/wB4HnxoOh5zMIFZYvMJSOF9H2WXoB7Y6qi00pojGM1yZNmUO1rkJt1yCdqO46ajqSv+0Tcy5SZK5dixO2dF/+AIc+jTHRRGyh68Rgqj/bW6tdrBntoOw8A23+orz93rY3Q3ELWRnyZFqHqVex+gXUs/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716224452; c=relaxed/simple;
	bh=1APxhd3ckTAzVBTdLTLt3c5andKLLsC+U+pcDI4EGBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kbWZfqa/3QZgfR9kvGFMN2PFM8SyQF64PYro+h5vqCXM64T0TLKxPY9UpCXfnXOtRCV6US2OSvQjTrhYM7uEIVnZ+eMbil74IY/l4Z+hKcYdumCUe3WOLJpZ2kWvaSy0KZUTGPFelmqodSJCBfAbnXQAjJ+Mi2TWM/wuOOgjI08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JamLfRcC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JamLfRcC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716224450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4qWhkh1epTlmJSat3qjeiKyBc/qMan6DIng62vymx/0=;
	b=JamLfRcCE2sCeqkWH1uYbnuo7kDYPe4YK4PRxkRy95aomlees3AtSDZfT2qxiXX996GYxu
	bErQaf47fXmoRKQ7nxlBvgSwl9gWWij623ye+1nRLX3AqJRom3G8S2vB9cj+0VWrmxt1kQ
	MTBU1ejGM05yG8Lu4HckUREiJq46Dww=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-9BZzNJXTN7289HOYQb4YEQ-1; Mon, 20 May 2024 13:00:48 -0400
X-MC-Unique: 9BZzNJXTN7289HOYQb4YEQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-51f6fb04b82so10331114e87.2
        for <fstests@vger.kernel.org>; Mon, 20 May 2024 10:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716224446; x=1716829246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qWhkh1epTlmJSat3qjeiKyBc/qMan6DIng62vymx/0=;
        b=MqhQgKswUysiYBMATGt7ofytBAZjzmo45sfPVOAjRuFhGZzGVVphmWgZV3MZpnrbpZ
         P2LYsRbN4Hc+M8UK7Shw+n70kLQjoz45dPAvcVnqb8rKOb7xvXBkPkS38G4BO74YiAnQ
         5JyBz0QiaTw70mmdEsWgO2I/At8kSGig2rNdhVc587h/c/GaAnL+DkDWu/4JeZSIg2Iz
         Auh71LdT+Qmmq0sbsssmzWChox/qt2KLHvHk1f1/UnMyAgWBBiHvXZs5X3VW1f3yr1EC
         z27QxT564d7w8vlrAMWfl46uetQjGjPv7HlobZRhbw76RBzhMF0bdUgMVPh1N78TCbdr
         Wt1A==
X-Gm-Message-State: AOJu0YzHI6bjyri3b6nFNqH0acvr+sM3t6zf3P7Z2tCrKGaiDdkdCvJx
	L1gSjGBL2NjwoRxu9SaCvjYLz6E/cMJTHxvT80eYv1OqujTvXiGPC0MiD/IIuBNpJvmi9JPvDD6
	lsE0TvftaC6jo5QFc+tKrZKYBGjZ5yovd5PH7OhN+FCQnF5PcyLTY20kF+oK48JoIefI5hYSc+q
	ImCtW2SA+Rr/ufp+LCFfFGKkB0bu/KAuMN+N5ukA==
X-Received: by 2002:a19:4309:0:b0:523:e073:36c6 with SMTP id 2adb3069b0e04-523e0733873mr5466678e87.48.1716224446031;
        Mon, 20 May 2024 10:00:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgR8006pqsvLSuExNivh1ntHtStjT+2FJZqDTI8e/r+3CL4gn8WqYjw0cmtsM+4aOotKUz3w==
X-Received: by 2002:a19:4309:0:b0:523:e073:36c6 with SMTP id 2adb3069b0e04-523e0733873mr5466658e87.48.1716224445257;
        Mon, 20 May 2024 10:00:45 -0700 (PDT)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2cb54csm15074896a12.60.2024.05.20.10.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 10:00:44 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH] xfs: test quota's project ID on special files
Date: Mon, 20 May 2024 19:00:05 +0200
Message-ID: <20240520170004.669254-2-aalbersh@redhat.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With addition of FS_IOC_FSSETXATTRAT xfs_quota now can set project
ID on filesystem inodes behind special files. Previously, quota
reporting didn't count inodes of special files created before
project initialization. Only new inodes had project ID set.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---

Notes:
    This is part of the patchset which introduces
    FS_IOC_FS[GET|SET]XATTRAT:
    https://lore.kernel.org/linux-xfs/20240520164624.665269-2-aalbersh@redhat.com/T/#t
    https://lore.kernel.org/linux-xfs/20240520165200.667150-2-aalbersh@redhat.com/T/#u

 tests/xfs/608     | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/608.out | 10 +++++++
 2 files changed, 83 insertions(+)
 create mode 100755 tests/xfs/608
 create mode 100644 tests/xfs/608.out

diff --git a/tests/xfs/608 b/tests/xfs/608
new file mode 100755
index 000000000000..3573c764c5f4
--- /dev/null
+++ b/tests/xfs/608
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Red Hat.  All Rights Reserved.
+#
+# FS QA Test 608
+#
+# Test that XFS can set quota project ID on special files
+#
+. ./common/preamble
+_begin_fstest auto quota
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+	rm -f $tmp.proects $tmp.projid
+}
+
+
+# Import common functions.
+. ./common/quota
+. ./common/filter
+
+# Modify as appropriate.
+_supported_fs xfs
+_require_scratch
+_require_xfs_quota
+_require_user
+
+_scratch_mkfs >/dev/null 2>&1
+_qmount_option "pquota"
+_scratch_mount
+_require_test_program "af_unix"
+_require_symlinks
+_require_mknod
+
+function create_af_unix () {
+	$here/src/af_unix $* || echo af_unix failed
+}
+
+function filter_quota() {
+	_filter_quota | sed "s~$tmp.proects~PROJECTS_FILE~"
+}
+
+projectdir=$SCRATCH_MNT/prj
+id=42
+
+mkdir $projectdir
+mkfifo $projectdir/fifo
+mknod $projectdir/chardev c 1 1
+mknod $projectdir/blockdev b 1 1
+create_af_unix $projectdir/socket
+touch $projectdir/foo
+ln -s $projectdir/foo $projectdir/symlink
+touch $projectdir/bar
+ln -s $projectdir/bar $projectdir/broken-symlink
+rm -f $projectdir/bar
+
+$XFS_QUOTA_PROG -D $tmp.proects -P $tmp.projid -x \
+	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.proects -P $tmp.projid -x \
+	-c "limit -p isoft=20 ihard=20 $id " $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.proects -P $tmp.projid -x \
+	-c "project -cp $projectdir $id" $SCRATCH_DEV | filter_quota
+$XFS_QUOTA_PROG -D $tmp.proects -P $tmp.projid -x \
+	-c "report -inN -p" $SCRATCH_DEV
+$XFS_QUOTA_PROG -D $tmp.proects -P $tmp.projid -x \
+	-c "project -Cp $projectdir $id" $SCRATCH_DEV | filter_quota
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/608.out b/tests/xfs/608.out
new file mode 100644
index 000000000000..c3d56c3c7682
--- /dev/null
+++ b/tests/xfs/608.out
@@ -0,0 +1,10 @@
+QA output created by 608
+Setting up project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+Checking project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
+#0                   3          0          0     00 [--------]
+#42                  8         20         20     00 [--------]
+
+Clearing project 42 (path SCRATCH_MNT/prj)...
+Processed 1 (PROJECTS_FILE and cmdline) paths for project 42 with recursion depth infinite (-1).
-- 
2.42.0

