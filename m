Received: from mx1.redhat.com ([209.132.183.28]:40218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbeH3Bm3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 29 Aug 2018 21:42:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45933308FB98
        for <fstests@vger.kernel.org>; Wed, 29 Aug 2018 21:43:39 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 153E660BE1
        for <fstests@vger.kernel.org>; Wed, 29 Aug 2018 21:43:39 +0000 (UTC)
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] misc large filesystem fixes
Message-ID: <b647246c-c206-229a-f801-60f20dfa9f28@redhat.com>
Date: Wed, 29 Aug 2018 16:43:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

There are a few tests which fail on large filesytems because
we run into mkfs limits.

xfs/010 and xfs/013 hardcode 2 AGs, but if the device is larger
than 2T this will fail.  Check the device size and restrict it
to just under 2T so that a 2-AG mkfs is possible.

xfs/178 tries to decrease the agcount and re-mkfs, but if the
default AG size was chosen to be 1T, decreasing the AG count
results in too-large AGs and mkfs fails.  The intention here
AFAICT is to simply re-mkfs with non-overlapping AG headers,
so increasing the AG count should achieve the same purpose,
and cause mkfs to choose a smaller-than-default AG size which
should pass.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/xfs/010 b/tests/xfs/010
index ee1595c8..2b30c867 100755
--- a/tests/xfs/010
+++ b/tests/xfs/010
@@ -96,7 +96,14 @@ _require_xfs_finobt
 
 rm -f $seqres.full
 
-_scratch_mkfs_xfs "-m crc=1,finobt=1 -d agcount=2" | _filter_mkfs 2>$seqres.full
+# If 2 AGs would result in too-large AG size, restrict the size
+DSIZEOPT=""
+DEV_SZ=$(blockdev --getsize64 $SCRATCH_DEV)
+if [ "$DEV_SZ" -ge "$((2*(2**40)))" ]; then
+  DSIZEOPT="-d size=2047g"
+fi
+
+_scratch_mkfs_xfs "-m crc=1,finobt=1 -d agcount=2 $DSIZEOPT" | _filter_mkfs 2>$seqres.full
 
 # sparsely populate the fs such that we create records with free inodes
 _scratch_mount
diff --git a/tests/xfs/013 b/tests/xfs/013
index 4d31d793..ee752de1 100755
--- a/tests/xfs/013
+++ b/tests/xfs/013
@@ -97,7 +97,14 @@ _require_command "$KILLALL_PROG" killall
 
 rm -f $seqres.full
 
-_scratch_mkfs_xfs "-m crc=1,finobt=1 -d agcount=2" | \
+# If 2 AGs would result in too-large AG size, restrict the size
+DSIZEOPT=""
+DEV_SZ=$(blockdev --getsize64 $SCRATCH_DEV)
+if [ "$DEV_SZ" -ge "$((2*(2**40)))" ]; then
+  DSIZEOPT="-d size=2047g"
+fi
+
+_scratch_mkfs_xfs "-m crc=1,finobt=1 -d agcount=2 $DSIZEOPT" | \
 	_filter_mkfs 2>> $seqres.full
 _scratch_mount
 
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
 
