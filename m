Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD202C77B71
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Apr 2023 22:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDNWL4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 14 Apr 2023 18:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjDNWL4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Apr 2023 18:11:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D41C46A6
        for <fstests@vger.kernel.org>; Fri, 14 Apr 2023 15:11:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2470524add2so624845a91.2
        for <fstests@vger.kernel.org>; Fri, 14 Apr 2023 15:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681510299; x=1684102299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kx3PbbalI062dWizlOchskVV3mUuFApwM3tlPSmdRr0=;
        b=DYtnAsOfwB/+hdN3EJ34iU2Mxe7zCIDkPM3SGIYPRuIYsF5fyhv+d+ukmaCj7zeWuE
         pSW6OHryCMOCumQBjdijcxgoBgxcuJscerd+uxOYxCq2dbi/NUGkaleKMVtrAzY6/xPp
         luWHqIPaieQ2xZqyAeZ2J2cPHLjvhg5s9HXHilVznmEITStX7I8SlWfPWQH7RazHuNtR
         2upl4z2QIHj56+8b0a74Fo9BW2EMfxtRDqk85lx09v6InxA3j8P+y0CsxkVA/r6IsbBM
         V9EfGK++O3jj8JR6WAFzlAhv0ngQ1KkzAkQ/FwSJAeQmb9wwrRgxhpAycjn5DaCIjmft
         sMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681510299; x=1684102299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kx3PbbalI062dWizlOchskVV3mUuFApwM3tlPSmdRr0=;
        b=FPsbxc0n026yNDzVedSxQJCatUmgpzG4Dnb/ItygDuGsY2M1z/b1bV5g30Q93drLz3
         K3GN45DQk6xx9qX2eOs3lyAsCN7/LG+ns1NsdWMV857OtEIj+wX9nKeU1LXS0jl2+TA/
         Yq2WQqSBvq8aScEqsxGGPSWJLft8umS3cxOe7a0UK7h39OSztV4ZzDksR/qpL81fcd/7
         OSlZTQwoAAzMCF+DZleD3ihy2NE9ucP4W50/pBVMECt4RO3MZo8YmMOnSXHoX3HZI5s3
         lzfLij/Xq8hGpWarjd+Sw3aUPew5kpZ9E9FlsLs6I5leRxMv9ro1JOCN+TNIfJGMTYJs
         TS/w==
X-Gm-Message-State: AAQBX9dz8eVCym387yOXVKQX4qX3wC/6EPqDKUUIFoqzrTvKu/ygh0m9
        yQ+Fc1wrUnPWuXouC0mjFOA3KU+mP8I=
X-Google-Smtp-Source: AKy350Yo9OGRL/J7ToItGW9ZPxG8pcbOudRsIyZrxeU9NkdNyPZFTsfJJY8qgGmplJ+3lQv4rhfjmw==
X-Received: by 2002:a05:6a00:2e82:b0:63b:e4:554 with SMTP id fd2-20020a056a002e8200b0063b00e40554mr11613363pfb.4.1681510299563;
        Fri, 14 Apr 2023 15:11:39 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2d4:203:1fb3:c400:8b7a:ed6])
        by smtp.gmail.com with ESMTPSA id k14-20020aa792ce000000b0062e15c22cd8sm3473219pfa.48.2023.04.14.15.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 15:11:39 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     fstests@vger.kernel.org
Cc:     tytso@mit.edu, djwong@kernel.org
Subject: [PATCH 1/2] check: try to fix the test device if it gets corrupted
Date:   Fri, 14 Apr 2023 15:11:32 -0700
Message-ID: <20230414221133.3431400-1-leah.rumancik@gmail.com>
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
---
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
index 90749343..e8fc7e86 100644
--- a/common/rc
+++ b/common/rc
@@ -1199,6 +1199,47 @@ _repair_scratch_fs()
     esac
 }
 
+_repair_test_fs()
+{
+	case $FSTYP in
+	xfs)
+		_repair_xfs_test_fs "$@" >$tmp.repair 2>&1
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
index e8e4832c..4a130493 100644
--- a/common/xfs
+++ b/common/xfs
@@ -988,6 +988,18 @@ _check_xfs_test_fs()
 	return $?
 }
 
+# modeled after _scratch_xfs_repair
+_repair_xfs_test_fs()
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

