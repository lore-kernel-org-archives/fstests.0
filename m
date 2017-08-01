Received: from mail-qk0-f193.google.com ([209.85.220.193]:38440 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdHAEzg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Aug 2017 00:55:36 -0400
Received: by mail-qk0-f193.google.com with SMTP id m84so541920qki.5
        for <fstests@vger.kernel.org>; Mon, 31 Jul 2017 21:55:35 -0700 (PDT)
Date: Tue, 1 Aug 2017 01:55:31 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Subject: [PATCH] generic/449: make the test effective against xfs
Message-ID: <20170801045528.GA4696@debian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
List-ID: <fstests@vger.kernel.org>

Setting acls on an xfs filesystem will succeed even after running out
of space for user attributes. Use trusted attributes instead.

Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.com=
>
---
 tests/generic/449 | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tests/generic/449 b/tests/generic/449
index fb776b3..6fbc634 100755
--- a/tests/generic/449
+++ b/tests/generic/449
@@ -59,6 +59,15 @@ _require_attrs
 _scratch_mkfs_sized $((50 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount || _fail "mount failed"
=20
+if [ "$FSTYP" =3D=3D "xfs" ]; then
+	# xfs takes too long to run out of space if setting only the names
+	# of the attributes. Create a 5k file filled with dots to be used
+	# as their value.
+	VFILE=3D$SCRATCH_MNT/valuefile
+	touch $VFILE
+	$XFS_IO_PROG -c "pwrite -S 0x2E 0 5k" $VFILE >>$seqres.full 2>&1
+fi
+
 TFILE=3D$SCRATCH_MNT/testfile.$seq
=20
 # Create the test file and choose its permissions
@@ -70,6 +79,13 @@ chmod go-rwx $TFILE
 $XFS_IO_PROG -c "pwrite 0 50m" $TFILE >>$seqres.full 2>&1
 i=3D1
 j=3D1
+ATTR_TYPE=3Duser
+if [ "$FSTYP" =3D=3D "xfs" ]; then
+	ATTR_TYPE=3Dtrusted
+	while $SETFATTR_PROG -n $ATTR_TYPE.$i -v $(cat $VFILE) $TFILE &>/dev/nu=
ll; do
+		((++i))
+	done
+fi
 ret=3D0
 while [ $ret -eq 0 ]; do
 	ret=3D1
@@ -77,7 +93,7 @@ while [ $ret -eq 0 ]; do
 		# On btrfs, setfattr will sometimes fail when free space is
 		# low, long before it's actually exhausted. Insist until it
 		# fails consistently.
-		$SETFATTR_PROG -n user.$i"x"$j $TFILE &>/dev/null
+		$SETFATTR_PROG -n $ATTR_TYPE.$i"x"$j $TFILE &>/dev/null
 		ret=3D$(( $ret && $? ))
 		((++j))
 	done
--=20
2.1.4

