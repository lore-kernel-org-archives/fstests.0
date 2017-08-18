Received: from mx1.redhat.com ([209.132.183.28]:58288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750729AbdHRIwD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 18 Aug 2017 04:52:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5B9A7E42F
        for <fstests@vger.kernel.org>; Fri, 18 Aug 2017 08:52:02 +0000 (UTC)
Received: from hades.localdomain.com (ovpn-204-214.brq.redhat.com [10.40.204.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37B1C5D743
        for <fstests@vger.kernel.org>; Fri, 18 Aug 2017 08:52:02 +0000 (UTC)
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH 1/2] xfs: Add helpers for checking CONFIG_XFS_DEBUG availability
Date: Fri, 18 Aug 2017 10:51:55 +0200
Message-Id: <20170818085156.8187-1-cmaiolino@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Add the following helpers to common/xfs:

_require_xfs_debug()
_require_no_xfs_debug()

Tests that require or not a kernel built with XFS_DEBUG can now use
these two helpers to explicitly check for it.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 common/xfs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/xfs b/common/xfs
index 2c34e088..def28bfc 100644
--- a/common/xfs
+++ b/common/xfs
@@ -585,6 +585,19 @@ _require_xfs_mkfs_ciname()
 		|| _notrun "need case-insensitive naming support in mkfs.xfs"
 }
 
+# XFS_DEBUG requirements
+_require_xfs_debug()
+{
+	if grep -q "debug 0" /proc/fs/xfs/stat; then
+		_notrun "Require XFS built with CONFIG_XFS_DEBUG"
+	fi
+}
+_require_no_xfs_debug()
+{
+	if grep -q "debug 1" /proc/fs/xfs/stat; then
+		_notrun "Require XFS built without CONFIG_XFS_DEBUG"
+	fi
+}
 # xfs generates WARNINGs on purpose when applications mix buffered/mmap IO with
 # direct IO on the same file. This is a helper for _check_dmesg() to filter out
 # such warnings.
-- 
2.13.5

