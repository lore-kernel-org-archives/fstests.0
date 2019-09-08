Received: from mail-ed1-f47.google.com ([209.85.208.47]:38420 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfIHKSK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Sep 2019 06:18:10 -0400
Received: by mail-ed1-f47.google.com with SMTP id a23so8187418edv.5
        for <fstests@vger.kernel.org>; Sun, 08 Sep 2019 03:18:09 -0700 (PDT)
MIME-Version: 1.0
From: Anatoly Pugachev <matorola@gmail.com>
Date: Sun, 8 Sep 2019 13:18:00 +0300
Message-ID: <CADxRZqyny2nRZwJ=_8QaNj5Xpui7_p8T4XE07ohP6SXrS1JrHw@mail.gmail.com>
Subject: generic/377 failing, xattr: security.SMACK64
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Hello!

JFYI

generic/377 test  failing after enabling CONFIG_SECURITY_SMACK in kernel:

xfstests-dev# ./check generic/377
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/sparc64 ttip 5.3.0-rc7-dirty #1206 SMP Sat Sep
7 16:26:01 MSK 2019
MKFS_OPTIONS  -- -f -bsize=4096 /dev/zram0
MOUNT_OPTIONS -- /dev/zram0 /1/scratch

generic/377 4s ... - output mismatch (see
xfstests-dev/results//generic/377.out.bad)
    --- tests/generic/377.out   2016-09-24 11:51:48.346895167 +0300
    +++ xfstests-dev/results//generic/377.out.bad      2019-09-08
12:25:59.028454297 +0300
    @@ -1,4 +1,5 @@
     QA output created by 377
    +xattr: security.SMACK64
     xattr: user.foo
     xattr: user.hello
     xattr: user.ping
    @@ -6,6 +7,7 @@
     listxattr: Numerical result out of range
    ...
    (Run 'diff -u xfstests-dev/tests/generic/377.out
xfstests-dev/results//generic/377.out.bad'  to see the entire diff)
Ran: generic/377
Failures: generic/377
Failed 1 of 1 tests




root@ttip:xfstests-dev# cat xfstests-dev/results//generic/377.out.bad
QA output created by 377
xattr: security.SMACK64
xattr: user.foo
xattr: user.hello
xattr: user.ping
listxattr: No such file or directory
listxattr: Numerical result out of range
listxattr: Numerical result out of range
listxattr: Numerical result out of range
xattr: security.SMACK64
xattr: user.foo
xattr: user.hello
xattr: user.ping
xfstests-dev#


switching off CONFIG_SECURITY_SMACK in kernel (or via kernel command
line security=none) make this test pass successfully.


A quick fix is probably mark SMACK as unsupported (yet) and grep smack
attrs out after calling to sort, for example (makes test as OK):

# git diff
diff --git a/tests/generic/377 b/tests/generic/377
index f7835ee8..6784233b 100755
--- a/tests/generic/377
+++ b/tests/generic/377
@@ -48,7 +48,7 @@ $SETFATTR_PROG -n user.ping -v pong $testfile
 $SETFATTR_PROG -n user.hello -v there $testfile

 # 1. Call listxattr without buffer length argument. This should succeed.
-$listxattr $testfile | sort
+$listxattr $testfile | sort | grep -v "security.SMACK64$"

 # 2. Calling listxattr on nonexistant file should fail with -ENOENT.
 $listxattr ""
@@ -66,7 +66,7 @@ $listxattr $testfile 9
 $listxattr $testfile 11

 # 6. Calling listxattr with buffersize bigger than needed should succeed.
-$listxattr $testfile 500 | sort
+$listxattr $testfile 500 | sort | grep -v "security.SMACK64$"

 status=0
 exit
