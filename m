Received: from mail.cn.fujitsu.com ([183.91.158.132]:30999 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751760AbeAOHwW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 15 Jan 2018 02:52:22 -0500
From: xiao yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v3 2/3] common/filter: factor out expected XFS warnings for mount
Date: Mon, 15 Jan 2018 15:48:31 +0800
Message-ID: <1516002512-3861-2-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <1516002512-3861-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180115062929.GB3102@eguan.usersys.redhat.com>
 <1516002512-3861-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: david@fromorbit.com, darrick.wong@oracle.com, fstests@vger.kernel.org, xiao yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

1) Move filter_xfs_dmesg from xfs/098 to common/filter, and rename
   it as _filter_mount_dmesg.

2) filter out another expected warning on CONFIG_XFS_DEBUG(without
   CONFIG_XFS_ASSERT_FATAL) build.

Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
---
 common/filter | 11 +++++++++++
 tests/xfs/098 | 16 ++++------------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/common/filter b/common/filter
index 8e1fdb4..71b8c92 100644
--- a/common/filter
+++ b/common/filter
@@ -570,5 +570,16 @@ _filter_aiodio_dmesg()
 	    -e "s#$warn9#Intentional warnings in dio_complete#"
 }
 
+# We generate mount related WARNINGs on purpose and make sure test doesn't fail
+# because of these warnings. This is a helper for _check_dmesg() to filter out
+# them.
+_filter_mount_dmesg()
+{
+	local warn1="WARNING:.*fs/xfs/xfs_message\.c:.*asswarn.*"
+	local warn2="WARNING:.*fs/xfs/xfs_message\.c:.*assfail.*"
+	sed -e "s#$warn1#Intentional warnings in asswarn#" \
+	    -e "s#$warn2#Intentional warnings in assfail#"
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/xfs/098 b/tests/xfs/098
index 9bcd94b..bf7f89a 100755
--- a/tests/xfs/098
+++ b/tests/xfs/098
@@ -56,16 +56,6 @@ test -z "${FUZZ_ARGS}" && FUZZ_ARGS="-n 8 -3"
 
 rm -f $seqres.full
 
-# If we corrupt log on a CONFIG_XFS_WARN build, there will be mount related
-# WARNINGs in dmesg as expected.  We don't want to simply _disable_dmesg_check
-# which could miss other potential bugs, so filter out the intentional WARNINGs,
-# make sure test doesn't fail because of this warning and fails on other WARNINGs.
-filter_xfs_dmesg()
-{
-	local warn="WARNING:.*fs/xfs/xfs_message\.c:.*asswarn.*"
-	sed -e "s#$warn#Intentional warnings in asswarn#"
-}
-
 TESTDIR="${SCRATCH_MNT}/scratchdir"
 TESTFILE="${TESTDIR}/testfile"
 
@@ -107,8 +97,10 @@ _scratch_mount 2>/dev/null && _fail "mount should not succeed"
 echo "+ repair fs"
 _repair_scratch_fs >> $seqres.full 2>&1
 
-# mount may trigger related WARNINGs, so filter them.
-_check_dmesg filter_xfs_dmesg
+# We may trigger mounted related WARNINGs if we corrupt log on a
+# CONFIG_XFS_WARN or CONFIG_XFS_DEBUG(without CONFIG_XFS_ASSERT_FATAL)
+# build, so filter them.
+_check_dmesg _filter_mount_dmesg
 
 echo "+ mount image (2)"
 _scratch_mount
-- 
1.8.3.1



