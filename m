Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:47073 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933440AbbENOaj (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 May 2015 10:30:39 -0400
Message-ID: <5554B18D.1060006@sandeen.net>
Date: Thu, 14 May 2015 09:30:37 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: [PATCH V2] xfs_repair: test for false positive reserved attr name
 use
References: <555414EA.80301@redhat.com>
In-Reply-To: <555414EA.80301@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

xfs_repair compares attr names in the root namespace to
two special/reserved names, "SGI_ACL_FILE" and "SGI_ACL_DEFAULT"
and if the value in them aren't valid acls, flags this as
an inconsistency.

However, due to various bugs, xfs_repair may only compare
a smaller portion of the on-disk value; hence either
substrings or superstrings may match, and false-positive
corruption will be detected.  This test checks for those
false positives; i.e. the ACL names created in this test
may cause xfs_repair to "fix" them, but it should not.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

V2: Fix all the dumb, thanks to Eryu :)
Add it to more groups, too.

diff --git a/tests/xfs/053 b/tests/xfs/053
new file mode 100755
index 0000000..f1d62f6
--- /dev/null
+++ b/tests/xfs/053
@@ -0,0 +1,84 @@
+#! /bin/bash
+# FS QA Test 053
+#
+# Ensure that xfs_repair can properly spot SGI_ACL_FILE
+# and SGI_ACL_DEFAULT in the root attr namespace.
+#
+# Due to bugs here and there, we sometimes matched on partial
+# strings with those names, and threw off xfs_repair.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2015 Red Hat, Inc.  All Rights Reserved.
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
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/attr
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# real QA test starts here
+
+_supported_fs xfs
+_supported_os IRIX Linux
+_require_scratch
+_require_attrs
+
+_scratch_mkfs s >/dev/null 2>&1
+_scratch_mount
+
+# Create root attr names which are substrings or superstrings
+# of the reserved ACL names, and make sure xfs_repair copes.
+
+# Due to various bugs, either the compared length was shorter
+# than the reserved name (7 chars), so substrings matched, and/or only
+# the reserved name length was compared, so superstrings matched.
+
+rm -f $SCRATCH_MNT/$seq.*
+
+# actual reserved names:
+#           SGI_ACL_FILE	SGI_ACL_DEFAULT
+for NAME in SGI_ACL \
+	    SGI_ACL_F		SGI_ACL_D \
+	    SGI_ACL_FILE_FOO	SGI_ACL_DEFAULT_FOO; do
+	touch $SCRATCH_MNT/${seq}.${NAME}
+	$ATTR_PROG -R -s $NAME -V "Wow, such $NAME" $SCRATCH_MNT/$seq.$NAME \
+		| _filter_scratch
+done
+
+# Older repair failed because it sees the above names as matching
+# SGI_ACL_FILE / SGI_ACL_DEFAULT but w/o valid acls on them
+
+# The test harness will catch this (false positive) corruption
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/053.out b/tests/xfs/053.out
new file mode 100644
index 0000000..d876555
--- /dev/null
+++ b/tests/xfs/053.out
@@ -0,0 +1,11 @@
+QA output created by 053
+Attribute "SGI_ACL" set to a 17 byte value for SCRATCH_MNT/053.SGI_ACL:
+Wow, such SGI_ACL
+Attribute "SGI_ACL_F" set to a 19 byte value for SCRATCH_MNT/053.SGI_ACL_F:
+Wow, such SGI_ACL_F
+Attribute "SGI_ACL_D" set to a 19 byte value for SCRATCH_MNT/053.SGI_ACL_D:
+Wow, such SGI_ACL_D
+Attribute "SGI_ACL_FILE_FOO" set to a 26 byte value for SCRATCH_MNT/053.SGI_ACL_FILE_FOO:
+Wow, such SGI_ACL_FILE_FOO
+Attribute "SGI_ACL_DEFAULT_FOO" set to a 29 byte value for SCRATCH_MNT/053.SGI_ACL_DEFAULT_FOO:
+Wow, such SGI_ACL_DEFAULT_FOO
diff --git a/tests/xfs/group b/tests/xfs/group
index 58144d2..26dd881 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -50,6 +50,7 @@
 050 quota auto quick
 051 auto log metadata
 052 quota db auto quick
+053 attr acl repair quick auto
 054 quota auto quick
 055 dump ioctl remote tape
 056 dump ioctl auto quick


