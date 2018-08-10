Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725744AbeHJFyc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 10 Aug 2018 01:54:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46E0040241C7
        for <fstests@vger.kernel.org>; Fri, 10 Aug 2018 03:26:38 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-26.pek2.redhat.com [10.72.12.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E72E2026D65
        for <fstests@vger.kernel.org>; Fri, 10 Aug 2018 03:26:36 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3] xfs/288: notrun if xfs_db write command fails
Date: Fri, 10 Aug 2018 11:26:32 +0800
Message-Id: <20180810032632.9558-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Old xfsprogs can't change attr hdr.count to 0 on v5 filesystems, two
reasons maybe cause this issue:

1) This commit has been merged: 89baf918(xfs_db: write values into
   dir/attr blocks and recalculate CRCs).
2) xfs_db write command doesn't support -d option.

That's not a real bug, so skip this test if xfs_db can't set attr
hdr.count to 0.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

V2 tried to bring in a common function named _require_xfs_db_write_da():
https://marc.info/?l=linux-xfs&m=153301569124126&w=2

But by talking with #xfs channel, I drop that common function, only change
in xfs/288 inside now.

Thanks,
Zorro

 tests/xfs/288 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/xfs/288 b/tests/xfs/288
index f4165b6c..c6821909 100755
--- a/tests/xfs/288
+++ b/tests/xfs/288
@@ -59,6 +59,14 @@ _scratch_unmount
 _scratch_xfs_set_metadata_field "hdr.count" "0" \
 				"inode $inum" "ablock 0" >> $seqres.full
 
+# verify current xfs_db write command can set hdr.count to 0. Old xfsprogs
+# can't do that on v5 filesystems.
+count=$(_scratch_xfs_get_metadata_field "hdr.count" \
+					"inode $inum" "ablock 0")
+if [ "$count" != "0" ]; then
+	_notrun "xfs_db can't set attr hdr.count to 0"
+fi
+
 # make sure xfs_repair can find above corruption. If it can't, that
 # means we need to fix this bug on current xfs_repair
 _scratch_xfs_repair -n >> $seqres.full 2>&1
-- 
2.14.4
