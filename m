Received: from mx1.redhat.com ([209.132.183.28]:58190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753902AbcHZOpf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 26 Aug 2016 10:45:35 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 947E6155DE
        for <fstests@vger.kernel.org>; Fri, 26 Aug 2016 14:45:33 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] generic/095: add xfs_file_aio_read into warning whitelist
Date: Fri, 26 Aug 2016 22:45:30 +0800
Message-Id: <1472222730-13624-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

Current generic/095 warning whitelist include:
"xfs_file_dio_aio_read" and "xfs_file_read_iter"

But from the history we can see:
1) xfs_file_dio_aio_read() was splited from xfs_file_read_iter() by
below commit:

  bbc5a74 xfs: split xfs_file_read_iter into buffered and direct I/O helpers

2) xfs_file_read_iter() came from xfs_file_aio_read() as below
commit:

  b4f5d2c xfs: switch to ->read_iter()

Some Linux distro (e.g: RHEL-7) still use the old kernel with old
function xfs_file_aio_read().

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/generic/095 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/generic/095 b/tests/generic/095
index 4754992..474825b 100755
--- a/tests/generic/095
+++ b/tests/generic/095
@@ -127,9 +127,11 @@ filter_xfs_dmesg()
 	local warn1="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_write.*"
 	local warn2="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_read.*"
 	local warn3="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_read_iter.*"
+	local warn4="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_aio_read.*"
 	sed -e "s#$warn1#Intentional warnings in xfs_file_dio_aio_write#" \
 	    -e "s#$warn2#Intentional warnings in xfs_file_dio_aio_read#" \
-	    -e "s#$warn3#Intentional warnings in xfs_file_read_iter#"
+	    -e "s#$warn3#Intentional warnings in xfs_file_read_iter#" \
+	    -e "s#$warn4#Intentional warnings in xfs_file_aio_read#"
 }
 
 # umount before checking dmesg in case umount triggers any WARNING or Oops
-- 
2.7.4

