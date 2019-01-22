Received: from szxga07-in.huawei.com ([45.249.212.35]:58354 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbfAVDUf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 Jan 2019 22:20:35 -0500
From: zhengbin <zhengbin13@huawei.com>
Subject: [PATCH 5/6] squashfs: add xattr test
Date: Tue, 22 Jan 2019 11:24:07 +0800
Message-ID: <20190122032408.91336-6-zhengbin13@huawei.com>
In-Reply-To: <20190122032408.91336-1-zhengbin13@huawei.com>
References: <20190122032408.91336-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, guaneryu@gmail.com, fstests@vger.kernel.org
Cc: houtao1@huawei.com, zhaohongjiang@huawei.com, zhengbin13@huawei.com
List-ID: <fstests@vger.kernel.org>

This patch add xattr test(set, get, list).

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 common/attr            |   5 +++
 tests/readonly/019     | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/readonly/019.out |  45 ++++++++++++++++++++
 tests/readonly/020     |  56 +++++++++++++++++++++++++
 tests/readonly/020.out |   9 ++++
 tests/readonly/021     |  74 +++++++++++++++++++++++++++++++++
 tests/readonly/021.out |  11 +++++
 tests/readonly/group   |   3 ++
 8 files changed, 312 insertions(+)
 create mode 100755 tests/readonly/019
 create mode 100644 tests/readonly/019.out
 create mode 100755 tests/readonly/020
 create mode 100644 tests/readonly/020.out
 create mode 100755 tests/readonly/021
 create mode 100644 tests/readonly/021.out

diff --git a/common/attr b/common/attr
index 20049de0..845ed88e 100644
--- a/common/attr
+++ b/common/attr
@@ -179,6 +179,11 @@ _require_attrs()
     [ -n "$GETFATTR_PROG" ] || _notrun "getfattr command not found"
     [ -n "$SETFATTR_PROG" ] || _notrun "setfattr command not found"

+    if [ "$FSTYP" == "squashfs" ]; then
+	# squashfs is a readonly filesystem, can not touch file
+	return
+    fi
+
     #
     # Test if chacl is able to write an attribute on the target filesystems.
     # On really old kernels the system calls might not be implemented at all,
diff --git a/tests/readonly/019 b/tests/readonly/019
new file mode 100755
index 00000000..69c6c7fd
--- /dev/null
+++ b/tests/readonly/019
@@ -0,0 +1,109 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2000-2004 Silicon Graphics, Inc.  All Rights Reserved.
+# Copyright (c) 2017 Google, Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 019. Modifed from generic/097.
+#
+# simple attr tests for EAs:
+#  - set should return error
+#  - get
+#  - list
+# Basic testing.
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/fooA
+	rm -f $SCRATCH_DEV/fooB
+	rm -f $SCRATCH_DEV/fooC
+}
+
+getfattr()
+{
+	_getfattr --absolute-names "$@" |& _filter_scratch
+}
+
+setfattr()
+{
+	$SETFATTR_PROG "$@" |& _filter_scratch
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/attr
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+
+_require_scratch
+_require_attrs
+
+file0=$SCRATCH_DEV/foo0
+fileA=$SCRATCH_DEV/fooA
+fileB=$SCRATCH_DEV/fooB
+fileC=$SCRATCH_DEV/fooC
+
+rm -f $file0
+rm -f $fileA
+rm -f $fileB
+rm -f $fileC
+echo -e "\ncreate file fooA"
+touch $fileA
+
+echo -e "\ncreate file fooB"
+touch $fileB
+echo -e "\nset fooB EA <user.noise,woof>:"
+setfattr -n user.noise -v woof $fileB
+
+echo -e "\ncreate file fooC"
+touch $fileC
+echo -e "\nset fooC EA <user.size,small>:"
+setfattr -n user.size -v small $fileC
+echo -e "\nset fooC EA <user.noise,low>:"
+setfattr -n user.noise -v low $fileC
+echo -e "\nset fooC EA <trusted.colour,blue>:"
+setfattr -n trusted.colour -v blue $fileC
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+file0=$SCRATCH_MNT/foo0
+fileA=$SCRATCH_MNT/fooA
+fileB=$SCRATCH_MNT/fooB
+fileC=$SCRATCH_MNT/fooC
+
+echo -e "\nset SCRATCH_MNT fooA EA"
+setfattr -n user.noise -v woof $fileA
+
+echo -e "\nlist non-existent file0 EA"
+getfattr -d $file0
+
+echo -e "\nshould be no EAs for fooA:"
+getfattr -d $fileA
+
+echo -e "\nlist the EAs for fooB: user.noise"
+getfattr -d $fileB
+
+echo -e "\nlist the EAs for fooC: user.size, user.noise"
+getfattr -d $fileC
+
+echo -e "\nget the value of the fooC user.size EA"
+getfattr -n user.size $fileC
+
+echo -e "\nlist fooC trusted EAs"
+getfattr -d -m '^trusted\.' $fileC
+
+echo -e "success"
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/019.out b/tests/readonly/019.out
new file mode 100644
index 00000000..48593890
--- /dev/null
+++ b/tests/readonly/019.out
@@ -0,0 +1,45 @@
+QA output created by 019
+
+create file fooA
+
+create file fooB
+
+set fooB EA <user.noise,woof>:
+
+create file fooC
+
+set fooC EA <user.size,small>:
+
+set fooC EA <user.noise,low>:
+
+set fooC EA <trusted.colour,blue>:
+
+set SCRATCH_MNT fooA EA
+setfattr: SCRATCH_MNT/fooA: Read-only file system
+
+list non-existent file0 EA
+getfattr: SCRATCH_MNT/foo0: No such file or directory
+
+should be no EAs for fooA:
+
+list the EAs for fooB: user.noise
+# file: SCRATCH_MNT/fooB
+user.noise="woof"
+
+
+list the EAs for fooC: user.size, user.noise
+# file: SCRATCH_MNT/fooC
+user.noise="low"
+user.size="small"
+
+
+get the value of the fooC user.size EA
+# file: SCRATCH_MNT/fooC
+user.size="small"
+
+
+list fooC trusted EAs
+# file: SCRATCH_MNT/fooC
+trusted.colour="blue"
+
+success
diff --git a/tests/readonly/020 b/tests/readonly/020
new file mode 100755
index 00000000..c56c4d3f
--- /dev/null
+++ b/tests/readonly/020
@@ -0,0 +1,56 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2016 SUSE Linux Products GmbH. All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 020. Modifed from generic/337.
+#
+# Test that the filesystem's implementation of the listxattrs system call lists
+# all the xattrs an inode has.
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_attrs
+
+rm -f $SCRATCH_DEV/testfile
+touch $SCRATCH_DEV/testfile
+# Create our test file with a few xattrs. The first 3 xattrs have a name that
+# when given as input to a crc32c function result in the same checksum. This
+# made btrfs list only one of the xattrs through listxattrs system call (because
+# it packs xattrs with the same name checksum into the same btree item).
+$SETFATTR_PROG -n user.foobar -v 123 $SCRATCH_DEV/testfile
+$SETFATTR_PROG -n user.WvG1c1Td -v qwerty $SCRATCH_DEV/testfile
+$SETFATTR_PROG -n user.J3__T_Km3dVsW_ -v hello $SCRATCH_DEV/testfile
+$SETFATTR_PROG -n user.something -v pizza $SCRATCH_DEV/testfile
+$SETFATTR_PROG -n user.ping -v pong $SCRATCH_DEV/testfile
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+# Now call getfattr with --dump, which calls the listxattrs system call.
+# It should list all the xattrs we have set before.
+_getfattr --absolute-names --dump $SCRATCH_MNT/testfile | _filter_scratch
+
+echo -e "success"
+# success, all done
+status=0
+exit
diff --git a/tests/readonly/020.out b/tests/readonly/020.out
new file mode 100644
index 00000000..27ca52a9
--- /dev/null
+++ b/tests/readonly/020.out
@@ -0,0 +1,9 @@
+QA output created by 020
+# file: SCRATCH_MNT/testfile
+user.J3__T_Km3dVsW_="hello"
+user.WvG1c1Td="qwerty"
+user.foobar="123"
+user.ping="pong"
+user.something="pizza"
+
+success
diff --git a/tests/readonly/021 b/tests/readonly/021
new file mode 100755
index 00000000..9d46c8e5
--- /dev/null
+++ b/tests/readonly/021
@@ -0,0 +1,74 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
+# Copyright (c) 2019 Huawei. All Rights Reserved.
+#
+# FS QA Test No. 021. Modifed from generic/377.
+#
+# Test listxattr syscall behaviour with different buffer sizes.
+#
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $SCRATCH_DEV/testfile
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_attrs
+_require_test_program "listxattr"
+
+listxattr="$here/src/listxattr"
+
+# Create a testfile with three xattrs such that the sum of namelengths of the
+# first two is bigger than the namelength of the third. This is needed for
+# the 5th testcase that tests one of the cornercases.
+testfile=$SCRATCH_DEV/testfile
+rm -f $testfile
+touch $testfile
+$SETFATTR_PROG -n user.foo -v bar $testfile
+$SETFATTR_PROG -n user.ping -v pong $testfile
+$SETFATTR_PROG -n user.hello -v there $testfile
+
+_scratch_mkfs >/dev/null 2>&1 || _fail "Could not mkfs scratch device"
+_scratch_mount
+
+testfile=$SCRATCH_MNT/testfile
+
+# 1. Call listxattr without buffer length argument. This should succeed.
+$listxattr $testfile | sort
+
+# 2. Calling listxattr on nonexistant file should fail with -ENOENT.
+$listxattr ""
+
+# 3. Calling listxattr with buffersize not suffecient for even one xattr
+# should fail with -ERANGE.
+$listxattr $testfile 1
+
+# 4. Calling listxattr with buffersize suffecient for one xattr, but not
+# sufficient for the whole list should still fail with -ERANGE.
+$listxattr $testfile 9
+
+# 5. Calling listxattr with buffersize suffecient for the last xattr, but not
+# sufficient for the sum of first two. Should fail with -ERANGE.
+$listxattr $testfile 11
+
+# 6. Calling listxattr with buffersize bigger than needed should succeed.
+$listxattr $testfile 500 | sort
+
+status=0
+exit
diff --git a/tests/readonly/021.out b/tests/readonly/021.out
new file mode 100644
index 00000000..09b2c5ea
--- /dev/null
+++ b/tests/readonly/021.out
@@ -0,0 +1,11 @@
+QA output created by 021
+xattr: user.foo
+xattr: user.hello
+xattr: user.ping
+listxattr: No such file or directory
+listxattr: Numerical result out of range
+listxattr: Numerical result out of range
+listxattr: Numerical result out of range
+xattr: user.foo
+xattr: user.hello
+xattr: user.ping
diff --git a/tests/readonly/group b/tests/readonly/group
index c5bca62c..3953328d 100644
--- a/tests/readonly/group
+++ b/tests/readonly/group
@@ -21,3 +21,6 @@
 016 auto
 017 auto
 018 auto
+019 auto
+020 auto
+021 auto
--
2.16.2.dirty
