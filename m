Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35969 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933645AbaGPQxi (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 16 Jul 2014 12:53:38 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6GGrcJF026236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <fstests@vger.kernel.org>; Wed, 16 Jul 2014 12:53:38 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 2/2] shared/006: use _get_free_inode helper
Date: Thu, 17 Jul 2014 00:53:19 +0800
Message-Id: <1405529599-31281-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Use _get_free_inode helper to get free inode count.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/shared/006 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/shared/006 b/tests/shared/006
index 445c35d..f7240c1 100755
--- a/tests/shared/006
+++ b/tests/shared/006
@@ -69,7 +69,7 @@ _scratch_mkfs_sized $((1024 * 1024 * 1024)) >>$seqres.full 2>&1
 _scratch_mount
 
 i=0
-free_inode=`$DF_PROG -i $SCRATCH_MNT | tail -1 | awk '{print $3}'`
+free_inode=`_get_free_inode $SCRATCH_MNT`
 file_per_dir=1000
 loop=$((free_inode / file_per_dir + 1))
 mkdir -p $SCRATCH_MNT/testdir
-- 
1.9.3

