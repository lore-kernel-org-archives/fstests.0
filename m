Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D458635C
	for <fstests@vger.kernel.org>; Mon, 14 Jul 2025 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752497526; cv=none; b=S9Ud9xHmOOcLXDhc7UUkloOojJGbv7cnvWDNoXlmRniIA8aN49dAikDwE6L3FTh9op9L0thOrDb8WAf/LKzjak4Rq0jYV4j0PMQdzcIF6uUt314DXIhcfW+EifGD0zGZpDY2CcAiFsHWg3VSQSl+8K5u5RPxt7fllS/GMz8fwng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752497526; c=relaxed/simple;
	bh=/RHZrOLGi/7eXE0m03DxHjslXbcj2bPzehXiRZ0R9nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ES9lfO1fqL66x4Hzx8AcYcGr70ZEgJXp7QRYdeCkELfb259HtecyCG0Aue9ScmmaG05gOb7gLROTrVCOTK+F9YJ+Feff6DywIEYoE8Mez5ft5O3NDPNYkQbQXU984fFTvegE01srIgN9JgYttVKKqpqnc4++5WBXyeeIFEAzWyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YOC8dbr3; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YOC8dbr3"
Received: from trampoline.thunk.org (pool-108-26-156-88.bstnma.fios.verizon.net [108.26.156.88])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56ECq0Zu003693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 08:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752497521; bh=jyu0ZM6ne3qZHp8DYkVDfgyBCBKsF66vyDgZTMOi6Es=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=YOC8dbr3qcdhCHZ/ETljj9HaeeWJEjaALWFNCPxIQ7xlU4raN9u9zgSS50YOZU7wc
	 nx13UPJCDzdlN0USb0j0weXWYo+wBv9+oaIhpESnwhJTjh0toIPHy8TT9jbUB+7FgH
	 bTCXZQAS1H8PoLloPNIWWHl0bH/Q7h/o4lLuWCttxTnCJKXWV3r3w1y9u8f8inMwlL
	 0tCX54thZ3oZtIhhy+bErW0KhEAjhBX7kl5uh4/mLm1YG+EqrPeQpvyPgtM0ij75RZ
	 s2xBjX680+fG9Z99thHzd6cqcZ22XC7IJaqKcaNWn/XK2Prb7g74sE9af6wffDSU+o
	 kpEgk6ax5O0jw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id F29F22E00D5; Mon, 14 Jul 2025 08:51:59 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4/028: require that the scratch file system has the extent feature enabled
Date: Mon, 14 Jul 2025 08:51:54 -0400
Message-ID: <20250714125154.50015-1-tytso@mit.edu>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the file system configuration has journalling enabled, but doesn't
have the extent feature enabled (e.g., when testing the ext3
configuration) the test will fail since _scratch_populate_cached
creates files with extents enabled.  So add a check to skip the test
in that case.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/ext4    | 23 +++++++++++++++++------
 tests/ext4/028 |  1 +
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/common/ext4 b/common/ext4
index f88fa5324..06191e304 100644
--- a/common/ext4
+++ b/common/ext4
@@ -165,15 +165,26 @@ _ext4_mdrestore()
 	return $res
 }
 
-# this test requires the ext4 kernel support crc feature on scratch device
+# this test requires the ext4 kernel supports a particular feature
+# on the scratch device
 #
+_require_scratch_ext4_feature_enabled()
+{
+    if [ -z "$1" ]; then
+        echo "Usage: _require_scratch_ext4_feature feature"
+        _exit 1
+    fi
+    _scratch_mkfs_ext4 >/dev/null 2>&1
+    dumpe2fs -h $SCRATCH_DEV 2> /dev/null | grep -q "$1" || \
+	_notrun "$1 not enabled by this filesystem"
+    _try_scratch_mount >/dev/null 2>&1 \
+	|| _notrun "Kernel doesn't support $1 feature"
+    _scratch_unmount
+}
+
 _require_scratch_ext4_crc()
 {
-	_scratch_mkfs_ext4 >/dev/null 2>&1
-	dumpe2fs -h $SCRATCH_DEV 2> /dev/null | grep -q metadata_csum || _notrun "metadata_csum not supported by this filesystem"
-	_try_scratch_mount >/dev/null 2>&1 \
-	   || _notrun "Kernel doesn't support metadata_csum feature"
-	_scratch_unmount
+    _require_scratch_ext4_feature_enabled "metadata_csum"
 }
 
 # Check whether the specified feature whether it is supported by
diff --git a/tests/ext4/028 b/tests/ext4/028
index 1b8855098..254074f08 100755
--- a/tests/ext4/028
+++ b/tests/ext4/028
@@ -24,6 +24,7 @@ _exclude_fs ext2
 _exclude_fs ext3
 
 _require_scratch
+_require_scratch_ext4_feature_enabled "extent"
 _require_populate_commands
 _require_xfs_io_command "fsmap"
 
-- 
2.47.2

