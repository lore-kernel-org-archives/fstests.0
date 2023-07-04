Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8825EB64D9
	for <linux-fstests@archiver.kernel.org>; Tue,  4 Jul 2023 23:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjGDXv2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 4 Jul 2023 19:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGDXv1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 4 Jul 2023 19:51:27 -0400
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCEE187
        for <fstests@vger.kernel.org>; Tue,  4 Jul 2023 16:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688514680;
        bh=KoRKg+TVRsQ3WKgtc8CcjtuWUIa5XhrtI4W7InydB6M=;
        h=From:To:Cc:Subject:Date;
        b=Nwjre8+EgvEFmq0kRr3Vc3OEncByopXFY+fouQuDqMPo7MhXoeMRXF3jzXiUlaERp
         RHL5ykNYj6miu/DndSPO5/OVTOnY03AKqOiRp+zNV/zRljmCVyUGmBN74zhsBRaSV3
         EbQYQl7GHhNyaFO8op+y1vU2VWoBkhfb9jZTtBOE=
Received: from LAPTOP-NG0NVCKT.localdomain ([210.22.74.199])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id CD227E6D; Wed, 05 Jul 2023 07:51:18 +0800
X-QQ-mid: xmsmtpt1688514678tunx7vhnv
Message-ID: <tencent_BAC515047634B24F4B5D5052B5FCD6D23B09@qq.com>
X-QQ-XMAILINFO: MmuCfgcSBfHxJ1oUmYyx5Cq6RCDeLdVUL69LgCqtRyGUYQk8nRCnQVrQmCPxCG
         Vq0QJ7zoPMc7LOH1Tcu/MZ2HPZf6KiRTgQtprjtfw9SwMhBcbKymRZ1dQ5JSOy61e2SDQ+MLtfcM
         dsF2FeljsO6Nym8WLntMUXf2NpO3n+mEYHOBfpIzbNzvktm3QY5nPOp/+ELRKcfMpWYKnpLvS+8S
         qGI3kI+qK2otnhB9CpjPnyFEyrop4xyF7ZiViGJ2mJyCeXG3da59ju3710nWErPcguKzTLAR9s+2
         a/w/egXjI/k8LNYW0dfHmeazpW6PuiMROr7CU7cusVrVOzAuY3UoQL4vGBMjtbguI4wMBfbdlMnN
         HtqG282R6aObpuw1AdHHeMTiIzlgXmpdAqRs7OzIGsC5ocOKcCXLStIOxvyR+n/ZzaDt+o/fxpY+
         Q2+mRGW/xTYGU7NUMU362c/BBxW6kg37V1aXS3RyEIS9VOMwU0R0O0lXLODkVkIxcvQaNdXPMifH
         MG8kikKyukl3lc2Q3nk5basYLnJhor7UuKVxunQoAp4AFqOZtvDLhaguaqZl5BgYnYBmzOZKGGyi
         1tSmqNE++YNw1T7EzTs6a0XFxmlGzm3mNb0wdLnqUIYLtFfJgGplnXt7gFNyf0KrU5+BNbRCs1Lt
         J/I/qQjx9dgG774mxZ4M7snslcytgxktH4nK0rySGUwQOTIedb+tErCPvkc2QBfdp47a3wb1IgE5
         qC9Nu59J27Zp2E2E2HE4GLqCYWu1yJwZPJxELPX44ndnxseepSuentrHS5HCOlUk+ZRHglwldaH7
         CN2FJSTwLkwM+oAsZfuxKaPywjk1IP3QrDBgcnYnFXm5Xbv8MrMhqJuX3JHNZwSfxV73hkbMVAoH
         p/+l5i+W/XiH1TPEswtCbZ6AyP8++cagKlFwwL622GvlkAFWPMgOga9SvKtg6VcVPObEsMjSJDEM
         Eag2eTUSyQ1VvlXXNPCpKOY/oQG+iO/s9io54SJf3+xo0f1UbeeQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From:   yuezhang.mo@foxmail.com
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, billodo@redhat.com, djwong@kernel.org,
        Yuezhang Mo <Yuezhang.Mo@foxmail.com>
Subject: [PATCH v2] check: fix excluded tests are only expunged in the first iteration
Date:   Wed,  5 Jul 2023 07:49:55 +0800
X-OQ-MSGID: <20230704234954.123-1-yuezhang.mo@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Yuezhang Mo <Yuezhang.Mo@foxmail.com>

If iterating more than once and excluding some tests, the
excluded tests are expunged in the first iteration, but run in
subsequent iterations. This is not expected.

The problem was caused by the temporary file saving the excluded
tests being deleted by `rm -f $tmp.*` in _wrapup() at the end of
the first iteration.

This commit saves the excluded tests into a variable instead of a
temporary file.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@foxmail.com>
---
 check | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/check b/check
index e36978c1..cb4b23bf 100755
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
@@ -302,13 +303,15 @@ while [ $# -gt 0 ]; do
 		;;
 	-e)
 		xfile=$2; shift ;
-		echo "$xfile" | tr ', ' '\n\n' >> $tmp.xlist
+		readarray -t -O "${#exclude_tests[@]}" exclude_tests < \
+			<(echo "$xfile" | tr ', ' '\n\n')
 		;;
 
 	-E)	xfile=$2; shift ;
 		if [ -f $xfile ]; then
-			sed "s/#.*$//" "$xfile" >> $tmp.xlist
-	        fi
+			readarray -t -O ${#exclude_tests[@]} exclude_tests < \
+				<(sed "s/#.*$//" $xfile)
+		fi
 		;;
 	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
 	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
@@ -383,7 +386,7 @@ if [ -n "$subdir_xfile" ]; then
 	for d in $SRC_GROUPS $FSTYP; do
 		[ -f $SRC_DIR/$d/$subdir_xfile ] || continue
 		for f in `sed "s/#.*$//" $SRC_DIR/$d/$subdir_xfile`; do
-			echo $d/$f >> $tmp.xlist
+			exclude_tests+=($d/$f)
 		done
 	done
 fi
@@ -570,13 +573,14 @@ _check_filesystems()
 _expunge_test()
 {
 	local TEST_ID="$1"
-	if [ -s $tmp.xlist ]; then
-		if grep -q $TEST_ID $tmp.xlist; then
+
+	for f in "${exclude_tests[@]}"; do
+		if [ "${TEST_ID}" == "$f" ]; then
 			echo "       [expunged]"
-			return 1
+			return 0
 		fi
-	fi
-	return 0
+	done
+	return 1
 }
 
 # retain files which would be overwritten in subsequent reruns of the same test
@@ -878,8 +882,7 @@ function run_section()
 		echo -n "$seqnum"
 
 		if $showme; then
-			_expunge_test $seqnum
-			if [ $? -eq 1 ]; then
+			if _expunge_test $seqnum; then
 				tc_status="expunge"
 			else
 				echo
@@ -902,8 +905,7 @@ function run_section()
 		rm -f $seqres.out.bad $seqres.hints
 
 		# check if we really should run it
-		_expunge_test $seqnum
-		if [ $? -eq 1 ]; then
+		if _expunge_test $seqnum; then
 			tc_status="expunge"
 			_stash_test_status "$seqnum" "$tc_status"
 			continue
-- 
2.25.1

