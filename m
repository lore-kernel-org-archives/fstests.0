Received: from mail-qk0-f195.google.com ([209.85.220.195]:37619 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbdHBETi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Aug 2017 00:19:38 -0400
Received: by mail-qk0-f195.google.com with SMTP id x77so3538657qka.4
        for <fstests@vger.kernel.org>; Tue, 01 Aug 2017 21:19:38 -0700 (PDT)
Date: Wed, 2 Aug 2017 01:19:34 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Subject: [PATCH v2] generic/449: make the test effective against xfs
Message-ID: <20170802041933.GB7310@debian.home>
References: <20170801045528.GA4696@debian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170801045528.GA4696@debian.home>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Setting acls on an xfs filesystem will succeed even after running out
of space for user attributes. Use trusted attributes instead. Also speed
up the test by setting large values for the attributes.

Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.com=
>
---
Changes in v2:
  - The check for xfs actually worked for all filesystems, as Eryu Guan
    noticed. So the test is now much more straightforward.

 tests/generic/449 | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/generic/449 b/tests/generic/449
index fb776b3..f5aad22 100755
--- a/tests/generic/449
+++ b/tests/generic/449
@@ -66,9 +66,17 @@ touch $TFILE
 chmod u+rwx $TFILE
 chmod go-rwx $TFILE
=20
+# The content of this file will be used as the value of the attributes
+VFILE=3D$SCRATCH_MNT/valuefile
+touch $VFILE
+$XFS_IO_PROG -c "pwrite -S 0x2E 0 1k" $VFILE >>$seqres.full 2>&1
+
 # Try to run out of space so setfacl will fail
 $XFS_IO_PROG -c "pwrite 0 50m" $TFILE >>$seqres.full 2>&1
 i=3D1
+while $SETFATTR_PROG -n trusted.$i -v $(cat $VFILE) $TFILE &>/dev/null; =
do
+	((++i))
+done
 j=3D1
 ret=3D0
 while [ $ret -eq 0 ]; do
@@ -77,7 +85,7 @@ while [ $ret -eq 0 ]; do
 		# On btrfs, setfattr will sometimes fail when free space is
 		# low, long before it's actually exhausted. Insist until it
 		# fails consistently.
-		$SETFATTR_PROG -n user.$i"x"$j $TFILE &>/dev/null
+		$SETFATTR_PROG -n trusted.$i"x"$j $TFILE &>/dev/null
 		ret=3D$(( $ret && $? ))
 		((++j))
 	done
--=20
2.1.4


