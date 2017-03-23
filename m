Received: from mx1.redhat.com ([209.132.183.28]:42010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751995AbdCWILD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 23 Mar 2017 04:11:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FE63C049D59
        for <fstests@vger.kernel.org>; Thu, 23 Mar 2017 08:10:34 +0000 (UTC)
Received: from dhcp-12-168.nay.redhat.com (dhcp-12-168.nay.redhat.com [10.66.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB362785C1
        for <fstests@vger.kernel.org>; Thu, 23 Mar 2017 08:10:33 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v8 2/2] xfs/068: update golden output due to new operations in fsstress
Date: Thu, 23 Mar 2017 16:10:27 +0800
Message-Id: <1490256627-32034-2-git-send-email-zlang@redhat.com>
In-Reply-To: <1490256627-32034-1-git-send-email-zlang@redhat.com>
References: <1490256627-32034-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

xfs/068 use a fixed seed (-s) and number of operations (-n) to run
fsstress, to get fixed number of files and directories. But new
operations of fsstress will break this "fixed number". So update
it, after fsstress get new operations.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/068     | 2 --
 tests/xfs/068.out | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/xfs/068 b/tests/xfs/068
index 4dac95e..7151e28 100755
--- a/tests/xfs/068
+++ b/tests/xfs/068
@@ -43,8 +43,6 @@ trap "rm -rf $tmp.*; exit \$status" 0 1 2 3 15
 _supported_fs xfs
 _supported_os Linux
=20
-# need to ensure new fsstress operations don't perturb expected output
-FSSTRESS_AVOID=3D"-f insert=3D0 $FSSTRESS_AVOID"
 _create_dumpdir_stress_num 4096
 _do_dump_restore
=20
diff --git a/tests/xfs/068.out b/tests/xfs/068.out
index 2196eee..b20604f 100644
--- a/tests/xfs/068.out
+++ b/tests/xfs/068.out
@@ -22,7 +22,7 @@ xfsrestore: session id: ID
 xfsrestore: media ID: ID
 xfsrestore: searching media for directory dump
 xfsrestore: reading directories
-xfsrestore: 495 directories and 1593 entries processed
+xfsrestore: 474 directories and 1592 entries processed
 xfsrestore: directory post-processing
 xfsrestore: restoring non-directory files
 xfsrestore: restore complete: SECS seconds elapsed
--=20
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3D_2r65LqNtlb6k2CII-boNlegEnQZJ80LPgaIfTDWUEc&s=3DY6Yulw2mWSpWxd0qQw6eY5_P=
qYFsy8JKy9IySo-meB4&e=3D=20
