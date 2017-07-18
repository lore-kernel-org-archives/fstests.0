Received: from mx1.redhat.com ([209.132.183.28]:33658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbdGROha (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 18 Jul 2017 10:37:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C5FB356D8
        for <fstests@vger.kernel.org>; Tue, 18 Jul 2017 14:37:30 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8863477DF1
        for <fstests@vger.kernel.org>; Tue, 18 Jul 2017 14:37:29 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2 3/3] xfs/068: update golden output due to new operations in fsstress
Date: Tue, 18 Jul 2017 22:37:14 +0800
Message-Id: <20170718143714.11359-3-zlang@redhat.com>
In-Reply-To: <20170718143714.11359-1-zlang@redhat.com>
References: <20170718143714.11359-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

I added some new operatoins to fsstress, and it changed the total
number of test operstions.

xfs/068 use a fixed seed (-s) and number of operations (-n) to run
fsstress, to get fixed number of files and directories. Due to my
patches break these fixed things, so update its expected result
in golden image.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/068.out | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/068.out b/tests/xfs/068.out
index b20604f7..fa3a5523 100644
--- a/tests/xfs/068.out
+++ b/tests/xfs/068.out
@@ -22,7 +22,7 @@ xfsrestore: session id: ID
 xfsrestore: media ID: ID
 xfsrestore: searching media for directory dump
 xfsrestore: reading directories
-xfsrestore: 474 directories and 1592 entries processed
+xfsrestore: 383 directories and 1335 entries processed
 xfsrestore: directory post-processing
 xfsrestore: restoring non-directory files
 xfsrestore: restore complete: SECS seconds elapsed
-- 
2.13.3

