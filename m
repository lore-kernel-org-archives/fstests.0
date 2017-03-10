Received: from mail-wr0-f193.google.com ([209.85.128.193]:34443 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbdCJHkA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Mar 2017 02:40:00 -0500
Received: by mail-wr0-f193.google.com with SMTP id u48so10555004wrc.1
        for <fstests@vger.kernel.org>; Thu, 09 Mar 2017 23:39:59 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2] filter: match $TEST_* $SCRATCH_* in beginning of path string
Date: Fri, 10 Mar 2017 09:39:56 +0200
Message-Id: <1489131596-9726-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

For example, if $TEST_DIR=/mnt, only replace instances of /mnt that
are in the beginning of a path string, e.g.:

"/mnt/mntA/mntB:/mnt/mntC" => "TEST_DIR/mntA/mntB:TEST_DIR/mntC"

With this change, there is no longer a need to check the case of
$TEST_DEV being a substring of $TEST_DIR, because that would mean
that $TEST_DIR is a prefix of $TEST_DIR and that is not possible.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Eryu,

Here's the formal patch you requested.
Tested it with:
kvm-xfstests -c overlay/large -g quick

Where kvm-xfstests uses new overlay config, see:
github.com/amir73il/xfstests-bld/commits/overlayfs-devel

v2:
- Remove the 'else' case in filters

v1:
- Add \B to pattern match

 common/filter | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/common/filter b/common/filter
index 1ceb346..5fd71a8 100644
--- a/common/filter
+++ b/common/filter
@@ -280,32 +280,19 @@ _filter_xfs_io_pages_modified()
 
 _filter_test_dir()
 {
-	if ( echo $TEST_DIR | grep -q $TEST_DEV ); then
-		# TEST_DEV is substr of TEST_DIR (e.g. /mnt and /mnt/ovl-mnt)
-		# substitute TEST_DIR first
-		sed -e "s,$TEST_DIR,TEST_DIR,g" \
-		    -e "s,$TEST_DEV,TEST_DEV,g"
-	else
-		# TEST_DIR maybe a substr of TEST_DIR (e.g. /vdc and /dev/vdc)
-		# substitute TEST_DEV first
-		sed -e "s,$TEST_DEV,TEST_DEV,g" \
-		    -e "s,$TEST_DIR,TEST_DIR,g"
-	fi
+	# TEST_DEV may be a prefix of TEST_DIR (e.g. /mnt, /mnt/ovl-mnt)
+	# so substitute TEST_DIR first
+	sed -e "s,\B$TEST_DIR,TEST_DIR,g" \
+	    -e "s,\B$TEST_DEV,TEST_DEV,g"
 }
 
 _filter_scratch()
 {
-	if ( echo $SCRATCH_MNT | grep -q $SCRATCH_DEV ); then
-		# SCRATCH_DEV is substr of SCRATCH_MNT
-		sed -e "s,$SCRATCH_MNT,SCRATCH_MNT,g" \
-		    -e "s,$SCRATCH_DEV,SCRATCH_DEV,g" \
-		    -e "/.use_space/d"
-	else
-		# SCRATCH_MNT maybe a substr of SCRATCH_DEV
-		sed -e "s,$SCRATCH_DEV,SCRATCH_DEV,g" \
-		    -e "s,$SCRATCH_MNT,SCRATCH_MNT,g" \
-		    -e "/.use_space/d"
-	fi
+	# SCRATCH_DEV may be a prefix of SCRATCH_MNT (e.g. /mnt, /mnt/ovl-mnt)
+	# so substitute SCRATCH_MNT first
+	sed -e "s,\B$SCRATCH_MNT,SCRATCH_MNT,g" \
+	    -e "s,\B$SCRATCH_DEV,SCRATCH_DEV,g" \
+	    -e "/.use_space/d"
 }
 
 # Turn any device in the scratch pool into SCRATCH_DEV
-- 
2.7.4

