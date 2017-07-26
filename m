Received: from mail-pg0-f46.google.com ([74.125.83.46]:36570 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdGZSCX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Jul 2017 14:02:23 -0400
Received: by mail-pg0-f46.google.com with SMTP id 125so87368381pgi.3
        for <fstests@vger.kernel.org>; Wed, 26 Jul 2017 11:02:23 -0700 (PDT)
From: Tahsin Erdogan <tahsin@google.com>
Subject: [PATCH v3] ext4: add a test for ea_inode feature
Date: Wed, 26 Jul 2017 11:02:16 -0700
Message-Id: <20170726180216.7359-1-tahsin@google.com>
In-Reply-To: <20170726085500.GX9167@eguan.usersys.redhat.com>
References: <20170726085500.GX9167@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>, fstests@vger.kernel.org
Cc: Tahsin Erdogan <tahsin@google.com>
List-ID: <fstests@vger.kernel.org>

ea_inode feature supports creating extended attributes with values
greater than the fs block size. This test exercises some common
scenarios:

 - Extended attibute being placed in inode vs xattr block
 - Removing extended attribute
 - Removing a file that has an extended attribute
 - Multiple files having identical large attribute values
 - Repeatedly setting an extended attribute with various sizes

Signed-off-by: Tahsin Erdogan <tahsin@google.com>
---
v3:
 - Removed hardcoded inode and block size

v2:
 - Expanded test description in the script
 - Added comments for inode and block size selection
 - replaced getfattr/setfattr with GETFATTR_PROG/SETFATTR_PROG
 - fixed unquoted variable comparison

 tests/ext4/026     | 137 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/026.out |  29 ++++++++++++
 tests/ext4/group   |   1 +
 3 files changed, 167 insertions(+)
 create mode 100755 tests/ext4/026
 create mode 100644 tests/ext4/026.out

diff --git a/tests/ext4/026 b/tests/ext4/026
new file mode 100755
index 000000000000..94a737ce0a5f
--- /dev/null
+++ b/tests/ext4/026
@@ -0,0 +1,137 @@
+#! /bin/bash
+# FS QA Test 026
+#
+# Test for ea_inode feature in ext4. Without ea_inode feature, an extended
+# attribute in ext4 cannot be larger than the fs block size. ea_inode feature
+# allows storing xattr values in external inodes and so raises xattr value
+# size limit to 64k.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Google, Inc.  All Rights Reserved.
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
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
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
+_supported_fs ext4
+_supported_os Linux
+_require_scratch
+_require_attrs
+_require_ext4_mkfs_feature ea_inode
+
+_scratch_mkfs_ext4 -O ea_inode >/dev/null 2>&1
+_scratch_mount
+
+# Sets an extended attribute on a file.
+attr_set()
+{
+	local file=$1 name=$2 value=$3 tmp
+
+	if [[ "$value" != "" ]]; then
+		$SETFATTR_PROG -n $name -v "$value" $file
+	else
+		$SETFATTR_PROG -n $name $file
+	fi
+
+	tmp=$($GETFATTR_PROG --absolute-names --only-values -n $name $file)
+	[[ "$tmp" == "$value" ]] || echo "unexpected value returned: $tmp"
+}
+
+# List attributes on a file.
+attr_list()
+{
+	$GETFATTR_PROG --absolute-names $1 | grep -v '^#'
+}
+
+# Removes an extended attribute from a file.
+attr_remove()
+{
+	local file=$1 name=$2
+
+	$SETFATTR_PROG -x $name $file
+}
+
+# Test files.
+x=$SCRATCH_MNT/x
+y=$SCRATCH_MNT/y
+z=$SCRATCH_MNT/z
+
+# Attribute with short name that goes into inode body.
+name_in_ibody=user.i
+
+# Attribute with long name that goes into xattr block.
+name_in_block=user.$(perl -e 'print "b" x 100;')
+
+# Set large xattr values on multiple files.
+touch $x $y $z
+for file in $x $y $z; do
+	for name in $name_in_ibody $name_in_block; do
+		for size in 4096 8000 $((64*1024)); do
+			attr_set $file $name-$size \
+				$(perl -e "print 'v' x $size;")
+		done
+	done
+	attr_list $file
+done
+rm $x $y $z
+
+# Set/remove.
+touch $x
+attr_set $x $name_in_ibody $(perl -e "print 'i' x 25000;")
+attr_set $x $name_in_block $(perl -e "print 'b' x 25000;")
+attr_list $x
+attr_remove $x $name_in_ibody
+attr_remove $x $name_in_block
+rm $x
+
+# Set with same value twice.
+touch $x
+attr_set $x $name_in_ibody $(perl -e "print 'i' x 60000;")
+attr_set $x $name_in_ibody $(perl -e "print 'i' x 60000;")
+attr_list $x
+rm $x
+
+# Repeatedly set an extended attribute with various value sizes.
+touch $x
+for size in 0 10 80 900 1900 3000 9000 60 10000 0 8000 3000 10 0 20 10000 5; do
+	attr_set $x user.1 $(perl -e "print 'v' x $size;")
+done
+attr_list $x
+rm $x
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/026.out b/tests/ext4/026.out
new file mode 100644
index 000000000000..5b94f3e2e4ea
--- /dev/null
+++ b/tests/ext4/026.out
@@ -0,0 +1,29 @@
+QA output created by 026
+user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-4096
+user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-65536
+user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-8000
+user.i-4096
+user.i-65536
+user.i-8000
+
+user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-4096
+user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-65536
+user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-8000
+user.i-4096
+user.i-65536
+user.i-8000
+
+user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-4096
+user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-65536
+user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-8000
+user.i-4096
+user.i-65536
+user.i-8000
+
+user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
+user.i
+
+user.i
+
+user.1
+
diff --git a/tests/ext4/group b/tests/ext4/group
index 664c0591e345..9aed07e271fe 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -28,6 +28,7 @@
 023 auto quick scrub
 024 auto quick encrypt dangerous
 025 auto quick fuzzers dangerous 
+026 auto quick attr
 271 auto rw quick
 301 aio auto ioctl rw stress defrag
 302 aio auto ioctl rw stress defrag
-- 
2.14.0.rc0.400.g1c36432dff-goog

