Received: from mx1.redhat.com ([209.132.183.28]:43584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751546AbdFPQLh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 16 Jun 2017 12:11:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 570E8C0467CB
        for <fstests@vger.kernel.org>; Fri, 16 Jun 2017 16:11:37 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-139.pek2.redhat.com [10.72.12.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62ADB8E240
        for <fstests@vger.kernel.org>; Fri, 16 Jun 2017 16:11:36 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH 4/4] xfs/068: update golden output due to new operations in fsstress
Date: Sat, 17 Jun 2017 00:11:06 +0800
Message-Id: <1497629466-22647-4-git-send-email-zlang@redhat.com>
In-Reply-To: <1497629466-22647-1-git-send-email-zlang@redhat.com>
References: <1497629466-22647-1-git-send-email-zlang@redhat.com>
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
index b20604f..37c75bf 100644
--- a/tests/xfs/068.out
+++ b/tests/xfs/068.out
@@ -22,7 +22,7 @@ xfsrestore: session id: ID
 xfsrestore: media ID: ID
 xfsrestore: searching media for directory dump
 xfsrestore: reading directories
-xfsrestore: 474 directories and 1592 entries processed
+xfsrestore: 413 directories and 1347 entries processed
 xfsrestore: directory post-processing
 xfsrestore: restoring non-directory files
 xfsrestore: restore complete: SECS seconds elapsed
-- 
2.7.4

