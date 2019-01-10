Received: from mx1.redhat.com ([209.132.183.28]:42614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfAJIZ0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 10 Jan 2019 03:25:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51E477BDDE
        for <fstests@vger.kernel.org>; Thu, 10 Jan 2019 08:25:26 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.13.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6850B81644
        for <fstests@vger.kernel.org>; Thu, 10 Jan 2019 08:25:25 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2 2/2] xfs/068: new fsstress operation breaks xfsrestore output
Date: Thu, 10 Jan 2019 16:25:16 +0800
Message-Id: <20190110082516.22526-2-zlang@redhat.com>
In-Reply-To: <20190110082516.22526-1-zlang@redhat.com>
References: <20190110082516.22526-1-zlang@redhat.com>
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
