Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:14599 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752328AbeF0IVJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 04:21:09 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hL-00083E-04
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:07 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fY5hK-0002iq-V4
        for fstests@vger.kernel.org; Wed, 27 Jun 2018 18:21:06 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 1/8] fstests: generic test setup preamble
Date: Wed, 27 Jun 2018 18:20:56 +1000
Message-Id: <20180627082103.9662-2-david@fromorbit.com>
In-Reply-To: <20180627082103.9662-1-david@fromorbit.com>
References: <20180627082103.9662-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

So many tests chop random bits out of the mandaotry test setup
preamble which leads to subtle problems and stray files being dumped
all over the place. Create a common test preamble with hooks for
local cleanup functions so we can prevent this in future.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/setup_test | 31 +++++++++++++++++++++++++++++++
 new               | 35 ++++++++---------------------------
 soak              | 19 +++++++------------
 3 files changed, 46 insertions(+), 39 deletions(-)
 create mode 100644 common/setup_test

diff --git a/common/setup_test b/common/setup_test
new file mode 100644
index 000000000000..f25ed11c2306
--- /dev/null
+++ b/common/setup_test
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# common test setup preamble
+# test specific cleanup is done via the cleanup() function now.
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup_test; exit \$status" 0 1 2 3 15
+
+_cleanup_test()
+{
+	# call local test cleanup function first, then cleanup tmp files
+	cleanup
+	cd /
+	rm -f $tmp.*
+}
+
+_success()
+{
+	status=0
+	exit
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
diff --git a/new b/new
index 2bb8ce5055c1..1f11fdad1b8c 100755
--- a/new
+++ b/new
@@ -9,12 +9,11 @@
 iam=new
 . ./common/test_names
 
-trap "rm -f /tmp/$$.; exit" 0 1 2 3 15
 
-_cleanup()
-{
-    :
+_cleanup() {
+	rm -f /tmp/$$.
 }
+trap "_cleanup; exit" 0 1 2 3 15
 
 SRC_GROUPS=`find tests -not -path tests -type d -printf "%f "`
 usage()
@@ -153,31 +152,15 @@ cat <<End-of-File >$tdir/$id
 #
 # what am I here for?
 #
-seq=\`basename \$0\`
-seqres=\$RESULT_DIR/\$seq
-echo "QA output created by \$seq"
-
-here=\`pwd\`
-tmp=/tmp/\$\$
-status=1	# failure is the default!
-trap "_cleanup; exit \\\$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f \$tmp.*
-}
+. common/setup_test
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+# test exit cleanup goes here
+cleanup() { :; }
 
 # remove previous \$seqres.full before test
 rm -f \$seqres.full
 
-# real QA test starts here
-
-# Modify as appropriate.
+# include test specific environments here
 _supported_fs generic
 _supported_os Linux
 _require_test
@@ -189,9 +172,7 @@ exit
 #echo
 #echo "If failure, check \$seqres.full (this) and \$seqres.full.ok (reference)"
 
-# success, all done
-status=0
-exit
+_success
 End-of-File
 
 sleep 2		# latency to read messages to this point
diff --git a/soak b/soak
index d5c4229ad6e7..3a9c4daa622e 100755
--- a/soak
+++ b/soak
@@ -3,21 +3,16 @@
 # Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.
 #
 
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
+. common/setup_test
 
-tmp=/tmp/$$
-seq=soak
-status=1	# failure is the default!
-
-_cleanup()
-{
-    echo "        *** umount"
-    _scratch_unmount >/dev/null 2>&1
+# test exit cleanup goes here
+cleanup() {
+	echo "        *** umount"
+	_scratch_unmount >/dev/null 2>&1
 }
 
-trap "_cleanup; exit \$status" 0 1 2 3 15
+# remove previous $seqres.full before test
+rm -f $seqres.full
 
 ROOT="."
 LOG="$ROOT/soak.log"
-- 
2.17.0

