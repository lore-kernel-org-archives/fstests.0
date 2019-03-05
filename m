Received: from mx1.redhat.com ([209.132.183.28]:43628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfCEEiR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 4 Mar 2019 23:38:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3D76307E045
        for <fstests@vger.kernel.org>; Tue,  5 Mar 2019 04:38:16 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-133.bne.redhat.com [10.64.54.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 123C3608C3
        for <fstests@vger.kernel.org>; Tue,  5 Mar 2019 04:38:15 +0000 (UTC)
From: Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH] Add new xattr test 532
Date: Tue,  5 Mar 2019 14:38:08 +1000
Message-Id: <20190305043808.12093-1-lsahlber@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This test is cloned from 097 but has had all the tests for trusted.*
removed.
This makes it possible to use this test on filesystems that can only
provide user.* xattrs such as CIFS.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 tests/generic/532     | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/532.out | 108 +++++++++++++++++++++++++++++++++++++
 tests/generic/group   |   1 +
 3 files changed, 253 insertions(+)
 create mode 100755 tests/generic/532
 create mode 100644 tests/generic/532.out

diff --git a/tests/generic/532 b/tests/generic/532
new file mode 100755
index 00000000..86adb3a6
--- /dev/null
+++ b/tests/generic/532
@@ -0,0 +1,144 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2000-2004 Silicon Graphics, Inc.  All Rights Reserved.
+# Copyright (c) 2017 Google, Inc.  All Rights Reserved.
+# Copyright (c) 2019 Red Hat Inc.  All Rights Reserved.
+#
+# FS QA Test No. 526. Modified from 097.
+#
+# simple attr tests for user. EAs:
+#  - set
+#  - get
+#  - list
+#  - remove
+# Basic testing.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+file=$TEST_DIR/foo
+
+_cleanup()
+{
+	rm -f $tmp.* $file
+}
+
+getfattr()
+{
+	_getfattr --absolute-names "$@" |& _filter_test_dir
+}
+
+setfattr()
+{
+	$SETFATTR_PROG "$@" |& _filter_test_dir
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
+_require_test
+_require_attrs
+
+echo -e "\ncreate file foo"
+rm -f $file
+touch $file
+
+echo -e "\nshould be no EAs for foo:"
+getfattr -d $file
+
+echo -e "\nset EA <NOISE,woof>:"
+setfattr -n user.NOISE -v woof $file
+
+echo -e "\nset EA <COLOUR,blue>:"
+setfattr -n user.COLOUR -v blue $file
+
+echo -e "\nset EA <SIZE,small>:"
+setfattr -n user.SIZE -v small $file
+
+echo -e "\nlist the EAs for foo: NOISE, COLOUR, SIZE"
+getfattr -d $file
+
+echo -e "\ncheck the list again for foo"
+getfattr -d $file
+
+echo -e "\nunmount the FS and see if EAs are persistent"
+_test_cycle_mount
+
+echo -e "\ncheck the list again for foo after umount/mount"
+getfattr -d $file
+
+echo -e "\nremove the COLOUR EA on foo"
+setfattr -x user.COLOUR $file
+
+echo -e "\nlist EAs for foo: NOISE, SIZE"
+getfattr -d $file
+
+echo -e "\nget the value of the NOISE EA"
+getfattr -n user.NOISE $file
+
+echo -e "\nget the value of the COLOUR EA which was removed earlier"
+getfattr -n user.COLOUR $file
+
+echo -e "\nget the value of the SIZE EA"
+getfattr -n user.SIZE $file
+
+echo -e "\nlist all the EAs again: NOISE, SIZE"
+getfattr -d $file
+
+echo -e "\nchange the value of the SIZE EA from small to huge"
+setfattr -n user.SIZE -v huge $file
+
+echo -e "\nget the SIZE EA which should now have value huge"
+getfattr -n user.SIZE $file
+
+echo -e "\nlist EAs: NOISE, SIZE"
+getfattr -d $file
+
+echo -e "\nremove the SIZE EA from foo"
+setfattr -x user.SIZE $file
+
+echo -e "\nlist EAs: NOISE (SIZE EA has been removed)"
+getfattr -d $file
+
+echo -e "\ntry removing non-existent EA named woof"
+setfattr -x user.WOOF $file
+
+echo -e "\ntry removing already removed EA SIZE"
+setfattr -x user.SIZE $file
+
+echo -e "\nlist EAs: NOISE"
+getfattr -d $file
+
+echo -e "\ntry removing already removed EA COLOUR"
+setfattr -x user.COLOUR $file
+
+echo -e "\nlist EAs: NOISE"
+getfattr -d $file
+
+echo -e "\nremove remaining EA NOISE"
+setfattr -x user.NOISE $file
+
+echo -e "\nlist EAs: should be no EAs left now"
+getfattr -d $file
+
+echo -e "\nunmount the FS and see if EAs are persistent"
+_test_cycle_mount
+
+echo -e "\nlist EAs: should still be no EAs left"
+getfattr -d $file
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/532.out b/tests/generic/532.out
new file mode 100644
index 00000000..562512b1
--- /dev/null
+++ b/tests/generic/532.out
@@ -0,0 +1,108 @@
+QA output created by 532
+
+create file foo
+
+should be no EAs for foo:
+
+set EA <NOISE,woof>:
+
+set EA <COLOUR,blue>:
+
+set EA <SIZE,small>:
+
+list the EAs for foo: NOISE, COLOUR, SIZE
+# file: TEST_DIR/foo
+user.COLOUR="blue"
+user.NOISE="woof"
+user.SIZE="small"
+
+
+check the list again for foo
+# file: TEST_DIR/foo
+user.COLOUR="blue"
+user.NOISE="woof"
+user.SIZE="small"
+
+
+unmount the FS and see if EAs are persistent
+
+check the list again for foo after umount/mount
+# file: TEST_DIR/foo
+user.COLOUR="blue"
+user.NOISE="woof"
+user.SIZE="small"
+
+
+remove the COLOUR EA on foo
+
+list EAs for foo: NOISE, SIZE
+# file: TEST_DIR/foo
+user.NOISE="woof"
+user.SIZE="small"
+
+
+get the value of the NOISE EA
+# file: TEST_DIR/foo
+user.NOISE="woof"
+
+
+get the value of the COLOUR EA which was removed earlier
+TEST_DIR/foo: user.COLOUR: No such attribute
+
+get the value of the SIZE EA
+# file: TEST_DIR/foo
+user.SIZE="small"
+
+
+list all the EAs again: NOISE, SIZE
+# file: TEST_DIR/foo
+user.NOISE="woof"
+user.SIZE="small"
+
+
+change the value of the SIZE EA from small to huge
+
+get the SIZE EA which should now have value huge
+# file: TEST_DIR/foo
+user.SIZE="huge"
+
+
+list EAs: NOISE, SIZE
+# file: TEST_DIR/foo
+user.NOISE="woof"
+user.SIZE="huge"
+
+
+remove the SIZE EA from foo
+
+list EAs: NOISE (SIZE EA has been removed)
+# file: TEST_DIR/foo
+user.NOISE="woof"
+
+
+try removing non-existent EA named woof
+setfattr: TEST_DIR/foo: No such attribute
+
+try removing already removed EA SIZE
+setfattr: TEST_DIR/foo: No such attribute
+
+list EAs: NOISE
+# file: TEST_DIR/foo
+user.NOISE="woof"
+
+
+try removing already removed EA COLOUR
+setfattr: TEST_DIR/foo: No such attribute
+
+list EAs: NOISE
+# file: TEST_DIR/foo
+user.NOISE="woof"
+
+
+remove remaining EA NOISE
+
+list EAs: should be no EAs left now
+
+unmount the FS and see if EAs are persistent
+
+list EAs: should still be no EAs left
diff --git a/tests/generic/group b/tests/generic/group
index 15227b67..14cb479a 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -534,3 +534,4 @@
 529 auto quick attr
 530 auto quick unlink
 531 auto quick unlink
+532 attr auto quick
-- 
2.13.6
