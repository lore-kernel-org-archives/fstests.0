Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38642 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757813AbaLKTOc (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Dec 2014 14:14:32 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBBJEQUq017369
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Thu, 11 Dec 2014 14:14:31 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 1/4] xfs/071: remove xfs/071.out from git
Date: Fri, 12 Dec 2014 01:16:08 +0800
Message-Id: <1418318171-5892-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1418318171-5892-1-git-send-email-eguan@redhat.com>
References: <1418318171-5892-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

xfs/071.out is supposed to linked to the right out file at run time.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/071.out | 107 ------------------------------------------------------
 1 file changed, 107 deletions(-)
 delete mode 100644 tests/xfs/071.out

diff --git a/tests/xfs/071.out b/tests/xfs/071.out
deleted file mode 100644
index 2ea0ef0..0000000
--- a/tests/xfs/071.out
+++ /dev/null
@@ -1,107 +0,0 @@
-QA output created by 071
-meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
-data     = bsize=XXX blocks=XXX, imaxpct=PCT
-         = sunit=XXX swidth=XXX, unwritten=X
-naming   =VERN bsize=XXX
-log      =LDEV bsize=XXX blocks=XXX
-realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
-
-Writing 512 bytes, offset is +0 (direct=false)
-wrote 512/512 bytes at offset <OFFSET>
-Reading 512 bytes (direct=false)
-read 512/512 bytes at offset <OFFSET>
-
-Writing 512 bytes, offset is minus 1 byte (direct=false)
-wrote 512/512 bytes at offset <OFFSET>
-Reading 512 bytes (direct=false)
-read 512/512 bytes at offset <OFFSET>
-
-Writing 512 bytes, offset is minus 1FSB (direct=false)
-wrote 512/512 bytes at offset <OFFSET>
-Reading 512 bytes (direct=false)
-read 512/512 bytes at offset <OFFSET>
-
-Writing 1 bytes, offset is minus 1FSB (direct=false)
-wrote 512/512 bytes at offset <OFFSET>
-Reading 1 bytes (direct=false)
-read 1/1 bytes at offset <OFFSET>
-
-Writing 1FSB bytes, offset is +0 (direct=true)
-wrote 512/512 bytes at offset <OFFSET>
-Reading 1FSB bytes (direct=true)
-read 512/1FSB bytes at offset <OFFSET>
-
-Writing 1FSB bytes, offset is minus 1FSB (direct=true)
-wrote 512/512 bytes at offset <OFFSET>
-Reading 1FSB bytes (direct=true)
-read 513/1FSB bytes at offset <OFFSET>
-
-=== Iterating, 2 remains
-
-
-Writing 512 bytes, offset is +0 (direct=false)
-pwrite64: File too large
-Reading 512 bytes (direct=false)
-read 0/512 bytes at offset <OFFSET>
-
-Writing 512 bytes, offset is minus 1 byte (direct=false)
-pwrite64: File too large
-Reading 512 bytes (direct=false)
-read 0/512 bytes at offset <OFFSET>
-
-Writing 512 bytes, offset is minus 1FSB (direct=false)
-wrote 512/512 bytes at offset <OFFSET>
-Reading 512 bytes (direct=false)
-read 512/512 bytes at offset <OFFSET>
-
-Writing 1 bytes, offset is minus 1FSB (direct=false)
-wrote 512/512 bytes at offset <OFFSET>
-Reading 1 bytes (direct=false)
-read 1/1 bytes at offset <OFFSET>
-
-Writing 1FSB bytes, offset is +0 (direct=true)
-pwrite64: File too large
-Reading 1FSB bytes (direct=true)
-read 0/1FSB bytes at offset <OFFSET>
-
-Writing 1FSB bytes, offset is minus 1FSB (direct=true)
-pwrite64: File too large
-Reading 1FSB bytes (direct=true)
-read 0/1FSB bytes at offset <OFFSET>
-
-=== Iterating, 1 remains
-
-
-Writing 512 bytes, offset is +0 (direct=false)
-pwrite64: File too large
-Reading 512 bytes (direct=false)
-read 0/512 bytes at offset <OFFSET>
-
-Writing 512 bytes, offset is minus 1 byte (direct=false)
-pwrite64: File too large
-Reading 512 bytes (direct=false)
-read 0/512 bytes at offset <OFFSET>
-
-Writing 512 bytes, offset is minus 1FSB (direct=false)
-pwrite64: File too large
-Reading 512 bytes (direct=false)
-read 0/512 bytes at offset <OFFSET>
-
-Writing 1 bytes, offset is minus 1FSB (direct=false)
-pwrite64: File too large
-Reading 1 bytes (direct=false)
-read 0/1 bytes at offset <OFFSET>
-
-Writing 1FSB bytes, offset is +0 (direct=true)
-pwrite64: File too large
-Reading 1FSB bytes (direct=true)
-read 0/1FSB bytes at offset <OFFSET>
-
-Writing 1FSB bytes, offset is minus 1FSB (direct=true)
-pwrite64: File too large
-Reading 1FSB bytes (direct=true)
-read 0/1FSB bytes at offset <OFFSET>
-
-=== Iterating, 0 remains
-
-
-- 
1.8.3.1

