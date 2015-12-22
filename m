Received: from mx1.redhat.com ([209.132.183.28]:40266 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932725AbbLVUyM (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 22 Dec 2015 15:54:12 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 9A36596F9
	for <fstests@vger.kernel.org>; Tue, 22 Dec 2015 20:54:12 +0000 (UTC)
Received: from schleppi.home.com (vpn1-6-224.ams2.redhat.com [10.36.6.224])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tBMKs3S7007345
	for <fstests@vger.kernel.org>; Tue, 22 Dec 2015 15:54:11 -0500
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 3/6] fsx: Report number of successful operations
Date: Tue, 22 Dec 2015 21:53:53 +0100
Message-Id: <1450817636-11416-4-git-send-email-agruenba@redhat.com>
In-Reply-To: <1450817636-11416-1-git-send-email-agruenba@redhat.com>
References: <1450817636-11416-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Report the number of successful operations at the end of an fsx run.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 ltp/fsx.c             |  2 +-
 tests/generic/127.out | 12 ++++++------
 tests/generic/231.out | 12 ++++++------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 16d74c0..0f4c49e 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1881,7 +1881,7 @@ main(int argc, char **argv)
 		prterr("close");
 		report_failure(99);
 	}
-	prt("All operations completed A-OK!\n");
+	prt("All %lu operations completed A-OK!\n", testcalls);
 
 	exit(0);
 	return 0;
diff --git a/tests/generic/127.out b/tests/generic/127.out
index 120c20a..9459dc8 100644
--- a/tests/generic/127.out
+++ b/tests/generic/127.out
@@ -1,13 +1,13 @@
 QA output created by 127
 === FSX Light Mode, No Memory Mapping ===
-All operations completed A-OK!
+All 100000 operations completed A-OK!
 === FSX Light Mode, Memory Mapping ===
-All operations completed A-OK!
+All 100000 operations completed A-OK!
 === FSX Standard Mode, No Memory Mapping ===
-All operations completed A-OK!
+All 100000 operations completed A-OK!
 === FSX Standard Mode, Memory Mapping ===
-All operations completed A-OK!
+All 100000 operations completed A-OK!
 === FSX Standard Mode, No Memory Mapping ===
-All operations completed A-OK!
+All 100000 operations completed A-OK!
 === FSX Standard Mode, Memory Mapping ===
-All operations completed A-OK!
+All 100000 operations completed A-OK!
diff --git a/tests/generic/231.out b/tests/generic/231.out
index ef264a9..8707b26 100644
--- a/tests/generic/231.out
+++ b/tests/generic/231.out
@@ -1,16 +1,16 @@
 QA output created by 231
 === FSX Standard Mode, Memory Mapping, 1 Tasks ===
-All operations completed A-OK!
+All 20000 operations completed A-OK!
 Comparing user usage
 Comparing group usage
 === FSX Standard Mode, Memory Mapping, 4 Tasks ===
-All operations completed A-OK!
-All operations completed A-OK!
-All operations completed A-OK!
-All operations completed A-OK!
+All 20000 operations completed A-OK!
+All 20000 operations completed A-OK!
+All 20000 operations completed A-OK!
+All 20000 operations completed A-OK!
 Comparing user usage
 Comparing group usage
 === FSX Standard Mode, Memory Mapping, 1 Tasks ===
-All operations completed A-OK!
+All 20000 operations completed A-OK!
 Comparing user usage
 Comparing group usage
-- 
2.4.3

