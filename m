Received: from mx1.redhat.com ([209.132.183.28]:49758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfCDCuO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 3 Mar 2019 21:50:14 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96D3FC4EB1
        for <fstests@vger.kernel.org>; Mon,  4 Mar 2019 02:50:14 +0000 (UTC)
From: Murphy Zhou <xzhou@redhat.com>
Subject: [PATCH] generic/294: skip on NFS
Date: Mon,  4 Mar 2019 10:50:08 +0800
Message-Id: <20190304025008.11986-1-xzhou@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: bcodding@redhat.com, yieli@redhat.com, bxue@redhat.com, Murphy Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Because NFS handles this differently, returning different values.
Details:
http://people.redhat.com/bcodding/nfs/2016/10/07/nfs_xfstest_generic/#generic294

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 tests/generic/294 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/294 b/tests/generic/294
index b74579ac..f7e763a3 100755
--- a/tests/generic/294
+++ b/tests/generic/294
@@ -27,6 +27,7 @@ _cleanup()
 . ./common/filter
 
 # real QA test starts here
+[ $FSTYP == "nfs" ] && _notrun "NFS behaves differently, breaks golden output"
 
 # Modify as appropriate.
 _supported_fs generic
-- 
2.21.0
