Received: from mail-pf0-f169.google.com ([209.85.192.169]:35735 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbcJLWDe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Oct 2016 18:03:34 -0400
Received: by mail-pf0-f169.google.com with SMTP id s8so24421093pfj.2
        for <fstests@vger.kernel.org>; Wed, 12 Oct 2016 15:03:33 -0700 (PDT)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH] generic/375: test both regular file and directory
Date: Wed, 12 Oct 2016 15:03:07 -0700
Message-Id: <1476309788-101401-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: jack@suse.cz, agruenba@redhat.com, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

generic/375 previously only tested SGID being cleared on a regular file.
It should test SGID being cleared on a directory too.  Though this is
not required by POSIX, it is the Linux behavior.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/375     | 54 ++++++++++++++++++++++++++++++++-------------------
 tests/generic/375.out |  8 ++++++++
 2 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/tests/generic/375 b/tests/generic/375
index f8c3260..1d523e5 100755
--- a/tests/generic/375
+++ b/tests/generic/375
@@ -52,30 +52,44 @@ _require_runas
 _require_acls
 
 cd $TEST_DIR
-testfile=testfile.$seq
-rm -f $testfile
 
-touch $testfile
-chown 100:100 $testfile
+# try with both regular file and directory
+for filetype in regular dir; do
 
-echo '*** SGID should remain set (twice)'
-chmod 2755 $testfile
-_runas -u 100 -g 100 -- chmod 2777 $testfile
-stat -c %A $testfile
-chmod 2755 $testfile
-_runas -u 100 -g 100 -- setfacl -m u::rwx,g::rwx,o::rwx $testfile
-stat -c %A $testfile
+	case $filetype in
+	regular)
+		testfile=testfile.$seq
+		rm -f $testfile
+		touch $testfile
+		;;
+	*)
+		testfile=testdir.$seq
+		rm -rf $testfile
+		mkdir $testfile
+		;;
+	esac
 
-echo '*** SGID should be cleared (twice)'
-chmod 2755 $testfile
-_runas -u 100 -g 101 -- chmod 2777 $testfile
-stat -c %A $testfile
-chmod 2755 $testfile
-_runas -u 100 -g 101 -- setfacl -m u::rwx,g::rwx,o::rwx $testfile
-stat -c %A $testfile
+	chown 100:100 $testfile
 
-echo '*** Expected failure'
-_runas -u 101 -g 101 -- chmod 2777 $testfile
+	echo '*** SGID should remain set (twice)'
+	chmod 2755 $testfile
+	_runas -u 100 -g 100 -- chmod 2777 $testfile
+	stat -c %A $testfile
+	chmod 2755 $testfile
+	_runas -u 100 -g 100 -- setfacl -m u::rwx,g::rwx,o::rwx $testfile
+	stat -c %A $testfile
+
+	echo '*** SGID should be cleared (twice)'
+	chmod 2755 $testfile
+	_runas -u 100 -g 101 -- chmod 2777 $testfile
+	stat -c %A $testfile
+	chmod 2755 $testfile
+	_runas -u 100 -g 101 -- setfacl -m u::rwx,g::rwx,o::rwx $testfile
+	stat -c %A $testfile
+
+	echo '*** Expected failure'
+	_runas -u 101 -g 101 -- chmod 2777 $testfile
+done
 
 status=0
 exit
diff --git a/tests/generic/375.out b/tests/generic/375.out
index 478d078..bb9bc72 100644
--- a/tests/generic/375.out
+++ b/tests/generic/375.out
@@ -7,3 +7,11 @@ QA output created by 375
 -rwxrwxrwx
 *** Expected failure
 chmod: changing permissions of 'testfile.375': Operation not permitted
+*** SGID should remain set (twice)
+drwxrwsrwx
+drwxrwsrwx
+*** SGID should be cleared (twice)
+drwxrwxrwx
+drwxrwxrwx
+*** Expected failure
+chmod: changing permissions of 'testdir.375': Operation not permitted
-- 
2.8.0.rc3.226.g39d4020

