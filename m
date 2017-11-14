Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:57735 "EHLO
        mgwkm02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdKNBKi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Nov 2017 20:10:38 -0500
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
        by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 82367AC01D0
        for <fstests@vger.kernel.org>; Tue, 14 Nov 2017 10:10:21 +0900 (JST)
Received: from g01jpexchkw35.g01.fujitsu.local (unknown [10.0.193.4])
        by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id A76F3BD66EC
        for <fstests@vger.kernel.org>; Tue, 14 Nov 2017 10:10:20 +0900 (JST)
Subject: [PATCH 1/1] overlay/035: small fix for newer util-linux
From: "Misono, Tomohiro" <misono.tomohiro@jp.fujitsu.com>
References: <7a255645-5148-cd45-c0f7-1645982ca4e9@jp.fujitsu.com>
Message-ID: <8389cef1-9d9b-a9f2-e5b7-e409e42e2df3@jp.fujitsu.com>
Date: Tue, 14 Nov 2017 10:10:17 +0900
MIME-Version: 1.0
In-Reply-To: <7a255645-5148-cd45-c0f7-1645982ca4e9@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Modify filter in order make the test run correctly for
both old (2.29) and new (2.30) util-linux.

Signed-off-by: Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>
---
 tests/overlay/035 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/overlay/035 b/tests/overlay/035
index 64fcd708..6f1627c6 100755
--- a/tests/overlay/035
+++ b/tests/overlay/035
@@ -69,7 +69,8 @@ mkdir -p $lowerdir1 $lowerdir2 $upperdir $workdir
 $MOUNT_PROG -t overlay -o"lowerdir=$lowerdir2:$lowerdir1" \
 			$OVL_BASE_SCRATCH_MNT $SCRATCH_MNT
 touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
-_scratch_remount rw 2>&1 | _filter_scratch
+_scratch_remount rw 2>&1 | _filter_scratch \
+	| sed -e "s,SCRATCH_MNT: ,," | sed -e "s,\.$,,"
 $UMOUNT_PROG $SCRATCH_MNT
 
 # Make workdir immutable to prevent workdir re-create on mount
@@ -79,7 +80,8 @@ $CHATTR_PROG +i $workdir
 # Verify that overlay is mounted read-only and that it cannot be remounted rw.
 _overlay_scratch_mount_dirs $lowerdir2 $upperdir $workdir
 touch $SCRATCH_MNT/bar 2>&1 | _filter_scratch
-_scratch_remount rw 2>&1 | _filter_scratch
+_scratch_remount rw 2>&1 | _filter_scratch \
+	| sed -e "s,SCRATCH_MNT: ,," | sed -e "s,\.$,,"
 
 # success, all done
 status=0
-- 
2.13.6

