Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41949C433FE
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Jan 2022 11:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbiAFLXT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Jan 2022 06:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238405AbiAFLXT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Jan 2022 06:23:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F36C061245
        for <fstests@vger.kernel.org>; Thu,  6 Jan 2022 03:23:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 854F561AA9
        for <fstests@vger.kernel.org>; Thu,  6 Jan 2022 11:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAE1C36AE3;
        Thu,  6 Jan 2022 11:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641468197;
        bh=LzqywcFucefNs1IfVDpVC9fBqeGBYW6TSztB6sUzrTc=;
        h=From:To:Cc:Subject:Date:From;
        b=X3o+U5/0iBLiHeyQ3kJ4IDIcZeFcmnaczf1twPgMbVYbjbjNiTnVrfV7AWujQBoI1
         pCDrgBnnaNl2L9w75v1u5pibXlx85dwT4uQCCsLtU3GiF05K9tgBrfIulOKblciRp/
         lNgyjEmPUmiw6Iv0srj8hWwZvgIVTBA5dJuV0SDOWPlybcCcz+q7JfouC+ndw2Ymly
         Y8lPI+89YUuMrT3rkn14tuYpCtBDyL4inpJYPSKhePi7gaG2rBAew1jVekkd39yGlW
         WIEt/MhNu0R+hGttYMgViUZDJ4exu4nfaOydBU2XY8ds8i33s/PEmDktfl4Nwriwho
         kY3+nzP2ls69A==
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me, zlang@redhat.com
Subject: [PATCH v2] common: handle ceph's new mount syntax
Date:   Thu,  6 Jan 2022 06:23:16 -0500
Message-Id: <20220106112316.6790-1-jlayton@kernel.org>
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
 common/config |  8 ++++++++
 common/rc     | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

v2: more rigorous check for ceph mount device in _check_device

diff --git a/common/config b/common/config
index e0a5c5df58ff..2b357746476b 100644
--- a/common/config
+++ b/common/config
@@ -537,6 +537,14 @@ _check_device()
 		# 9p and virtiofs mount tags are just plain strings, so anything is allowed
 		# tmpfs doesn't use mount source, ignore
 		;;
+	ceph)
+		# ceph has two different possible syntaxes for mount devices. The
+		# network URL check above catches the legacy syntax. Check for the
+		# new-style syntax here.
+		if ( echo $dev | grep -qEv "=/" ); then
+			_fatal "common/config: $name ($dev) is not a valid ceph mount string"
+		fi
+		;;
 	overlay)
 		if [ ! -d "$dev" ]; then
 			_fatal "common/config: $name ($dev) is not a directory for overlay"
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

