Received: from cn.fujitsu.com ([59.151.112.132]:28580 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752023AbbHTBHF (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 19 Aug 2015 21:07:05 -0400
From: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
Subject: [PATCH] fstests: link .out to correct output when we set USE_ATTR_SECURE=yes
Date: Thu, 20 Aug 2015 09:01:04 +0800
Message-ID: <1440032464-17626-1-git-send-email-yangds.fnst@cn.fujitsu.com>
In-Reply-To: <55D52473.7050209@cn.fujitsu.com>
References: <55D52473.7050209@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: richard.weinberger@gmail.com, andreas.gruenbacher@gmail.com, Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

When we set USE_ATTR_SECURE to yes or no, the expected outputs of generic/062
would be different. So we need to link the .out to different file.

Reported-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
---
 common/rc                       |  14 +
 tests/generic/062               |   5 +
 tests/generic/062.out           | 654 ---------------------------
 tests/generic/062.out.no_secure | 654 +++++++++++++++++++++++++++
 tests/generic/062.out.secure    | 976 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1649 insertions(+), 654 deletions(-)
 delete mode 100644 tests/generic/062.out
 create mode 100644 tests/generic/062.out.no_secure
 create mode 100644 tests/generic/062.out.secure

diff --git a/common/rc b/common/rc
index 610045e..1ef262b 100644
--- a/common/rc
+++ b/common/rc
@@ -2145,6 +2145,20 @@ _link_out_file()
 	fi
 }
 
+_link_secure_out_file()
+{
+	if [ -z "$1" -o -z "$2" ]; then
+		echo Error must pass src and dst.
+		exit
+	fi
+	rm -f $2
+	if [ "$USE_ATTR_SECURE" = yes ]; then
+		ln -s $1.secure $2
+	else
+		ln -s $1.no_secure $2
+	fi
+}
+
 _die()
 {
         echo $@
diff --git a/tests/generic/062 b/tests/generic/062
index 047c930..194b638 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -23,6 +23,7 @@
 #-----------------------------------------------------------------------
 #
 
+seqfull=$0
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
@@ -94,6 +95,10 @@ if [ "$USE_ATTR_SECURE" = yes ]; then
 else
     ATTR_MODES="user trusted"
 fi
+
+# link correct .out file
+_link_secure_out_file $seq.out $seqfull.out
+
 for nsp in $ATTR_MODES; do
 	for inode in reg dir lnk dev/b dev/c dev/p; do
 
diff --git a/tests/generic/062.out b/tests/generic/062.out
deleted file mode 100644
index 8cc3c65..0000000
--- a/tests/generic/062.out
+++ /dev/null
@@ -1,654 +0,0 @@
-QA output created by 062
-*** create test bed
-SCRATCH_MNT
-SCRATCH_MNT/dev
-SCRATCH_MNT/dev/b
-SCRATCH_MNT/dev/c
-SCRATCH_MNT/dev/p
-SCRATCH_MNT/dir
-SCRATCH_MNT/lnk
-SCRATCH_MNT/reg
-
-=== TYPE reg; NAMESPACE user
-
-*** set/get one initially empty attribute
-# file: SCRATCH_MNT/reg
-user.name
-
-*** overwrite empty, set several new attributes
-*** fetch several attribute names and values (hex)
-# file: SCRATCH_MNT/reg
-user.name=0xbabe
-user.name2=0xdeadbeef
-user.name3=0xdeface
-
-*** fetch several attribute names and values (base64)
-# file: SCRATCH_MNT/reg
-user.name=0sur4=
-user.name2=0s3q2+7w==
-user.name3=0s3vrO
-
-*** shrink value of an existing attribute
-# file: SCRATCH_MNT/reg
-user.name=0xbabe
-user.name2=0xdeaf
-user.name3=0xdeface
-
-*** grow value of existing attribute
-# file: SCRATCH_MNT/reg
-user.name=0xbabe
-user.name2=0xdecade
-user.name3=0xdeface
-
-*** set an empty value for second attribute
-# file: SCRATCH_MNT/reg
-user.name2
-
-*** overwrite empty value
-# file: SCRATCH_MNT/reg
-user.name2=0xcafe
-
-*** remove attribute
-SCRATCH_MNT/reg: user.name2: No such attribute or operation not permitted
-*** final list (strings, type=reg, nsp=user)
-# file: SCRATCH_MNT/reg
-user.name=0xbabe
-user.name3=0xdeface
-
-
-=== TYPE dir; NAMESPACE user
-
-*** set/get one initially empty attribute
-# file: SCRATCH_MNT/dir
-user.name
-
-*** overwrite empty, set several new attributes
-*** fetch several attribute names and values (hex)
-# file: SCRATCH_MNT/dir
-user.name=0xbabe
-user.name2=0xdeadbeef
-user.name3=0xdeface
-
-*** fetch several attribute names and values (base64)
-# file: SCRATCH_MNT/dir
-user.name=0sur4=
-user.name2=0s3q2+7w==
-user.name3=0s3vrO
-
-*** shrink value of an existing attribute
-# file: SCRATCH_MNT/dir
-user.name=0xbabe
-user.name2=0xdeaf
-user.name3=0xdeface
-
-*** grow value of existing attribute
-# file: SCRATCH_MNT/dir
-user.name=0xbabe
-user.name2=0xdecade
-user.name3=0xdeface
-
-*** set an empty value for second attribute
-# file: SCRATCH_MNT/dir
-user.name2
-
-*** overwrite empty value
-# file: SCRATCH_MNT/dir
-user.name2=0xcafe
-
-*** remove attribute
-SCRATCH_MNT/dir: user.name2: No such attribute or operation not permitted
-*** final list (strings, type=dir, nsp=user)
-# file: SCRATCH_MNT/dir
-user.name=0xbabe
-user.name3=0xdeface
-
-
-=== TYPE lnk; NAMESPACE user
-
-*** set/get one initially empty attribute
-setfattr: SCRATCH_MNT/lnk: Operation not permitted
-*** overwrite empty, set several new attributes
-setfattr: SCRATCH_MNT/lnk: Operation not permitted
-setfattr: SCRATCH_MNT/lnk: Operation not permitted
-setfattr: SCRATCH_MNT/lnk: Operation not permitted
-*** fetch several attribute names and values (hex)
-*** fetch several attribute names and values (base64)
-*** shrink value of an existing attribute
-setfattr: SCRATCH_MNT/lnk: Operation not permitted
-*** grow value of existing attribute
-setfattr: SCRATCH_MNT/lnk: Operation not permitted
-*** set an empty value for second attribute
-setfattr: SCRATCH_MNT/lnk: Operation not permitted
-SCRATCH_MNT/lnk: user.name2: No such attribute or operation not permitted
-*** overwrite empty value
-setfattr: SCRATCH_MNT/lnk: Operation not permitted
-SCRATCH_MNT/lnk: user.name2: No such attribute or operation not permitted
-*** remove attribute
-setfattr: SCRATCH_MNT/lnk: Operation not permitted
-SCRATCH_MNT/lnk: user.name2: No such attribute or operation not permitted
-*** final list (strings, type=lnk, nsp=user)
-
-=== TYPE dev/b; NAMESPACE user
-
-*** set/get one initially empty attribute
-setfattr: SCRATCH_MNT/dev/b: Operation not permitted
-*** overwrite empty, set several new attributes
-setfattr: SCRATCH_MNT/dev/b: Operation not permitted
-setfattr: SCRATCH_MNT/dev/b: Operation not permitted
-setfattr: SCRATCH_MNT/dev/b: Operation not permitted
-*** fetch several attribute names and values (hex)
-*** fetch several attribute names and values (base64)
-*** shrink value of an existing attribute
-setfattr: SCRATCH_MNT/dev/b: Operation not permitted
-*** grow value of existing attribute
-setfattr: SCRATCH_MNT/dev/b: Operation not permitted
-*** set an empty value for second attribute
-setfattr: SCRATCH_MNT/dev/b: Operation not permitted
-SCRATCH_MNT/dev/b: user.name2: No such attribute or operation not permitted
-*** overwrite empty value
-setfattr: SCRATCH_MNT/dev/b: Operation not permitted
-SCRATCH_MNT/dev/b: user.name2: No such attribute or operation not permitted
-*** remove attribute
-setfattr: SCRATCH_MNT/dev/b: Operation not permitted
-SCRATCH_MNT/dev/b: user.name2: No such attribute or operation not permitted
-*** final list (strings, type=dev/b, nsp=user)
-
-=== TYPE dev/c; NAMESPACE user
-
-*** set/get one initially empty attribute
-setfattr: SCRATCH_MNT/dev/c: Operation not permitted
-*** overwrite empty, set several new attributes
-setfattr: SCRATCH_MNT/dev/c: Operation not permitted
-setfattr: SCRATCH_MNT/dev/c: Operation not permitted
-setfattr: SCRATCH_MNT/dev/c: Operation not permitted
-*** fetch several attribute names and values (hex)
-*** fetch several attribute names and values (base64)
-*** shrink value of an existing attribute
-setfattr: SCRATCH_MNT/dev/c: Operation not permitted
-*** grow value of existing attribute
-setfattr: SCRATCH_MNT/dev/c: Operation not permitted
-*** set an empty value for second attribute
-setfattr: SCRATCH_MNT/dev/c: Operation not permitted
-SCRATCH_MNT/dev/c: user.name2: No such attribute or operation not permitted
-*** overwrite empty value
-setfattr: SCRATCH_MNT/dev/c: Operation not permitted
-SCRATCH_MNT/dev/c: user.name2: No such attribute or operation not permitted
-*** remove attribute
-setfattr: SCRATCH_MNT/dev/c: Operation not permitted
-SCRATCH_MNT/dev/c: user.name2: No such attribute or operation not permitted
-*** final list (strings, type=dev/c, nsp=user)
-
-=== TYPE dev/p; NAMESPACE user
-
-*** set/get one initially empty attribute
-setfattr: SCRATCH_MNT/dev/p: Operation not permitted
-*** overwrite empty, set several new attributes
-setfattr: SCRATCH_MNT/dev/p: Operation not permitted
-setfattr: SCRATCH_MNT/dev/p: Operation not permitted
-setfattr: SCRATCH_MNT/dev/p: Operation not permitted
-*** fetch several attribute names and values (hex)
-*** fetch several attribute names and values (base64)
-*** shrink value of an existing attribute
-setfattr: SCRATCH_MNT/dev/p: Operation not permitted
-*** grow value of existing attribute
-setfattr: SCRATCH_MNT/dev/p: Operation not permitted
-*** set an empty value for second attribute
-setfattr: SCRATCH_MNT/dev/p: Operation not permitted
-SCRATCH_MNT/dev/p: user.name2: No such attribute or operation not permitted
-*** overwrite empty value
-setfattr: SCRATCH_MNT/dev/p: Operation not permitted
-SCRATCH_MNT/dev/p: user.name2: No such attribute or operation not permitted
-*** remove attribute
-setfattr: SCRATCH_MNT/dev/p: Operation not permitted
-SCRATCH_MNT/dev/p: user.name2: No such attribute or operation not permitted
-*** final list (strings, type=dev/p, nsp=user)
-
-=== TYPE reg; NAMESPACE trusted
-
-*** set/get one initially empty attribute
-# file: SCRATCH_MNT/reg
-trusted.name
-
-*** overwrite empty, set several new attributes
-*** fetch several attribute names and values (hex)
-# file: SCRATCH_MNT/reg
-trusted.name=0xbabe
-trusted.name2=0xdeadbeef
-trusted.name3=0xdeface
-
-*** fetch several attribute names and values (base64)
-# file: SCRATCH_MNT/reg
-trusted.name=0sur4=
-trusted.name2=0s3q2+7w==
-trusted.name3=0s3vrO
-
-*** shrink value of an existing attribute
-# file: SCRATCH_MNT/reg
-trusted.name=0xbabe
-trusted.name2=0xdeaf
-trusted.name3=0xdeface
-
-*** grow value of existing attribute
-# file: SCRATCH_MNT/reg
-trusted.name=0xbabe
-trusted.name2=0xdecade
-trusted.name3=0xdeface
-
-*** set an empty value for second attribute
-# file: SCRATCH_MNT/reg
-trusted.name2
-
-*** overwrite empty value
-# file: SCRATCH_MNT/reg
-trusted.name2=0xcafe
-
-*** remove attribute
-SCRATCH_MNT/reg: trusted.name2: No such attribute or operation not permitted
-*** final list (strings, type=reg, nsp=trusted)
-# file: SCRATCH_MNT/reg
-trusted.name=0xbabe
-trusted.name3=0xdeface
-user.name=0xbabe
-user.name3=0xdeface
-
-
-=== TYPE dir; NAMESPACE trusted
-
-*** set/get one initially empty attribute
-# file: SCRATCH_MNT/dir
-trusted.name
-
-*** overwrite empty, set several new attributes
-*** fetch several attribute names and values (hex)
-# file: SCRATCH_MNT/dir
-trusted.name=0xbabe
-trusted.name2=0xdeadbeef
-trusted.name3=0xdeface
-
-*** fetch several attribute names and values (base64)
-# file: SCRATCH_MNT/dir
-trusted.name=0sur4=
-trusted.name2=0s3q2+7w==
-trusted.name3=0s3vrO
-
-*** shrink value of an existing attribute
-# file: SCRATCH_MNT/dir
-trusted.name=0xbabe
-trusted.name2=0xdeaf
-trusted.name3=0xdeface
-
-*** grow value of existing attribute
-# file: SCRATCH_MNT/dir
-trusted.name=0xbabe
-trusted.name2=0xdecade
-trusted.name3=0xdeface
-
-*** set an empty value for second attribute
-# file: SCRATCH_MNT/dir
-trusted.name2
-
-*** overwrite empty value
-# file: SCRATCH_MNT/dir
-trusted.name2=0xcafe
-
-*** remove attribute
-SCRATCH_MNT/dir: trusted.name2: No such attribute or operation not permitted
-*** final list (strings, type=dir, nsp=trusted)
-# file: SCRATCH_MNT/dir
-trusted.name=0xbabe
-trusted.name3=0xdeface
-user.name=0xbabe
-user.name3=0xdeface
-
-
-=== TYPE lnk; NAMESPACE trusted
-
-*** set/get one initially empty attribute
-# file: SCRATCH_MNT/lnk
-trusted.name
-
-*** overwrite empty, set several new attributes
-*** fetch several attribute names and values (hex)
-# file: SCRATCH_MNT/lnk
-trusted.name=0xbabe
-trusted.name2=0xdeadbeef
-trusted.name3=0xdeface
-
-*** fetch several attribute names and values (base64)
-# file: SCRATCH_MNT/lnk
-trusted.name=0sur4=
-trusted.name2=0s3q2+7w==
-trusted.name3=0s3vrO
-
-*** shrink value of an existing attribute
-# file: SCRATCH_MNT/lnk
-trusted.name=0xbabe
-trusted.name2=0xdeaf
-trusted.name3=0xdeface
-
-*** grow value of existing attribute
-# file: SCRATCH_MNT/lnk
-trusted.name=0xbabe
-trusted.name2=0xdecade
-trusted.name3=0xdeface
-
-*** set an empty value for second attribute
-# file: SCRATCH_MNT/lnk
-trusted.name2
-
-*** overwrite empty value
-# file: SCRATCH_MNT/lnk
-trusted.name2=0xcafe
-
-*** remove attribute
-SCRATCH_MNT/lnk: trusted.name2: No such attribute or operation not permitted
-*** final list (strings, type=lnk, nsp=trusted)
-# file: SCRATCH_MNT/lnk
-trusted.name=0xbabe
-trusted.name3=0xdeface
-
-
-=== TYPE dev/b; NAMESPACE trusted
-
-*** set/get one initially empty attribute
-# file: SCRATCH_MNT/dev/b
-trusted.name
-
-*** overwrite empty, set several new attributes
-*** fetch several attribute names and values (hex)
-# file: SCRATCH_MNT/dev/b
-trusted.name=0xbabe
-trusted.name2=0xdeadbeef
-trusted.name3=0xdeface
-
-*** fetch several attribute names and values (base64)
-# file: SCRATCH_MNT/dev/b
-trusted.name=0sur4=
-trusted.name2=0s3q2+7w==
-trusted.name3=0s3vrO
-
-*** shrink value of an existing attribute
-# file: SCRATCH_MNT/dev/b
-trusted.name=0xbabe
-trusted.name2=0xdeaf
-trusted.name3=0xdeface
-
-*** grow value of existing attribute
-# file: SCRATCH_MNT/dev/b
-trusted.name=0xbabe
-trusted.name2=0xdecade
-trusted.name3=0xdeface
-
-*** set an empty value for second attribute
-# file: SCRATCH_MNT/dev/b
-trusted.name2
-
-*** overwrite empty value
-# file: SCRATCH_MNT/dev/b
-trusted.name2=0xcafe
-
-*** remove attribute
-SCRATCH_MNT/dev/b: trusted.name2: No such attribute or operation not permitted
-*** final list (strings, type=dev/b, nsp=trusted)
-# file: SCRATCH_MNT/dev/b
-trusted.name=0xbabe
-trusted.name3=0xdeface
-
-
-=== TYPE dev/c; NAMESPACE trusted
-
-*** set/get one initially empty attribute
-# file: SCRATCH_MNT/dev/c
-trusted.name
-
-*** overwrite empty, set several new attributes
-*** fetch several attribute names and values (hex)
-# file: SCRATCH_MNT/dev/c
-trusted.name=0xbabe
-trusted.name2=0xdeadbeef
-trusted.name3=0xdeface
-
-*** fetch several attribute names and values (base64)
-# file: SCRATCH_MNT/dev/c
-trusted.name=0sur4=
-trusted.name2=0s3q2+7w==
-trusted.name3=0s3vrO
-
-*** shrink value of an existing attribute
-# file: SCRATCH_MNT/dev/c
-trusted.name=0xbabe
-trusted.name2=0xdeaf
-trusted.name3=0xdeface
-
-*** grow value of existing attribute
-# file: SCRATCH_MNT/dev/c
-trusted.name=0xbabe
-trusted.name2=0xdecade
-trusted.name3=0xdeface
-
-*** set an empty value for second attribute
-# file: SCRATCH_MNT/dev/c
-trusted.name2
-
-*** overwrite empty value
-# file: SCRATCH_MNT/dev/c
-trusted.name2=0xcafe
-
-*** remove attribute
-SCRATCH_MNT/dev/c: trusted.name2: No such attribute or operation not permitted
-*** final list (strings, type=dev/c, nsp=trusted)
-# file: SCRATCH_MNT/dev/c
-trusted.name=0xbabe
-trusted.name3=0xdeface
-
-
-=== TYPE dev/p; NAMESPACE trusted
-
-*** set/get one initially empty attribute
-# file: SCRATCH_MNT/dev/p
-trusted.name
-
-*** overwrite empty, set several new attributes
-*** fetch several attribute names and values (hex)
-# file: SCRATCH_MNT/dev/p
-trusted.name=0xbabe
-trusted.name2=0xdeadbeef
-trusted.name3=0xdeface
-
-*** fetch several attribute names and values (base64)
-# file: SCRATCH_MNT/dev/p
-trusted.name=0sur4=
-trusted.name2=0s3q2+7w==
-trusted.name3=0s3vrO
-
-*** shrink value of an existing attribute
-# file: SCRATCH_MNT/dev/p
-trusted.name=0xbabe
-trusted.name2=0xdeaf
-trusted.name3=0xdeface
-
-*** grow value of existing attribute
-# file: SCRATCH_MNT/dev/p
-trusted.name=0xbabe
-trusted.name2=0xdecade
-trusted.name3=0xdeface
-
-*** set an empty value for second attribute
-# file: SCRATCH_MNT/dev/p
-trusted.name2
-
-*** overwrite empty value
-# file: SCRATCH_MNT/dev/p
-trusted.name2=0xcafe
-
-*** remove attribute
-SCRATCH_MNT/dev/p: trusted.name2: No such attribute or operation not permitted
-*** final list (strings, type=dev/p, nsp=trusted)
-# file: SCRATCH_MNT/dev/p
-trusted.name=0xbabe
-trusted.name3=0xdeface
-
-
-
-*** extend test bed
-SCRATCH_MNT
-SCRATCH_MNT/descend
-SCRATCH_MNT/descend/and
-SCRATCH_MNT/descend/down
-SCRATCH_MNT/descend/down/here
-SCRATCH_MNT/dev
-SCRATCH_MNT/dev/b
-SCRATCH_MNT/dev/c
-SCRATCH_MNT/dev/p
-SCRATCH_MNT/dir
-SCRATCH_MNT/here
-SCRATCH_MNT/here/up
-SCRATCH_MNT/here/up/ascend
-SCRATCH_MNT/lnk
-SCRATCH_MNT/reg
-
-*** directory descent with us following symlinks
-# file: SCRATCH_MNT/descend
-user.1=0x3233
-user.x=0x797a
-
-# file: SCRATCH_MNT/descend/and/ascend
-trusted.9=0x3837
-trusted.a=0x6263
-
-# file: SCRATCH_MNT/descend/down
-user.1=0x3233
-user.x=0x797a
-
-# file: SCRATCH_MNT/descend/down/here
-user.1=0x3233
-user.x=0x797a
-
-# file: SCRATCH_MNT/dev/b
-trusted.name=0xbabe
-trusted.name3=0xdeface
-
-# file: SCRATCH_MNT/dev/c
-trusted.name=0xbabe
-trusted.name3=0xdeface
-
-# file: SCRATCH_MNT/dev/p
-trusted.name=0xbabe
-trusted.name3=0xdeface
-
-# file: SCRATCH_MNT/dir
-trusted.name=0xbabe
-trusted.name3=0xdeface
-user.name=0xbabe
-user.name3=0xdeface
-
-# file: SCRATCH_MNT/here
-trusted.9=0x3837
-trusted.a=0x6263
-
-# file: SCRATCH_MNT/here/up
-trusted.9=0x3837
-trusted.a=0x6263
-
-# file: SCRATCH_MNT/here/up/ascend
-trusted.9=0x3837
-trusted.a=0x6263
-
-# file: SCRATCH_MNT/lnk
-trusted.name=0xbabe
-trusted.name3=0xdeface
-
-# file: SCRATCH_MNT/reg
-trusted.name=0xbabe
-trusted.name3=0xdeface
-user.name=0xbabe
-user.name3=0xdeface
-
-
-*** directory descent without following symlinks
-# file: SCRATCH_MNT/descend
-user.1=0x3233
-user.x=0x797a
-
-# file: SCRATCH_MNT/descend/down
-user.1=0x3233
-user.x=0x797a
-
-# file: SCRATCH_MNT/descend/down/here
-user.1=0x3233
-user.x=0x797a
-
-# file: SCRATCH_MNT/dev/b
-trusted.name=0xbabe
-trusted.name3=0xdeface
-
-# file: SCRATCH_MNT/dev/c
-trusted.name=0xbabe
-trusted.name3=0xdeface
-
-# file: SCRATCH_MNT/dev/p
-trusted.name=0xbabe
-trusted.name3=0xdeface
-
-# file: SCRATCH_MNT/dir
-trusted.name=0xbabe
-trusted.name3=0xdeface
-user.name=0xbabe
-user.name3=0xdeface
-
-# file: SCRATCH_MNT/here
-trusted.9=0x3837
-trusted.a=0x6263
-
-# file: SCRATCH_MNT/here/up
-trusted.9=0x3837
-trusted.a=0x6263
-
-# file: SCRATCH_MNT/here/up/ascend
-trusted.9=0x3837
-trusted.a=0x6263
-
-# file: SCRATCH_MNT/lnk
-trusted.name=0xbabe
-trusted.name3=0xdeface
-
-# file: SCRATCH_MNT/reg
-trusted.name=0xbabe
-trusted.name3=0xdeface
-user.name=0xbabe
-user.name3=0xdeface
-
-
-
-*** backup everything
-*** clear out the scratch device
-*** reset test bed with no extended attributes
-*** create test bed
-SCRATCH_MNT
-SCRATCH_MNT/dev
-SCRATCH_MNT/dev/b
-SCRATCH_MNT/dev/c
-SCRATCH_MNT/dev/p
-SCRATCH_MNT/dir
-SCRATCH_MNT/lnk
-SCRATCH_MNT/reg
-*** extend test bed
-SCRATCH_MNT
-SCRATCH_MNT/descend
-SCRATCH_MNT/descend/and
-SCRATCH_MNT/descend/down
-SCRATCH_MNT/descend/down/here
-SCRATCH_MNT/dev
-SCRATCH_MNT/dev/b
-SCRATCH_MNT/dev/c
-SCRATCH_MNT/dev/p
-SCRATCH_MNT/dir
-SCRATCH_MNT/here
-SCRATCH_MNT/here/up
-SCRATCH_MNT/here/up/ascend
-SCRATCH_MNT/lnk
-SCRATCH_MNT/reg
-*** restore everything
-*** compare before and after backups
-
-*** unmount
diff --git a/tests/generic/062.out.no_secure b/tests/generic/062.out.no_secure
new file mode 100644
index 0000000..8cc3c65
--- /dev/null
+++ b/tests/generic/062.out.no_secure
@@ -0,0 +1,654 @@
+QA output created by 062
+*** create test bed
+SCRATCH_MNT
+SCRATCH_MNT/dev
+SCRATCH_MNT/dev/b
+SCRATCH_MNT/dev/c
+SCRATCH_MNT/dev/p
+SCRATCH_MNT/dir
+SCRATCH_MNT/lnk
+SCRATCH_MNT/reg
+
+=== TYPE reg; NAMESPACE user
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/reg
+user.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/reg
+user.name=0xbabe
+user.name2=0xdeadbeef
+user.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/reg
+user.name=0sur4=
+user.name2=0s3q2+7w==
+user.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/reg
+user.name=0xbabe
+user.name2=0xdeaf
+user.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/reg
+user.name=0xbabe
+user.name2=0xdecade
+user.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/reg
+user.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/reg
+user.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/reg: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=reg, nsp=user)
+# file: SCRATCH_MNT/reg
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE dir; NAMESPACE user
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dir
+user.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dir
+user.name=0xbabe
+user.name2=0xdeadbeef
+user.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dir
+user.name=0sur4=
+user.name2=0s3q2+7w==
+user.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dir
+user.name=0xbabe
+user.name2=0xdeaf
+user.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dir
+user.name=0xbabe
+user.name2=0xdecade
+user.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dir
+user.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dir
+user.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dir: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=dir, nsp=user)
+# file: SCRATCH_MNT/dir
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE lnk; NAMESPACE user
+
+*** set/get one initially empty attribute
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+*** overwrite empty, set several new attributes
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+*** fetch several attribute names and values (hex)
+*** fetch several attribute names and values (base64)
+*** shrink value of an existing attribute
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+*** grow value of existing attribute
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+*** set an empty value for second attribute
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+SCRATCH_MNT/lnk: user.name2: No such attribute or operation not permitted
+*** overwrite empty value
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+SCRATCH_MNT/lnk: user.name2: No such attribute or operation not permitted
+*** remove attribute
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+SCRATCH_MNT/lnk: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=lnk, nsp=user)
+
+=== TYPE dev/b; NAMESPACE user
+
+*** set/get one initially empty attribute
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+*** overwrite empty, set several new attributes
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+*** fetch several attribute names and values (hex)
+*** fetch several attribute names and values (base64)
+*** shrink value of an existing attribute
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+*** grow value of existing attribute
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+*** set an empty value for second attribute
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+SCRATCH_MNT/dev/b: user.name2: No such attribute or operation not permitted
+*** overwrite empty value
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+SCRATCH_MNT/dev/b: user.name2: No such attribute or operation not permitted
+*** remove attribute
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+SCRATCH_MNT/dev/b: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/b, nsp=user)
+
+=== TYPE dev/c; NAMESPACE user
+
+*** set/get one initially empty attribute
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+*** overwrite empty, set several new attributes
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+*** fetch several attribute names and values (hex)
+*** fetch several attribute names and values (base64)
+*** shrink value of an existing attribute
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+*** grow value of existing attribute
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+*** set an empty value for second attribute
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+SCRATCH_MNT/dev/c: user.name2: No such attribute or operation not permitted
+*** overwrite empty value
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+SCRATCH_MNT/dev/c: user.name2: No such attribute or operation not permitted
+*** remove attribute
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+SCRATCH_MNT/dev/c: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/c, nsp=user)
+
+=== TYPE dev/p; NAMESPACE user
+
+*** set/get one initially empty attribute
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+*** overwrite empty, set several new attributes
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+*** fetch several attribute names and values (hex)
+*** fetch several attribute names and values (base64)
+*** shrink value of an existing attribute
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+*** grow value of existing attribute
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+*** set an empty value for second attribute
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+SCRATCH_MNT/dev/p: user.name2: No such attribute or operation not permitted
+*** overwrite empty value
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+SCRATCH_MNT/dev/p: user.name2: No such attribute or operation not permitted
+*** remove attribute
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+SCRATCH_MNT/dev/p: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/p, nsp=user)
+
+=== TYPE reg; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/reg
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/reg
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/reg
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/reg
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/reg
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/reg
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/reg
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/reg: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=reg, nsp=trusted)
+# file: SCRATCH_MNT/reg
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE dir; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dir
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dir
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dir
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dir
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dir
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dir
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dir
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dir: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=dir, nsp=trusted)
+# file: SCRATCH_MNT/dir
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE lnk; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/lnk
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/lnk
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/lnk
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/lnk
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/lnk
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/lnk
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/lnk
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/lnk: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=lnk, nsp=trusted)
+# file: SCRATCH_MNT/lnk
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+
+=== TYPE dev/b; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dev/b
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dev/b
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dev/b
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dev/b
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dev/b
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dev/b
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dev/b
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dev/b: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/b, nsp=trusted)
+# file: SCRATCH_MNT/dev/b
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+
+=== TYPE dev/c; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dev/c
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dev/c
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dev/c
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dev/c
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dev/c
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dev/c
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dev/c
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dev/c: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/c, nsp=trusted)
+# file: SCRATCH_MNT/dev/c
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+
+=== TYPE dev/p; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dev/p
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dev/p
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dev/p
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dev/p
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dev/p
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dev/p
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dev/p
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dev/p: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/p, nsp=trusted)
+# file: SCRATCH_MNT/dev/p
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+
+
+*** extend test bed
+SCRATCH_MNT
+SCRATCH_MNT/descend
+SCRATCH_MNT/descend/and
+SCRATCH_MNT/descend/down
+SCRATCH_MNT/descend/down/here
+SCRATCH_MNT/dev
+SCRATCH_MNT/dev/b
+SCRATCH_MNT/dev/c
+SCRATCH_MNT/dev/p
+SCRATCH_MNT/dir
+SCRATCH_MNT/here
+SCRATCH_MNT/here/up
+SCRATCH_MNT/here/up/ascend
+SCRATCH_MNT/lnk
+SCRATCH_MNT/reg
+
+*** directory descent with us following symlinks
+# file: SCRATCH_MNT/descend
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/descend/and/ascend
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/descend/down
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/descend/down/here
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/dev/b
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+# file: SCRATCH_MNT/dev/c
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+# file: SCRATCH_MNT/dev/p
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+# file: SCRATCH_MNT/dir
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+# file: SCRATCH_MNT/here
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/here/up
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/here/up/ascend
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/lnk
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+# file: SCRATCH_MNT/reg
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+*** directory descent without following symlinks
+# file: SCRATCH_MNT/descend
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/descend/down
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/descend/down/here
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/dev/b
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+# file: SCRATCH_MNT/dev/c
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+# file: SCRATCH_MNT/dev/p
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+# file: SCRATCH_MNT/dir
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+# file: SCRATCH_MNT/here
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/here/up
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/here/up/ascend
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/lnk
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+# file: SCRATCH_MNT/reg
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+
+*** backup everything
+*** clear out the scratch device
+*** reset test bed with no extended attributes
+*** create test bed
+SCRATCH_MNT
+SCRATCH_MNT/dev
+SCRATCH_MNT/dev/b
+SCRATCH_MNT/dev/c
+SCRATCH_MNT/dev/p
+SCRATCH_MNT/dir
+SCRATCH_MNT/lnk
+SCRATCH_MNT/reg
+*** extend test bed
+SCRATCH_MNT
+SCRATCH_MNT/descend
+SCRATCH_MNT/descend/and
+SCRATCH_MNT/descend/down
+SCRATCH_MNT/descend/down/here
+SCRATCH_MNT/dev
+SCRATCH_MNT/dev/b
+SCRATCH_MNT/dev/c
+SCRATCH_MNT/dev/p
+SCRATCH_MNT/dir
+SCRATCH_MNT/here
+SCRATCH_MNT/here/up
+SCRATCH_MNT/here/up/ascend
+SCRATCH_MNT/lnk
+SCRATCH_MNT/reg
+*** restore everything
+*** compare before and after backups
+
+*** unmount
diff --git a/tests/generic/062.out.secure b/tests/generic/062.out.secure
new file mode 100644
index 0000000..1c7214d
--- /dev/null
+++ b/tests/generic/062.out.secure
@@ -0,0 +1,976 @@
+QA output created by 062
+*** create test bed
+SCRATCH_MNT
+SCRATCH_MNT/dev
+SCRATCH_MNT/dev/b
+SCRATCH_MNT/dev/c
+SCRATCH_MNT/dev/p
+SCRATCH_MNT/dir
+SCRATCH_MNT/lnk
+SCRATCH_MNT/reg
+
+=== TYPE reg; NAMESPACE user
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/reg
+user.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/reg
+user.name=0xbabe
+user.name2=0xdeadbeef
+user.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/reg
+user.name=0sur4=
+user.name2=0s3q2+7w==
+user.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/reg
+user.name=0xbabe
+user.name2=0xdeaf
+user.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/reg
+user.name=0xbabe
+user.name2=0xdecade
+user.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/reg
+user.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/reg
+user.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/reg: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=reg, nsp=user)
+# file: SCRATCH_MNT/reg
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE dir; NAMESPACE user
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dir
+user.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dir
+user.name=0xbabe
+user.name2=0xdeadbeef
+user.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dir
+user.name=0sur4=
+user.name2=0s3q2+7w==
+user.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dir
+user.name=0xbabe
+user.name2=0xdeaf
+user.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dir
+user.name=0xbabe
+user.name2=0xdecade
+user.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dir
+user.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dir
+user.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dir: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=dir, nsp=user)
+# file: SCRATCH_MNT/dir
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE lnk; NAMESPACE user
+
+*** set/get one initially empty attribute
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+*** overwrite empty, set several new attributes
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+*** fetch several attribute names and values (hex)
+*** fetch several attribute names and values (base64)
+*** shrink value of an existing attribute
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+*** grow value of existing attribute
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+*** set an empty value for second attribute
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+SCRATCH_MNT/lnk: user.name2: No such attribute or operation not permitted
+*** overwrite empty value
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+SCRATCH_MNT/lnk: user.name2: No such attribute or operation not permitted
+*** remove attribute
+setfattr: SCRATCH_MNT/lnk: Operation not permitted
+SCRATCH_MNT/lnk: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=lnk, nsp=user)
+
+=== TYPE dev/b; NAMESPACE user
+
+*** set/get one initially empty attribute
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+*** overwrite empty, set several new attributes
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+*** fetch several attribute names and values (hex)
+*** fetch several attribute names and values (base64)
+*** shrink value of an existing attribute
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+*** grow value of existing attribute
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+*** set an empty value for second attribute
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+SCRATCH_MNT/dev/b: user.name2: No such attribute or operation not permitted
+*** overwrite empty value
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+SCRATCH_MNT/dev/b: user.name2: No such attribute or operation not permitted
+*** remove attribute
+setfattr: SCRATCH_MNT/dev/b: Operation not permitted
+SCRATCH_MNT/dev/b: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/b, nsp=user)
+
+=== TYPE dev/c; NAMESPACE user
+
+*** set/get one initially empty attribute
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+*** overwrite empty, set several new attributes
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+*** fetch several attribute names and values (hex)
+*** fetch several attribute names and values (base64)
+*** shrink value of an existing attribute
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+*** grow value of existing attribute
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+*** set an empty value for second attribute
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+SCRATCH_MNT/dev/c: user.name2: No such attribute or operation not permitted
+*** overwrite empty value
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+SCRATCH_MNT/dev/c: user.name2: No such attribute or operation not permitted
+*** remove attribute
+setfattr: SCRATCH_MNT/dev/c: Operation not permitted
+SCRATCH_MNT/dev/c: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/c, nsp=user)
+
+=== TYPE dev/p; NAMESPACE user
+
+*** set/get one initially empty attribute
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+*** overwrite empty, set several new attributes
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+*** fetch several attribute names and values (hex)
+*** fetch several attribute names and values (base64)
+*** shrink value of an existing attribute
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+*** grow value of existing attribute
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+*** set an empty value for second attribute
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+SCRATCH_MNT/dev/p: user.name2: No such attribute or operation not permitted
+*** overwrite empty value
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+SCRATCH_MNT/dev/p: user.name2: No such attribute or operation not permitted
+*** remove attribute
+setfattr: SCRATCH_MNT/dev/p: Operation not permitted
+SCRATCH_MNT/dev/p: user.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/p, nsp=user)
+
+=== TYPE reg; NAMESPACE security
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/reg
+security.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/reg
+security.name=0xbabe
+security.name2=0xdeadbeef
+security.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/reg
+security.name=0sur4=
+security.name2=0s3q2+7w==
+security.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/reg
+security.name=0xbabe
+security.name2=0xdeaf
+security.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/reg
+security.name=0xbabe
+security.name2=0xdecade
+security.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/reg
+security.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/reg
+security.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/reg: security.name2: No such attribute or operation not permitted
+*** final list (strings, type=reg, nsp=security)
+# file: SCRATCH_MNT/reg
+security.name=0xbabe
+security.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE dir; NAMESPACE security
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dir
+security.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dir
+security.name=0xbabe
+security.name2=0xdeadbeef
+security.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dir
+security.name=0sur4=
+security.name2=0s3q2+7w==
+security.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dir
+security.name=0xbabe
+security.name2=0xdeaf
+security.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dir
+security.name=0xbabe
+security.name2=0xdecade
+security.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dir
+security.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dir
+security.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dir: security.name2: No such attribute or operation not permitted
+*** final list (strings, type=dir, nsp=security)
+# file: SCRATCH_MNT/dir
+security.name=0xbabe
+security.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE lnk; NAMESPACE security
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/lnk
+security.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/lnk
+security.name=0xbabe
+security.name2=0xdeadbeef
+security.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/lnk
+security.name=0sur4=
+security.name2=0s3q2+7w==
+security.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/lnk
+security.name=0xbabe
+security.name2=0xdeaf
+security.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/lnk
+security.name=0xbabe
+security.name2=0xdecade
+security.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/lnk
+security.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/lnk
+security.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/lnk: security.name2: No such attribute or operation not permitted
+*** final list (strings, type=lnk, nsp=security)
+# file: SCRATCH_MNT/lnk
+security.name=0xbabe
+security.name3=0xdeface
+
+
+=== TYPE dev/b; NAMESPACE security
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dev/b
+security.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dev/b
+security.name=0xbabe
+security.name2=0xdeadbeef
+security.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dev/b
+security.name=0sur4=
+security.name2=0s3q2+7w==
+security.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dev/b
+security.name=0xbabe
+security.name2=0xdeaf
+security.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dev/b
+security.name=0xbabe
+security.name2=0xdecade
+security.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dev/b
+security.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dev/b
+security.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dev/b: security.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/b, nsp=security)
+# file: SCRATCH_MNT/dev/b
+security.name=0xbabe
+security.name3=0xdeface
+
+
+=== TYPE dev/c; NAMESPACE security
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dev/c
+security.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dev/c
+security.name=0xbabe
+security.name2=0xdeadbeef
+security.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dev/c
+security.name=0sur4=
+security.name2=0s3q2+7w==
+security.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dev/c
+security.name=0xbabe
+security.name2=0xdeaf
+security.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dev/c
+security.name=0xbabe
+security.name2=0xdecade
+security.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dev/c
+security.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dev/c
+security.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dev/c: security.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/c, nsp=security)
+# file: SCRATCH_MNT/dev/c
+security.name=0xbabe
+security.name3=0xdeface
+
+
+=== TYPE dev/p; NAMESPACE security
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dev/p
+security.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dev/p
+security.name=0xbabe
+security.name2=0xdeadbeef
+security.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dev/p
+security.name=0sur4=
+security.name2=0s3q2+7w==
+security.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dev/p
+security.name=0xbabe
+security.name2=0xdeaf
+security.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dev/p
+security.name=0xbabe
+security.name2=0xdecade
+security.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dev/p
+security.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dev/p
+security.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dev/p: security.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/p, nsp=security)
+# file: SCRATCH_MNT/dev/p
+security.name=0xbabe
+security.name3=0xdeface
+
+
+=== TYPE reg; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/reg
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/reg
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/reg
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/reg
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/reg
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/reg
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/reg
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/reg: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=reg, nsp=trusted)
+# file: SCRATCH_MNT/reg
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE dir; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dir
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dir
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dir
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dir
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dir
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dir
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dir
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dir: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=dir, nsp=trusted)
+# file: SCRATCH_MNT/dir
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+=== TYPE lnk; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/lnk
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/lnk
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/lnk
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/lnk
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/lnk
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/lnk
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/lnk
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/lnk: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=lnk, nsp=trusted)
+# file: SCRATCH_MNT/lnk
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+
+=== TYPE dev/b; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dev/b
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dev/b
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dev/b
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dev/b
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dev/b
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dev/b
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dev/b
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dev/b: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/b, nsp=trusted)
+# file: SCRATCH_MNT/dev/b
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+
+=== TYPE dev/c; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dev/c
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dev/c
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dev/c
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dev/c
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dev/c
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dev/c
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dev/c
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dev/c: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/c, nsp=trusted)
+# file: SCRATCH_MNT/dev/c
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+
+=== TYPE dev/p; NAMESPACE trusted
+
+*** set/get one initially empty attribute
+# file: SCRATCH_MNT/dev/p
+trusted.name
+
+*** overwrite empty, set several new attributes
+*** fetch several attribute names and values (hex)
+# file: SCRATCH_MNT/dev/p
+trusted.name=0xbabe
+trusted.name2=0xdeadbeef
+trusted.name3=0xdeface
+
+*** fetch several attribute names and values (base64)
+# file: SCRATCH_MNT/dev/p
+trusted.name=0sur4=
+trusted.name2=0s3q2+7w==
+trusted.name3=0s3vrO
+
+*** shrink value of an existing attribute
+# file: SCRATCH_MNT/dev/p
+trusted.name=0xbabe
+trusted.name2=0xdeaf
+trusted.name3=0xdeface
+
+*** grow value of existing attribute
+# file: SCRATCH_MNT/dev/p
+trusted.name=0xbabe
+trusted.name2=0xdecade
+trusted.name3=0xdeface
+
+*** set an empty value for second attribute
+# file: SCRATCH_MNT/dev/p
+trusted.name2
+
+*** overwrite empty value
+# file: SCRATCH_MNT/dev/p
+trusted.name2=0xcafe
+
+*** remove attribute
+SCRATCH_MNT/dev/p: trusted.name2: No such attribute or operation not permitted
+*** final list (strings, type=dev/p, nsp=trusted)
+# file: SCRATCH_MNT/dev/p
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+
+
+*** extend test bed
+SCRATCH_MNT
+SCRATCH_MNT/descend
+SCRATCH_MNT/descend/and
+SCRATCH_MNT/descend/down
+SCRATCH_MNT/descend/down/here
+SCRATCH_MNT/dev
+SCRATCH_MNT/dev/b
+SCRATCH_MNT/dev/c
+SCRATCH_MNT/dev/p
+SCRATCH_MNT/dir
+SCRATCH_MNT/here
+SCRATCH_MNT/here/up
+SCRATCH_MNT/here/up/ascend
+SCRATCH_MNT/lnk
+SCRATCH_MNT/reg
+
+*** directory descent with us following symlinks
+# file: SCRATCH_MNT/descend
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/descend/and/ascend
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/descend/down
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/descend/down/here
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/dev/b
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+# file: SCRATCH_MNT/dev/c
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+# file: SCRATCH_MNT/dev/p
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+# file: SCRATCH_MNT/dir
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+# file: SCRATCH_MNT/here
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/here/up
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/here/up/ascend
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/lnk
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+# file: SCRATCH_MNT/reg
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+*** directory descent without following symlinks
+# file: SCRATCH_MNT/descend
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/descend/down
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/descend/down/here
+user.1=0x3233
+user.x=0x797a
+
+# file: SCRATCH_MNT/dev/b
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+# file: SCRATCH_MNT/dev/c
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+# file: SCRATCH_MNT/dev/p
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+# file: SCRATCH_MNT/dir
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+# file: SCRATCH_MNT/here
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/here/up
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/here/up/ascend
+trusted.9=0x3837
+trusted.a=0x6263
+
+# file: SCRATCH_MNT/lnk
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+
+# file: SCRATCH_MNT/reg
+security.name=0xbabe
+security.name3=0xdeface
+trusted.name=0xbabe
+trusted.name3=0xdeface
+user.name=0xbabe
+user.name3=0xdeface
+
+
+
+*** backup everything
+*** clear out the scratch device
+*** reset test bed with no extended attributes
+*** create test bed
+SCRATCH_MNT
+SCRATCH_MNT/dev
+SCRATCH_MNT/dev/b
+SCRATCH_MNT/dev/c
+SCRATCH_MNT/dev/p
+SCRATCH_MNT/dir
+SCRATCH_MNT/lnk
+SCRATCH_MNT/reg
+*** extend test bed
+SCRATCH_MNT
+SCRATCH_MNT/descend
+SCRATCH_MNT/descend/and
+SCRATCH_MNT/descend/down
+SCRATCH_MNT/descend/down/here
+SCRATCH_MNT/dev
+SCRATCH_MNT/dev/b
+SCRATCH_MNT/dev/c
+SCRATCH_MNT/dev/p
+SCRATCH_MNT/dir
+SCRATCH_MNT/here
+SCRATCH_MNT/here/up
+SCRATCH_MNT/here/up/ascend
+SCRATCH_MNT/lnk
+SCRATCH_MNT/reg
+*** restore everything
+*** compare before and after backups
+
+*** unmount
-- 
1.8.4.2

