Return-Path: <SRS0=DGTx=ZZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4D2C432C0
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0751E206EC
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Dec 2019 12:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfLCMzz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:55:55 -0500
Received: from snd00007.auone-net.jp ([111.86.247.7]:6533 "EHLO
        dmta0004.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726017AbfLCMzz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 3 Dec 2019 07:55:55 -0500
Received: from ppp.dion.ne.jp by dmta0004.auone-net.jp with ESMTP
          id <20191203125554271.ZCVM.12759.ppp.dion.ne.jp@dmta0004.auone-net.jp>
          for <fstests@vger.kernel.org>; Tue, 3 Dec 2019 21:55:54 +0900
Date:   Tue, 3 Dec 2019 21:55:54 +0900
From:   Kusanagi Kouichi <slash@ac.auone-net.jp>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic: Use $RESULT_DIR instead of $here
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Message-Id: <20191203125554271.ZCVM.12759.ppp.dion.ne.jp@dmta0004.auone-net.jp>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

If $here is not writable, tests fail.

Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
---
 tests/generic/075 | 10 +++++-----
 tests/generic/112 |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/generic/075 b/tests/generic/075
index 923c9e4f..df2087c3 100755
--- a/tests/generic/075
+++ b/tests/generic/075
@@ -55,16 +55,16 @@ _do_test()
 	fi
     fi
 
-    # This cd and use of -P gets full debug on $here (not TEST_DEV)
+    # This cd and use of -P gets full debug on "$RESULT_DIR" (not TEST_DEV)
     cd $out
-    if ! $here/ltp/fsx $_param -P $here $seq.$_n $FSX_AVOID &>/dev/null
+    if ! $here/ltp/fsx $_param -P "$RESULT_DIR" $seq.$_n $FSX_AVOID &>/dev/null
     then
 	echo "    fsx ($_param) failed, $? - compare $seqres.$_n.{good,bad,fsxlog}"
 	mv $out/$seq.$_n $seqres.$_n.full
-	mv $here/$seq.$_n.fsxlog $seqres.$_n.fsxlog
+	mv "$RESULT_DIR"/$seq.$_n.fsxlog $seqres.$_n.fsxlog
 	od -xAx $seqres.$_n.full > $seqres.$_n.bad
-	od -xAx $here/$seq.$_n.fsxgood > $seqres.$_n.good
-	rm -f $here/$seq.$_n.fsxgood
+	od -xAx "$RESULT_DIR"/$seq.$_n.fsxgood > $seqres.$_n.good
+	rm -f "$RESULT_DIR"/$seq.$_n.fsxgood
 	status=1
 	exit
     fi
diff --git a/tests/generic/112 b/tests/generic/112
index 18d610ee..580c4cd5 100755
--- a/tests/generic/112
+++ b/tests/generic/112
@@ -55,12 +55,12 @@ _do_test()
 	fi
     fi
 
-    # This cd and use of -P gets full debug on $here (not TEST_DEV)
+    # This cd and use of -P gets full debug on "$RESULT_DIR" (not TEST_DEV)
     cd $out
-    if ! $here/ltp/fsx $_param -P $here $FSX_AVOID $seq.$_n &>/dev/null
+    if ! $here/ltp/fsx $_param -P "$RESULT_DIR" $FSX_AVOID $seq.$_n &>/dev/null
     then
 	echo "    fsx ($_param) returned $? - see $seq.$_n.full"
-	mv $here/$seq.$_n.fsxlog $seqres.$_n.full
+	mv "$RESULT_DIR"/$seq.$_n.fsxlog $seqres.$_n.full
 	status=1
 	exit
     fi
-- 
2.24.0

