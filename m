Received: from sandeen.net ([63.231.237.45]:45162 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeIZBVl (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 Sep 2018 21:21:41 -0400
Subject: [PATCH V2] misc large filesystem fixes
References: <b647246c-c206-229a-f801-60f20dfa9f28@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <5b3d5d41-83d3-c217-c3a2-3d269204caa4@sandeen.net>
Date: Tue, 25 Sep 2018 14:12:40 -0500
MIME-Version: 1.0
In-Reply-To: <b647246c-c206-229a-f801-60f20dfa9f28@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

There are a few tests which fail on large filesytems because
we run into mkfs limits.

xfs/010, xfs/013, and xfs/062 specify AG count, but if the device
is larger than agcount*1T this will fail.  Add a mkfs helper that
will adjust the data size to accommodate the ag count request.
xfs/178 tries to decrease the agcount and re-mkfs, but if the
default AG size was chosen to be 1T, decreasing the AG count
results in too-large AGs and mkfs fails.  The intention here
AFAICT is to simply re-mkfs with non-overlapping AG headers,
so increasing the AG count should achieve the same purpose,
and cause mkfs to choose a smaller-than-default AG size which
should pass.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/common/xfs b/common/xfs
index d971b4a8..34412882 100644
--- a/common/xfs
+++ b/common/xfs
@@ -110,6 +110,21 @@ _scratch_mkfs_xfs()
 	return $mkfs_status
 }
 
+_scratch_mkfs_xfs_agcount()
+{
+	local agcount=$1
+	local opts=$2
+
+	# If $agcount AGs would result in too-large AG size, restrict the size
+	# to create $agcount AGS roughly 1T in size.
+	local dsizeopt=""
+	dev_sz=$(blockdev --getsize64 $SCRATCH_DEV)
+	if [ "$dev_sz" -ge "$(($agcount*(2**40)))" ]; then
+		  dsizeopt="-d size=$(($agcount*((2**40)-1)))"
+	fi
+	_scratch_mkfs_xfs "$opts -d agcount=$agcount $dsizeopt" | _filter_mkfs 2>$seqres.full
+}
+
 # xfs_check script is planned to be deprecated. But, we want to
 # be able to invoke "xfs_check" behavior in xfstests in order to
 # maintain the current verification levels.
diff --git a/tests/xfs/010 b/tests/xfs/010
index ee1595c8..5da815a5 100755
--- a/tests/xfs/010
+++ b/tests/xfs/010
@@ -96,7 +96,7 @@ _require_xfs_finobt
 
 rm -f $seqres.full
 
-_scratch_mkfs_xfs "-m crc=1,finobt=1 -d agcount=2" | _filter_mkfs 2>$seqres.full
+_scratch_mkfs_xfs_agcount 2 "-m crc=1,finobt=1"
 
 # sparsely populate the fs such that we create records with free inodes
 _scratch_mount
diff --git a/tests/xfs/013 b/tests/xfs/013
index 4d31d793..f45217ba 100755
--- a/tests/xfs/013
+++ b/tests/xfs/013
@@ -97,8 +97,7 @@ _require_command "$KILLALL_PROG" killall
 
 rm -f $seqres.full
 
-_scratch_mkfs_xfs "-m crc=1,finobt=1 -d agcount=2" | \
-	_filter_mkfs 2>> $seqres.full
+_scratch_mkfs_xfs_agcount 2 "-m crc=1,finobt=1"
 _scratch_mount
 
 COUNT=20000	# number of files per directory
diff --git a/tests/xfs/062 b/tests/xfs/062
index 755c5243..c0f82a78 100755
--- a/tests/xfs/062
+++ b/tests/xfs/062
@@ -57,7 +57,7 @@ rm -f $seqres.full
 DIRCOUNT=8
 INOCOUNT=$((2048 / DIRCOUNT))
 
-_scratch_mkfs "-d agcount=$DIRCOUNT" >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mkfs_xfs_agcount $DIRCOUNT >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount
 
 # create a set of directories and fill each with a fixed number of files
diff --git a/tests/xfs/178 b/tests/xfs/178
index 84151056..f7ea9139 100755
--- a/tests/xfs/178
+++ b/tests/xfs/178
@@ -51,8 +51,8 @@ _supported_os Linux
 # o Summary of testing:
 #    1. mkfs.xfs a default filesystem, note agcount value.
 #    2. dd zero first sector and repair and verify.
-#    3. mkfs.xfs overriding agcount to a smaller value
-#             (ie. each AG is bigger)
+#    3. mkfs.xfs overriding agcount to a larger value
+#             (ie. each AG is smaller)
 #    4. dd zero first sector, repair and verify.
 #          -> old mkfs.xfs will cause repair to incorrectly
 #             fix filesystem, new mkfs.xfs will be fine.
@@ -74,8 +74,8 @@ fi
 
 _dd_repair_check $SCRATCH_DEV $sectsz
 
-# smaller AGCOUNT
-let "agcount=$agcount-2"
+# larger AGCOUNT
+let "agcount=$agcount+2"
 _scratch_mkfs_xfs -dagcount=$agcount >/dev/null 2>&1 \
         || _fail "mkfs failed!"
 
