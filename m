Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13579C77B76
	for <linux-fstests@archiver.kernel.org>; Fri, 21 Apr 2023 17:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjDURvm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 21 Apr 2023 13:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjDURvl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 21 Apr 2023 13:51:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713B918D
        for <fstests@vger.kernel.org>; Fri, 21 Apr 2023 10:51:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-246fdb97191so1690911a91.0
        for <fstests@vger.kernel.org>; Fri, 21 Apr 2023 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682099500; x=1684691500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=svy4Bn8bjYqm614LLHkn/nl3IEarudNGE7PcsV6gE20=;
        b=C2O+pKM9l3of2A65DNQTvY68VkepCA/YpdlnaUBc6lJafudZxYNzUKI3AMmJn1TYIR
         Ic3rGx2RwxlfO08CqQVADTwgyPdOV0vfRHTUz7ffwDcHDXMnLJVni4WR/3ut5hZ3zTBv
         gw2ZnZPfxEVFvfIE4+g68a+Yv/uxIiLSJTp3D63YT9ouztE9cgJyEMW2P/spnFl89bBm
         xailP3T4r5CjVcdeBbjjmGT2DXSXIVBTo3ySIb36WwhENTivPT6gqL/gcd39SoD3aylQ
         /z3hAVDt8kVe1ZQWD/ciPM5D/sX448nls86jmM6DLpcd//fQfquXn5+OExeCHh7fLUlx
         GW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682099500; x=1684691500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svy4Bn8bjYqm614LLHkn/nl3IEarudNGE7PcsV6gE20=;
        b=Im+KLWhkBMUcE2fj0/4eS546HXbGSU5BiKqvcL5Xe/z3IF7fgKjP00Wn68Da4TQdJy
         5gFx3CouFvyfZPLSj11IEZ4AH4QnSIClYbKX9JfgE7v8ifsiD/CeGZ6MTUQjJujAPipl
         IZGNS4/V+Qb56rpZn+v8trWgDq08ZAn1UebQQGgdPRPomwDGTFxMfv/nSjupxtNhDfCe
         9VH2pI7N6BHMfZvPiI1q+g1GlUkvxdj83p8y5vgBc3KSzKobWtEoMXWdX79AvgwD5Wgt
         ghmrR2uDbZMPzKYfO/zCnRT40bHdDyuk8AfvrVYVMigpgvI+JR7bF8BvaM7lalClb3FG
         DDnA==
X-Gm-Message-State: AAQBX9cRLzrJkCjbmNB4giNcfJKDCqG1RBhHfAJCBfxZ1tQl98GCkz5S
        8/Fl3h+nvQON5LS+bPi3d44J9XaQOzM=
X-Google-Smtp-Source: AKy350bFNkejJ+iK24mqwO+CEOk9ZM1/LnTGAgnB6URrRQWYAnJB5vIPL0PGqtnEi2VT7uDFv+8Fwg==
X-Received: by 2002:a17:90a:e509:b0:247:1e1e:57c0 with SMTP id t9-20020a17090ae50900b002471e1e57c0mr5845315pjy.14.1682099499524;
        Fri, 21 Apr 2023 10:51:39 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2d4:203:fda6:981:889:c7cc])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090a950300b0024796ddd19bsm4798228pjo.7.2023.04.21.10.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:51:39 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     fstests@vger.kernel.org
Cc:     tytso@mit.edu, djwong@kernel.org,
        Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v2 1/2] check: try to fix the test device if it gets corrupted
Date:   Fri, 21 Apr 2023 10:51:31 -0700
Message-ID: <20230421175132.3596583-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

If the test device gets corrupted all subsequent tests will fail.  To
prevent this from causing all subsequent tests to be useless, try
repair the file system on TEST_DEV if possible.  We don't need to do
this with the scratch device since that file system gets recreated
each time anyway.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
Changes v1->v2:
- Update function name _repair_xfs_test_fs -> _test_xfs_repair

 check      |  7 ++++++-
 common/rc  | 41 +++++++++++++++++++++++++++++++++++++++++
 common/xfs | 12 ++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 1a58a2b2..befbf465 100755
--- a/check
+++ b/check
@@ -536,7 +536,12 @@ _check_filesystems()
 	local ret=0
 
 	if [ -f ${RESULT_DIR}/require_test ]; then
-		_check_test_fs || ret=1
+		if ! _check_test_fs ; then
+			ret=1
+			echo "Trying to repair broken TEST_DEV file system"
+			_repair_test_fs
+			_test_mount
+		fi
 		rm -f ${RESULT_DIR}/require_test*
 	else
 		_test_unmount 2> /dev/null
diff --git a/common/rc b/common/rc
index 90749343..ad5cca56 100644
--- a/common/rc
+++ b/common/rc
@@ -1199,6 +1199,47 @@ _repair_scratch_fs()
     esac
 }
 
+_repair_test_fs()
+{
+	case $FSTYP in
+	xfs)
+		_test_xfs_repair "$@" >$tmp.repair 2>&1
+		res=$?
+		if [ "$res" -ne 0 ]; then
+			echo "xfs_repair returns $res; replay log?" >>$tmp.repair
+			_test_mount
+			res=$?
+			if [ $res -gt 0 ]; then
+				echo "mount returns $res; zap log?" >>$tmp.repair
+				_xfs_repair_test_fs -L >>$tmp.repair 2>&1
+				echo "log zap returns $?" >> $tmp.repair
+			else
+				umount "$TEST_DEV"
+			fi
+			_xfs_repair_test_fs "$@" >>$tmp.repair 2>&1
+			res=$?
+		fi
+		;;
+	*)
+		# Let's hope fsck -y suffices...
+		fsck -t $FSTYP -fy $TEST_DEV >$tmp.repair 2>&1
+		res=$?
+		if test "$res" -lt 4 ; then
+			res=0
+		fi
+		;;
+	esac
+	if [ $res -ne 0 ]; then
+		_log_err "_repair_test_fs: failed, err=$res"
+		echo "*** fsck.$FSTYP output ***"	>>$seqres.full
+		cat $tmp.repair				>>$seqres.full
+		echo "*** end fsck.$FSTYP output"	>>$seqres.full
+
+	fi
+	rm -f $tmp.repair
+	return $res
+}
+
 _get_pids_by_name()
 {
     if [ $# -ne 1 ]
diff --git a/common/xfs b/common/xfs
index e8e4832c..16f292a7 100644
--- a/common/xfs
+++ b/common/xfs
@@ -988,6 +988,18 @@ _check_xfs_test_fs()
 	return $?
 }
 
+# modeled after _scratch_xfs_repair
+_test_xfs_repair()
+{
+	TEST_OPTIONS=""
+	[ "$USE_EXTERNAL" = yes -a ! -z "$TEST_LOGDEV" ] && \
+		TEST_OPTIONS="-l$TEST_LOGDEV"
+	[ "$USE_EXTERNAL" = yes -a ! -z "$TEST_RTDEV" ] && \
+		TEST_OPTIONS=$TEST_OPTIONS" -r$TEST_RTDEV"
+	[ "$LARGE_TEST_DEV" = yes ] && TEST_OPTIONS=$TEST_OPTIONS" -t"
+	$XFS_REPAIR_PROG $TEST_OPTIONS $* $TEST_DEV
+}
+
 _require_xfs_test_rmapbt()
 {
 	_require_test
-- 
2.40.0.634.g4ca3ef3211-goog

