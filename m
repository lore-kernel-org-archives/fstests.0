Received: from mail-qt0-f178.google.com ([209.85.216.178]:35330 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdGSFvz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Jul 2017 01:51:55 -0400
Received: by mail-qt0-f178.google.com with SMTP id b40so32943122qtb.2
        for <fstests@vger.kernel.org>; Tue, 18 Jul 2017 22:51:54 -0700 (PDT)
Date: Wed, 19 Jul 2017 02:51:50 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Subject: [xfstests PATCH v4] generic: add test of file mode when setfacl fails
Message-ID: <20170719055146.GA7249@debian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Eryu Guan <eguan@redhat.com>, Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
List-ID: <fstests@vger.kernel.org>

Check that the group permission bits of a file are not altered when setfa=
cl
fails. At the time of this patch the test fails for at least ext2, ext4,
jfs and btrfs.

The failure in setfacl is induced by filling the device and setting as
many user attributes to the file as possible. For xfs this is not enough,
and the test will not run.

Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.com=
>
---
Changes in v4:
  - Continue to set attributes even when the filesystem claims to be out =
of
    space. With this change the test will now fail for btrfs.
  - Call _notrun when setfacl succeeds, since no check can be done. As su=
ggested
    by Eryu Guan.=20
Changes in v3:
  - Several fixes requested by Eryu Guan (thank you for your review), mos=
t
    importantly:
    - Place the jfs support in a separate patch, already sent.
    - Make the test fail when the scratch device does not mount, so rootf=
s
      won't be filled.
    - Add the test to auto and quick groups.
Changes in v2:
  - Use the scratch dev instead of the test dev so we can make a small fs=
 and
    fill it faster. As suggested by Christoph Hellwig.
  - Make jfs work with _scratch_mkfs_sized, needed for the above.
  - Remove the mention to an issue with reiserfs, since I now believe the
    problem is on their side.

 tests/generic/449     | 98 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
 tests/generic/449.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 101 insertions(+)
 create mode 100755 tests/generic/449
 create mode 100644 tests/generic/449.out

diff --git a/tests/generic/449 b/tests/generic/449
new file mode 100755
index 0000000..7c7a3f8
--- /dev/null
+++ b/tests/generic/449
@@ -0,0 +1,98 @@
+#! /bin/bash
+# FS QA Test 449
+#
+# Fill the device and set as many extended attributes to a file as
+# possible. Then call setfacl on it and, if this fails for lack of
+# space, test that the permissions remain the same.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Ernesto A. Fernandez.  All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#-----------------------------------------------------------------------
+#
+
+seq=3D`basename $0`
+seqres=3D$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=3D`pwd`
+tmp=3D/tmp/$$
+status=3D1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/attr
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_test
+_require_acls
+_require_attrs
+
+_scratch_mkfs_sized $((50 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mount || _fail "mount failed"
+
+TFILE=3D$SCRATCH_MNT/testfile.$seq
+
+# Create the test file and choose its permissions
+touch $TFILE
+chmod u+rwx $TFILE
+chmod go-rwx $TFILE
+
+# Try to run out of space so setfacl will fail
+$XFS_IO_PROG -c "pwrite 0 50m" $TFILE >>$seqres.full 2>&1
+i=3D1
+j=3D1
+ret=3D0
+while [ $ret -eq 0 ]; do
+	ret=3D1
+	while [ $j -le 1000 ]; do
+		# On btrfs, setfattr will sometimes fail when free space is
+		# low, long before it's actually exhausted. Insist until it
+		# fails consistently.
+		setfattr -n user.$i"x"$j $TFILE &>/dev/null
+		ret=3D$(( $ret && $? ))
+		((++j))
+	done
+	j=3D1
+	((++i))
+done
+
+if setfacl -m m:r $TFILE &>/dev/null; then
+	# setfacl succeeded, so the test was meaningless
+	# The filesystem might still have an issue
+	_notrun "$FSTYP succeeds in setting acls despite running out of space f=
or user attrs"
+fi
+
+# Since setfacl failed, the permissions should not have changed
+stat -c %A $TFILE
+
+status=3D0
+exit
diff --git a/tests/generic/449.out b/tests/generic/449.out
new file mode 100644
index 0000000..95177ef
--- /dev/null
+++ b/tests/generic/449.out
@@ -0,0 +1,2 @@
+QA output created by 449
+-rwx------
diff --git a/tests/generic/group b/tests/generic/group
index e626820..c1dd505 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -451,3 +451,4 @@
 446 auto quick rw dangerous
 447 auto quick clone
 448 auto quick rw
+449 auto quick acl
--=20
2.1.4

