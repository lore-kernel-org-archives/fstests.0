Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44481C43334
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Jun 2022 13:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiFSNrZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Jun 2022 09:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbiFSNrK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Jun 2022 09:47:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744CF6378
        for <fstests@vger.kernel.org>; Sun, 19 Jun 2022 06:47:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g4so11315534wrh.11
        for <fstests@vger.kernel.org>; Sun, 19 Jun 2022 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CY/oNJ8EO9OsfnaLTi7yO+kVNqN3sw4e4XLEDmrhyeM=;
        b=W6hsGgsV9Rrya24zNST8qeezFeLOTellkMb5l3KkTBt6E1qG5Ntk1XGzZ42JAm4DBS
         pgL+wDC4d8HK4Rol1cDlV02vhcc6SFacqagS7VfDS8xODNzU/jUDEeLGJv4iZOOBUG+o
         X2P06UqdIXi0endEb0uqH/Y8v/UPDh19nYgzbq/uaHr9UYdZ6+kvvp0KpLJaJ+d0omLH
         7ZV5NjJ+D5UHD16j+RfCtZr2gH73/WVBXV9Mw0A82dk+7k6wHsQ2HTwzo+1Rlvu13Uio
         SrWL5sUVCH5GOzjaLAa7cgkqSt/L+cM49Cj/DVK1Edvf//6kFzT+mhAHAw6UwFHZQFJR
         GF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CY/oNJ8EO9OsfnaLTi7yO+kVNqN3sw4e4XLEDmrhyeM=;
        b=VAiakzYF+RF3tR4VGX+PZzbiFzVCIteJinJdGpIHVJjldQ90Ib59Fh3KIWvERNa/BA
         b8dtt1RzLZT0aJq8uVN6OdXboAxu5NeEsciu89QqcMY9+/nOSxFMirQv3hjJ/0qOhTUt
         FAOVQ3SxZQZVVSGLneIQlLWePQbVZltBsTqvWGFD7f0iSofYLfUZl536PfZ8b0KFQo6f
         XHM2ldWltzy9CPK6mrrIdYkgGvNd9/MdElXfo9KU6aFhwAZKYVMXTfVMX/BMyybofuFE
         VHU/4BumCgvTwhGsR75VAWKX5bZzc1DsignzOGrPx965mehIkrZAew720OUmXxgkjrRx
         QeYA==
X-Gm-Message-State: AJIora+o+BlgjWmi06FZoKVLryHl31gMH2ZTb++50SZIv8ihaPH905kT
        lHsu/FViv4lQkhmmWAIW5iI=
X-Google-Smtp-Source: AGRyM1sL/Z+M4APAHrLgecFyORMTpGHtIMNIIXDCzTUn+eC4Tpr6dPpGR36BAG3jACndy9L4zfzorg==
X-Received: by 2002:adf:ebc4:0:b0:21b:815b:d135 with SMTP id v4-20020adfebc4000000b0021b815bd135mr10654007wrn.653.1655646428050;
        Sun, 19 Jun 2022 06:47:08 -0700 (PDT)
Received: from localhost.localdomain ([77.137.66.49])
        by smtp.gmail.com with ESMTPSA id q18-20020adfcd92000000b00219e77e489fsm5240927wrj.17.2022.06.19.06.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 06:47:07 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: [PATCH 2/4] fstests: make sure to unfreeze test and scratch mounts
Date:   Sun, 19 Jun 2022 16:46:55 +0300
Message-Id: <20220619134657.1846292-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220619134657.1846292-1-amir73il@gmail.com>
References: <20220619134657.1846292-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Almost all of the tests that _require_freeze() fail to unfreeze
scratch mount in case the test is interrupted while fs is frozen.

Move the handling of unfreeze to generic check code.
For now, tests only freeze scratch fs, but to be more robust, unfreeze
both test and scratch fs following a call to _require_freeze().

Tests could still hang if thier private _cleanup() routine tries
to modify the frozen fs or wait for a blocked process. Fix the
_cleanup() routine of xfs/011 to avoid that.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 check             | 14 ++++++++------
 common/rc         |  5 +++--
 tests/generic/390 |  2 --
 tests/xfs/011     |  2 --
 tests/xfs/517     |  1 -
 5 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/check b/check
index de11b37e..d6ee71aa 100755
--- a/check
+++ b/check
@@ -527,17 +527,21 @@ _check_filesystems()
 {
 	local ret=0
 
+	# Make sure both test and scratch are unfrozen post _require_freeze()
+	if [ -f ${RESULT_DIR}/require_freeze ]; then
+		xfs_freeze -u "$TEST_DIR" >/dev/null 2>&1
+		xfs_freeze -u "$SCRATCH_MNT" >/dev/null 2>&1
+	fi
 	if [ -f ${RESULT_DIR}/require_test ]; then
 		_check_test_fs || ret=1
-		rm -f ${RESULT_DIR}/require_test*
 	else
 		_test_unmount 2> /dev/null
 	fi
 	if [ -f ${RESULT_DIR}/require_scratch ]; then
 		_check_scratch_fs || ret=1
-		rm -f ${RESULT_DIR}/require_scratch*
 	fi
 	_scratch_unmount 2> /dev/null
+	rm -f ${RESULT_DIR}/require_*
 	return $ret
 }
 
@@ -783,8 +787,7 @@ function run_section()
 		seqres="$REPORT_DIR/$seqnum"
 
 		mkdir -p $RESULT_DIR
-		rm -f ${RESULT_DIR}/require_scratch*
-		rm -f ${RESULT_DIR}/require_test*
+		rm -f ${RESULT_DIR}/require_*
 		echo -n "$seqnum"
 
 		if $showme; then
@@ -882,8 +885,7 @@ function run_section()
 			_dump_err_cont "[failed, exit status $sts]"
 			_test_unmount 2> /dev/null
 			_scratch_unmount 2> /dev/null
-			rm -f ${RESULT_DIR}/require_test*
-			rm -f ${RESULT_DIR}/require_scratch*
+			rm -f ${RESULT_DIR}/require_*
 			err=true
 		else
 			# The test apparently passed, so check for corruption
diff --git a/common/rc b/common/rc
index 3c072c16..b87dfe05 100644
--- a/common/rc
+++ b/common/rc
@@ -1540,8 +1540,7 @@ _notrun()
 {
     echo "$*" > $seqres.notrun
     echo "$seq not run: $*"
-    rm -f ${RESULT_DIR}/require_test*
-    rm -f ${RESULT_DIR}/require_scratch*
+    rm -f ${RESULT_DIR}/require_*
 
     status=0
     exit
@@ -3648,6 +3647,8 @@ _require_freeze()
 	local result=$?
 	xfs_freeze -u "$TEST_DIR" >/dev/null 2>&1
 	[ $result -eq 0 ] || _notrun "$FSTYP does not support freezing"
+	# Make sure both test and scratch are unfrozen at the end of the test
+	touch ${RESULT_DIR}/require_freeze
 }
 
 # Does NFS export work on this fs?
diff --git a/tests/generic/390 b/tests/generic/390
index 20c66e22..0f2b86fa 100755
--- a/tests/generic/390
+++ b/tests/generic/390
@@ -14,8 +14,6 @@ _begin_fstest auto freeze stress
 _cleanup()
 {
 	cd /
-	# Make sure $SCRATCH_MNT is unfreezed
-	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
 	rm -f $tmp.*
 }
 
diff --git a/tests/xfs/011 b/tests/xfs/011
index d6e9099e..351a574e 100755
--- a/tests/xfs/011
+++ b/tests/xfs/011
@@ -17,9 +17,7 @@ _begin_fstest auto freeze log metadata quick
 _cleanup()
 {
 	$KILLALL_PROG -9 fsstress 2>/dev/null
-	wait
 	cd /
-	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 
diff --git a/tests/xfs/517 b/tests/xfs/517
index f7f9a8a2..961668e3 100755
--- a/tests/xfs/517
+++ b/tests/xfs/517
@@ -15,7 +15,6 @@ _register_cleanup "_cleanup" BUS
 _cleanup()
 {
 	cd /
-	$XFS_IO_PROG -x -c 'thaw' $SCRATCH_MNT > /dev/null 2>&1
 	rm -rf $tmp.*
 }
 
-- 
2.25.1

