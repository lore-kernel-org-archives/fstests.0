Received: from mx1.redhat.com ([209.132.183.28]:41792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729963AbfASCnH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 18 Jan 2019 21:43:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53F04C04959F
        for <fstests@vger.kernel.org>; Sat, 19 Jan 2019 02:43:07 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-40.pek2.redhat.com [10.72.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62387600C2
        for <fstests@vger.kernel.org>; Sat, 19 Jan 2019 02:43:06 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3 2/2] xfs/068: new fsstress operation breaks xfsrestore output
Date: Sat, 19 Jan 2019 10:42:58 +0800
Message-Id: <20190119024258.6864-2-zlang@redhat.com>
In-Reply-To: <20190119024258.6864-1-zlang@redhat.com>
References: <20190119024258.6864-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

After fsstress has new operation, xfs/068 has different dump output,
so change the expected number of files and directories.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/068.out | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/068.out b/tests/xfs/068.out
index fa3a5523..f9ec37b8 100644
--- a/tests/xfs/068.out
+++ b/tests/xfs/068.out
@@ -22,7 +22,7 @@ xfsrestore: session id: ID
 xfsrestore: media ID: ID
 xfsrestore: searching media for directory dump
 xfsrestore: reading directories
-xfsrestore: 383 directories and 1335 entries processed
+xfsrestore: 416 directories and 1373 entries processed
 xfsrestore: directory post-processing
 xfsrestore: restoring non-directory files
 xfsrestore: restore complete: SECS seconds elapsed
-- 
2.17.2
