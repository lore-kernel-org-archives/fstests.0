Received: from mx1.redhat.com ([209.132.183.28]:60408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751603AbdCHMBr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 8 Mar 2017 07:01:47 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E69D380F94
        for <fstests@vger.kernel.org>; Wed,  8 Mar 2017 11:54:17 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] ext4/308: add the missing _supported_fs
Date: Wed,  8 Mar 2017 19:54:10 +0800
Message-Id: <20170308115410.11346-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

There's no supported fs check in this test, it will run on all
filesystems. Let's add it back.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/ext4/308 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/ext4/308 b/tests/ext4/308
index 74bfc1b..4a811af 100755
--- a/tests/ext4/308
+++ b/tests/ext4/308
@@ -43,6 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
+_supported_fs ext4
 _require_scratch
 _require_defrag
 _require_xfs_io_command "falloc"
-- 
2.9.3

