Received: from mx1.redhat.com ([209.132.183.28]:49676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfCHDex (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 7 Mar 2019 22:34:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 787A830D78B9
        for <fstests@vger.kernel.org>; Fri,  8 Mar 2019 03:34:52 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-95.bne.redhat.com [10.64.54.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9CC35D788
        for <fstests@vger.kernel.org>; Fri,  8 Mar 2019 03:34:51 +0000 (UTC)
From: Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH] Add new xattr test 532
Date: Fri,  8 Mar 2019 13:34:38 +1000
Message-Id: <20190308033438.25832-1-lsahlber@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Split out most of the user.* tests from 097 and move them to a new
test that only tests user.* xattrs.
This makes it possible to use this test on filesystems that can only
provide user.* xattrs such as CIFS.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 tests/generic/097     |  84 -------------------------
 tests/generic/097.out | 105 -------------------------------
 tests/generic/532     | 143 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/532.out | 108 +++++++++++++++++++++++++++++++
 tests/generic/group   |   1 +
 5 files changed, 252 insertions(+), 189 deletions(-)
 create mode 100755 tests/generic/532
 create mode 100644 tests/generic/532.out

diff --git a/tests/generic/097 b/tests/generic/097
index 679f1a24..39730bb0 100755
--- a/tests/generic/097
+++ b/tests/generic/097
@@ -54,90 +54,6 @@ echo -e "\ncreate file foo"
 rm -f $file
 touch $file
 
-echo -e "\nshould be no EAs for foo:"
-getfattr -d $file
-
-echo -e "\nset EA <noise,woof>:"
-setfattr -n user.noise -v woof $file
-
-echo -e "\nset EA <colour,blue>:"
-setfattr -n user.colour -v blue $file
-
-echo -e "\nset EA <size,small>:"
-setfattr -n user.size -v small $file
-
-echo -e "\nlist the EAs for foo: noise, colour, size"
-getfattr -d $file
-
-echo -e "\ncheck the list again for foo"
-getfattr -d $file
-
-echo -e "\nunmount the FS and see if EAs are persistent"
-_test_cycle_mount
-
-echo -e "\ncheck the list again for foo after umount/mount"
-getfattr -d $file
-
-echo -e "\nremove the colour EA on foo"
-setfattr -x user.colour $file
-
-echo -e "\nlist EAs for foo: noise, size"
-getfattr -d $file
-
-echo -e "\nget the value of the noise EA"
-getfattr -n user.noise $file
-
-echo -e "\nget the value of the colour EA which was removed earlier"
-getfattr -n user.colour $file
-
-echo -e "\nget the value of the size EA"
-getfattr -n user.size $file
-
-echo -e "\nlist all the EAs again: noise, size"
-getfattr -d $file
-
-echo -e "\nchange the value of the size EA from small to huge"
-setfattr -n user.size -v huge $file
-
-echo -e "\nget the size EA which should now have value huge"
-getfattr -n user.size $file
-
-echo -e "\nlist EAs: noise, size"
-getfattr -d $file
-
-echo -e "\nremove the size EA from foo"
-setfattr -x user.size $file
-
-echo -e "\nlist EAs: noise (size EA has been removed)"
-getfattr -d $file
-
-echo -e "\ntry removing non-existent EA named woof"
-setfattr -x user.woof $file
-
-echo -e "\ntry removing already removed EA size"
-setfattr -x user.size $file
-
-echo -e "\nlist EAs: noise"
-getfattr -d $file
-
-echo -e "\ntry removing already removed EA colour"
-setfattr -x user.colour $file
-
-echo -e "\nlist EAs: noise"
-getfattr -d $file
-
-echo -e "\nremove remaining EA noise"
-setfattr -x user.noise $file
-
-echo -e "\nlist EAs: should be no EAs left now"
-getfattr -d $file
-
-echo -e "\nunmount the FS and see if EAs are persistent"
-_test_cycle_mount
-
-echo -e "\nlist EAs: should still be no EAs left"
-getfattr -d $file
-
 echo -e "\n*** Test out the trusted namespace ***"
 
 echo -e "\nset EA <trusted:colour,marone>:"
diff --git a/tests/generic/097.out b/tests/generic/097.out
index 948d57b6..fcfc6ffc 100644
--- a/tests/generic/097.out
+++ b/tests/generic/097.out
@@ -2,111 +2,6 @@ QA output created by 097
 
 create file foo
 
-should be no EAs for foo:
-
-set EA <noise,woof>:
-
-set EA <colour,blue>:
-
-set EA <size,small>:
-
-list the EAs for foo: noise, colour, size
-# file: TEST_DIR/foo
-user.colour="blue"
-user.noise="woof"
-user.size="small"
-
-
-check the list again for foo
-# file: TEST_DIR/foo
-user.colour="blue"
-user.noise="woof"
-user.size="small"
-
-
-unmount the FS and see if EAs are persistent
-
-check the list again for foo after umount/mount
-# file: TEST_DIR/foo
-user.colour="blue"
-user.noise="woof"
-user.size="small"
-
-
-remove the colour EA on foo
-
-list EAs for foo: noise, size
-# file: TEST_DIR/foo
-user.noise="woof"
-user.size="small"
-
-
-get the value of the noise EA
-# file: TEST_DIR/foo
-user.noise="woof"
-
-
-get the value of the colour EA which was removed earlier
-TEST_DIR/foo: user.colour: No such attribute
-
-get the value of the size EA
-# file: TEST_DIR/foo
-user.size="small"
-
-
-list all the EAs again: noise, size
-# file: TEST_DIR/foo
-user.noise="woof"
-user.size="small"
-
-
-change the value of the size EA from small to huge
-
-get the size EA which should now have value huge
-# file: TEST_DIR/foo
-user.size="huge"
-
-
-list EAs: noise, size
-# file: TEST_DIR/foo
-user.noise="woof"
-user.size="huge"
-
-
-remove the size EA from foo
-
-list EAs: noise (size EA has been removed)
-# file: TEST_DIR/foo
-user.noise="woof"
-
-
-try removing non-existent EA named woof
-setfattr: TEST_DIR/foo: No such attribute
-
-try removing already removed EA size
-setfattr: TEST_DIR/foo: No such attribute
-
-list EAs: noise
-# file: TEST_DIR/foo
-user.noise="woof"
-
-
-try removing already removed EA colour
-setfattr: TEST_DIR/foo: No such attribute
-
-list EAs: noise
-# file: TEST_DIR/foo
-user.noise="woof"
-
-
-remove remaining EA noise
-
-list EAs: should be no EAs left now
-
-unmount the FS and see if EAs are persistent
-
-list EAs: should still be no EAs left
-
 *** Test out the trusted namespace ***
 
 set EA <trusted:colour,marone>:
diff --git a/tests/generic/532 b/tests/generic/532
new file mode 100755
index 00000000..e1d349bb
--- /dev/null
+++ b/tests/generic/532
@@ -0,0 +1,143 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2000-2004 Silicon Graphics, Inc.  All Rights Reserved.
+# Copyright (c) 2017 Google, Inc.  All Rights Reserved.
+# Copyright (c) 2019 Red Hat Inc.  All Rights Reserved.
+#
+# FS QA Test No. 526.
+#
+# Simple attr smoke tests for user EAs, dereived from generic/097.
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
+file=$TEST_DIR/foo.$seq
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
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
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+echo -e "\ncreate file foo.$seq"
+rm -f $file
+touch $file
+
+echo -e "\nshould be no EAs for foo.$seq:"
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
+echo -e "\nlist the EAs for foo.$seq: NOISE, COLOUR, SIZE"
+getfattr -d $file
+
+echo -e "\ncheck the list again for foo.$seq"
+getfattr -d $file
+
+echo -e "\nunmount the FS and see if EAs are persistent"
+_test_cycle_mount
+
+echo -e "\ncheck the list again for foo.$seq after umount/mount"
+getfattr -d $file
+
+echo -e "\nremove the COLOUR EA on foo.$seq"
+setfattr -x user.COLOUR $file
+
+echo -e "\nlist EAs for foo.$seq: NOISE, SIZE"
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
+echo -e "\nremove the SIZE EA from foo.$seq"
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
index 00000000..9a2ce870
--- /dev/null
+++ b/tests/generic/532.out
@@ -0,0 +1,108 @@
+QA output created by 532
+
+create file foo.532
+
+should be no EAs for foo.532:
+
+set EA <NOISE,woof>:
+
+set EA <COLOUR,blue>:
+
+set EA <SIZE,small>:
+
+list the EAs for foo.532: NOISE, COLOUR, SIZE
+# file: TEST_DIR/foo.532
+user.COLOUR="blue"
+user.NOISE="woof"
+user.SIZE="small"
+
+
+check the list again for foo.532
+# file: TEST_DIR/foo.532
+user.COLOUR="blue"
+user.NOISE="woof"
+user.SIZE="small"
+
+
+unmount the FS and see if EAs are persistent
+
+check the list again for foo.532 after umount/mount
+# file: TEST_DIR/foo.532
+user.COLOUR="blue"
+user.NOISE="woof"
+user.SIZE="small"
+
+
+remove the COLOUR EA on foo.532
+
+list EAs for foo.532: NOISE, SIZE
+# file: TEST_DIR/foo.532
+user.NOISE="woof"
+user.SIZE="small"
+
+
+get the value of the NOISE EA
+# file: TEST_DIR/foo.532
+user.NOISE="woof"
+
+
+get the value of the COLOUR EA which was removed earlier
+TEST_DIR/foo.532: user.COLOUR: No such attribute
+
+get the value of the SIZE EA
+# file: TEST_DIR/foo.532
+user.SIZE="small"
+
+
+list all the EAs again: NOISE, SIZE
+# file: TEST_DIR/foo.532
+user.NOISE="woof"
+user.SIZE="small"
+
+
+change the value of the SIZE EA from small to huge
+
+get the SIZE EA which should now have value huge
+# file: TEST_DIR/foo.532
+user.SIZE="huge"
+
+
+list EAs: NOISE, SIZE
+# file: TEST_DIR/foo.532
+user.NOISE="woof"
+user.SIZE="huge"
+
+
+remove the SIZE EA from foo.532
+
+list EAs: NOISE (SIZE EA has been removed)
+# file: TEST_DIR/foo.532
+user.NOISE="woof"
+
+
+try removing non-existent EA named woof
+setfattr: TEST_DIR/foo.532: No such attribute
+
+try removing already removed EA SIZE
+setfattr: TEST_DIR/foo.532: No such attribute
+
+list EAs: NOISE
+# file: TEST_DIR/foo.532
+user.NOISE="woof"
+
+
+try removing already removed EA COLOUR
+setfattr: TEST_DIR/foo.532: No such attribute
+
+list EAs: NOISE
+# file: TEST_DIR/foo.532
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
index 15227b67..a8977a70 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -534,3 +534,4 @@
 529 auto quick attr
 530 auto quick unlink
 531 auto quick unlink
+532 auto quick attr
-- 
2.21.0.rc1
