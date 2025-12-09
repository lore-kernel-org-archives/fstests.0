Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA119644B
	for <fstests@vger.kernel.org>; Tue,  9 Dec 2025 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765266639; cv=none; b=OjNMcYCD2Y7m2ScoulsPyLGrX9sgFQLC/Z5OTrRrujjVC/swNdZZqL+Wsikq8S5fy7whwvbcbY8y28rmGXaTP4fca6tvd4fMaPRPxI5eK6NvXkafQkIv0uA8gU/RAGFFQLqGSsCMYK22aOEIZno+p7q8wEpQ1BN4bb4zZeduEAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765266639; c=relaxed/simple;
	bh=LrBjfGwuZDchK7/MYTK0mv5CH8g5/vx8/nh/5oP7Blo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJjT5XrsKVMN3um7uWbEAjdyr9vFh/03DkRhY0EL8iMaqASTPIYN51uPhcdUJuTIUEpMRUmBIoFoLAVU1WcUPMgefWcAfFnXy/covgIIS0tQUkMUSjz+gmaQPpYGbwbiZMN0Z9DUnYLtJz4nleztplIqvoemXotXfurSQXyoS+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyYbXyEW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyYbXyEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C29C4CEF5;
	Tue,  9 Dec 2025 07:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765266639;
	bh=LrBjfGwuZDchK7/MYTK0mv5CH8g5/vx8/nh/5oP7Blo=;
	h=From:To:Cc:Subject:Date:From;
	b=EyYbXyEWaCWOOHyFrriTBGGgI6PVr25QSO/Hk+7O2zibNBSExcMxU6VmqPmjp37GX
	 ejxzakJ9Q9a8ZaYaUaQYIhF2GR+/c5hB9S1T0RFicv4swE/4gz4hT1dJ9dfBo5HMF4
	 /Cg4MysWb0q9FCjxF7GZe7shs3YJ222ZYrinQDm+f0wSSE5iWS+9FOo2t6fo37PRUC
	 zgspCKt95EbsYf9v1DP4Huj8Gcc+Hv4ohepKW1ZDLtRGFCfC1/AjBfb7PzYJaQRbPn
	 Y6/RWMMU+URC1Gm459jw47TSjZZpj00ozKW+PxscIui2StW2aCzb+LaP89PQ6EjRal
	 PmUZevDRLKlgw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v3] common/quota: fix to wait for all inodes been evicted in _check_quota_usage()
Date: Tue,  9 Dec 2025 15:50:28 +0800
Message-ID: <20251209075028.909869-1-chao@kernel.org>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic/233  3s ... - output mismatch (see /share/git/fstests/results//generic/233.out.bad)
    --- tests/generic/233.out   2025-01-12 21:57:40.259440359 +0800
    +++ /share/git/fstests/results//generic/233.out.bad 2025-12-04 03:02:26.000000000 +0800
    @@ -4,4 +4,12 @@

     seed = S
     Comparing user usage
    +4c4
    +< #1000     --   31476   32000   32000            994  1000  1000
    +---
    +> #1000     --   31476   32000   32000            944  1000  1000
    ...
    (Run 'diff -u /share/git/fstests/tests/generic/233.out /share/git/fstests/results//generic/233.out.bad'  to see the entire diff)
Ran: generic/233
Failures: generic/233
Failed 1 of 1 tests

Sometimes, generic/233 will fail due to it founds inode count is mismatched
in between quota system and filesystem.

The reason is cgroup v2 implementation will increase inode reference first,
and then, attach it to thread related cgroup writeback structure, once it
needs to switch write owner of target inode, a kernel thread will process
it, and finally release inode reference via evict_inode().

So, sync & drop_cache may not guarantee all inodes being evicted, as cgroup
has one more referenece on inodes during the time.

If inode has not been evicted, dquot inode reference will not be release, it
will lead to inode count mismatch.

Let's add a delay to wait for cgroup switching completion before quota check.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- sleep in existed case statement rather than in newly added check condition
 common/quota | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/common/quota b/common/quota
index a51386b1..5d351fdf 100644
--- a/common/quota
+++ b/common/quota
@@ -335,7 +335,14 @@ _check_quota_usage()
 
 	VFS_QUOTA=0
 	case $FSTYP in
-	ext2|ext3|ext4|f2fs|gfs2|bcachefs)
+	ext2|ext3|ext4|gfs2|bcachefs)
+		VFS_QUOTA=1
+		quotaon -f -u -g $SCRATCH_MNT 2>/dev/null
+		;;
+	f2fs)
+		# wait for inode_switch_wbs_wor_fn() to release inodes
+		sleep 3
+
 		VFS_QUOTA=1
 		quotaon -f -u -g $SCRATCH_MNT 2>/dev/null
 		;;
-- 
2.49.0

