Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35466 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbaLPLmZ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 16 Dec 2014 06:42:25 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBGBgPfj021197
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Tue, 16 Dec 2014 06:42:25 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2 2/3] common: return failure if _check_xxx_filesystem find corruption
Date: Tue, 16 Dec 2014 19:41:41 +0800
Message-Id: <1418730102-17061-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1418730102-17061-1-git-send-email-eguan@redhat.com>
References: <1418730102-17061-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

So the callers could know if these functions find corruptions by the
return value.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---

v2:
- write new commit message, the old one is not correct
- split out the 'check' check as a separate patch

 common/rc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 6bbdc69..bf4e580 100644
--- a/common/rc
+++ b/common/rc
@@ -1722,6 +1722,7 @@ _check_generic_filesystem()
 	if [ "$iam" != "check" ]; then
 		exit 1
 	fi
+	return 1
     fi
 
     return 0
@@ -1823,6 +1824,7 @@ _check_xfs_filesystem()
 	if [ "$iam" != "check" ]; then
 		exit 1
 	fi
+	return 1
     fi
 
     return 0
@@ -1867,7 +1869,8 @@ _check_udf_filesystem()
     $here/src/udf_test $OPT_ARG $device | tee $seqres.checkfs | egrep "Error|Warning" | \
 	_udf_test_known_error_filter | \
 	egrep -iv "Error count:.*[0-9]+.*total occurrences:.*[0-9]+|Warning count:.*[0-9]+.*total occurrences:.*[0-9]+" && \
-        echo "Warning UDF Verifier reported errors see $seqres.checkfs."
+        echo "Warning UDF Verifier reported errors see $seqres.checkfs." && return 1
+    return 0
 }
 
 _check_xfs_test_fs()
@@ -1935,6 +1938,7 @@ _check_btrfs_filesystem()
 	if [ "$iam" != "check" ]; then
 		exit 1
 	fi
+	return 1
     fi
 
     return 0
-- 
2.1.0

