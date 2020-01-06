Return-Path: <SRS0=Klg3=23=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49164C32771
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jan 2020 07:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2669621734
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jan 2020 07:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgAFHLr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:11:47 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51710 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726494AbgAFHLq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Jan 2020 02:11:46 -0500
X-IronPort-AV: E=Sophos;i="5.69,401,1571673600"; 
   d="scan'208";a="81356203"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 06 Jan 2020 15:11:44 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id ADE6D49E932E;
        Mon,  6 Jan 2020 15:02:43 +0800 (CST)
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 6 Jan 2020 15:11:42 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.439.0; Mon, 6 Jan 2020 15:11:46 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <eguan@linux.alibaba.com>
CC:     <fstests@vger.kernel.org>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2 2/2] fsx: Add '-a' option to skip unsupported keep size automatically
Date:   Mon, 6 Jan 2020 15:06:54 +0800
Message-ID: <20200106070654.13249-2-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200106070654.13249-1-yangx.jy@cn.fujitsu.com>
References: <20200106070654.13249-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: ADE6D49E932E.AD13C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1) Use '-a' option to skip unsupported keep size automatically even if
   it's defined by --replay-ops.
2) Add $FSX_AVOID to tests which defines keep size by --replay-ops.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 ltp/fsx.c         | 9 +++++++--
 tests/generic/456 | 2 +-
 tests/generic/469 | 2 +-
 tests/generic/499 | 2 +-
 tests/generic/511 | 2 +-
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 11465e62..cde7df5c 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -163,6 +163,7 @@ int	seed = 1;			/* -S flag */
 int     mapped_writes = 1;              /* -W flag disables */
 int     fallocate_calls = 1;            /* -F flag disables */
 int     keep_size_calls = 1;            /* -K flag disables */
+int     skip_keep_size = 0;             /* -a flag skips unsupported keep_size automatically */
 int     punch_hole_calls = 1;           /* -H flag disables */
 int     zero_range_calls = 1;           /* -z flag disables */
 int	collapse_range_calls = 1;	/* -C flag disables */
@@ -2215,7 +2216,7 @@ void
 usage(void)
 {
 	fprintf(stdout, "usage: %s",
-		"fsx [-dknqxABEFJKLOWZ] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
+		"fsx [-adknqxABEFJKLOWZ] [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid] [-l flen] [-m start:end] [-o oplen] [-p progressinterval] [-r readbdy] [-s style] [-t truncbdy] [-w writebdy] [-D startingop] [-N numops] [-P dirpath] [-S seed] fname\n\
 	-b opnum: beginning operation number (default 1)\n\
 	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
 	-d: debug output for all operations\n\
@@ -2268,6 +2269,7 @@ usage(void)
 #ifdef FALLOC_FL_KEEP_SIZE
 "	-K: Do not use keep size calls\n"
 #endif
+"	-a: Skip unsupported keep size automatically even if it's defined by --replay-ops\n"
 "	-L: fsxLite - no file creations & no file size changes\n\
 	-N numops: total # operations to do (default infinity)\n\
 	-O: use oplen (see -o flag) for every op (default random)\n\
@@ -2472,7 +2474,7 @@ main(int argc, char **argv)
 	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
 
 	while ((ch = getopt_long(argc, argv,
-				 "b:c:dfg:i:j:kl:m:no:p:qr:s:t:w:xyABD:EFJKHzCILN:OP:RS:WXZ",
+				 "ab:c:dfg:i:j:kl:m:no:p:qr:s:t:w:xyABD:EFJKHzCILN:OP:RS:WXZ",
 				 longopts, NULL)) != EOF)
 		switch (ch) {
 		case 'b':
@@ -2590,6 +2592,9 @@ main(int argc, char **argv)
 		case 'K':
 			keep_size_calls = 0;
 			break;
+		case 'a':
+			skip_keep_size = 1;
+			break;
 		case 'H':
 			punch_hole_calls = 0;
 			break;
diff --git a/tests/generic/456 b/tests/generic/456
index 6124f0bb..0298c789 100755
--- a/tests/generic/456
+++ b/tests/generic/456
@@ -56,7 +56,7 @@ write 0x3e5ec 0x1a14 0x21446
 zero_range 0x20fac 0x6d9c 0x40000 keep_size
 mapwrite 0x216ad 0x274f 0x40000
 EOF
-run_check $here/ltp/fsx -d --replay-ops $fsxops $SCRATCH_MNT/testfile
+run_check $here/ltp/fsx -d --replay-ops $fsxops $FSX_AVOID $SCRATCH_MNT/testfile
 
 _flakey_drop_and_remount
 _unmount_flakey
diff --git a/tests/generic/469 b/tests/generic/469
index 47fdf0cf..ba13e022 100755
--- a/tests/generic/469
+++ b/tests/generic/469
@@ -43,7 +43,7 @@ _require_test
 
 run_fsx()
 {
-	$here/ltp/fsx $2 --replay-ops $1 $file 2>&1 | tee -a $seqres.full >$tmp.fsx
+	$here/ltp/fsx $2 --replay-ops $1 $FSX_AVOID $file 2>&1 | tee -a $seqres.full >$tmp.fsx
 	if [ ${PIPESTATUS[0]} -ne 0 ]; then
 		cat $tmp.fsx
 		exit 1
diff --git a/tests/generic/499 b/tests/generic/499
index 773eab2e..61346832 100755
--- a/tests/generic/499
+++ b/tests/generic/499
@@ -50,7 +50,7 @@ ENDL
 
 victim=$SCRATCH_MNT/a
 touch $victim
-$here/ltp/fsx --replay-ops $tmp.fsxops $victim > $tmp.output 2>&1 || cat $tmp.output
+$here/ltp/fsx --replay-ops $tmp.fsxops $FSX_AVOID $victim > $tmp.output 2>&1 || cat $tmp.output
 
 echo "Silence is golden"
 status=0
diff --git a/tests/generic/511 b/tests/generic/511
index 4d133f49..346e291d 100755
--- a/tests/generic/511
+++ b/tests/generic/511
@@ -47,7 +47,7 @@ ENDL
 
 victim=$SCRATCH_MNT/a
 touch $victim
-$here/ltp/fsx --replay-ops $tmp.fsxops $victim > $tmp.output 2>&1 || cat $tmp.output
+$here/ltp/fsx --replay-ops $tmp.fsxops $FSX_AVOID $victim > $tmp.output 2>&1 || cat $tmp.output
 
 echo "Silence is golden"
 status=0
-- 
2.21.0



