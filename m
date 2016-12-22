Received: from sandeen.net ([63.231.237.45]:35898 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965112AbcLVBYL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 21 Dec 2016 20:24:11 -0500
Subject: [PATCH 2/2] common: add _require_getnextquota helper
References: <a3c43ff2-c641-aba4-b10e-781a3f3c86e3@redhat.com>
 <8c91051e-8a78-cb20-d926-ea86e5b4645a@sandeen.net>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <bdf026bf-113e-6ba1-f157-d3d2f01143ad@sandeen.net>
Date: Wed, 21 Dec 2016 19:24:10 -0600
MIME-Version: 1.0
In-Reply-To: <8c91051e-8a78-cb20-d926-ea86e5b4645a@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Add a helper to determine if the kernel supports
the GETNEXTQUOTA quotactl.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/common/quota b/common/quota
index d9bb8d9..d4ae861 100644
--- a/common/quota
+++ b/common/quota
@@ -109,6 +109,16 @@ _require_prjquota()
 }
 
 #
+# Do we have GETNEXTQUOTA?  Querying ID 0 should work.
+#
+_require_getnextquota()
+{
+	_require_test_program "test-nextquota"
+	$here/src/test-nextquota -i 0 -u -d $SCRATCH_DEV &> $seqres.full || \
+		_notrun "No GETNEXTQUOTA support"
+}
+
+#
 # ext4 (for now) is unique in that we must enable the project quota feature
 # prior to mount.  This is a relatively new feature ...
 _scratch_enable_pquota()
diff --git a/tests/generic/244 b/tests/generic/244
index 36c632e..0c64330 100755
--- a/tests/generic/244
+++ b/tests/generic/244
@@ -59,10 +59,7 @@ _scratch_mkfs >> $seqres.full 2>&1
 TYPES="u g"
 MOUNT_OPTIONS="-o usrquota,grpquota"
 _qmount
-
-# Ok, do we even have GETNEXTQUOTA?  Querying ID 0 should work.
-$here/src/test-nextquota -i 0 -u -d $SCRATCH_DEV &> $seqres.full || \
-	_notrun "No GETNEXTQUOTA support"
+_require_getnextquota
 
 echo "Launch all quotas"
 
diff --git a/tests/generic/395 b/tests/generic/395
index cc4a93e..151229d 100755
--- a/tests/generic/395
+++ b/tests/generic/395
@@ -57,12 +57,8 @@ _require_scratch
 _scratch_mkfs >> $seqres.full 2>&1
 
 MOUNT_OPTIONS="-o usrquota,grpquota"
-
 _qmount
-
-# Ok, do we even have GETNEXTQUOTA?  Querying ID 0 should work.
-$here/src/test-nextquota -i 0 -u -d $SCRATCH_DEV &> $seqres.full || \
-	_notrun "No GETNEXTQUOTA support"
+_require_getnextquota
 
 echo "Launch all quotas"
 

