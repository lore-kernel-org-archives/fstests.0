Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D27AC433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  5 Jan 2022 17:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242282AbiAERag (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:30:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59300 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242279AbiAERaS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 5 Jan 2022 12:30:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1606FB81151
        for <fstests@vger.kernel.org>; Wed,  5 Jan 2022 17:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79215C36AE3;
        Wed,  5 Jan 2022 17:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641403814;
        bh=Sqr+eu/mtK13XxbN0QyTY1zywCfiYTzA7VDxKBCIxc4=;
        h=From:To:Cc:Subject:Date:From;
        b=AYoDsOLPdEsnC+URRWx0uLEEQD+5YXhLcCC1F5jkF36WLEPpoJqKnxwqjpoR33214
         IdqqYfkpStUamdKVc5lsphdiWVpo1gGK4NWncOC4nlkLyUjb6qpHSgkIBnX70r8yKU
         ale7FxroDT9ivZ7eD0D0ymesM8yGGBB2WNDHG5y/6lsFqdhJQepGjSdHQbNKIo1iq4
         ek1pjsVCN8qHSsbyWfjEowWrrimPKVD5tpcRV8fdIjpUp6CZgaAG88rqcBaFdBbqMF
         lTGbc49KB7+4HxnJg47dsA/K7JraZd0CC0VcS6ggBagTK1YKfyaHN6/nnyrPDQ5m2/
         BxvFoD7ekHfkQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me
Subject: [PATCH] common: handle ceph's new mount syntax
Date:   Wed,  5 Jan 2022 12:30:13 -0500
Message-Id: <20220105173013.172424-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Cephfs is introducing a new mount device syntax. Fix the fstests
infrastructure to handle the new syntax correctly.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/config |  2 +-
 common/rc     | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/common/config b/common/config
index e0a5c5df58ff..be97436b0857 100644
--- a/common/config
+++ b/common/config
@@ -533,7 +533,7 @@ _check_device()
 	fi
 
 	case "$FSTYP" in
-	9p|tmpfs|virtiofs)
+	9p|tmpfs|virtiofs|ceph)
 		# 9p and virtiofs mount tags are just plain strings, so anything is allowed
 		# tmpfs doesn't use mount source, ignore
 		;;
diff --git a/common/rc b/common/rc
index 7973ceb5fdf8..4fa0b818d840 100644
--- a/common/rc
+++ b/common/rc
@@ -1592,7 +1592,7 @@ _require_scratch_nocheck()
 			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
-	nfs*|ceph)
+	nfs*)
 		echo $SCRATCH_DEV | grep -q ":/" > /dev/null 2>&1
 		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
 			_notrun "this test requires a valid \$SCRATCH_DEV"
@@ -1601,6 +1601,21 @@ _require_scratch_nocheck()
 			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
+	ceph)
+		if [ -z "$SCRATCH_DEV" ]; then
+			_notrun "this test requires a valid \$SCRATCH_DEV"
+		fi
+		echo $SCRATCH_DEV | grep -q "=/" > /dev/null 2>&1
+		if [ "$?" != "0" ]; then
+			echo $SCRATCH_DEV | grep -q ":/" > /dev/null 2>&1
+			if [ "$?" != "0" ]; then
+				_notrun "this test requires a valid \$SCRATCH_DEV"
+			fi
+		fi
+		if [ ! -d "$SCRATCH_MNT" ]; then
+			_notrun "this test requires a valid \$SCRATCH_MNT"
+		fi
+		;;
 	pvfs2)
 		echo $SCRATCH_DEV | grep -q "://" > /dev/null 2>&1
 		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
@@ -1770,7 +1785,7 @@ _require_test()
 			_notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
-	nfs*|ceph)
+	nfs*)
 		echo $TEST_DEV | grep -q ":/" > /dev/null 2>&1
 		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
 			_notrun "this test requires a valid \$TEST_DEV"
@@ -1779,6 +1794,21 @@ _require_test()
 			_notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
+	ceph)
+		if [ -z "$TEST_DEV" ]; then
+			_notrun "this test requires a valid \$TEST_DEV"
+		fi
+		echo $TEST_DEV | grep -q "=/" > /dev/null 2>&1
+		if [ "$?" != "0" ]; then
+			echo $TEST_DEV | grep -q ":/" > /dev/null 2>&1
+			if [ "$?" != "0" ]; then
+				_notrun "this test requires a valid \$TEST_DEV"
+			fi
+		fi
+		if [ ! -d "$TEST_DIR" ]; then
+			_notrun "this test requires a valid \$TEST_DIR"
+		fi
+		;;
 	cifs)
 		echo $TEST_DEV | grep -q "//" > /dev/null 2>&1
 		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
-- 
2.33.1

