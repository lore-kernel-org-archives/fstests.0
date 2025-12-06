Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F2023B63E
	for <fstests@vger.kernel.org>; Sat,  6 Dec 2025 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764981639; cv=none; b=GGcPfLVv1rZtX7LVaJb59DN8hd+mys9ICtN5JRx+nGwL0ojBff+UzlqzQRskp//WjjL6tBdIJqmpqPvzfMMztGd1RYyQMZi9+7+Ad1Zdb6/DztHs51PdEWdDuH26TCuCL+MNnaUKStLJQXeLtN+wr+VHpQw3idIDcOfnut1T4/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764981639; c=relaxed/simple;
	bh=SAtm1XxXYuGTwcRUQICs7Zs7Yin7yGN2ed//wLM8YsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgVHERxd2mRw6WT5BhZGMuFlG7ewRegwj6MO2hv/z7WpBnZ7SkgJoFdCpxHcZS1c0MTbit2KJT9crAf+BFKuH1hlXZTU39IH3F813LQu5d1Dq/SV9l5oaOVm4l4eQgWd32B4XiT089SCjvncRe45DHrgxZwyS4khIYwDAMKHBBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ij0R8Za7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ij0R8Za7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DB0C4CEF1;
	Sat,  6 Dec 2025 00:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764981638;
	bh=SAtm1XxXYuGTwcRUQICs7Zs7Yin7yGN2ed//wLM8YsQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Ij0R8Za705WAbOr8VVrSWxHR445BI0ZkNwKKv7xL5jkmThOTWdDOYA77D+pZdJkra
	 gJAsiUXUOEwZBxCTv9Jl9HleWcz6XHCLUzgd7QDkz+3LWxalyXA1gJYB0AcjW7G/9C
	 a0ZVOJiQyxekS4l35majsSjIG/sRmDa385gX7BgcIy3usbKc5l9hzw1/0KNVfMdTEH
	 LpOJmB9RlOy1dwB3lQkQZbZg2wkVwOi1uM/yettpwzK+NRlvCslmkwRaZPHjhogTdD
	 K++QKtOSYe7W1t4fNJkGO0ploBBeCkbhrcP/jvlBshErU2JKAngPk6EevCISWCp8mt
	 9+7r2F10SsMGg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2] common/quota: fix to wait for all inodes been evicted in _check_quota_usage()
Date: Sat,  6 Dec 2025 08:40:17 +0800
Message-ID: <20251206004017.4021067-1-chao@kernel.org>
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
v2:
- sleep only for f2fs case
 common/quota | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/quota b/common/quota
index a51386b1..a7239501 100644
--- a/common/quota
+++ b/common/quota
@@ -333,6 +333,11 @@ _check_quota_usage()
 	# XXX: really need an ioctl instead of this big hammer
 	echo 3 > /proc/sys/vm/drop_caches
 
+	if [ $FSTYP == "f2fs" ]; then
+		# wait for inode_switch_wbs_wor_fn() to release inodes
+		sleep 3
+	fi
+
 	VFS_QUOTA=0
 	case $FSTYP in
 	ext2|ext3|ext4|f2fs|gfs2|bcachefs)
-- 
2.49.0

