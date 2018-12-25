Received: from mx1.redhat.com ([209.132.183.28]:36862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbeLYI4l (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 Dec 2018 03:56:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F95036807
        for <fstests@vger.kernel.org>; Tue, 25 Dec 2018 08:56:41 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.13.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A7E9101963A
        for <fstests@vger.kernel.org>; Tue, 25 Dec 2018 08:56:40 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH 2/2] xfs/068: new fsstress operation breaks xfsrestore output
Date: Tue, 25 Dec 2018 16:56:32 +0800
Message-Id: <20181225085632.9875-2-zlang@redhat.com>
In-Reply-To: <20181225085632.9875-1-zlang@redhat.com>
References: <20181225085632.9875-1-zlang@redhat.com>
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
