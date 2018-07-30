Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726481AbeG3JPv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 30 Jul 2018 05:15:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 782744001388
        for <fstests@vger.kernel.org>; Mon, 30 Jul 2018 07:42:10 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-115.pek2.redhat.com [10.72.12.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AB8E10C1E
        for <fstests@vger.kernel.org>; Mon, 30 Jul 2018 07:42:07 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs/288: _notrun if xfs_db write doesn't support -d option
Date: Mon, 30 Jul 2018 15:42:02 +0800
Message-Id: <20180730074202.26450-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Commit b3cf8b72334fd35ef961869506e5a72ab398bc82 help xfs/288 to
support v5 filesystems testing, but there're still some old
distributions don't support xfs_db 'write -d' usage. Then this
case fails on them.

For compatible with older versions, skip this test on v5 xfs
if xfs_db write command doesn't support -d option.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/288 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/xfs/288 b/tests/xfs/288
index bccdb6fc..f8e117ed 100755
--- a/tests/xfs/288
+++ b/tests/xfs/288
@@ -40,6 +40,14 @@ _require_attrs
 _scratch_mkfs_xfs 2>/dev/null | _filter_mkfs 2>$tmp.mkfs >/dev/null
 . $tmp.mkfs
 
+# Require write -d option to write invalid data into V5 filesystem
+if [ $_fs_has_crcs -eq 1 ]; then
+	_scratch_xfs_db -x -c "help write" | egrep -q "(-d)"
+	if [ $? -ne 0 ]; then
+		_notrun "xfs_db write doesn't support -d option"
+	fi
+fi
+
 _scratch_mount
 
 touch $SCRATCH_MNT/$seq.attrfile
-- 
2.14.4

