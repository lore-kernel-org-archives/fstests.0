Received: from mail.cn.fujitsu.com ([183.91.158.132]:3957 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727797AbeHVLtI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Aug 2018 07:49:08 -0400
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id EF35A4B6ED48
        for <fstests@vger.kernel.org>; Wed, 22 Aug 2018 16:25:14 +0800 (CST)
From: Su Yue <suy.fnst@cn.fujitsu.com>
Subject: [PATCH] xfstests: generic/062: Change output of empty attribute values
Date: Wed, 22 Aug 2018 16:32:01 +0800
Message-ID: <20180822083201.14851-1-suy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: suy.fnst@cn.fujitsu.com
List-ID: <fstests@vger.kernel.org>

Since v2.4.47 of attr(5)[1], commit 0550d2bc989d (Properly
set and report empty attribute values) changed output format of
empty attribute value with quotes.

Here, change generic/062.out to match the actual output.

[1]: https://git.savannah.nongnu.org/git/attr.git

Signed-off-by: Su Yue <suy.fnst@cn.fujitsu.com>
---
 tests/generic/062.out | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tests/generic/062.out b/tests/generic/062.out
index 8cc3c655..9b9cd744 100644
--- a/tests/generic/062.out
+++ b/tests/generic/062.out
@@ -13,7 +13,7 @@ SCRATCH_MNT/reg
 
 *** set/get one initially empty attribute
 # file: SCRATCH_MNT/reg
-user.name
+user.name=""
 
 *** overwrite empty, set several new attributes
 *** fetch several attribute names and values (hex)
@@ -42,7 +42,7 @@ user.name3=0xdeface
 
 *** set an empty value for second attribute
 # file: SCRATCH_MNT/reg
-user.name2
+user.name2=""
 
 *** overwrite empty value
 # file: SCRATCH_MNT/reg
@@ -60,7 +60,7 @@ user.name3=0xdeface
 
 *** set/get one initially empty attribute
 # file: SCRATCH_MNT/dir
-user.name
+user.name=""
 
 *** overwrite empty, set several new attributes
 *** fetch several attribute names and values (hex)
@@ -89,7 +89,7 @@ user.name3=0xdeface
 
 *** set an empty value for second attribute
 # file: SCRATCH_MNT/dir
-user.name2
+user.name2=""
 
 *** overwrite empty value
 # file: SCRATCH_MNT/dir
@@ -207,7 +207,7 @@ SCRATCH_MNT/dev/p: user.name2: No such attribute or operation not permitted
 
 *** set/get one initially empty attribute
 # file: SCRATCH_MNT/reg
-trusted.name
+trusted.name=""
 
 *** overwrite empty, set several new attributes
 *** fetch several attribute names and values (hex)
@@ -236,7 +236,7 @@ trusted.name3=0xdeface
 
 *** set an empty value for second attribute
 # file: SCRATCH_MNT/reg
-trusted.name2
+trusted.name2=""
 
 *** overwrite empty value
 # file: SCRATCH_MNT/reg
@@ -256,7 +256,7 @@ user.name3=0xdeface
 
 *** set/get one initially empty attribute
 # file: SCRATCH_MNT/dir
-trusted.name
+trusted.name=""
 
 *** overwrite empty, set several new attributes
 *** fetch several attribute names and values (hex)
@@ -285,7 +285,7 @@ trusted.name3=0xdeface
 
 *** set an empty value for second attribute
 # file: SCRATCH_MNT/dir
-trusted.name2
+trusted.name2=""
 
 *** overwrite empty value
 # file: SCRATCH_MNT/dir
@@ -305,7 +305,7 @@ user.name3=0xdeface
 
 *** set/get one initially empty attribute
 # file: SCRATCH_MNT/lnk
-trusted.name
+trusted.name=""
 
 *** overwrite empty, set several new attributes
 *** fetch several attribute names and values (hex)
@@ -334,7 +334,7 @@ trusted.name3=0xdeface
 
 *** set an empty value for second attribute
 # file: SCRATCH_MNT/lnk
-trusted.name2
+trusted.name2=""
 
 *** overwrite empty value
 # file: SCRATCH_MNT/lnk
@@ -352,7 +352,7 @@ trusted.name3=0xdeface
 
 *** set/get one initially empty attribute
 # file: SCRATCH_MNT/dev/b
-trusted.name
+trusted.name=""
 
 *** overwrite empty, set several new attributes
 *** fetch several attribute names and values (hex)
@@ -381,7 +381,7 @@ trusted.name3=0xdeface
 
 *** set an empty value for second attribute
 # file: SCRATCH_MNT/dev/b
-trusted.name2
+trusted.name2=""
 
 *** overwrite empty value
 # file: SCRATCH_MNT/dev/b
@@ -399,7 +399,7 @@ trusted.name3=0xdeface
 
 *** set/get one initially empty attribute
 # file: SCRATCH_MNT/dev/c
-trusted.name
+trusted.name=""
 
 *** overwrite empty, set several new attributes
 *** fetch several attribute names and values (hex)
@@ -428,7 +428,7 @@ trusted.name3=0xdeface
 
 *** set an empty value for second attribute
 # file: SCRATCH_MNT/dev/c
-trusted.name2
+trusted.name2=""
 
 *** overwrite empty value
 # file: SCRATCH_MNT/dev/c
@@ -446,7 +446,7 @@ trusted.name3=0xdeface
 
 *** set/get one initially empty attribute
 # file: SCRATCH_MNT/dev/p
-trusted.name
+trusted.name=""
 
 *** overwrite empty, set several new attributes
 *** fetch several attribute names and values (hex)
@@ -475,7 +475,7 @@ trusted.name3=0xdeface
 
 *** set an empty value for second attribute
 # file: SCRATCH_MNT/dev/p
-trusted.name2
+trusted.name2=""
 
 *** overwrite empty value
 # file: SCRATCH_MNT/dev/p
-- 
2.18.0
