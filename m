Received: from mx1.redhat.com ([209.132.183.28]:38680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfC0HpQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Mar 2019 03:45:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2FFAD309267E
        for <fstests@vger.kernel.org>; Wed, 27 Mar 2019 07:45:16 +0000 (UTC)
Received: from dhcp-12-125.nay.redhat.com (dhcp-12-125.nay.redhat.com [10.66.12.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5520917586
        for <fstests@vger.kernel.org>; Wed, 27 Mar 2019 07:45:15 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs/065: make sure SCRATCH_DEV is unmount before mkfs
Date: Wed, 27 Mar 2019 15:45:09 +0800
Message-Id: <20190327074509.27770-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Commit "8309b39a fstests: fix broken _require_scratch usage" did
below change on xfs/065:

  -_scratch_unmount 2>/dev/null
  +_scratch_mkfs_xfs >> $seqres.full

It cause xfs/065 always fails now, as:
  QA output created by 065
  mkfs.xfs: /dev/sdb2 contains a mounted filesystem
  ...

So use _require_scratch, to make sure the SCRATCH_DEV is unmounted
before mkfs.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/065 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/xfs/065 b/tests/xfs/065
index c0d1ee93..f09bd947 100755
--- a/tests/xfs/065
+++ b/tests/xfs/065
@@ -50,6 +50,7 @@ _list_dir()
 # real QA test starts here
 _supported_fs xfs
 _supported_os Linux
+_require_scratch
 
 #
 # too much hassle to get output matching with quotas turned on
-- 
2.17.2
