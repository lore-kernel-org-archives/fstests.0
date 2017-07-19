Received: from mail-qt0-f194.google.com ([209.85.216.194]:33481 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdGSBhP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jul 2017 21:37:15 -0400
Received: by mail-qt0-f194.google.com with SMTP id 50so3436565qtz.0
        for <fstests@vger.kernel.org>; Tue, 18 Jul 2017 18:37:14 -0700 (PDT)
Date: Tue, 18 Jul 2017 22:37:10 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Subject: [xfstests PATCH v2] common/rc: support jfs in _scratch_mkfs_sized
Message-ID: <20170719013708.GA6047@debian.home>
References: <20170714220616.GA3975@debian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170714220616.GA3975@debian.home>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>, jfs-discussion@lists.sourceforge.net, Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
List-ID: <fstests@vger.kernel.org>

Add support for jfs in _scratch_mkfs_sized. Fix the block size in 4096,
which seems to be the only option in jfs_mkfs.

Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.com=
>
---
I'm sorry, it seems I dropped a double semicolon. It worked the same of c=
ourse,
but better to fix it.

 common/rc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/rc b/common/rc
index fa1314c..c537ab4 100644
--- a/common/rc
+++ b/common/rc
@@ -1023,6 +1023,9 @@ _scratch_mkfs_sized()
     ext2|ext3|ext4|ext4dev|udf|btrfs|reiser4|ocfs2)
 	def_blksz=3D`echo $MKFS_OPTIONS| sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
 	;;
+    jfs)
+	def_blksz=3D4096
+	;;
     esac
=20
     [ -n "$def_blksz" ] && blocksize=3D$def_blksz
@@ -1068,6 +1071,9 @@ _scratch_mkfs_sized()
 	(( fssize <=3D 100 * 1024 * 1024 )) && mixed_opt=3D'--mixed'
 	$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
 	;;
+    jfs)
+	${MKFS_PROG}.$FSTYP $MKFS_OPTIONS $SCRATCH_DEV $blocks
+	;;
     reiser4)
 	# mkfs.resier4 requires size in KB as input for creating filesystem
 	$MKFS_REISER4_PROG $MKFS_OPTIONS -y -b $blocksize $SCRATCH_DEV \
--=20
2.1.4


