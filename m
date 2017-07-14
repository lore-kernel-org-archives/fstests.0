Received: from mail-qk0-f195.google.com ([209.85.220.195]:35599 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdGNWGY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Jul 2017 18:06:24 -0400
Received: by mail-qk0-f195.google.com with SMTP id c18so3671303qkb.2
        for <fstests@vger.kernel.org>; Fri, 14 Jul 2017 15:06:24 -0700 (PDT)
Date: Fri, 14 Jul 2017 19:06:19 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Subject: [xfstests PATCH] common/rc: support jfs in _scratch_mkfs_sized
Message-ID: <20170714220616.GA3975@debian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
This change in common/rc is different from the one sent as part of
generic/447, which was not working as intended. I will soon send a revisi=
on
of that patch as well.

 common/rc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/rc b/common/rc
index b505365..5cb6b0c 100644
--- a/common/rc
+++ b/common/rc
@@ -1023,6 +1023,8 @@ _scratch_mkfs_sized()
     ext2|ext3|ext4|ext4dev|udf|btrfs|reiser4|ocfs2)
 	def_blksz=3D`echo $MKFS_OPTIONS| sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
 	;;
+    jfs)
+	def_blksz=3D4096
     esac
=20
     [ -n "$def_blksz" ] && blocksize=3D$def_blksz
@@ -1068,6 +1070,9 @@ _scratch_mkfs_sized()
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

