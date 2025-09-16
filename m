Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9825E313267
	for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035555; cv=none; b=Q0epuvtb+1Cufi+saggKwNVYDNNbXsl6fug3PV0YANBIHP9WqZ3SrHBujxJ9rJ7iyohvmHtBXKViHMF+1oUxyhMKl3K9xGm0KjOZ/2mqcr7iijKGwD0ESy7QiPWtHUqKua2GUcC3V6UZ4TCbgobsYof/L3H2oiy742wN8VM6zLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035555; c=relaxed/simple;
	bh=52dm8vE0b9XMEcBizu6dX6hNzmMPv+yJ/9yp89AZYXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WCWO2z/JIamKP/UpyW3/eApnuqR9VGjALgrObKz6v8OKZiM5/bgDlj5CkM7miBXte+c5aKGan+GUKWNhg3r2sauG9SQ8KiKmr67kBsZBpo45ajMs8lekt6AemIZkABEaccoZ8cYkzb3rId3x71li3i9UQSs1hmcygsJ6sSdFqM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbFXa+Jz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbFXa+Jz"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-26060bcc5c8so34596365ad.1
        for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758035552; x=1758640352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lia7qHS7vatNKnZWg3upjBy1l3FQ5GxPeDvnNhzXYE=;
        b=mbFXa+JzUfKjFDsdpwwycE3BXR9zGYLmQ/GH8831HrrySczMLHogO63UEp/lGHyyS0
         8dPkF88BHHU4Wv2x/JwCnx04vT9HaAxJNd+FN/84g5zNAPp5cOiqErRWj27E9RdX5xxI
         SBtiMCU5MFLgtbUYv3OwX32eSiFI5OB4O1zK5clXmS1y+qbkXiRMedqzlEpEQvA4xrki
         dvsNYNuGsMhMnzg/9SgAoi55C3+6yk/UxoNzGPPnSgfgknNlG/k9CiKVqLhgM4MK3uc5
         HxC2XoX/pCOHxscS+UcKy6eKD39qMH8l8CrhNQDl5BQ4cqvFCIvhSSGxzdx6awYomHDq
         MIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035552; x=1758640352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lia7qHS7vatNKnZWg3upjBy1l3FQ5GxPeDvnNhzXYE=;
        b=aGtVZXrZZmQ9J7CGQ8buO0HPfwqfnVlWlirJ04kZRM5X/YU8umWBTKwKxleSiHXUhZ
         7oOBFHLn/OdIAyuD3OVozP/U17LjMuV4Z69CY7unG4W+sbEw1mqFji10/u5yClUDjza4
         1catSjwLvGonVIV5FdysTKAWYbkbWWhX9+wa+byzQYja5uj05LuRaGLk7lFS4q9v8XRW
         RhiVH/3Mp+vxAXSvwTUCqhV9LaTagF76nNr9sNyk7qMc5Gt49wyk4+gra/ohESpjov5v
         5W9QcDPf89nja0VG4G8VtJEgFayFMtBkqksOxs7Ez+6GWjNjHQunF5uCyAb99DP1vUE7
         03Dw==
X-Gm-Message-State: AOJu0YwNavjDkF3kmSGXiHr5jvNwT5DuQJMkBDiZ5NolhesjotxjKoU3
	ADPm02CVad83p30RbypWiA5jw0XY2BhlRn4MnBV9AOqkjgzxhlEx7nitBvCPIw==
X-Gm-Gg: ASbGncsa18U3Dl2oUgcvxRSJmOnr4t6oeWptNMLgdi8elaRifFHY1hGpwEJ8vU/O0ub
	l7EYVjj0SSK5sviV5X+NM7EfijkxrMmRlzXS7RA34rDUF5bA21WOnghpPuUoeFyHm0jKZpOQasA
	eI337pvDVMSMyVe5FUdcFWzQKdmnv0ALn7T2FSEVYmMv1WZbc/tMKrkukHQSFswW1nukmdRv+ID
	NKNLLGfVG3RFr3ZId1XgPSBOuiathIfAtdmVLw6nppD1G7DTqWBjDavlGmc5ULWrukd/GUZsNPL
	gAxwVLQX20Qrvo/2TDF7xlif19ZhDUPgeVZeH5rFqXWChh4Hhehg3p9X3rTY2gKrJYqG39wYC2b
	V+jM0w1QgBL55NH7F34gXwlevk3s=
X-Google-Smtp-Source: AGHT+IFVZZm4lA2BHgbhsVi5jux7fAcpZpcBPgjjtlRMCHESlgJEbEs25GPx7+NtYuLPG5IoXq7pFw==
X-Received: by 2002:a17:903:b0e:b0:24c:e6fa:2a38 with SMTP id d9443c01a7336-25d2547e40fmr198717555ad.25.1758035552108;
        Tue, 16 Sep 2025 08:12:32 -0700 (PDT)
Received: from citest-1.. ([49.207.211.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a750sm164780175ad.83.2025.09.16.08.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:12:31 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: nirjhar.roy.lists@gmail.com,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	bfoster@redhat.com,
	david@fromorbit.com,
	hsiangkao@linux.alibaba.com,
	zlang@kernel.org
Subject: [RFC 3/3] xfs: Add multi AG shrink + shutdown + recovery tests
Date: Tue, 16 Sep 2025 15:11:32 +0000
Message-Id: <f3ac18465aa2d7d3eb382dca7c76fc893bd9aadd.1758035262.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1758035262.git.nirjhar.roy.lists@gmail.com>
References: <cover.1758035262.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test repeatedly shrinks, then shuts down
the filesystem and checks that recovery works
fine - this is similar to what is already being done
in xfs/609 but this tests with filesystem shrink and in
xfs/609 it is tested with filesystem growth.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/xfs/333     | 87 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/333.out |  2 ++
 2 files changed, 89 insertions(+)
 create mode 100755 tests/xfs/333
 create mode 100644 tests/xfs/333.out

diff --git a/tests/xfs/333 b/tests/xfs/333
new file mode 100755
index 00000000..1c319329
--- /dev/null
+++ b/tests/xfs/333
@@ -0,0 +1,87 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>.  All Rights Reserved.
+#
+# FS QA Test 333
+#
+# Test XFS online growfs log recover with shrinking the filesystem
+#
+. ./common/preamble
+_begin_fstest auto growfs stress shutdown log recoveryloop shrinkfs
+
+# Import common functions.
+. ./common/filter
+
+_stress_scratch()
+{
+	procs=4
+	nops=999
+	# -w ensures that the only ops are ones which cause write I/O
+	FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -w -p $procs \
+	    -n $nops`
+	_run_fsstress_bg $FSSTRESS_ARGS >> $seqres.full 2>&1
+}
+FSSIZE=$(( 1024 * 1024 * 1024 )) # 1G
+_require_scratch
+_require_scratch_size $((FSSIZE / 1024)) #KB
+_require_command "$XFS_GROWFS_PROG" xfs_growfs
+
+_scratch_mkfs_xfs | _filter_mkfs >$seqres.full 2>$tmp.mkfs
+. $tmp.mkfs	# extract blocksize and data size for scratch device
+
+endsize=`expr 128 \* 1048576`	# stop after shrinking to this size
+[ `expr $endsize / $dbsize` -lt $dblocks ] || _notrun "Scratch device too small"
+
+nags=16
+# We want to test with and without stress. The reason is that, if stress
+# fills up the filesystem such that all the AGs are non-empty, then all
+# the shrink commands will fail and we won't be able to test recovery
+# during shrink. So to cover all the types of scenarios, we are testing
+#  with and without stress.
+for stress in 0 1
+do
+	size=`expr 512 \* 1048576`	# 512 megabytes initially
+	sizeb=`expr $size / $dbsize`	# in data blocks
+	logblks=$(_scratch_find_xfs_min_logblocks -dsize=${size} -dagcount=${nags})
+	_scratch_mkfs_xfs -lsize=${logblks}b -dsize=${size} -dagcount=${nags} \
+		>> $seqres.full 2>&1 || _fail "mkfs failed"
+	_scratch_mount
+
+	$XFS_INFO_PROG $SCRATCH_MNT 2>&1 | _filter_mkfs 2>$tmp.xfsinfo >/dev/null
+	. $tmp.xfsinfo
+
+	if [[ "$stress" -eq 1 ]]; then
+		echo "Testing with Stress" >> $seqres.full 2>&1
+	else
+		echo "Testing without Stress" >> $seqres.full 2>&1
+	fi
+	# Shrink the filesystem in random sized chunks while performing shutdown and
+	# recovery. The randomization is intended to create a mix of sub-ag and
+	# multi-ag shrinks.
+	while [ $size -ge $endsize ]; do
+		echo "*** shrinking a ${sizeb} block filesystem (shrink)" >> \
+			$seqres.full
+		if [[ "$stress" -eq 1 ]]; then
+			_stress_scratch
+		fi
+
+		decsize=$((RANDOM % 40 * 1048576))
+		size=`expr $size - $decsize`
+		sizeb=`expr $size / $dbsize`	# in data blocks
+		$XFS_GROWFS_PROG -D ${sizeb} $SCRATCH_MNT >> $seqres.full 2>&1
+
+		sleep $((RANDOM % 3))
+		_scratch_shutdown
+		if [[ "$stress" -eq 1 ]]; then
+			_kill_fsstress
+		fi
+		_scratch_cycle_mount
+	done > /dev/null 2>&1
+	wait
+	_scratch_unmount
+done
+
+echo "Silence is golden"
+
+_exit 0
+
diff --git a/tests/xfs/333.out b/tests/xfs/333.out
new file mode 100644
index 00000000..60a15898
--- /dev/null
+++ b/tests/xfs/333.out
@@ -0,0 +1,2 @@
+QA output created by 333
+Silence is golden
-- 
2.34.1

