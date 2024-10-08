Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0DB18873E
	for <fstests@vger.kernel.org>; Tue,  8 Oct 2024 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386611; cv=none; b=kJClixRbfUH4RYmS8MUD/W1Hzka9OASxGoO9j9PVFVRBxcHOOBey/xeus9y1etiVIhz6cloiYjM7q0iQVrAZCrounLe+fbcTz0OImKqIjJWYM47a8fibmD8dGNXHZXHoqP8y2komUHchL//fMiKFV5D6IQlnqAoiZcOtkEkp1BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386611; c=relaxed/simple;
	bh=vI9JZ6EDI6lQhZLKSOi7yqHOeShtKeqjx0RWa9I5OfE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K8/KU11Jiml6SjVStF16tuRgOFVlkihxYO9DorRg48eICzA/fxNGoQ2K6PIwNmH8AM0VsCF07j0GG5QkvXpVGFpTmC5BgaCQlaAKfFEbMcxuhpvLWIM5Q/84yVNc3nUFkMpvbADDLKQZ/+9bEs2n4Q9wAeP2YO485eWagDK+YuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=FDu7GbGL; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FDu7GbGL"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498BNOKI006012
	for <fstests@vger.kernel.org>; Tue, 8 Oct 2024 04:23:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=lFhGPnT2D5YfyQH9NdPusGd
	c2f7yO9nt3rBHwC1Bxr0=; b=FDu7GbGLHRY8zox7dQDVNbvkQzxzQLYh4mVo75r
	pXZHmOWHZRCSGgTH7lXZKj7bBDbn54pCLaccOuVxkj4uR/LNPk70jNs/XM8aEpfH
	H+0+TWNvMHRk3A/QJdjCStmfeNEar8lhnHppqAui/FekJ/LsWk14nqXs4cYt3i75
	G5a0=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4231gf8b46-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <fstests@vger.kernel.org>; Tue, 08 Oct 2024 04:23:28 -0700 (PDT)
Received: from twshared17314.02.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 8 Oct 2024 11:23:26 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 5DFA378E827E; Tue,  8 Oct 2024 12:23:18 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <fstests@vger.kernel.org>
CC: <linux-btrfs@vger.kernel.org>, Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] btrfs: add test for missing csums in log when doing async on subpage vol
Date: Tue, 8 Oct 2024 12:22:54 +0100
Message-ID: <20241008112302.2757404-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: j3lpPMRfybSHkkbNmEsk3HW1193bW68u
X-Proofpoint-GUID: j3lpPMRfybSHkkbNmEsk3HW1193bW68u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

Adds a test for a bug we encountered on Linux 6.4 on aarch64, where a
race could mean that csums weren't getting written to the log tree,
leading to corruption when it was replayed.

The patches to detect log this tree corruption are in btrfs-progs 6.11.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 common/dmlogwrites  | 24 ++++++++++++++++++
 tests/btrfs/192     | 26 +-------------------
 tests/btrfs/333     | 59 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/333.out |  2 ++
 4 files changed, 86 insertions(+), 25 deletions(-)
 create mode 100755 tests/btrfs/333
 create mode 100644 tests/btrfs/333.out

diff --git a/common/dmlogwrites b/common/dmlogwrites
index c1c85de9..f7faf244 100644
--- a/common/dmlogwrites
+++ b/common/dmlogwrites
@@ -203,3 +203,27 @@ _log_writes_replay_log_range()
 		>> $seqres.full 2>&1
 	[ $? -ne 0 ] && _fail "replay failed"
 }
+
+# Replay and check each fua/flush (specified by $2) point.
+#
+# Since dm-log-writes records bio sequentially, even just replaying a ra=
nge
+# still needs to iterate all records before the end point.
+# When number of records grows, it will be unacceptably slow, thus we ne=
ed
+# to use relay-log itself to trigger fsck, avoid unnecessary seek.
+_log_writes_fast_replay_check()
+{
+	local check_point=3D$1
+	local blkdev=3D$2
+	local fsck_command=3D$3
+	local ret
+
+	[ -z "$check_point" -o -z "$blkdev" ] && _fail \
+	"check_point and blkdev must be specified for log_writes_fast_replay_ch=
eck"
+
+	$here/src/log-writes/replay-log --log $LOGWRITES_DEV \
+		--replay $blkdev --check $check_point --fsck "$fsck_command" \
+		&> $tmp.full_fsck
+	ret=3D$?
+	tail -n 150 $tmp.full_fsck >> $seqres.full
+	[ $ret -ne 0 ] && _fail "fsck failed during replay"
+}
diff --git a/tests/btrfs/192 b/tests/btrfs/192
index f7fb65b8..449f0459 100755
--- a/tests/btrfs/192
+++ b/tests/btrfs/192
@@ -96,30 +96,6 @@ delete_workload()
 	done
 }
=20
-# Replay and check each fua/flush (specified by $2) point.
-#
-# Since dm-log-writes records bio sequentially, even just replaying a ra=
nge
-# still needs to iterate all records before the end point.
-# When number of records grows, it will be unacceptably slow, thus we ne=
ed
-# to use relay-log itself to trigger fsck, avoid unnecessary seek.
-log_writes_fast_replay_check()
-{
-	local check_point=3D$1
-	local blkdev=3D$2
-	local fsck_command=3D"$BTRFS_UTIL_PROG check $blkdev"
-	local ret
-
-	[ -z "$check_point" -o -z "$blkdev" ] && _fail \
-	"check_point and blkdev must be specified for log_writes_fast_replay_ch=
eck"
-
-	$here/src/log-writes/replay-log --log $LOGWRITES_DEV \
-		--replay $blkdev --check $check_point --fsck "$fsck_command" \
-		&> $tmp.full_fsck
-	ret=3D$?
-	tail -n 150 $tmp.full_fsck >> $seqres.full
-	[ $ret -ne 0 ] && _fail "fsck failed during replay"
-}
-
 xattr_value=3D$(printf '%0.sX' $(seq 1 3800))
=20
 # Bumping tree height to level 2.
@@ -145,7 +121,7 @@ wait
 _log_writes_unmount
 _log_writes_remove
=20
-log_writes_fast_replay_check fua "$SCRATCH_DEV"
+_log_writes_fast_replay_check fua "$SCRATCH_DEV" "$BTRFS_UTIL_PROG check=
 $SCRATCH_DEV"
=20
 echo "Silence is golden"
=20
diff --git a/tests/btrfs/333 b/tests/btrfs/333
new file mode 100755
index 00000000..13f113ca
--- /dev/null
+++ b/tests/btrfs/333
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test 333
+#
+# Test async dio with fsync to test a bug where a race meant that csums =
weren't
+# getting written to the log tree, causing corruptions on remount. This =
can be
+# seen on subpage FSes on 6.4.
+#
+. ./common/preamble
+_begin_fstest auto quick metadata log volume
+
+_fixed_by_kernel_commit e917ff56c8e7 \
+	"btrfs: determine synchronous writers from bio or writeback control"
+
+fio_config=3D$tmp.fio
+
+. ./common/dmlogwrites
+
+_require_scratch
+_require_log_writes
+
+cat >$fio_config <<EOF
+[global]
+iodepth=3D128
+direct=3D1
+ioengine=3Dlibaio
+rw=3Drandwrite
+runtime=3D1s
+[job0]
+rw=3Drandwrite
+filename=3D$SCRATCH_MNT/file
+size=3D1g
+fdatasync=3D1
+EOF
+
+_require_fio $fio_config
+
+cat $fio_config >> $seqres.full
+
+_log_writes_init $SCRATCH_DEV
+_log_writes_mkfs >> $seqres.full 2>&1
+_log_writes_mark mkfs
+
+_log_writes_mount
+
+$FIO_PROG $fio_config > /dev/null 2>&1
+_log_writes_unmount
+
+_log_writes_remove
+_log_writes_replay_log mkfs $SCRATCH_DEV
+
+_log_writes_fast_replay_check fua "$SCRATCH_DEV" "$BTRFS_UTIL_PROG check=
 $SCRATCH_DEV"
+
+echo "Silence is golden"
+
+# success, all done
+status=3D0
+exit
diff --git a/tests/btrfs/333.out b/tests/btrfs/333.out
new file mode 100644
index 00000000..60a15898
--- /dev/null
+++ b/tests/btrfs/333.out
@@ -0,0 +1,2 @@
+QA output created by 333
+Silence is golden
--=20
2.44.2

