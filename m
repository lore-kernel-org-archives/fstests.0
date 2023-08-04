Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0385C001DB
	for <linux-fstests@archiver.kernel.org>; Fri,  4 Aug 2023 05:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjHDFnT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 4 Aug 2023 01:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjHDFnS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 4 Aug 2023 01:43:18 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Aug 2023 22:43:14 PDT
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6035212B
        for <fstests@vger.kernel.org>; Thu,  3 Aug 2023 22:43:13 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="126520995"
X-IronPort-AV: E=Sophos;i="6.01,254,1684767600"; 
   d="scan'208";a="126520995"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 14:42:07 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 21682D29EB
        for <fstests@vger.kernel.org>; Fri,  4 Aug 2023 14:42:05 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4CD06D614A
        for <fstests@vger.kernel.org>; Fri,  4 Aug 2023 14:42:04 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id CFF5210210
        for <fstests@vger.kernel.org>; Fri,  4 Aug 2023 14:42:03 +0900 (JST)
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] fsx: add missing -K in usage() and cleanup
Date:   Fri,  4 Aug 2023 13:40:03 +0800
Message-ID: <20230804054003.936263-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27792.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27792.005
X-TMASE-Result: 10--6.131300-10.000000
X-TMASE-MatchedRID: U3PagEpWyqKPo+6vQMop+k7nLUqYrlslFIuBIWrdOeOXQiTz9aMsS1Vx
        c/d4wt8XKEnRKg0O/Ve5hiunv4GcS+borC6rlhrMxmapIHNZmMTC4hYi9ARtbjb9TB28UbkicEo
        cGwB4+oDV4q36S0NEz+IFEVJUN3tqzUdA39OUndnFVAV8vDjN/1zyvct8/NhrR6RHdVK85hUKXN
        T5dnG4tZ8am96RW0iInogwBVulCRu3cEPgqzRphmY+xOrx57jWWQ3R4k5PTnDB1z1KvCXwaCX0w
        oPAxta6EBJ91WyEKoU+X36xH4Nh5Q+5S4lzVIazh2VzUlo4HVMaJDwYgQY/fxdHX2eZFfZfYGq1
        3itIwN3i8zVgXoAltsIJ+4gwXrEtIAcCikR3vq/rn0QFm3s1AsPZ0fxXYOC6BhtKlh9TW2urhJh
        oGYDv1SsE8PTGacnT
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 ltp/fsx.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index ffa64cfa0..753c472f4 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -2393,11 +2393,17 @@ void
 usage(void)
 {
 	fprintf(stdout, "usage: %s",
-		"fsx [-dknqxBEFJLOWZ][-A|-U] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
+		"fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
+	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
+	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
+	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
+	   [-A|-U] [-D startingop] [-N numops] [-P dirpath] [-S seed]\n\
+	   [--replay-ops opsfile] [--record-ops[=opsfile]] [--duration seconds]\n\
+	   ... fname\n\
 	-b opnum: beginning operation number (default 1)\n\
 	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
 	-d: debug output for all operations\n\
-	-f flush and invalidate cache after I/O\n\
+	-f: flush and invalidate cache after I/O\n\
 	-g X: write character X instead of random generated data\n\
 	-i logdev: do integrity testing, logdev is the dm log writes device\n\
 	-j logid: prefix debug log messsages with this id\n\
@@ -2412,15 +2418,15 @@ usage(void)
 	-s style: 1 gives smaller truncates (default 0)\n\
 	-t truncbdy: 4096 would make truncates page aligned (default 1)\n\
 	-w writebdy: 4096 would make writes page aligned (default 1)\n\
-	-x: preallocate file space before starting, XFS only (default 0)\n\
-	-y synchronize changes to a file\n"
+	-x: preallocate file space before starting, XFS only\n\
+	-y: synchronize changes to a file\n"
 
 #ifdef AIO
 "	-A: Use the AIO system calls, -A excludes -U\n"
 #endif
 #ifdef URING
 "	-U: Use the IO_URING system calls, -U excludes -A\n"
- #endif
+#endif
 "	-D startingop: debug output starting at specified operation\n"
 #ifdef HAVE_LINUX_FALLOC_H
 "	-F: Do not use fallocate (preallocation) calls\n"
@@ -2449,18 +2455,19 @@ usage(void)
 #ifdef FIEXCHANGE_RANGE
 "	-0: Do not use exchange range calls\n"
 #endif
-"	-L: fsxLite - no file creations & no file size changes\n\
+"	-K: Do not use keep size\n\
+	-L: fsxLite - no file creations & no file size changes\n\
 	-N numops: total # operations to do (default infinity)\n\
 	-O: use oplen (see -o flag) for every op (default random)\n\
-	-P: save .fsxlog .fsxops and .fsxgood files in dirpath (default ./)\n\
+	-P dirpath: save .fsxlog .fsxops and .fsxgood files in dirpath (default ./)\n\
 	-S seed: for random # generator (default 1) 0 gets timestamp\n\
 	-W: mapped write operations DISabled\n\
 	-X: Read file and compare to good buffer after every operation.\n\
-        -R: read() system calls only (mapped reads disabled)\n\
-        -Z: O_DIRECT (use -R, -W, -r and -w too)\n\
+	-R: read() system calls only (mapped reads disabled)\n\
+	-Z: O_DIRECT (use -R, -W, -r and -w too)\n\
 	--replay-ops opsfile: replay ops from recorded .fsxops file\n\
 	--record-ops[=opsfile]: dump ops file also on success. optionally specify ops file name\n\
-	--duration=seconds: ignore any -N setting and run for this many seconds\n\
+	--duration seconds: ignore any -N setting and run for this many seconds\n\
 	fname: this filename is REQUIRED (no default)\n");
 	exit(90);
 }
-- 
2.41.0

