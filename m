Received: from cn.fujitsu.com ([59.151.112.132]:19881 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751091AbcINC6S (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Sep 2016 22:58:18 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v4] xfs/098: fix xfs_repair on newer xfsprogs
Date: Wed, 14 Sep 2016 10:52:36 +0800
Message-ID: <1473821556-27889-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20160913070804.GF12847@dhcp12-143.nay.redhat.com>
References: <20160913070804.GF12847@dhcp12-143.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, sandeen@redhat.com, darrick.wong@oracle.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

1) use _repair_scratch_fs instead of xfs_repair
   The obsolete xfs_repair always cleared the log regardless of whether
   it is corrupted and current xfs_repair only cleared the log when -L
   option is specified.  xfs_repair -L option should be used to clear it
   if xfs_repair failed to clear log.
2) catch non-zero return value instead of 2
   It can be applied to both the old return value 1 and the new return
   value 2
3) add filter_xfs_dmesg to ignore mount related warnings
   If we corrupt log and mount on a CONFIG_XFS_WARN build, there will be
   mount related warnings in dmesg as expected.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc     |  2 +-
 tests/xfs/098 | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 13afc6a..655ae28 100644
--- a/common/rc
+++ b/common/rc
@@ -1152,7 +1152,7 @@ _repair_scratch_fs()
     xfs)
         _scratch_xfs_repair "$@" 2>&1
 	res=$?
-	if [ "$res" -eq 2 ]; then
+	if [ "$res" -ne 0 ]; then
 		echo "xfs_repair returns $res; replay log?"
 		_scratch_mount
 		res=$?
diff --git a/tests/xfs/098 b/tests/xfs/098
index d91d617..86ec62c 100755
--- a/tests/xfs/098
+++ b/tests/xfs/098
@@ -54,6 +54,17 @@ _require_xfs_db_blocktrash_z_command
 test -z "${FUZZ_ARGS}" && FUZZ_ARGS="-n 8 -3"
 
 rm -f $seqres.full
+
+# If we corrupt log on a CONFIG_XFS_WARN build, there will be mount related
+# WARNINGs in dmesg as expected.  We don't want to simply _disable_dmesg_check
+# which could miss other potential bugs, so filter out the intentional WARNINGs,
+# make sure test doesn't fail because of this warning and fails on other WARNINGs.
+filter_xfs_dmesg()
+{
+	local warn="WARNING:.*fs/xfs/xfs_message\.c:.*asswarn.*"
+	sed -e "s#$warn#Intentional warnings in asswarn#"
+}
+
 TESTDIR="${SCRATCH_MNT}/scratchdir"
 TESTFILE="${TESTDIR}/testfile"
 
@@ -93,7 +104,10 @@ echo "+ mount image"
 _scratch_mount 2>/dev/null && _fail "mount should not succeed"
 
 echo "+ repair fs"
-_scratch_xfs_repair >> $seqres.full 2>&1
+_repair_scratch_fs >> $seqres.full 2>&1
+
+# mount may trigger related WARNINGs, so filter them.
+_check_dmesg filter_xfs_dmesg
 
 echo "+ mount image (2)"
 _scratch_mount
-- 
1.8.3.1



