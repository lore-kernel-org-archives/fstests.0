Received: from mx1.redhat.com ([209.132.183.28]:46072 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753374AbcCPL0M (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 16 Mar 2016 07:26:12 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id EB92F627DA
	for <fstests@vger.kernel.org>; Wed, 16 Mar 2016 11:26:11 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v5 3/3] generic/338-346: Add richacl tests
Date: Wed, 16 Mar 2016 12:26:05 +0100
Message-Id: <1458127565-24149-4-git-send-email-agruenba@redhat.com>
In-Reply-To: <1458127565-24149-1-git-send-email-agruenba@redhat.com>
References: <1458127565-24149-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 common/rc             |  39 ++++++++++++++
 tests/generic/338     | 117 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/338.out |  94 +++++++++++++++++++++++++++++++++
 tests/generic/339     | 109 +++++++++++++++++++++++++++++++++++++++
 tests/generic/339.out | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/340     |  90 ++++++++++++++++++++++++++++++++
 tests/generic/340.out |  39 ++++++++++++++
 tests/generic/341     |  77 +++++++++++++++++++++++++++
 tests/generic/341.out |   9 ++++
 tests/generic/342     |  76 +++++++++++++++++++++++++++
 tests/generic/342.out |  11 ++++
 tests/generic/343     |  75 +++++++++++++++++++++++++++
 tests/generic/343.out |  11 ++++
 tests/generic/344     |  75 +++++++++++++++++++++++++++
 tests/generic/344.out |   7 +++
 tests/generic/345     | 116 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/345.out |  24 +++++++++
 tests/generic/346     |  80 +++++++++++++++++++++++++++++
 tests/generic/346.out |  19 +++++++
 tests/generic/group   |   9 ++++
 20 files changed, 1217 insertions(+)
 create mode 100755 tests/generic/338
 create mode 100644 tests/generic/338.out
 create mode 100755 tests/generic/339
 create mode 100644 tests/generic/339.out
 create mode 100755 tests/generic/340
 create mode 100644 tests/generic/340.out
 create mode 100755 tests/generic/341
 create mode 100644 tests/generic/341.out
 create mode 100755 tests/generic/342
 create mode 100644 tests/generic/342.out
 create mode 100755 tests/generic/343
 create mode 100644 tests/generic/343.out
 create mode 100755 tests/generic/344
 create mode 100644 tests/generic/344.out
 create mode 100755 tests/generic/345
 create mode 100644 tests/generic/345.out
 create mode 100755 tests/generic/346
 create mode 100644 tests/generic/346.out

diff --git a/common/rc b/common/rc
index 16f5a43..d7472fc 100644
--- a/common/rc
+++ b/common/rc
@@ -1973,6 +1973,45 @@ _require_seek_data_hole()
         _notrun "File system does not support llseek(2) SEEK_DATA/HOLE"
 }
 
+_require_richacl()
+{
+	GETRICHACL_PROG=`set_prog_path getrichacl`
+	_require_command "$GETRICHACL_PROG" getrichacl
+	SETRICHACL_PROG=`set_prog_path setrichacl`
+	_require_command "$SETRICHACL_PROG" setrichacl
+}
+
+_setup_scratch_richacl_xfs()
+{
+	_scratch_mkfs_xfs_supported -m richacl=1 >/dev/null 2>&1 \
+		|| _notrun "mkfs.xfs doesn't have richacl feature"
+
+	_scratch_mkfs_xfs -m richacl=1 >/dev/null 2>&1
+	_scratch_mount >/dev/null 2>&1 \
+		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
+}
+
+__setup_scratch_richacl()
+{
+	_scratch_mkfs -O richacl >/dev/null 2>&1 \
+		|| _notrun "can't mkfs $FSTYP with option -O richacl"
+	_scratch_mount >/dev/null 2>&1 \
+		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
+}
+
+_setup_scratch_richacl()
+{
+	_require_scratch
+	case "$FSTYP" in
+	xfs)    _setup_scratch_richacl_xfs
+		;;
+	ext4)   __setup_scratch_richacl
+		;;
+	*)      _notrun "this test requires richacl support on \$SCRATCH_DEV"
+		;;
+	esac
+}
+
 # check that a FS on a device is mounted
 # if so, return mount point
 #
diff --git a/tests/generic/338 b/tests/generic/338
new file mode 100755
index 0000000..8f82bce
--- /dev/null
+++ b/tests/generic/338
@@ -0,0 +1,117 @@
+#! /bin/bash
+# FS QA Test 338
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
+_require_richacl
+_setup_scratch_richacl
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
diff --git a/tests/generic/338.out b/tests/generic/338.out
new file mode 100644
index 0000000..be0df64
--- /dev/null
+++ b/tests/generic/338.out
@@ -0,0 +1,94 @@
+QA output created by 338
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
diff --git a/tests/generic/339 b/tests/generic/339
new file mode 100755
index 0000000..d8b3427
--- /dev/null
+++ b/tests/generic/339
@@ -0,0 +1,109 @@
+#! /bin/bash
+# FS QA Test 339
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
+_require_richacl
+_setup_scratch_richacl
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
diff --git a/tests/generic/339.out b/tests/generic/339.out
new file mode 100644
index 0000000..7d7f0b1
--- /dev/null
+++ b/tests/generic/339.out
@@ -0,0 +1,140 @@
+QA output created by 339
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
diff --git a/tests/generic/340 b/tests/generic/340
new file mode 100755
index 0000000..da75b30
--- /dev/null
+++ b/tests/generic/340
@@ -0,0 +1,90 @@
+#! /bin/bash
+# FS QA Test 340
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
+_require_richacl
+_setup_scratch_richacl
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
diff --git a/tests/generic/340.out b/tests/generic/340.out
new file mode 100644
index 0000000..f0874b0
--- /dev/null
+++ b/tests/generic/340.out
@@ -0,0 +1,39 @@
+QA output created by 340
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
diff --git a/tests/generic/341 b/tests/generic/341
new file mode 100755
index 0000000..e94d357
--- /dev/null
+++ b/tests/generic/341
@@ -0,0 +1,77 @@
+#! /bin/bash
+# FS QA Test 341
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
+_require_richacl
+_setup_scratch_richacl
+
+cd $SCRATCH_MNT
+
+r() {
+	echo "--- runas -u 99 -g 99 $*"
+	$here/src/runas -u 99 -g 99 -- "$@"
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
diff --git a/tests/generic/341.out b/tests/generic/341.out
new file mode 100644
index 0000000..6c5855c
--- /dev/null
+++ b/tests/generic/341.out
@@ -0,0 +1,9 @@
+QA output created by 341
+--- runas -u 99 -g 99 setrichacl --set u:99:rwc::allow a
+a: Operation not permitted
+--- runas -u 99 -g 99 chmod 666 a
+chmod: changing permissions of 'a': Operation not permitted
+--- runas -u 99 -g 99 setrichacl --set u:99:rwpC::allow a
+--- runas -u 99 -g 99 chmod 666 a
+--- runas -u 99 -g 99 setrichacl --set u:99:rwpC::allow a
+a: Operation not permitted
diff --git a/tests/generic/342 b/tests/generic/342
new file mode 100755
index 0000000..f9c77ea
--- /dev/null
+++ b/tests/generic/342
@@ -0,0 +1,76 @@
+#! /bin/bash
+# FS QA Test 342
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
+_require_richacl
+_setup_scratch_richacl
+
+cd $SCRATCH_MNT
+
+r() {
+	echo "--- runas -u 99 -g 99 $*"
+	$here/src/runas -u 99 -g 99 -- "$@"
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
diff --git a/tests/generic/342.out b/tests/generic/342.out
new file mode 100644
index 0000000..db1eceb
--- /dev/null
+++ b/tests/generic/342.out
@@ -0,0 +1,11 @@
+QA output created by 342
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
diff --git a/tests/generic/343 b/tests/generic/343
new file mode 100755
index 0000000..88e4141
--- /dev/null
+++ b/tests/generic/343
@@ -0,0 +1,75 @@
+#! /bin/bash
+# FS QA Test 343
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
+_require_richacl
+_setup_scratch_richacl
+
+cd $SCRATCH_MNT
+
+r() {
+	echo "--- runas -u 99 -g 99 $*"
+	$here/src/runas -u 99 -g 99 -- "$@"
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
diff --git a/tests/generic/343.out b/tests/generic/343.out
new file mode 100644
index 0000000..bb028f5
--- /dev/null
+++ b/tests/generic/343.out
@@ -0,0 +1,11 @@
+QA output created by 343
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
diff --git a/tests/generic/344 b/tests/generic/344
new file mode 100755
index 0000000..ea97a77
--- /dev/null
+++ b/tests/generic/344
@@ -0,0 +1,75 @@
+#! /bin/bash
+# FS QA Test 344
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
+_require_richacl
+_setup_scratch_richacl
+
+cd $SCRATCH_MNT
+
+r() {
+	echo "--- runas -u 99 -g 99 $*"
+	$here/src/runas -u 99 -g 99 -- "$@"
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
diff --git a/tests/generic/344.out b/tests/generic/344.out
new file mode 100644
index 0000000..029c5ec
--- /dev/null
+++ b/tests/generic/344.out
@@ -0,0 +1,7 @@
+QA output created by 344
+--- runas -u 99 -g 99 touch a
+touch: cannot touch 'a': Permission denied
+--- runas -u 99 -g 99 touch a
+--- runas -u 99 -g 99 touch -d 1 hour ago a
+touch: setting times of 'a': Operation not permitted
+--- runas -u 99 -g 99 touch -d 1 hour ago a
diff --git a/tests/generic/345 b/tests/generic/345
new file mode 100755
index 0000000..faf6a64
--- /dev/null
+++ b/tests/generic/345
@@ -0,0 +1,116 @@
+#! /bin/bash
+# FS QA Test 345
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
+_require_richacl
+_setup_scratch_richacl
+
+cd $SCRATCH_MNT
+
+r() {
+	echo "--- runas -u 99 -g 99 $*"
+	$here/src/runas -u 99 -g 99 -- "$@"
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
diff --git a/tests/generic/345.out b/tests/generic/345.out
new file mode 100644
index 0000000..8701dcf
--- /dev/null
+++ b/tests/generic/345.out
@@ -0,0 +1,24 @@
+QA output created by 345
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
diff --git a/tests/generic/346 b/tests/generic/346
new file mode 100755
index 0000000..da1fa00
--- /dev/null
+++ b/tests/generic/346
@@ -0,0 +1,80 @@
+#! /bin/bash
+# FS QA Test 346
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
+_require_richacl
+_setup_scratch_richacl
+
+cd $SCRATCH_MNT
+
+r() {
+	echo "--- runas -u 99 -g 99 $*"
+	$here/src/runas -u 99 -g 99 -- "$@"
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
diff --git a/tests/generic/346.out b/tests/generic/346.out
new file mode 100644
index 0000000..3dfc445
--- /dev/null
+++ b/tests/generic/346.out
@@ -0,0 +1,19 @@
+QA output created by 346
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
index 727648c..e892ae9 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -340,3 +340,12 @@
 335 auto quick metadata
 336 auto quick metadata
 337 auto quick metadata
+338 auto richacl
+339 auto richacl
+340 auto richacl
+341 auto richacl
+342 auto richacl
+343 auto richacl
+344 auto richacl
+345 auto richacl
+346 auto richacl
-- 
2.5.0

