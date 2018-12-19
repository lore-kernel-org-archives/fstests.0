Received: from mx1.redhat.com ([209.132.183.28]:60462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbeLSDoc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 18 Dec 2018 22:44:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0386A720AB
        for <fstests@vger.kernel.org>; Wed, 19 Dec 2018 03:44:32 +0000 (UTC)
From: XiaoLi Feng <xifeng@redhat.com>
Subject: [PATCH v1] xfstests: filter the default EA
Date: Wed, 19 Dec 2018 11:44:28 +0800
Message-Id: <1545191068-6719-1-git-send-email-xifeng@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xiaoli feng <xifeng@redhat.com>
List-ID: <fstests@vger.kernel.org>

From: xiaoli feng <xifeng@redhat.com>

For some filesystems, such as CIFS, the file or directory has the
default extend attribute. It makes these tests generic/020
generic/337 generic/377 failed. Now add this patch to filter the
default EA.

Signed-off-by: xiaoli feng <xifeng@redhat.com>
---
 tests/generic/020 | 11 ++++++++---
 tests/generic/337 |  7 ++++++-
 tests/generic/377 |  9 +++++++--
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/tests/generic/020 b/tests/generic/020
index 936d848..8fb1d1d 100755
--- a/tests/generic/020
+++ b/tests/generic/020
@@ -39,7 +39,7 @@ do_getfattr()
 {
     _getfattr $* 2>$tmp.err >$tmp.out
     exit=$?
-    _filter $tmp.out
+    _filter $tmp.out | grep -v "$defaultEA"
     _filter $tmp.err 1>&2
     return $exit
 }
@@ -66,13 +66,18 @@ _require_attrs
 rm -f $seqres.full
 
 testfile=$TEST_DIR/attribute_$$
+defaultEA="NODEFAULTEA"
 
 echo "*** list non-existant file"
 _attr_list $testfile
 
 echo "*** list empty file"
 touch $testfile
-_attr_list $testfile
+defaultEA_tmp=`do_getfattr -d -e text --absolute-names $testfile`
+if [ -n "$defaultEA_tmp" ]; then
+	defaultEA=`echo "$defaultEA_tmp" | grep -v ^#`
+fi
+_attr_list $testfile | grep -v ^# | grep -v ^$
 
 echo "*** query non-existant attribute"
 _attr -g "nonexistant" $testfile 2>&1
@@ -110,7 +115,7 @@ done
 
 echo "*** check"
 # don't print it all out...
-_getfattr --absolute-names $testfile \
+_getfattr --absolute-names $testfile | grep -v `echo "$defaultEA" | cut -d = -f 1` \
     | tee -a $seqres.full \
     | $AWK_PROG '
     	/^#/ { next }
diff --git a/tests/generic/337 b/tests/generic/337
index 344a365..57e4f9b 100755
--- a/tests/generic/337
+++ b/tests/generic/337
@@ -35,12 +35,17 @@ rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
+defaultEA="NODEFAULTEA"
 
 # Create our test file with a few xattrs. The first 3 xattrs have a name that
 # when given as input to a crc32c function result in the same checksum. This
 # made btrfs list only one of the xattrs through listxattrs system call (because
 # it packs xattrs with the same name checksum into the same btree item).
 touch $SCRATCH_MNT/testfile
+defaultEA_tmp=`_getfattr --absolute-names --dump $SCRATCH_MNT/testfile`
+if [ -n "$defaultEA_tmp" ]; then
+        defaultEA=`echo "$defaultEA_tmp" | grep -v ^#`
+fi
 $SETFATTR_PROG -n user.foobar -v 123 $SCRATCH_MNT/testfile
 $SETFATTR_PROG -n user.WvG1c1Td -v qwerty $SCRATCH_MNT/testfile
 $SETFATTR_PROG -n user.J3__T_Km3dVsW_ -v hello $SCRATCH_MNT/testfile
@@ -49,7 +54,7 @@ $SETFATTR_PROG -n user.ping -v pong $SCRATCH_MNT/testfile
 
 # Now call getfattr with --dump, which calls the listxattrs system call.
 # It should list all the xattrs we have set before.
-_getfattr --absolute-names --dump $SCRATCH_MNT/testfile | _filter_scratch
+_getfattr --absolute-names --dump $SCRATCH_MNT/testfile |grep -v "$defaultEA" | _filter_scratch
 
 status=0
 exit
diff --git a/tests/generic/377 b/tests/generic/377
index f7835ee..4692053 100755
--- a/tests/generic/377
+++ b/tests/generic/377
@@ -37,18 +37,23 @@ rm -f $seqres.full
 
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
+defaultEA="NODEFAULTEA"
 
 # Create a testfile with three xattrs such that the sum of namelengths of the
 # first two is bigger than the namelength of the third. This is needed for
 # the 5th testcase that tests one of the cornercases.
 testfile=${SCRATCH_MNT}/testfile
 touch $testfile
+defaultEA_tmp=`$listxattr $SCRATCH_MNT/testfile`
+if [ -n "$defaultEA_tmp" ]; then
+        defaultEA=`echo "$defaultEA_tmp" | grep -v ^#`
+fi
 $SETFATTR_PROG -n user.foo -v bar $testfile
 $SETFATTR_PROG -n user.ping -v pong $testfile
 $SETFATTR_PROG -n user.hello -v there $testfile
 
 # 1. Call listxattr without buffer length argument. This should succeed.
-$listxattr $testfile | sort
+$listxattr $testfile | grep -v "$defaultEA" | sort
 
 # 2. Calling listxattr on nonexistant file should fail with -ENOENT.
 $listxattr ""
@@ -66,7 +71,7 @@ $listxattr $testfile 9
 $listxattr $testfile 11
 
 # 6. Calling listxattr with buffersize bigger than needed should succeed.
-$listxattr $testfile 500 | sort
+$listxattr $testfile 500 | grep -v "$defaultEA" | sort
 
 status=0
 exit
-- 
1.8.3.1
