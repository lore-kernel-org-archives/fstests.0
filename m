Received: from mx1.redhat.com ([209.132.183.28]:59100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751110AbdCPHGm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 16 Mar 2017 03:06:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC8E0C0092D3
        for <fstests@vger.kernel.org>; Thu, 16 Mar 2017 07:06:42 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic/417: reduce extend attribute size
Date: Thu, 16 Mar 2017 15:06:37 +0800
Message-Id: <20170316070637.6489-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

xattr size 1024 is too big for 1k block size ext3/4 filesystem, so
test fails due to ENSPC message from multi_open_unlink when setting
xattr.

Reduce the xattr size to 512 so it fits in 1k block size ext3/4.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/417 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/417 b/tests/generic/417
index 45d63f5..690ceb5 100755
--- a/tests/generic/417
+++ b/tests/generic/417
@@ -61,7 +61,7 @@ function create_dirty_orphans() {
 
 	num_files=200
 	num_eas=1
-	ea_val_size=1024
+	ea_val_size=512
 
 	# sleep for ages and we will kill this pid when we are ready
 	delay=100
-- 
2.9.3

