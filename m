Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD566D530
	for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714370950; cv=none; b=nYorAhy8+mgXm56P11wOQ/Hfky4caTp8aFHUvjYmwuXDLQ1j9UxnVvn4l6i8NKF+z9Js1AwYiycur7INVgYY7a94SKvW7ZLA93Sa425b5EgJockPTlHKgK4Fl4uKVsffT2r6MHlg5cFqXJVuAz9OO/rtWrw4WOau8/9d0fX8qY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714370950; c=relaxed/simple;
	bh=CJPK+VdLjZFhsOCyKctU0tTy1CVK+diyYngtAMshBWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQ7NijcMWe//a7XX0yfnF+Wbg4NCPlW1xkzQWqPt/vMTzqXJvahhz4IxUBKLljSLS628nxVYzSVaMdoVhVl+dzPxFv5TQ1gl8Ar+7WXhTnFBJXjmdO7wXdkPeK5esgtxgzlIzF14P74kIP0FYxr4MD7IJ8vWOfrlLowZrtm6C+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxcdF59h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxcdF59h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86C0C113CD;
	Mon, 29 Apr 2024 06:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714370950;
	bh=CJPK+VdLjZFhsOCyKctU0tTy1CVK+diyYngtAMshBWo=;
	h=From:To:Cc:Subject:Date:From;
	b=BxcdF59hwU9H4SsEOIkWM5TqWrdfocrhNzQTrQ37Q7DxqU4XHMvCwONxJxtWNaceI
	 kDM4B2B9KO3qXnqLWgH9+mFFp8NedyS7EJBfAmbApglUlU3k/QN7pwo1+X8j8+4Oq6
	 T95DGsIi0KGNo2RcxvCKP6rWDlCfD3LTWY2Bhy30XisbXFU4vX4J++I3+7/jpcNJwl
	 4jTrKDI3JqGQYQJimosbp/OHh/08oQe9j+mcXyhzlH7M/3z8VBvJ/r38LbDw8CLE4+
	 l7PTIl3V+/unJ0xkYmPWL7tHPfDhggHs5zxuBPE9gqUgu3djlvzQmZ0lnW1pzDI6S9
	 nV51MyHIRrFNQ==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] fstests: fix _require_debugfs and call it properly
Date: Mon, 29 Apr 2024 14:09:06 +0800
Message-ID: <20240429060906.465135-1-zlang@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old _require_debugfs helper doesn't work now, fix it to check
a system supports debugfs. And then call this helper in cases which
need $DEBUGFS_MNT.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 common/rc       | 10 ++++++++--
 tests/btrfs/150 |  1 +
 tests/ceph/001  |  2 +-
 tests/xfs/499   |  1 +
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 56f1afb6..6f0bdf60 100644
--- a/common/rc
+++ b/common/rc
@@ -2978,8 +2978,14 @@ _require_sparse_files()
 
 _require_debugfs()
 {
-    #boot_params always present in debugfs
-    [ -d "$DEBUGFS_MNT/boot_params" ] || _notrun "Debugfs not mounted"
+	local type
+
+	if [ -d "$DEBUGFS_MNT" ];then
+		type=$(findmnt -rncv -T $DEBUGFS_MNT -S debugfs -o FSTYPE)
+		[ "$type" = "debugfs" ] && return 0
+	fi
+
+	_notrun "Cannot find debugfs on $DEBUGFS_MNT"
 }
 
 #
diff --git a/tests/btrfs/150 b/tests/btrfs/150
index a02bdafc..fd386d92 100755
--- a/tests/btrfs/150
+++ b/tests/btrfs/150
@@ -17,6 +17,7 @@ _begin_fstest auto quick dangerous read_repair compress
 . ./common/fail_make_request
 
 _supported_fs btrfs
+_require_debugfs
 _require_scratch
 _require_fail_make_request
 _require_scratch_dev_pool 2
diff --git a/tests/ceph/001 b/tests/ceph/001
index 060c4c45..79a5f58a 100755
--- a/tests/ceph/001
+++ b/tests/ceph/001
@@ -20,7 +20,7 @@ _begin_fstest auto quick copy_range
 
 # real QA test starts here
 _supported_fs ceph
-
+_require_debugfs
 _require_xfs_io_command "copy_range"
 _exclude_test_mount_option "test_dummy_encryption"
 _require_attrs
diff --git a/tests/xfs/499 b/tests/xfs/499
index 9672f95d..6421cc4b 100755
--- a/tests/xfs/499
+++ b/tests/xfs/499
@@ -18,6 +18,7 @@ _register_cleanup "_cleanup" BUS
 # real QA test starts here
 _supported_fs xfs
 _require_command "$CC_PROG" "cc"
+_require_debugfs
 
 cprog=$tmp.ftrace.c
 oprog=$tmp.ftrace
-- 
2.44.0

