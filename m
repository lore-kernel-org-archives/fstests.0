Received: from mx0.herbolt.com (mx0.herbolt.com [5.59.97.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757E423D7DC
	for <fstests@vger.kernel.org>; Thu, 14 May 2026 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.59.97.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758848; cv=none; b=t+pTgbAerkxuZjqfWpbEqFkfjZ8aKmjbmzIgkt+9OygtUQocL2ASRSp5/wkRMrQccTtP3EpXioyF7xl2pUGXqbrj4JkSvVuh6x+M/IVXUOwnEX3E2TtpGT+753rvLC3fmnmYAOkwNPKLhq0yqyah8Wk5lz13ygJGH8o9zb9+chc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758848; c=relaxed/simple;
	bh=PaK8qhF+KOjbMEGq6ndRTvDN2SdmDa4MMRzkObfatkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Up5cAo0okARXNdk0pc+WLFyDojotRgFNILM4+KRKsvvfdqlC/bSb1z99uHPjQyzmhFuiAPmUAcVOB5wVp/99eL4Nr85uFTxz+0p1pcM0w8GLpIu+y+dxpULsIX3SQ5OLPTwVwf/O5c4VGcpbJsa4u3J+jnW/MUD4wsNkZrVRkK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com; spf=pass smtp.mailfrom=herbolt.com; arc=none smtp.client-ip=5.59.97.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbolt.com
Received: from mx0.herbolt.com (localhost [127.0.0.1])
	by mx0.herbolt.com (Postfix) with ESMTP id 7BE20180F2E7;
	Thu, 14 May 2026 13:40:43 +0200 (CEST)
Received: from trufa.intra.herbolt.com.com ([172.168.31.30])
	by mx0.herbolt.com with ESMTPSA
	id uaW8NIm0BWoNiioAKEJqOA:T5
	(envelope-from <lukas@herbolt.com>); Thu, 14 May 2026 13:40:43 +0200
From: Lukas Herbolt <lukas@herbolt.com>
To: zlang@kernel.org,
	djwong@kernel.org
Cc: fstests@vger.kernel.org,
	xfs-linux@kernel.org,
	Lukas Herbolt <lukas@herbolt.com>
Subject: [PATCH v2 4/4] xfs/21{6,7} Use default -l concurrency=0 on mkfs.xfs that supports it
Date: Thu, 14 May 2026 13:39:15 +0200
Message-ID: <20260514113910.866888-10-lukas@herbolt.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514113910.866888-2-lukas@herbolt.com>
References: <20260514113910.866888-2-lukas@herbolt.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The XFS concurrency optimization breaks the log sizing check on
systems with non-rotational disks and high amount of CPUs. Default to
the old behavior with -l concurrency=0 and with -d concurrency=0.

Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
---
 changes v2:
	use default mkfs.xfs for scratch device
	remove the double check -l/-d as those were introduced together
 tests/xfs/216 | 6 +++++-
 tests/xfs/217 | 7 ++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/216 b/tests/xfs/216
index 091c11d08642..0148e7f4de3e 100755
--- a/tests/xfs/216
+++ b/tests/xfs/216
@@ -22,13 +22,17 @@ _cleanup()
 
 _require_scratch
 _scratch_mkfs_xfs >/dev/null 2>&1
+if _scratch_mkfs_xfs_supports_concurrency -l >> $seqres.full 2>&1; then
+	loop_mkfs_opts="-l concurrency=0"
+else
+	loop_mkfs_opts=""
+fi
 _scratch_mount
 
 _require_loop
 LOOP_IMG=$SCRATCH_MNT/test_fs
 LOOP_MNT=$SCRATCH_MNT/test_fs_dir
 
-loop_mkfs_opts=
 $MKFS_XFS_PROG 2>&1 | grep -q rmapbt && \
 	loop_mkfs_opts="$loop_mkfs_opts -m rmapbt=0"
 $MKFS_XFS_PROG 2>&1 | grep -q reflink && \
diff --git a/tests/xfs/217 b/tests/xfs/217
index dae6ce55f475..23aae842d1fb 100755
--- a/tests/xfs/217
+++ b/tests/xfs/217
@@ -21,6 +21,11 @@ _cleanup()
 
 _require_scratch
 _scratch_mkfs_xfs >/dev/null 2>&1
+if _scratch_mkfs_xfs_supports_concurrency -l >> $seqres.full 2>&1; then
+	loop_mkfs_opts="-l concurrency=0 -d concurrency=0"
+else
+	loop_mkfs_opts=""
+fi
 _scratch_mount
 # 16T mkfs requires a bit over 2G free
 _require_fs_space $SCRATCH_MNT 2202000
@@ -34,7 +39,7 @@ _do_mkfs()
 	for i in $*; do
 		echo -n "fssize=${i}g "
 		$MKFS_XFS_PROG -f -b size=4096 -l version=2 \
-			-d size=${i}g $loop_dev |grep log
+			-d size=${i}g $loop_dev $loop_mkfs_opts |grep log
 		_mount $loop_dev $LOOP_MNT
 		echo "test write" > $LOOP_MNT/test
 		_unmount $LOOP_MNT > /dev/null 2>&1
-- 
2.54.0

