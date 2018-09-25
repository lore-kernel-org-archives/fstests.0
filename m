Received: from mx1.redhat.com ([209.132.183.28]:43432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbeIZAZA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 Sep 2018 20:25:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26BF9811A9
        for <fstests@vger.kernel.org>; Tue, 25 Sep 2018 18:16:17 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E8A60106A796
        for <fstests@vger.kernel.org>; Tue, 25 Sep 2018 18:16:16 +0000 (UTC)
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] xfs/270: allow corrupted xfs_db write
Message-ID: <a2a62573-efd2-f3f6-b986-029bb691372d@redhat.com>
Date: Tue, 25 Sep 2018 13:16:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Upcoming verifiers treat the unknown ro_compat flag written via xfs_db
as corruption, so use the -d flag to allow it, and filter our the
resulting informational message.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/xfs/270 b/tests/xfs/270
index d5c8df19..da66bc33 100755
--- a/tests/xfs/270
+++ b/tests/xfs/270
@@ -44,7 +44,8 @@ _scratch_mkfs_xfs >>$seqres.full 2>&1
 # set the highest bit of features_ro_compat, use it as an unknown
 # feature bit. If one day this bit become known feature, please
 # change this case.
-$XFS_DB_PROG -x -c "sb 0" -c "write features_ro_compat $((2**31))" $SCRATCH_DEV
+$XFS_DB_PROG -x -c "sb 0" -c "write -d features_ro_compat $((2**31))" \
+	$SCRATCH_DEV | grep -v "Allowing write of corrupted data"
 
 # rw mount with unknown ro-compat feature should fail
 echo "rw mount test"
