Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93A6EB64D7
	for <linux-fstests@archiver.kernel.org>; Fri, 30 Jun 2023 12:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjF3Mad (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 30 Jun 2023 08:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjF3Mac (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 30 Jun 2023 08:30:32 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BDC213D
        for <fstests@vger.kernel.org>; Fri, 30 Jun 2023 05:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688128225;
        bh=ZjJ8rL0KrgQbtc8TEEcZCHt59JU3DTVVs8TEBR39IXY=;
        h=From:To:Cc:Subject:Date;
        b=QYsagtvm7VPt/R5Sy7KQE1IQtdOSp8uP0hT2/OaEkliZutyJwveRpGCV+sbqFiQfa
         qBxlwfu2+e7R+xhvRrFFHMRbxI7sktTyXt1uso9zwpfEYTO58j2Ac6Z32oSE2d091Z
         hAVKcglen2v8Klp0VteLGAsUexST0QaUc6ZQPVow=
Received: from LAPTOP-NG0NVCKT.localdomain ([210.22.74.199])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 755822FA; Fri, 30 Jun 2023 20:29:21 +0800
X-QQ-mid: xmsmtpt1688128161tkfr0pevu
Message-ID: <tencent_02888B6E2AB95F44BA9CB8A5408E86CE2906@qq.com>
X-QQ-XMAILINFO: NCQxuYa6IC+ctely6y0jZEypFxUL0a9lFsAvR2RqQA+6qtxUiCAjsXJ/KlFHmy
         Fk659951m3sNLuR+BVQX6KFNHm3+CRDUIquIYxEY6xPi6Pl/ZdWiDFe8UxqMxjEQHDLPMqfE5HO4
         mpNxAQfyQ/5q+cPrqrcyRo3NtdVet6savtenXSDU25br5K0N6AdRbbt/gRjnf+nyHTVOxqvpcQrR
         QlP/DlYIAQVGmZvEbGnTggqHJzRoDb0eKAPARy6kO4Prr4ppp8HlLu41yT4oyHaa8W9HZ6XpbLFv
         oj1L/LI2DI29JGZQeivDluLtyvJCnRHXSk55YqgestdkorPXLIgAiooO+D5fmfxFJ5e/yJE9Tlil
         pY/GIQatMvWvZ6me+skjPzydyKd0ngYGF4MgfXA6yS4xjBK++UxAtMH8b95QCR45gWKwNrKGPAXA
         y257wCw8OGcQoVEGuye4h5mDIGWE+qdgT4Mu/SYaVP0KiD7m1od2t0IjGKuRhEtcLWY2WVlpd/xm
         F4Zg8aD/4NhhhY2nJichzlM0aKeQiS4+pntOHS3E9PNVHhxpx9NF26d8aFWB5shgPeNVGmIU8Sk0
         Myoh+hj00yskLP7vLgTS14EcXUvX0KG4Vf2UrwSYbFlJ224T5GWtlZuOVCJAOKdM3S1Kr+MRY9WX
         CgnkzIZ6iAxgf0JkN+2a3hV1X/LUnGOG9cywhtVdCTxYKd/BigCISBOSrPIyXze8DLZQi+7/9tyr
         mV5IUqrXGWc8rXLOfMB4mkajKAXfHE7MJRqIcwtg1T/vQEbmBaKCwP9bWjMiHdtDYkUJArXj2xeb
         l7Se/sTgyxXrIdY+sRd2Vir/hzwOLa3CQeLm40NcXqPmO5hNu5YCWFy22/pnFaqoICzuMLy58avi
         O2aq/AONZXhp/2bPEcSCko9eqwPgyJrtD5dl9CxiqG9fh+kw6u50wD9wj3U03h2T2hOYtMwdS2YL
         2LuM9pD8xMyG7CdujX/8v6H7FSDUsQimjp7JlJwNO1VsWPCIKwf3tSAe2+uqTk6ASMzWhUnOuGrV
         029cXqUsEToXJKVy1lmLtrqlu087pavRbuYgFI6zrS0Mz5/ur/vrSsBdOuM7EfVpM8C/d38z/EXm
         UPmxXm
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From:   yuezhang.mo@foxmail.com
To:     fstests@vger.kernel.org
Cc:     Yuezhang Mo <yuezhang.mo@foxmail.com>
Subject: [PATCH] check: fix excluded tests are only expunged in the first iteration
Date:   Fri, 30 Jun 2023 20:28:29 +0800
X-OQ-MSGID: <20230630122829.1861-1-yuezhang.mo@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Yuezhang Mo <yuezhang.mo@foxmail.com>

If iterating more than once and excluding some tests, the
excluded tests are expunged in the first iteration, but run in
subsequent iterations. This is not expected.

The problem was caused by the temporary file saving the excluded
tests being deleted at the end of the first iteration.

This commit saves the excluded tests into a variable instead of a
temp file.

Signed-off-by: Yuezhang Mo <yuezhang.mo@foxmail.com>
---
 check | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/check b/check
index e36978c1..a8071121 100755
--- a/check
+++ b/check
@@ -27,6 +27,7 @@ DUMP_OUTPUT=false
 iterations=1
 istop=false
 loop_on_fail=0
+exclude_tests=()
 
 # This is a global variable used to pass test failure text to reporting gunk
 _err_msg=""
@@ -46,7 +47,7 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
 # by default don't output timestamps
 timestamp=${TIMESTAMP:=false}
 
-rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.* $tmp.arglist
+rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
 
 SRC_GROUPS="generic shared"
 export SRC_DIR="tests"
@@ -302,13 +303,13 @@ while [ $# -gt 0 ]; do
 		;;
 	-e)
 		xfile=$2; shift ;
-		echo "$xfile" | tr ', ' '\n\n' >> $tmp.xlist
+		exclude_tests+=($(echo "$xfile" | tr ', ' '\n\n'))
 		;;
 
 	-E)	xfile=$2; shift ;
 		if [ -f $xfile ]; then
-			sed "s/#.*$//" "$xfile" >> $tmp.xlist
-	        fi
+			exclude_tests+=($(sed "s/#.*$//" "$xfile"))
+		fi
 		;;
 	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
 	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
@@ -383,7 +384,7 @@ if [ -n "$subdir_xfile" ]; then
 	for d in $SRC_GROUPS $FSTYP; do
 		[ -f $SRC_DIR/$d/$subdir_xfile ] || continue
 		for f in `sed "s/#.*$//" $SRC_DIR/$d/$subdir_xfile`; do
-			echo $d/$f >> $tmp.xlist
+			exclude_tests+=($d/$f)
 		done
 	done
 fi
@@ -570,11 +571,10 @@ _check_filesystems()
 _expunge_test()
 {
 	local TEST_ID="$1"
-	if [ -s $tmp.xlist ]; then
-		if grep -q $TEST_ID $tmp.xlist; then
-			echo "       [expunged]"
-			return 1
-		fi
+
+	if echo ${exclude_tests[*]} | grep -q $TEST_ID; then
+		echo "       [expunged]"
+		return 1
 	fi
 	return 0
 }
-- 
2.25.1

