Received: from mail-pl1-f196.google.com ([209.85.214.196]:44011 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeK1Imw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Nov 2018 03:42:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so16266103plb.10
        for <fstests@vger.kernel.org>; Tue, 27 Nov 2018 13:43:36 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 3/3] generic: exclude selinux xattr form being considered
Date: Tue, 27 Nov 2018 13:43:08 -0800
Message-Id: <20181127214308.137410-4-gwendal@chromium.org>
In-Reply-To: <20181127214308.137410-1-gwendal@chromium.org>
References: <20181127214308.137410-1-gwendal@chromium.org>
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 common/filter     | 1 +
 tests/generic/062 | 2 +-
 tests/generic/377 | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/filter b/common/filter
index ed082d24..3ca40431 100644
--- a/common/filter
+++ b/common/filter
@@ -290,6 +290,7 @@ _filter_scratch()
 	# so substitute SCRATCH_MNT first
 	sed -e "s,\B$SCRATCH_MNT,SCRATCH_MNT,g" \
 	    -e "s,\B$SCRATCH_DEV,SCRATCH_DEV,g" \
+	    -e "/security\.selinux/d" \
 	    -e "/.use_space/d"
 }
 
diff --git a/tests/generic/062 b/tests/generic/062
index 9024af2e..7e79a2dd 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -120,7 +120,7 @@ for nsp in $ATTR_MODES; do
 		getfattr -m $nsp -e hex -n $nsp.name2 $SCRATCH_MNT/$inode 2>&1 | invalid_attribute_filter
 
 		echo "*** final list (strings, type=$inode, nsp=$nsp)"
-		getfattr -m '.' -e hex $SCRATCH_MNT/$inode
+		getfattr -m '.' -e hex $SCRATCH_MNT/$inode | grep -ve "security\.selinux"
 	
 	done
 done
diff --git a/tests/generic/377 b/tests/generic/377
index f7835ee8..0ce2cb4b 100755
--- a/tests/generic/377
+++ b/tests/generic/377
@@ -66,7 +66,7 @@ $listxattr $testfile 9
 $listxattr $testfile 11
 
 # 6. Calling listxattr with buffersize bigger than needed should succeed.
-$listxattr $testfile 500 | sort
+$listxattr $testfile 500 | grep -ve "security\.selinux" | sort
 
 status=0
 exit
-- 
2.18.1
