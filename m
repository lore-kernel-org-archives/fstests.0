Received: from mx1.redhat.com ([209.132.183.28]:42942 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbcEaUS5 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 31 May 2016 16:18:57 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1169C00B8E6
	for <fstests@vger.kernel.org>; Tue, 31 May 2016 20:18:56 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v6 1/3] generic/352-360: Add richacl tests
Date: Tue, 31 May 2016 22:18:49 +0200
Message-Id: <1464725931-27588-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 common/rc             |  61 ++++++++++++++++++++++
 tests/generic/352     | 122 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/352.out |  94 +++++++++++++++++++++++++++++++++
 tests/generic/353     | 114 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/353.out | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/354     |  95 ++++++++++++++++++++++++++++++++++
 tests/generic/354.out |  39 ++++++++++++++
 tests/generic/355     |  83 ++++++++++++++++++++++++++++++
 tests/generic/355.out |   9 ++++
 tests/generic/356     |  82 +++++++++++++++++++++++++++++
 tests/generic/356.out |  11 ++++
 tests/generic/357     |  81 +++++++++++++++++++++++++++++
 tests/generic/357.out |  11 ++++
 tests/generic/358     |  81 +++++++++++++++++++++++++++++
 tests/generic/358.out |   7 +++
 tests/generic/359     | 122 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/359.out |  24 +++++++++
 tests/generic/360     |  86 +++++++++++++++++++++++++++++++
 tests/generic/360.out |  19 +++++++
 tests/generic/group   |   9 ++++
 20 files changed, 1290 insertions(+)
 create mode 100755 tests/generic/352
 create mode 100644 tests/generic/352.out
 create mode 100755 tests/generic/353
 create mode 100644 tests/generic/353.out
 create mode 100755 tests/generic/354
 create mode 100644 tests/generic/354.out
 create mode 100755 tests/generic/355
 create mode 100644 tests/generic/355.out
 create mode 100755 tests/generic/356
 create mode 100644 tests/generic/356.out
 create mode 100755 tests/generic/357
 create mode 100644 tests/generic/357.out
 create mode 100755 tests/generic/358
 create mode 100644 tests/generic/358.out
 create mode 100755 tests/generic/359
 create mode 100644 tests/generic/359.out
 create mode 100755 tests/generic/360
 create mode 100644 tests/generic/360.out

diff --git a/common/rc b/common/rc
index 51092a0..ab7d54d 100644
--- a/common/rc
+++ b/common/rc
@@ -1989,6 +1989,67 @@ _require_seek_data_hole()
         _notrun "File system does not support llseek(2) SEEK_DATA/HOLE"
 }
 
+_require_runas()
+{
+	[ -x "$here/src/runas" ] \
+		|| _notrun "$here/src/runas executable not found"
+}
+
+runas()
+{
+	"$here/src/runas" "$@"
+}
+
+_require_richacl_prog()
+{
+	GETRICHACL_PROG=`set_prog_path getrichacl`
+	_require_command "$GETRICHACL_PROG" getrichacl
+	SETRICHACL_PROG=`set_prog_path setrichacl`
+	_require_command "$SETRICHACL_PROG" setrichacl
+}
+
+_require_scratch_richacl_xfs()
+{
+	_scratch_mkfs_xfs_supported -m richacl=1 >/dev/null 2>&1 \
+		|| _notrun "mkfs.xfs doesn't have richacl feature"
+	_scratch_mkfs_xfs -m richacl=1 >/dev/null 2>&1
+	_scratch_mount >/dev/null 2>&1 \
+		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
+	_scratch_unmount
+}
+
+_require_scratch_richacl_ext4()
+{
+	_scratch_mkfs -O richacl >/dev/null 2>&1 \
+		|| _notrun "can't mkfs $FSTYP with option -O richacl"
+	_scratch_mount >/dev/null 2>&1 \
+		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
+	_scratch_unmount
+}
+
+_require_scratch_richacl()
+{
+	case "$FSTYP" in
+	xfs)    _require_scratch_richacl_xfs
+		;;
+	ext4)   _require_scratch_richacl_ext4
+		;;
+	*)      _notrun "this test requires richacl support on \$SCRATCH_DEV"
+		;;
+	esac
+}
+
+_scratch_mkfs_richacl()
+{
+	_require_scratch
+	case "$FSTYP" in
+	xfs)    _scratch_mkfs_xfs -m richacl=1
+		;;
+	ext4)   _scratch_mkfs -O richacl
+		;;
+	esac
+}
+
 # check that a FS on a device is mounted
 # if so, return mount point
 #
diff --git a/tests/generic/352 b/tests/generic/352
new file mode 100755
index 0000000..0f32ee5
--- /dev/null
+++ b/tests/generic/352
@@ -0,0 +1,122 @@
+#! /bin/bash
+# FS QA Test 352
+#
+# RichACL apply-masks test
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
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
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
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
+
+# real QA test starts here
+
+_supported_fs generic
+_supported_os Linux
+
+_require_scratch
+_require_scratch_richacl
+_require_richacl_prog
+
+_scratch_mkfs_richacl >> $seqres.full
+_scratch_mount
+
+cd $SCRATCH_MNT
+
+touch x
+setrichacl --set 'owner@:rwp::allow group@:rwp::allow everyone@:r::allow' x
+getrichacl x
+
+setrichacl --set 'everyone@:wp::allow owner@:r::allow group@:r::allow' x
+chmod 664 x
+getrichacl x
+
+setrichacl --set 'everyone@:wp::deny owner@:rwp::allow group@:rwp::allow' x
+chmod 664 x
+getrichacl x
+
+setrichacl --set 'owner@:rwCo::allow' x
+getrichacl x
+
+setrichacl --set 'owner@:rwpCo::allow' x
+getrichacl x
+
+chmod 644 x
+getrichacl x
+
+setrichacl --set 'u:77:rwp::allow' x
+chmod 664 x
+getrichacl x
+
+chmod 644 x
+getrichacl --numeric-ids x
+
+chmod 664 x
+getrichacl x
+
+setrichacl --set 'u:77:rwp::allow everyone@:r::allow' x
+chmod 664 x
+getrichacl x
+
+setrichacl --set 'u:77:r::allow everyone@:rwp::allow' x
+chmod 664 x
+getrichacl x
+
+setrichacl --set 'u:77:wp::deny everyone@:rwp::allow' x
+chmod 664 x
+getrichacl x
+
+setrichacl --set 'u:77:rwp::allow u:77:wp::deny everyone@:rwp::allow' x
+chmod 664 x
+getrichacl x
+
+setrichacl --set 'everyone@:rwp::allow' x
+chmod 066 x
+getrichacl x
+
+chmod 006 x
+getrichacl x
+
+chmod 606 x
+getrichacl x
+
+setrichacl --set 'u:77:rwp::allow everyone@:rwp::allow' x
+chmod 606 x
+getrichacl x
+
+chmod 646 x
+getrichacl x
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/352.out b/tests/generic/352.out
new file mode 100644
index 0000000..7a10361
--- /dev/null
+++ b/tests/generic/352.out
@@ -0,0 +1,94 @@
+QA output created by 352
+x:
+    owner@:rwp----------::allow
+    group@:rwp----------::allow
+ everyone@:r------------::allow
+
+x:
+    owner@:rwp----------::allow
+    group@:rwp----------::allow
+ everyone@:r------------::allow
+
+x:
+    owner@:rwp----------::allow
+    group@:rwp----------::allow
+ everyone@:r------------::allow
+
+x:
+ owner@:rw-------Co--::allow
+
+x:
+ owner@:rwp----------::allow
+
+x:
+    owner@:rwp----------::allow
+ everyone@:r------------::allow
+
+x:
+    owner@:rwp----------::allow
+   user:77:rwp----------::allow
+    group@:r------------::deny
+ everyone@:r------------::allow
+
+x:
+    owner@:rwp----------::allow
+   user:77:r------------::allow
+    group@:r------------::deny
+ everyone@:r------------::allow
+
+x:
+    owner@:rwp----------::allow
+   user:77:rwp----------::allow
+    group@:r------------::deny
+ everyone@:r------------::allow
+
+x:
+    owner@:rwp----------::allow
+   user:77:rwp----------::allow
+ everyone@:r------------::allow
+
+x:
+   user:77:rwp----------::allow
+    owner@:rwp----------::allow
+    group@:rwp----------::allow
+ everyone@:r------------::allow
+
+x:
+    owner@:rwp----------::allow
+   user:77:-wp----------::deny
+    group@:rwp----------::allow
+ everyone@:r------------::allow
+
+x:
+    owner@:rwp----------::allow
+   user:77:rwp----------::allow
+   user:77:-wp----------::deny
+    group@:rwp----------::allow
+ everyone@:r------------::allow
+
+x:
+    owner@:rwp----------::deny
+ everyone@:rwp----------::allow
+
+x:
+    owner@:rwp----------::deny
+    group@:rwp----------::deny
+ everyone@:rwp----------::allow
+
+x:
+    owner@:rwp----------::allow
+    group@:rwp----------::deny
+ everyone@:rwp----------::allow
+
+x:
+    owner@:rwp----------::allow
+    group@:rwp----------::deny
+ everyone@:rwp----------::allow
+
+x:
+   user:77:r------------::allow
+    owner@:rwp----------::allow
+    group@:-wp----------::deny
+   user:77:-wp----------::deny
+ everyone@:rwp----------::allow
+
diff --git a/tests/generic/353 b/tests/generic/353
new file mode 100755
index 0000000..5ce3526
--- /dev/null
+++ b/tests/generic/353
@@ -0,0 +1,114 @@
+#! /bin/bash
+# FS QA Test 353
+#
+# RichACL auto-inheritance test
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
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
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
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
+
+# real QA test starts here
+
+_supported_fs generic
+_supported_os Linux
+
+_require_scratch
+_require_scratch_richacl
+_require_richacl_prog
+
+_scratch_mkfs_richacl >> $seqres.full
+_scratch_mount
+
+cd $SCRATCH_MNT
+
+umask 022
+
+mkdir d1
+setrichacl --modify owner@:rwpxd:fd:allow,u:101:rw:fd:deny d1
+setrichacl --modify u:102:rw:f:deny d1
+setrichacl --modify u:103:rw:d:deny d1
+setrichacl --modify g:101:rw:fdi:deny d1
+
+setrichacl --modify flags:a d1
+
+getrichacl --numeric --raw d1
+
+mkdir d1/d2
+touch d1/d3
+
+# Mode bits derived from inherited ACEs
+getrichacl --numeric --raw d1/d2
+
+getrichacl --numeric --raw d1/d3
+
+mkdir d1/d2/d4
+touch d1/d2/d4/d5
+
+# Protected files
+mkdir d1/d6
+touch d1/d7
+
+getrichacl --numeric --raw d1/d2/d4
+
+getrichacl --numeric --raw d1/d2/d4/d5
+
+# Clear protected flag from all the ACLs
+setrichacl --modify flags:a d1/d2
+setrichacl --modify flags:a d1/d3
+setrichacl --modify flags:a d1/d2/d4
+setrichacl --modify flags:a d1/d2/d4/d5
+
+getrichacl --numeric d1 | sed -e 's/:fd:deny/:fd:allow/'
+
+setrichacl --set-file acl.txt d1
+
+getrichacl --numeric --raw d1
+
+getrichacl --numeric --raw d1/d2
+
+getrichacl --numeric --raw d1/d3
+
+getrichacl --numeric --raw d1/d2/d4
+
+getrichacl --numeric --raw d1/d2/d4/d5
+
+# No automatic inheritance for protected files
+getrichacl --numeric --raw d1/d6
+
+getrichacl --numeric --raw d1/d7
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/353.out b/tests/generic/353.out
new file mode 100644
index 0000000..e7a011b
--- /dev/null
+++ b/tests/generic/353.out
@@ -0,0 +1,140 @@
+QA output created by 353
+d1:
+     flags:a
+     owner:rwpxd-----------::mask
+     group:r--x------------::mask
+     other:r--x------------::mask
+  user:101:rw--------------:fd:deny
+  user:102:rw--------------:f:deny
+  user:103:rw--------------:d:deny
+ group:101:rw--------------:fdi:deny
+    owner@:rwpxd-----------:fd:allow
+ everyone@:r--x------------::allow
+
+d1/d2:
+     flags:map
+     owner:rwpxd-----------::mask
+     group:----------------::mask
+     other:----------------::mask
+  user:101:rw--------------:fda:deny
+  user:102:rw--------------:fia:deny
+  user:103:rw--------------:da:deny
+ group:101:rw--------------:fda:deny
+    owner@:rwpxd-----------:fda:allow
+
+d1/d3:
+     flags:map
+     owner:rwp-------------::mask
+     group:----------------::mask
+     other:----------------::mask
+  user:101:rw--------------:a:deny
+  user:102:rw--------------:a:deny
+ group:101:rw--------------:a:deny
+    owner@:rwpx------------:a:allow
+
+d1/d2/d4:
+     flags:map
+     owner:rwpxd-----------::mask
+     group:----------------::mask
+     other:----------------::mask
+  user:101:rw--------------:fda:deny
+  user:102:rw--------------:fia:deny
+  user:103:rw--------------:da:deny
+ group:101:rw--------------:fda:deny
+    owner@:rwpxd-----------:fda:allow
+
+d1/d2/d4/d5:
+     flags:map
+     owner:rwp-------------::mask
+     group:----------------::mask
+     other:----------------::mask
+  user:101:rw--------------:a:deny
+  user:102:rw--------------:a:deny
+ group:101:rw--------------:a:deny
+    owner@:rwpx------------:a:allow
+
+d1:
+     flags:a
+  user:101:rw-----------:fd:allow
+  user:102:rw-----------:f:deny
+  user:103:rw-----------:d:deny
+ group:101:rw-----------:fdi:deny
+    owner@:rwpxd--------:fd:allow
+ everyone@:r--x---------::allow
+
+acl.txt: No such file or directory
+d1:
+     flags:a
+     owner:rwpxd-----------::mask
+     group:r--x------------::mask
+     other:r--x------------::mask
+  user:101:rw--------------:fd:deny
+  user:102:rw--------------:f:deny
+  user:103:rw--------------:d:deny
+ group:101:rw--------------:fdi:deny
+    owner@:rwpxd-----------:fd:allow
+ everyone@:r--x------------::allow
+
+d1/d2:
+     flags:a
+     owner:rwpxd-----------::mask
+     group:----------------::mask
+     other:----------------::mask
+  user:101:rw--------------:fda:deny
+  user:102:rw--------------:fia:deny
+  user:103:rw--------------:da:deny
+ group:101:rw--------------:fda:deny
+    owner@:rwpxd-----------:fda:allow
+
+d1/d3:
+     flags:a
+     owner:rwp-------------::mask
+     group:----------------::mask
+     other:----------------::mask
+  user:101:rw--------------:a:deny
+  user:102:rw--------------:a:deny
+ group:101:rw--------------:a:deny
+    owner@:rwp-------------:a:allow
+
+d1/d2/d4:
+     flags:a
+     owner:rwpxd-----------::mask
+     group:----------------::mask
+     other:----------------::mask
+  user:101:rw--------------:fda:deny
+  user:102:rw--------------:fia:deny
+  user:103:rw--------------:da:deny
+ group:101:rw--------------:fda:deny
+    owner@:rwpxd-----------:fda:allow
+
+d1/d2/d4/d5:
+     flags:a
+     owner:rwp-------------::mask
+     group:----------------::mask
+     other:----------------::mask
+  user:101:rw--------------:a:deny
+  user:102:rw--------------:a:deny
+ group:101:rw--------------:a:deny
+    owner@:rwp-------------:a:allow
+
+d1/d6:
+     flags:map
+     owner:rwpxd-----------::mask
+     group:----------------::mask
+     other:----------------::mask
+  user:101:rw--------------:fda:deny
+  user:102:rw--------------:fia:deny
+  user:103:rw--------------:da:deny
+ group:101:rw--------------:fda:deny
+    owner@:rwpxd-----------:fda:allow
+
+d1/d7:
+     flags:map
+     owner:rwp-------------::mask
+     group:----------------::mask
+     other:----------------::mask
+  user:101:rw--------------:a:deny
+  user:102:rw--------------:a:deny
+ group:101:rw--------------:a:deny
+    owner@:rwpx------------:a:allow
+
diff --git a/tests/generic/354 b/tests/generic/354
new file mode 100755
index 0000000..f19e19d
--- /dev/null
+++ b/tests/generic/354
@@ -0,0 +1,95 @@
+#! /bin/bash
+# FS QA Test 354
+#
+# RichACL basic test
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
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
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
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
+
+# real QA test starts here
+
+_supported_fs generic
+_supported_os Linux
+
+_require_scratch
+_require_scratch_richacl
+_require_richacl_prog
+
+_scratch_mkfs_richacl >> $seqres.full
+_scratch_mount
+
+cd $SCRATCH_MNT
+
+umask 022
+
+touch x
+
+setrichacl --set 'everyone@:rwp::allow' x
+ls -l x | sed -e 's/[. ].*//'
+getrichacl x
+
+chmod 664 x
+ls -l x | sed -e 's/[. ].*//'
+getrichacl x
+
+# Note that unlike how the test cases look at first sight, we do *not* require
+# a richacl-enabled version of ls here ...
+
+mkdir sub
+setrichacl --set 'everyone@:rwpxd:fd:allow' sub
+ls -dl sub | sed -e 's/[.+ ].*/+/'
+getfattr -m system\.richacl sub
+
+chmod 775 sub
+ls -dl sub | sed -e 's/[.+ ].*/+/'
+getfattr -m system\.richacl sub
+getrichacl sub
+
+touch sub/f
+ls -l sub/f | sed -e 's/[. ].*//'
+getrichacl sub/f
+
+mkdir sub/sub2
+ls -dl sub/sub2 | sed -e 's/[.+ ].*/+/'
+getrichacl sub/sub2
+
+mkdir -m 750 sub/sub3
+ls -dl sub/sub3 | sed -e 's/[.+ ].*/+/'
+getrichacl sub/sub3
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/354.out b/tests/generic/354.out
new file mode 100644
index 0000000..8fc1e64
--- /dev/null
+++ b/tests/generic/354.out
@@ -0,0 +1,39 @@
+QA output created by 354
+-rw-rw-rw-
+x:
+ everyone@:rwp----------::allow
+
+-rw-rw-r--
+x:
+    owner@:rwp----------::allow
+    group@:rwp----------::allow
+ everyone@:r------------::allow
+
+drwxrwxrwx+
+# file: sub
+system.richacl
+
+drwxrwxr-x+
+# file: sub
+system.richacl
+
+sub:
+    owner@:rwpxd--------::allow
+    group@:rwpxd--------::allow
+ everyone@:rwpxd--------:fdi:allow
+ everyone@:r--x---------::allow
+
+-rw-rw-rw-
+sub/f:
+ everyone@:rwp----------::allow
+
+drwxrwxrwx+
+sub/sub2:
+ everyone@:rwpxd--------:fd:allow
+
+drwxr-x---+
+sub/sub3:
+    owner@:rwpxd--------::allow
+    group@:r--x---------::allow
+ everyone@:rwpxd--------:fdi:allow
+
diff --git a/tests/generic/355 b/tests/generic/355
new file mode 100755
index 0000000..b99d22e
--- /dev/null
+++ b/tests/generic/355
@@ -0,0 +1,83 @@
+#! /bin/bash
+# FS QA Test 355
+#
+# RichACL chmod test
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
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
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
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
+
+# real QA test starts here
+
+_supported_fs generic
+_supported_os Linux
+
+_require_scratch
+_require_scratch_richacl
+_require_richacl_prog
+_require_runas
+
+_scratch_mkfs_richacl >> $seqres.full
+_scratch_mount
+
+cd $SCRATCH_MNT
+
+r() {
+	echo "--- runas -u 99 -g 99 $*"
+	runas -u 99 -g 99 -- "$@"
+}
+
+# Create file as root
+touch a
+
+# We cannot set the acl as another user
+r setrichacl --set 'u:99:rwc::allow' a
+
+# We cannot chmod as another user
+r chmod 666 a
+
+# Give user 99 the write_acl permission
+setrichacl --set 'u:99:rwpC::allow' a
+
+# Now user 99 can setrichacl and chmod ...
+r setrichacl --set 'u:99:rwpC::allow' a
+r chmod 666 a
+
+# ... but chmod disables the write_acl permission
+r setrichacl --set 'u:99:rwpC::allow' a
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/355.out b/tests/generic/355.out
new file mode 100644
index 0000000..b0dce47
--- /dev/null
+++ b/tests/generic/355.out
@@ -0,0 +1,9 @@
+QA output created by 355
+--- runas -u 99 -g 99 setrichacl --set u:99:rwc::allow a
+a: Operation not permitted
+--- runas -u 99 -g 99 chmod 666 a
+chmod: changing permissions of 'a': Operation not permitted
+--- runas -u 99 -g 99 setrichacl --set u:99:rwpC::allow a
+--- runas -u 99 -g 99 chmod 666 a
+--- runas -u 99 -g 99 setrichacl --set u:99:rwpC::allow a
+a: Operation not permitted
diff --git a/tests/generic/356 b/tests/generic/356
new file mode 100755
index 0000000..8791566
--- /dev/null
+++ b/tests/generic/356
@@ -0,0 +1,82 @@
+#! /bin/bash
+# FS QA Test 356
+#
+# RichACL chown test
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
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
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
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
+
+# real QA test starts here
+
+_supported_fs generic
+_supported_os Linux
+
+_require_scratch
+_require_scratch_richacl
+_require_richacl_prog
+_require_runas
+
+_scratch_mkfs_richacl >> $seqres.full
+_scratch_mount
+
+cd $SCRATCH_MNT
+
+r() {
+	echo "--- runas -u 99 -g 99 $*"
+	runas -u 99 -g 99 -- "$@"
+}
+
+# Create file as root
+touch a
+
+# Chown and chgrp with no take ownership permission fails
+r chown 99 a
+r chgrp 99 a
+
+# Add the take_ownership permission
+setrichacl --set 'u:99:rwpo::allow' a
+
+# Chown and chgrp to a user or group the process is not in fails
+r chown 100 a
+r chgrp 100 a
+
+# Chown and chgrp to a user and group the process is in succeeds
+r chown 99 a
+r chgrp 99 a
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/356.out b/tests/generic/356.out
new file mode 100644
index 0000000..414832b
--- /dev/null
+++ b/tests/generic/356.out
@@ -0,0 +1,11 @@
+QA output created by 356
+--- runas -u 99 -g 99 chown 99 a
+chown: changing ownership of 'a': Operation not permitted
+--- runas -u 99 -g 99 chgrp 99 a
+chgrp: changing group of 'a': Operation not permitted
+--- runas -u 99 -g 99 chown 100 a
+chown: changing ownership of 'a': Operation not permitted
+--- runas -u 99 -g 99 chgrp 100 a
+chgrp: changing group of 'a': Operation not permitted
+--- runas -u 99 -g 99 chown 99 a
+--- runas -u 99 -g 99 chgrp 99 a
diff --git a/tests/generic/357 b/tests/generic/357
new file mode 100755
index 0000000..8318dab
--- /dev/null
+++ b/tests/generic/357
@@ -0,0 +1,81 @@
+#! /bin/bash
+# FS QA Test 357
+#
+# RichACL create test
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
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
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
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
+
+# real QA test starts here
+
+_supported_fs generic
+_supported_os Linux
+
+_require_scratch
+_require_scratch_richacl
+_require_richacl_prog
+_require_runas
+
+_scratch_mkfs_richacl >> $seqres.full
+_scratch_mount
+
+cd $SCRATCH_MNT
+
+r() {
+	echo "--- runas -u 99 -g 99 $*"
+	runas -u 99 -g 99 -- "$@"
+}
+
+# Create directories as root with different permissions
+mkdir d1 d2 d3
+setrichacl --set 'u:99:wx::allow' d2
+setrichacl --set 'u:99:px::allow' d3
+
+# Cannot create files or directories without permissions
+r touch d1/f
+r mkdir d1/d
+
+# Can create files with add_file (w) permission
+r touch d2/f
+r mkdir d2/d
+
+# Can create directories with add_subdirectory (p) permission
+r touch d3/f
+r mkdir d3/d
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/357.out b/tests/generic/357.out
new file mode 100644
index 0000000..df82323
--- /dev/null
+++ b/tests/generic/357.out
@@ -0,0 +1,11 @@
+QA output created by 357
+--- runas -u 99 -g 99 touch d1/f
+touch: cannot touch 'd1/f': Permission denied
+--- runas -u 99 -g 99 mkdir d1/d
+mkdir: cannot create directory 'd1/d': Permission denied
+--- runas -u 99 -g 99 touch d2/f
+--- runas -u 99 -g 99 mkdir d2/d
+mkdir: cannot create directory 'd2/d': Permission denied
+--- runas -u 99 -g 99 touch d3/f
+touch: cannot touch 'd3/f': Permission denied
+--- runas -u 99 -g 99 mkdir d3/d
diff --git a/tests/generic/358 b/tests/generic/358
new file mode 100755
index 0000000..511abfb
--- /dev/null
+++ b/tests/generic/358
@@ -0,0 +1,81 @@
+#! /bin/bash
+# FS QA Test 358
+#
+# RichACL ctime test
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
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
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
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
+
+# real QA test starts here
+
+_supported_fs generic
+_supported_os Linux
+
+_require_scratch
+_require_scratch_richacl
+_require_richacl_prog
+_require_runas
+
+_scratch_mkfs_richacl >> $seqres.full
+_scratch_mount
+
+cd $SCRATCH_MNT
+
+r() {
+	echo "--- runas -u 99 -g 99 $*"
+	runas -u 99 -g 99 -- "$@"
+}
+
+touch a
+
+# Without write access, the ctime cannot be changed
+r touch a
+
+setrichacl --set 'u:99:rw::allow' a
+
+# With write access, the ctime can be set to the current time, but not to
+# any other time
+r touch a
+r touch -d '1 hour ago' a
+
+setrichacl --set 'u:99:rwA::allow' a
+
+# With set_attributes access, the ctime can be set to an arbitrary time
+r touch -d '1 hour ago' a
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/358.out b/tests/generic/358.out
new file mode 100644
index 0000000..18c0ad0
--- /dev/null
+++ b/tests/generic/358.out
@@ -0,0 +1,7 @@
+QA output created by 358
+--- runas -u 99 -g 99 touch a
+touch: cannot touch 'a': Permission denied
+--- runas -u 99 -g 99 touch a
+--- runas -u 99 -g 99 touch -d 1 hour ago a
+touch: setting times of 'a': Operation not permitted
+--- runas -u 99 -g 99 touch -d 1 hour ago a
diff --git a/tests/generic/359 b/tests/generic/359
new file mode 100755
index 0000000..c8b668b
--- /dev/null
+++ b/tests/generic/359
@@ -0,0 +1,122 @@
+#! /bin/bash
+# FS QA Test 359
+#
+# RichACL delete test
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
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
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
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
+
+# real QA test starts here
+
+_supported_fs generic
+_supported_os Linux
+
+_require_scratch
+_require_scratch_richacl
+_require_richacl_prog
+_require_runas
+
+_scratch_mkfs_richacl >> $seqres.full
+_scratch_mount
+
+cd $SCRATCH_MNT
+
+r() {
+	echo "--- runas -u 99 -g 99 $*"
+	runas -u 99 -g 99 -- "$@"
+}
+
+umask 022
+
+chmod go+w .
+mkdir d1 d2 d3 d4 d5 d6 d7
+touch d1/f d1/g d2/f d3/f d4/f d5/f d6/f d7/f d7/g d7/h
+chmod o+w d1/g
+chown 99 d2
+chgrp 99 d3
+chmod g+w d3
+setrichacl --set 'u:99:wx::allow' d4
+setrichacl --set 'u:99:d::allow' d5
+setrichacl --set 'u:99:xd::allow' d6
+setrichacl --set 'u:99:D::allow' d7/f d7/g d7/h
+chmod 664 d7/g
+
+mkdir s2 s3 s4 s5 s6 s7
+chmod +t s2 s3 s4 s5 s6 s7
+touch s2/f s3/f s4/f s5/f s6/f s7/f s7/g s7/h
+chown 99 s2
+chgrp 99 s3
+chmod g+w s3
+setrichacl --set 'u:99:wx::allow' s4
+setrichacl --set 'u:99:d::allow' s5
+setrichacl --set 'u:99:xd::allow' s6
+setrichacl --set 'u:99:D::allow' s7/f s7/g s7/h
+chmod 664 s7/g
+
+# Cannot delete files with no or only with write permissions on the directory
+r rm -f d1/f d1/g
+
+# Can delete files in directories we own
+r rm -f d2/f s2/f
+
+# Can delete files in non-sticky directories we have write access to
+r rm -f d3/f s3/f
+
+# "Write_data/execute" access does not include delete_child access, so deleting
+# is not allowed:
+r rm -f d4/f s4/f
+
+# "Delete_child" access alone also is not sufficient
+r rm -f d5/f s5/f
+
+# "Execute/delete_child" access is sufficient for non-sticky directories
+r rm -f d6/f s6/f
+
+# "Delete" access on the child is sufficient, even in sticky directories.
+r rm -f d7/f s7/f
+
+# Regression: Delete access must not override add_file / add_subdirectory
+# access.
+r touch h
+r mv -f h d7/
+r mv -f h s7/
+
+# A chmod turns off the "delete" permission
+r rm -f d7/g s7/g
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/359.out b/tests/generic/359.out
new file mode 100644
index 0000000..190a40e
--- /dev/null
+++ b/tests/generic/359.out
@@ -0,0 +1,24 @@
+QA output created by 359
+--- runas -u 99 -g 99 rm -f d1/f d1/g
+rm: cannot remove 'd1/f': Permission denied
+rm: cannot remove 'd1/g': Permission denied
+--- runas -u 99 -g 99 rm -f d2/f s2/f
+--- runas -u 99 -g 99 rm -f d3/f s3/f
+rm: cannot remove 's3/f': Operation not permitted
+--- runas -u 99 -g 99 rm -f d4/f s4/f
+rm: cannot remove 'd4/f': Permission denied
+rm: cannot remove 's4/f': Permission denied
+--- runas -u 99 -g 99 rm -f d5/f s5/f
+rm: cannot remove 'd5/f': Permission denied
+rm: cannot remove 's5/f': Permission denied
+--- runas -u 99 -g 99 rm -f d6/f s6/f
+rm: cannot remove 's6/f': Operation not permitted
+--- runas -u 99 -g 99 rm -f d7/f s7/f
+--- runas -u 99 -g 99 touch h
+--- runas -u 99 -g 99 mv -f h d7/
+mv: cannot move 'h' to 'd7/h': Permission denied
+--- runas -u 99 -g 99 mv -f h s7/
+mv: cannot move 'h' to 's7/h': Permission denied
+--- runas -u 99 -g 99 rm -f d7/g s7/g
+rm: cannot remove 'd7/g': Permission denied
+rm: cannot remove 's7/g': Permission denied
diff --git a/tests/generic/360 b/tests/generic/360
new file mode 100755
index 0000000..c68baff
--- /dev/null
+++ b/tests/generic/360
@@ -0,0 +1,86 @@
+#! /bin/bash
+# FS QA Test 360
+#
+# RichACL write-vs-append test
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
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
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
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
+
+# real QA test starts here
+
+_supported_fs generic
+_supported_os Linux
+
+_require_scratch
+_require_scratch_richacl
+_require_richacl_prog
+_require_runas
+
+_scratch_mkfs_richacl >> $seqres.full
+_scratch_mount
+
+cd $SCRATCH_MNT
+
+r() {
+	echo "--- runas -u 99 -g 99 $*"
+	runas -u 99 -g 99 -- "$@"
+}
+
+touch a b c d e f
+setrichacl --set 'owner@:rwp::allow' a
+setrichacl --set 'owner@:rwp::allow u:99:w::allow' b
+setrichacl --set 'owner@:rwp::allow u:99:p::allow' c
+setrichacl --set 'owner@:rwp::allow u:99:wp::allow' d
+setrichacl --set 'u:99:a::deny owner@:rwp::allow u:99:w::allow' e
+setrichacl --set 'u:99:w::deny owner@:rwp::allow u:99:p::allow' f
+
+r sh -c 'echo a > a'
+r sh -c 'echo b > b'
+r sh -c 'echo c > c'
+r sh -c 'echo d > d'
+r sh -c 'echo e > e'
+r sh -c 'echo f > f'
+
+r sh -c 'echo A >> a'
+r sh -c 'echo B >> b'
+r sh -c 'echo C >> c'
+r sh -c 'echo D >> d'
+r sh -c 'echo E >> e'
+r sh -c 'echo F >> f'
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/360.out b/tests/generic/360.out
new file mode 100644
index 0000000..ce62732
--- /dev/null
+++ b/tests/generic/360.out
@@ -0,0 +1,19 @@
+QA output created by 360
+--- runas -u 99 -g 99 sh -c echo a > a
+sh: a: Permission denied
+--- runas -u 99 -g 99 sh -c echo b > b
+--- runas -u 99 -g 99 sh -c echo c > c
+sh: c: Permission denied
+--- runas -u 99 -g 99 sh -c echo d > d
+--- runas -u 99 -g 99 sh -c echo e > e
+--- runas -u 99 -g 99 sh -c echo f > f
+sh: f: Permission denied
+--- runas -u 99 -g 99 sh -c echo A >> a
+sh: a: Permission denied
+--- runas -u 99 -g 99 sh -c echo B >> b
+sh: b: Permission denied
+--- runas -u 99 -g 99 sh -c echo C >> c
+--- runas -u 99 -g 99 sh -c echo D >> d
+--- runas -u 99 -g 99 sh -c echo E >> e
+sh: e: Permission denied
+--- runas -u 99 -g 99 sh -c echo F >> f
diff --git a/tests/generic/group b/tests/generic/group
index 36fb759..09dcb93 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -354,3 +354,12 @@
 349 blockdev quick rw
 350 blockdev quick rw
 351 blockdev quick rw
+352 auto quick richacl
+353 auto quick richacl
+354 auto quick richacl
+355 auto quick richacl
+356 auto quick richacl
+357 auto quick richacl
+358 auto quick richacl
+359 auto quick richacl
+360 auto quick richacl
-- 
2.5.5

