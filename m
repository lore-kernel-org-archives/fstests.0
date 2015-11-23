Received: from cn.fujitsu.com ([59.151.112.132]:41384 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753842AbbKWJ5t (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 23 Nov 2015 04:57:49 -0500
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain [127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id tAN9v2b2006028
	for <fstests@vger.kernel.org>; Mon, 23 Nov 2015 17:57:02 +0800
From: Zhaolei <zhaolei@cn.fujitsu.com>
Subject: [PATCH] fstests: Update generic/077 for newest version of btrfs progs
Date: Mon, 23 Nov 2015 17:55:58 +0800
Message-ID: <22cee31ea262eb30d3243bcd5bc05dcfe16a9440.1448272550.git.zhaolei@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zhao Lei <zhaolei@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Zhao Lei <zhaolei@cn.fujitsu.com>

generic/077 fails on btrfs progs v4.3:
 # ./check generic/077
 FSTYP         -- btrfs
 PLATFORM      -- Linux/x86_64 lenovo 4.4.0-rc2_HEAD_1ec218373b8ebda821aec00bb156a9c94fad9cd4_
 MKFS_OPTIONS  -- /dev/sdb6
 MOUNT_OPTIONS -- /dev/sdb6 /var/ltf/tester/scratch_mnt

 generic/077 344s ... [failed, exit status 1] - output mismatch (see /var/lib/xfstests/results//generic/077.out.bad)
     --- tests/generic/077.out   2015-11-23 17:06:27.144983112 +0800
     +++ /var/lib/xfstests/results//generic/077.out.bad  2015-11-23 17:41:25.187062895 +0800
     @@ -1,7 +1,5 @@
      QA output created by 077
      *** create filesystem
     -*** set default ACL
     -*** populate filesystem, pass #1
     -*** populate filesystem, pass #2
     -*** all done
     +mkfs failed
     +(see /var/lib/xfstests/results//generic/077.full for details)
      *** unmount
 Ran: generic/077
 Failures: generic/077
 Failed 1 of 1 tests

Reason:
 btrfs progs v4.3 use non-mixed blockgroup for small volume as default,
 it need at least 100M to build a filesystem.

Fix:
 We can force mixed block group for btrfs, or increase filesystem
 size to btrfs's least requirement to make test works, the first
 way create a non-common filesystem in btrfs case, so this patch
 use the second way.

Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 tests/generic/077 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/077 b/tests/generic/077
index 8405b02..c646997 100755
--- a/tests/generic/077
+++ b/tests/generic/077
@@ -65,7 +65,7 @@ rm -f $seqres.full
 umount $SCRATCH_DEV >/dev/null 2>&1
 echo "*** MKFS ***"                         >>$seqres.full
 echo ""                                     >>$seqres.full
-SIZE=`expr 50 \* 1024 \* 1024`
+SIZE=`expr 100 \* 1024 \* 1024`
 _scratch_mkfs_sized $SIZE                   >>$seqres.full 2>&1 \
 	|| _fail "mkfs failed"
 _scratch_mount                              >>$seqres.full 2>&1 \
-- 
1.8.5.1

