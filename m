Received: from mx2.suse.de ([195.135.220.15]:41505 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbdALRTB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 12 Jan 2017 12:19:01 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ED5DBAC6A
        for <fstests@vger.kernel.org>; Thu, 12 Jan 2017 17:18:58 +0000 (UTC)
From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH 1/3] xfs/188: add and use _require_xfs_mkfs_ciname
Date: Thu, 12 Jan 2017 18:18:47 +0100
Message-Id: <20170112171849.10784-1-ddiss@suse.de>
In-Reply-To: <20170112132656.7caa64dd@suse.de>
References: <20170112132656.7caa64dd@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
List-ID: <fstests@vger.kernel.org>

Use an explicit mkfs -n version=ci test to check whether the test should
run, instead of checking the xfsprogs version.

Suggested-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 common/xfs    | 7 +++++++
 tests/xfs/188 | 6 +-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/common/xfs b/common/xfs
index fbd139a..767a481 100644
--- a/common/xfs
+++ b/common/xfs
@@ -587,3 +587,10 @@ _require_meta_uuid()
 	   || _notrun "Kernel doesn't support meta_uuid feature"
 	_scratch_unmount
 }
+
+# this test requires mkfs.xfs have case-insensitive naming support
+_require_xfs_mkfs_ciname()
+{
+	_scratch_mkfs_xfs_supported -n version=ci >/dev/null 2>&1 \
+		|| _notrun "need case-insensitive naming support in mkfs.xfs"
+}
diff --git a/tests/xfs/188 b/tests/xfs/188
index 6332085..8798ecf 100755
--- a/tests/xfs/188
+++ b/tests/xfs/188
@@ -52,12 +52,8 @@ _cleanup()
 # real QA test starts here
 _supported_fs xfs
 _supported_os IRIX Linux
-
-if [ $XFSPROGS_VERSION -lt 21000 ]; then
-    _notrun "this test requires case-insensitive support"
-fi
-
 _require_scratch
+_require_xfs_mkfs_ciname
 rm -f $seqres.full
 
 _scratch_mkfs -n version=ci >/dev/null 2>&1
-- 
2.10.2

