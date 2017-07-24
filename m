Received: from mail-qt0-f194.google.com ([209.85.216.194]:33116 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdGXECk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jul 2017 00:02:40 -0400
Received: by mail-qt0-f194.google.com with SMTP id n42so1472525qtn.0
        for <fstests@vger.kernel.org>; Sun, 23 Jul 2017 21:02:39 -0700 (PDT)
Date: Mon, 24 Jul 2017 01:02:35 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Subject: [xfstests PATCH] common/rc: support reiserfs in _scratch_mkfs_sized
Message-ID: <20170724040232.GA7309@debian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.com=
>
---
 common/rc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index c537ab4..d3c2286 100644
--- a/common/rc
+++ b/common/rc
@@ -1020,7 +1020,7 @@ _scratch_mkfs_sized()
     xfs)
 	def_blksz=3D`echo $MKFS_OPTIONS|sed -rn 's/.*-b ?size=3D ?+([0-9]+).*/\=
1/p'`
 	;;
-    ext2|ext3|ext4|ext4dev|udf|btrfs|reiser4|ocfs2)
+    ext2|ext3|ext4|ext4dev|udf|btrfs|reiser4|ocfs2|reiserfs)
 	def_blksz=3D`echo $MKFS_OPTIONS| sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
 	;;
     jfs)
@@ -1074,6 +1074,9 @@ _scratch_mkfs_sized()
     jfs)
 	${MKFS_PROG}.$FSTYP $MKFS_OPTIONS $SCRATCH_DEV $blocks
 	;;
+    reiserfs)
+	${MKFS_PROG}.$FSTYP $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
+	;;
     reiser4)
 	# mkfs.resier4 requires size in KB as input for creating filesystem
 	$MKFS_REISER4_PROG $MKFS_OPTIONS -y -b $blocksize $SCRATCH_DEV \
--=20
2.1.4

