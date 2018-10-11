Received: from aserp2120.oracle.com ([141.146.126.78]:46918 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbeJKPVp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Oct 2018 11:21:45 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v4] geneirc/077 fix min size for btrfs
Date: Thu, 11 Oct 2018 15:55:28 +0800
Message-Id: <1539244528-9647-1-git-send-email-anand.jain@oracle.com>
In-Reply-To: <1539228360-8575-1-git-send-email-anand.jain@oracle.com>
References: <1539228360-8575-1-git-send-email-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

If btrfs need to be tested at its default blockgroup which is non-mixed,
then it needs at least 256mb.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3->v4: fix the check for the /usr or /lib/modules size. Thanks Darrick.
v2->v3:
	separated from the patch set of 9.
	notrun for the cases where filler is not big enough to fill the
		fssize.
v2->v1: ref the cover-letter of the set.

 tests/generic/077 | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tests/generic/077 b/tests/generic/077
index ef6af18c83e3..284e25253c9e 100755
--- a/tests/generic/077
+++ b/tests/generic/077
@@ -13,11 +13,18 @@ echo "QA output created by $seq"
 here=`pwd`
 tmp=/tmp/$$
 status=1
-# Something w/ enough data to fill 50M of fs...
-filler=/lib/modules/
 
-# fall back in case /lib/modules doesn't exist
-[ -d $filler ] || filler=/usr
+# Something w/ enough data to fill 256M of fs...
+filler=""
+[ -d /lib/modules ] && \
+	[ $(( $(du -h -m /lib/modules | tail -1| cut -f1) * 2 )) -ge 256 ] && \
+	filler=/lib/modules
+
+# fall back in case /lib/modules doesn't exist or smaller
+[[ -z $filler ]] && \
+	[ -d /usr ] && \
+	[ $(( $(du -h -m /usr | tail -1| cut -f1) * 2 )) -ge 256 ] && \
+	filler=/usr
 
 _cleanup()
 {
@@ -36,7 +43,7 @@ trap "_cleanup; rm -f $tmp.*; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 
-[ ! -d $filler ] && _notrun "No directory to source files from"
+[ ! -d $filler ] && _notrun "No directory at least 256MB to source files from"
 
 _require_scratch
 _require_attrs
@@ -49,9 +56,8 @@ rm -f $seqres.full
 _scratch_unmount >/dev/null 2>&1
 echo "*** MKFS ***"                         >>$seqres.full
 echo ""                                     >>$seqres.full
-SIZE=`expr 50 \* 1024 \* 1024`
-_scratch_mkfs_sized $SIZE                   >>$seqres.full 2>&1 \
-	|| _fail "mkfs failed"
+fs_size=$((256 * 1024 * 1024))
+_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount
 mkdir $SCRATCH_MNT/subdir
 
-- 
1.8.3.1
