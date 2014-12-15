Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36645 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbaLORJ7 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Dec 2014 12:09:59 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBFH9x8r013527
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Mon, 15 Dec 2014 12:09:59 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 1/2] common: return failure if _check_xxx_filesystem finds corruption
Date: Tue, 16 Dec 2014 01:09:26 +0800
Message-Id: <1418663367-18755-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Tests like xfs/179 depend on the return value of _check_scratch_fs to
detect fs corruption, but _check_$FSTYP_filesystem always returns 0.

Make _check_$FSTYP_filesystem return failure on corruption.

Also don't exit if these functions called by 'check', like what
_check_xfs_filesystem() does.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 692d45c..87d2928 100644
--- a/common/rc
+++ b/common/rc
@@ -1717,7 +1717,10 @@ _check_generic_filesystem()
 
     if [ $ok -eq 0 ]; then
 	status=1
-	exit 1
+	if [ "$iam" != "check" ]; then
+		exit 1
+	fi
+	return 1
     fi
 
     return 0
@@ -1819,6 +1822,7 @@ _check_xfs_filesystem()
 	if [ "$iam" != "check" ]; then
 		exit 1
 	fi
+	return 1
     fi
 
     return 0
@@ -1863,7 +1867,8 @@ _check_udf_filesystem()
     $here/src/udf_test $OPT_ARG $device | tee $seqres.checkfs | egrep "Error|Warning" | \
 	_udf_test_known_error_filter | \
 	egrep -iv "Error count:.*[0-9]+.*total occurrences:.*[0-9]+|Warning count:.*[0-9]+.*total occurrences:.*[0-9]+" && \
-        echo "Warning UDF Verifier reported errors see $seqres.checkfs."
+        echo "Warning UDF Verifier reported errors see $seqres.checkfs." && return 1
+    return 0
 }
 
 _check_xfs_test_fs()
@@ -1928,7 +1933,10 @@ _check_btrfs_filesystem()
 
     if [ $ok -eq 0 ]; then
 	status=1
-	exit 1
+	if [ "$iam" != "check" ]; then
+		exit 1
+	fi
+	return 1
     fi
 
     return 0
-- 
1.8.3.1

