Received: from cn.fujitsu.com ([59.151.112.132]:48526 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752408AbdBMLYG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Feb 2017 06:24:06 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id BD80847D8AAF
        for <fstests@vger.kernel.org>; Mon, 13 Feb 2017 19:23:19 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] shared/005,7: add check whether debugfs succeeds to set a negative i_size or not
Date: Mon, 13 Feb 2017 19:21:50 +0800
Message-ID: <1486984910-4623-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

shared/005 and shared/007 work abnornamlly on RHEL6.8GA and
RHEL6.9Beta because debugfs fails to set i_size to -1 or -512
and reports "exceeds field size maximum".  When debugfs fails
to set a negative i_size, we can skip these cases which don't
trigger the kernel bug.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/shared/005 | 7 +++++++
 tests/shared/007 | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/tests/shared/005 b/tests/shared/005
index 296de17..37912d6 100755
--- a/tests/shared/005
+++ b/tests/shared/005
@@ -67,6 +67,13 @@ $DEBUGFS_PROG -w -R "sif /a size -1" $SCRATCH_DEV >> $seqres.full 2>&1
 
 echo "Remount, try to append"
 _scratch_mount
+
+#check whether debugfs succeeds to set i_size to -1 or not
+i_size=$(stat -c "%s" $testdir/a)
+if [ $i_size -ne -1 ]; then
+	_notrun "Could not set i_size to -1 successfully, skip test."
+fi
+
 dd if=/dev/zero of=$testdir/a bs=512 count=1 oflag=append conv=notrunc >> $seqres.full 2>&1 || echo "Write did not succeed (ok)."
 sync
 
diff --git a/tests/shared/007 b/tests/shared/007
index 0729ab8..06055a0 100755
--- a/tests/shared/007
+++ b/tests/shared/007
@@ -69,6 +69,13 @@ $DEBUGFS_PROG -w -R "sif /a size 0xFFFFFFFFFFFFFE00" $SCRATCH_DEV >> $seqres.ful
 
 echo "Remount, try to append"
 _scratch_mount
+
+#check whether debugfs succeeds to set i_size to -512 or not
+i_size=$(stat -c "%s" $testdir/a)
+if [ $i_size -ne -512 ]; then
+	_notrun "Could not set i_size to -512 successfully, skip test."
+fi
+
 dd if=/dev/zero of=$testdir/a bs=512 count=1 oflag=direct,append conv=notrunc >> $seqres.full 2>&1 || echo "Write did not succeed (ok)."
 sync
 
-- 
1.8.3.1



