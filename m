Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFB6C001DB
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Aug 2023 03:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjHND6a (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Aug 2023 23:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjHND63 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Aug 2023 23:58:29 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Aug 2023 20:58:28 PDT
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DD4E53
        for <fstests@vger.kernel.org>; Sun, 13 Aug 2023 20:58:28 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="107417466"
X-IronPort-AV: E=Sophos;i="6.01,171,1684767600"; 
   d="scan'208";a="107417466"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 12:57:22 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id BB0F8DE63C
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 12:57:19 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9D478D6034
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 12:57:18 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0718B6B803;
        Mon, 14 Aug 2023 12:57:17 +0900 (JST)
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     fstests@vger.kernel.org
Cc:     djwong@kernel.org, zlang@redhat.com, ruansy.fnst@fujitsu.com
Subject: [PATCH v2] fsx: tidy options usage and format
Date:   Mon, 14 Aug 2023 11:55:03 +0800
Message-ID: <20230814035503.1724774-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804054003.936263-1-ruansy.fnst@fujitsu.com>
References: <20230804054003.936263-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27812.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27812.004
X-TMASE-Result: 10--13.162300-10.000000
X-TMASE-MatchedRID: YVoDTlX4T0xZQ4rley4x/qzGfgakLdjawTlc9CcHMZerwqxtE531VBFu
        p4CINH3JpsX84hgxtprDlswFp/2PscIRMxauaS3UuLt50vtxBA5w1ShlQ7jqItfKF/jK2yLiEoN
        4n3g9RrbPu/rMYsy8zd6rPPq1PqrN68BVSn5BPNcRW4LR41Fi8gV54COoxb6Xx4aARMrh3G0WWg
        76IlE/zHGGuF3kLXprEj1NnWJcw6zc+HB+YVvemPCW/PNRRp/ZwBi8lRTMyBoJeMOJX8c9nA8pG
        XPEaliG5jmTk07qyg2UgZaMkXm5K9z07adr0VnOEzEoOqAAVLM2nLo2hN48IXEa7quPFSpQZ0nl
        A6gXdt7i8zVgXoAltqKtaNMn6jcZC24oEZ6SpSkj80Za3RRg8NXNRNnJJqzBddrhylP28GS7NnI
        Bqz9iQbaxmKgMDPGNSQTg4dNf2V4=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1. Add missing options and wrap the cli example line.
2. Cleanup and also add missing "-K" operation for options description
part.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 ltp/fsx.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index ffa64cfa0..ccb382e77 100644
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
+	   [--replay-ops=opsfile] [--record-ops[=opsfile]] [--duration=seconds]\n\
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
@@ -2449,16 +2455,17 @@ usage(void)
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
+	-R: read() system calls only (mapped reads disabled)\n\
 	-S seed: for random # generator (default 1) 0 gets timestamp\n\
 	-W: mapped write operations DISabled\n\
-	-X: Read file and compare to good buffer after every operation.\n\
-        -R: read() system calls only (mapped reads disabled)\n\
-        -Z: O_DIRECT (use -R, -W, -r and -w too)\n\
-	--replay-ops opsfile: replay ops from recorded .fsxops file\n\
+	-X: Read file and compare to good buffer after every operation\n\
+	-Z: O_DIRECT (use -R, -W, -r and -w too)\n\
+	--replay-ops=opsfile: replay ops from recorded .fsxops file\n\
 	--record-ops[=opsfile]: dump ops file also on success. optionally specify ops file name\n\
 	--duration=seconds: ignore any -N setting and run for this many seconds\n\
 	fname: this filename is REQUIRED (no default)\n");
-- 
2.41.0

