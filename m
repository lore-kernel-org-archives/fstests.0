Received: from mx0.herbolt.com (mx0.herbolt.com [5.59.97.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF89A4219F7
	for <fstests@vger.kernel.org>; Thu, 30 Apr 2026 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.59.97.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554906; cv=none; b=pi7S6P1x0rrS4tmbcsIFBxZvKDoucCPaiF1vHEcrCut79nWIzOVr3tOedjKRD8o7C7rMPEl1PmvQUeJa1J8nmXTe0L1nbAXxqLYVs+pSJsBU8Ox2MNQNHwn1LLpWcuz3fiQuvyEEMLNwrB/UXXN99ZtQ6u3oriZ1Uze7pvSb0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554906; c=relaxed/simple;
	bh=ypd6vI11OFRLP7cD3BbMlZ8nHZZWP8Bl3iFMFtdUQm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXmnD8JT6fdGakywCbsDK8k7uv6j8+zUuFnJBOJsqwhZm+p2zZlHzVpRK8PzNFH+9y61q6s0biaWQByC46NUiLQOQylwzcdDPLQAgoBCsrY5WdW4rJv+UhWj0C8w/cgoF9GflGi2NapFo7yo689wBKKhu3Txn9OQQPygWbwurao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com; spf=pass smtp.mailfrom=herbolt.com; arc=none smtp.client-ip=5.59.97.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbolt.com
Received: from mx0.herbolt.com (localhost [127.0.0.1])
	by mx0.herbolt.com (Postfix) with ESMTP id 61D29180F244;
	Thu, 30 Apr 2026 15:15:01 +0200 (CEST)
Received: from trufa.intra.herbolt.com.com ([172.168.31.30])
	by mx0.herbolt.com with ESMTPSA
	id HBgTK4ZV82m0DRoAKEJqOA:T5
	(envelope-from <lukas@herbolt.com>); Thu, 30 Apr 2026 15:15:01 +0200
From: Lukas Herbolt <lukas@herbolt.com>
To: zlang@kernel.org,
	djwong@kernel.org
Cc: fstests@vger.kernel.org,
	Lukas Herbolt <lukas@herbolt.com>
Subject: [PATCH 4/4] xfs/216 xfs/217 Use default -l conccurency=0 on mkfs.xfs that supports it
Date: Thu, 30 Apr 2026 15:13:22 +0200
Message-ID: <20260430131317.693845-10-lukas@herbolt.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430131317.693845-2-lukas@herbolt.com>
References: <20260430131317.693845-2-lukas@herbolt.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The XFS conccurency optimalization breaks the log sizing check on
systems with non-rotational disks and high amount of CPUs. Default to
the old behavior with -l conccurency=0 and with -d concurrency=0.

Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
---
 tests/xfs/216 |  9 +++++++--
 tests/xfs/217 | 17 +++++++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tests/xfs/216 b/tests/xfs/216
index 091c11d08642..8b4610d5a0a6 100755
--- a/tests/xfs/216
+++ b/tests/xfs/216
@@ -21,14 +21,19 @@ _cleanup()
 }
 
 _require_scratch
-_scratch_mkfs_xfs >/dev/null 2>&1
+if _scratch_mkfs_supports_concurrency -l >> $seqres.full 2>&1; then
+	_scratch_mkfs_xfs -l concurrency=0 >/dev/null 2>&1
+	loop_mkfs_opts="-l concurrency=0"
+else
+	_scratch_mkfs_xfs >/dev/null 2>&1
+	loop_mkfs_opts=
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
index dae6ce55f475..7c7b33b1ccf7 100755
--- a/tests/xfs/217
+++ b/tests/xfs/217
@@ -20,7 +20,20 @@ _cleanup()
 }
 
 _require_scratch
-_scratch_mkfs_xfs >/dev/null 2>&1
+if _scratch_mkfs_supports_concurrency -l >> $seqres.full 2>&1; then
+	_scratch_mkfs_xfs -l concurrency=0 >/dev/null 2>&1
+	loop_mkfs_opts="-l concurrency=0"
+		if _scratch_mkfs_supports_concurrency -d >> $seqres.full 2>&1; then
+			# We could go just with -l concurency but then on 512CPUs
+			# it gives log size off by one block so better to set
+			# -d concurrency to 0.
+			loop_mkfs_opts="$loop_mkfs_opts -d concurrency=0"
+
+		fi
+else
+	_scratch_mkfs_xfs >/dev/null 2>&1
+	loop_mkfs_opts=
+fi
 _scratch_mount
 # 16T mkfs requires a bit over 2G free
 _require_fs_space $SCRATCH_MNT 2202000
@@ -34,7 +47,7 @@ _do_mkfs()
 	for i in $*; do
 		echo -n "fssize=${i}g "
 		$MKFS_XFS_PROG -f -b size=4096 -l version=2 \
-			-d size=${i}g $loop_dev |grep log
+			-d size=${i}g $loop_dev $loop_mkfs_opts |grep log
 		_mount $loop_dev $LOOP_MNT
 		echo "test write" > $LOOP_MNT/test
 		_unmount $LOOP_MNT > /dev/null 2>&1
-- 
2.53.0

