Received: from mx1.redhat.com ([209.132.183.28]:47449 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbbLUNFI (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 21 Dec 2015 08:05:08 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id EFB308E37C
	for <fstests@vger.kernel.org>; Mon, 21 Dec 2015 13:05:07 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic/263: be quiet about unsupported operation
Date: Mon, 21 Dec 2015 21:04:57 +0800
Message-Id: <1450703097-3162-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Old kernels don't support zero-range/collapse-range/insert-range
fallocate operations and fail the test as:

  +fsx: main: filesystem does not support fallocate mode 0x10, disabling!
  +: Operation not supported
  +fsx: main: filesystem does not support fallocate mode 0x8, disabling!
  +: Operation not supported
  +fsx: main: filesystem does not support fallocate mode 0x20, disabling!
  +: Operation not supported

Adding "-q" option to fsx to quiet the warning message.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/263     | 4 ++--
 tests/generic/263.out | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/generic/263 b/tests/generic/263
index 7584bc7..d6456f8 100755
--- a/tests/generic/263
+++ b/tests/generic/263
@@ -58,8 +58,8 @@ run_fsx()
 psize=`$here/src/feature -s`
 bsize=`_min_dio_alignment $TEST_DEV`
 
-run_fsx -N 10000  -o 8192   -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
-run_fsx -N 10000  -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
+run_fsx -N 10000  -o 8192   -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -q
+run_fsx -N 10000  -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -q
 
 status=0
 exit
diff --git a/tests/generic/263.out b/tests/generic/263.out
index 64699f6..5285735 100644
--- a/tests/generic/263.out
+++ b/tests/generic/263.out
@@ -1,3 +1,3 @@
 QA output created by 263
-fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
-fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
+fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -q
+fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -q
-- 
2.5.0

