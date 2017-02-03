Received: from mail-wj0-f195.google.com ([209.85.210.195]:36677 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbdBCLFt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Feb 2017 06:05:49 -0500
Received: by mail-wj0-f195.google.com with SMTP id kq3so505976wjc.3
        for <fstests@vger.kernel.org>; Fri, 03 Feb 2017 03:05:49 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2] generic/007: cleanup $TEST_DIR/$seq dir
Date: Fri,  3 Feb 2017 13:05:37 +0200
Message-Id: <1486119937-2803-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Test generic/007 was failing after running test overlay/007,
because the latter left behind a non empty directory named 007
in test dir and the former failed to mkdir a directory with the
same name.

Cleanup $TEST_DIR/$seq both at end of overlay/007 and beginning of
generic/007 to avoid this collision.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/generic/007 | 1 +
 tests/overlay/007 | 1 +
 2 files changed, 2 insertions(+)

v2:
- Cleanup just $TEST_DIR/007

v1:
- Cleanup $TEST_DIR/$seq* files after tests

diff --git a/tests/generic/007 b/tests/generic/007
index 88cd6cc..cfa4554 100755
--- a/tests/generic/007
+++ b/tests/generic/007
@@ -64,6 +64,7 @@ while [ $i -le $num_filenames ]; do
   let i=$i+1
 done
 
+rm -rf $TEST_DIR/$seq
 mkdir $TEST_DIR/$seq
 cd $TEST_DIR/$seq
 $here/src/nametest -l $sourcefile -s $seed -i $iterations -z
diff --git a/tests/overlay/007 b/tests/overlay/007
index ccf2b75..ed7914b 100755
--- a/tests/overlay/007
+++ b/tests/overlay/007
@@ -37,6 +37,7 @@ _cleanup()
 {
 	cd /
 	rm -f $tmp.*
+	rm -rf $TEST_DIR/$seq
 }
 
 # get standard environment, filters and checks
-- 
2.7.4

