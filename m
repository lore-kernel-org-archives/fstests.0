Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54D199237
	for <fstests@vger.kernel.org>; Thu, 18 Sep 2025 00:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758155598; cv=none; b=G1AtY+HXKIdgP/Kx7h3OaIILioJ+YtSW/JGhPb93BvLJANaG5vX7pUAUJ3YRBtBJI0s+ls4mvsguBwSCvkRbG0xnaq4JteZfpwTAIkpZqPybR2iqIW45ZEbMezOc5TyFsWcyK2O8h4i83JN6nogy54kyM4wDAjhZHEQYZ9DYtoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758155598; c=relaxed/simple;
	bh=hAqR93w+XiRa2S8cDIVSi8wXFbzAsDzhPYEyF0meuxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eph6ofHtJzPh1gJi0YseDClx2RIF+rNSeliS38i43vSp2E3lGx/XzhxsM+YwSGw0rhu/jSqZ5qHWd7UYXc5NvT7yujpepxGuMiiRlvOkWbVRNHm9UhJpjodPxW8+kuJEcwqVRXo1dd0KGWm/rNlJPHqbn3CdpIWuw5nQQMVeNc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iN1kyzQd; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN1kyzQd"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32e64d54508so363773a91.0
        for <fstests@vger.kernel.org>; Wed, 17 Sep 2025 17:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758155595; x=1758760395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTWvdiSmTyeacfFcM8U68B32XVdZJkCprbhP3/f5kBI=;
        b=iN1kyzQdiP3nuU9hTZ+WVTs+SQbiMJuJ9Oo62arw/NOOHr+6Uhv7Z0C8v0h+Oi04t8
         /Xdsbtp5pJNEIb82u1KMfwwWL8WOavsKd4IUl0yFqo32ZPvRw46zQHbyxE+vFnlN5PQg
         tUuwNFsQrPNUlSD2DgeLZ2h2IMHKcGB2UTSZ7CxG8QF7iYe6EL4P4akEopWEwF71hCYB
         qnCSPDW7rZx/Y/4vrOpNwS7iRObKDyoEz4AlfjT1NeOY8ODgKM+vNZymkxAof8TLm8Ui
         Jkc50ROW33H7KsYcJgTQBg/S3wrPQ+Y4uPxusuMIBxNY/pR50MmryFn4MV2cleZqvs93
         qoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758155595; x=1758760395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTWvdiSmTyeacfFcM8U68B32XVdZJkCprbhP3/f5kBI=;
        b=vaXfqrQsw+PKp8AwidAnXcGyzYGT8CEAjZM0QAEzBWsYFoBEh8nTLeTyrExHcFkxs2
         m3Hd1Q0M3q1DQDn9yewXKpNprrAm2gMgDDz6axqYX1fLQZIgJk1DPKwe/8zRyi+8LaRX
         5mYopCoguD91/XTwX4aUmRXEfc2+/JOtfHLTEc/asGKkHfz35Uo9b1PtBURdcTn2NoyF
         tEyfkBHzy8a6SQSVij/5n1wDi91kBxuwS3/clczyxL6YWJVdlnzOvhkHJmiaWaG3pyCh
         OzhM/5tWPWz22NHsWCKSegAbrD0QfS6yCClGUoIE1g6Fyko/eo/MDlfMlEOoksEBU8xT
         w7YQ==
X-Gm-Message-State: AOJu0Yyxn+c/pkuLWJfTPwuV7ODj9qh2btQoaL7uhoU+mHg0i4LHsruo
	pB0VwDxdWEuDeHfM395DntzInxt19+SvVIOpdf9Z3vu1hskRBzKbzZOd1Sgnbw==
X-Gm-Gg: ASbGncuFlEAf3IOp2fle9agRx+WIodz7/Ds4149HtbcV0c5mmFs3QtSQOdAbmxGbdJI
	/cYKORz0S9+HQKvaBRhE6tiGBo5QYu5py2rfGoDkKlL2Ytng20hz7VNvHHR8lFDBN8hEx43Bj8V
	eRxS9i83COgBOm+n92pXQwRb3E6YRRbc33l2w3WgKzbuH6heDOb8l1gyVtriJEDeqEK/kaBBawW
	owWKFFHmdau/ZuM8JIyAne5H9UK1k625VQm8vUZkaRkHIREtWRV1b/DNlmyepfBqT4m2+R/Hyyn
	UoEjHV55uA5Sf2wZ/6kc4jxFbuc88FQc7M42vTOMNz37uM/aRTpSdoAgB11QrnqOi1988JR1yzu
	zu/xTqI0aTkirnfxfHC4uDkLuFjPYrpCUiE1/UGxTRMx9jHUzZphUHXf24Z7u/ifhO1I64CpHaw
	==
X-Google-Smtp-Source: AGHT+IE28EG5LlRQNZBjW7kKUHDtUWpTqRGMh5eMtHM+owJRDWG5sMbf3mHt9lEtSt8UZ3aqcY7orw==
X-Received: by 2002:a17:90b:4cc7:b0:32d:f4cb:7486 with SMTP id 98e67ed59e1d1-32ee3f5d61emr5863139a91.19.1758155595072;
        Wed, 17 Sep 2025 17:33:15 -0700 (PDT)
Received: from feddev.blackrouter ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330607b1f5esm644428a91.17.2025.09.17.17.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 17:33:14 -0700 (PDT)
From: Anand Jain <anajain.sg@gmail.com>
X-Google-Original-From: Anand Jain <asj@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] generic: test case for reappearing device
Date: Thu, 18 Sep 2025 08:32:47 +0800
Message-ID: <4cc549240200e8ac3b4646c99fef5fcf30ef6f2d.1758148804.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758148804.git.anand.jain@oracle.com>
References: <cover.1758148804.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anand Jain <anand.jain@oracle.com>

Tests how the filesystem handles a device that reappears with a different
MAJ:MIN due to a block layer transport failure.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/generic/809     | 72 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/809.out |  2 ++
 2 files changed, 74 insertions(+)
 create mode 100755 tests/generic/809
 create mode 100644 tests/generic/809.out

diff --git a/tests/generic/809 b/tests/generic/809
new file mode 100755
index 000000000000..3e9943f9ac85
--- /dev/null
+++ b/tests/generic/809
@@ -0,0 +1,72 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 809
+#
+# Tests how the filesystem handles a device that reappears with a different
+# MAJ:MIN while the old MAJ:MIN is still mounted and in use, due to a block
+# layer transport failure.
+
+. ./common/preamble
+
+_begin_fstest auto quick tempfsid shutdown
+
+_cleanup()
+{
+	local new_blk_handle
+
+	cd /
+	rm -r -f $tmp.*
+	$UMOUNT_PROG $mnt1 &> /dev/null
+	$UMOUNT_PROG $SCRATCH_MNT &> /dev/null
+
+	if [[ ! -b $new_scratch_dev ]]; then
+		echo "_cleanup: failed to restore the scratch device."
+		return
+	fi
+	new_blk_handle=$(_bdev_handle $new_scratch_dev)
+	_devmgt_remove  $new_blk_handle $new_scratch_dev
+	_devmgt_add $new_blk_handle
+
+	[[ -b $SCRATCH_DEV ]] || \
+		echo "_cleanup: failed to restore scratch device."
+}
+
+_require_test
+_require_scratch
+_require_scratch_bdev_delete
+
+mnt1=$TEST_DIR/$seq/mnt1
+rm -r -f $mnt1
+mkdir -p $mnt1
+
+_scratch_mkfs >> /dev/null
+_scratch_mount
+
+$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo >> $seqres.full
+_mount $SCRATCH_DEV $mnt1
+$UMOUNT_PROG $mnt1
+
+# Ensure data is flushed to disk before the device disappears
+sync
+
+id1=$(lsblk -ndo MAJ:MIN $SCRATCH_DEV)
+scratch_fsid=$(blkid --probe --match-tag UUID $SCRATCH_DEV | \
+	$AWK_PROG '{print $2}' | sed -e 's/UUID=//g' | sed -e 's/\"//g')
+blk_handle=$(_bdev_handle $SCRATCH_DEV)
+_devmgt_remove  $blk_handle $SCRATCH_DEV
+_devmgt_add $blk_handle
+new_scratch_dev=$(blkid -l -o device -t UUID=$scratch_fsid)
+id2=$(lsblk -ndo MAJ:MIN $new_scratch_dev)
+[[ -b $new_scratch_dev ]] || _fail "Device failed to reappear"
+[[ "$id1" != "$id2" ]] || \
+		_not_run "Device cannot reappear with a different major:minor"
+
+# Mount the reappeared device while the old node is still mounted
+# (not supported on XFS).
+[[ $FSTYP == "xfs" ]] && $UMOUNT_PROG $SCRATCH_MNT
+_mount $new_scratch_dev $mnt1
+echo Silence is golden
+status=0
+exit
diff --git a/tests/generic/809.out b/tests/generic/809.out
new file mode 100644
index 000000000000..e90865ca8f8c
--- /dev/null
+++ b/tests/generic/809.out
@@ -0,0 +1,2 @@
+QA output created by 809
+Silence is golden
-- 
2.51.0

