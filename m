Received: from mx1.redhat.com ([209.132.183.28]:35482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751191AbdBWDRJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 22 Feb 2017 22:17:09 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62D1CC049D5D
        for <fstests@vger.kernel.org>; Thu, 23 Feb 2017 03:08:28 +0000 (UTC)
Received: from dhcp12-154.nay.redhat.com (dhcp12-154.nay.redhat.com [10.66.12.154] (may be forged))
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v1N38QSm013952
        for <fstests@vger.kernel.org>; Wed, 22 Feb 2017 22:08:27 -0500
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] generic/095: fix duplicate variable name
Date: Thu, 23 Feb 2017 11:08:21 +0800
Message-Id: <1487819301-7401-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

I think this definitely isn't what we want:
  local warn4="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_aio_read.*"
  local warn4="WARNING:.*fs/iomap\.c:.*iomap_dio_rw.*"

The second warn4 will overlay the first one. So change the second
to warn5.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/generic/095 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/095 b/tests/generic/095
index 991baef..d837564 100755
--- a/tests/generic/095
+++ b/tests/generic/095
@@ -128,12 +128,12 @@ filter_xfs_dmesg()
 	local warn2="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_read.*"
 	local warn3="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_read_iter.*"
 	local warn4="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_aio_read.*"
-	local warn4="WARNING:.*fs/iomap\.c:.*iomap_dio_rw.*"
+	local warn5="WARNING:.*fs/iomap\.c:.*iomap_dio_rw.*"
 	sed -e "s#$warn1#Intentional warnings in xfs_file_dio_aio_write#" \
 	    -e "s#$warn2#Intentional warnings in xfs_file_dio_aio_read#" \
 	    -e "s#$warn3#Intentional warnings in xfs_file_read_iter#" \
 	    -e "s#$warn4#Intentional warnings in xfs_file_aio_read#" \
-	    -e "s#$warn4#Intentional warnings in iomap_dio_rw#"
+	    -e "s#$warn5#Intentional warnings in iomap_dio_rw#"
 }
 
 # umount before checking dmesg in case umount triggers any WARNING or Oops
-- 
2.7.4

