Received: from userp2120.oracle.com ([156.151.31.85]:37014 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfDLFYa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 12 Apr 2019 01:24:30 -0400
From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH RFC] fstests: generic/077: fix populate fs use _fill_fs()
Date: Fri, 12 Apr 2019 13:24:18 +0800
Message-Id: <20190412052418.22206-1-anand.jain@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Test case generic/077 uses files under /lib or /usr to fill SCRATCH_MNT.
If /usr or /lib is below 256mb then test fails to run, or if these dirs
are too large it takes a long time for the cp to finish. On my machine
it takes 645sec.

This patch propose to use the common/populate function _fill_fs() to
write files into the target directory instead. However I am not too
sure about the motivation of this test case in the first place, and
why does it wanted to cp /usr or /lib, and why fs should become full?
Any idea? Thanks.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/generic/077     | 24 +++++-------------------
 tests/generic/077.out |  3 +--
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/tests/generic/077 b/tests/generic/077
index d11b49c6ff15..d8e5551f1925 100755
--- a/tests/generic/077
+++ b/tests/generic/077
@@ -14,18 +14,6 @@ here=`pwd`
 tmp=/tmp/$$
 status=1
 
-# Something w/ enough data to fill 256M of fs...
-filler=""
-[ -d /lib/modules ] && \
-	[ $(( $(du -h -m /lib/modules | tail -1| cut -f1) * 2 )) -ge 256 ] && \
-	filler=/lib/modules
-
-# fall back in case /lib/modules doesn't exist or smaller
-[[ -z $filler ]] && \
-	[ -d /usr ] && \
-	[ $(( $(du -h -m /usr | tail -1| cut -f1) * 2 )) -ge 256 ] && \
-	filler=/usr
-
 _cleanup()
 {
 	cd /
@@ -38,13 +26,12 @@ trap "_cleanup; rm -f $tmp.*; exit \$status" 0 1 2 3 15
 . ./common/rc
 . ./common/filter
 . ./common/attr
+. ./common/populate
 
 # real QA test starts here
 _supported_fs generic
 _supported_os Linux
 
-[ ! -d $filler ] && _notrun "No directory at least 256MB to source files from"
-
 _require_scratch
 _require_attrs
 _require_acls
@@ -64,11 +51,10 @@ mkdir $SCRATCH_MNT/subdir
 echo "*** set default ACL"
 setfacl -R -dm u:fsgqa:rwx,g::rwx,o::r-x,m::rwx $SCRATCH_MNT/subdir
 
-echo "*** populate filesystem, pass #1" | tee -a $seqres.full
-cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&1
-
-echo "*** populate filesystem, pass #2" | tee -a $seqres.full
-cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&1
+blksz="$(_get_block_size $SCRATCH_MNT/subdir)"
+echo "*** populate filesystem" | tee -a $seqres.full
+echo "*** fill_fs $fs_size $SCRATCH_MNT/subdir $blksz 0" >> $seqres.full
+_fill_fs $fs_size $SCRATCH_MNT/subdir $blksz 0 >> $seqres.full 2>&1
 
 _check_scratch_fs
 
diff --git a/tests/generic/077.out b/tests/generic/077.out
index eae7226ab29c..9c143c902a2c 100644
--- a/tests/generic/077.out
+++ b/tests/generic/077.out
@@ -1,7 +1,6 @@
 QA output created by 077
 *** create filesystem
 *** set default ACL
-*** populate filesystem, pass #1
-*** populate filesystem, pass #2
+*** populate filesystem
 *** all done
 *** unmount
-- 
2.17.1
