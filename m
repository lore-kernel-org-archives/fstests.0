Received: from aserp2130.oracle.com ([141.146.126.79]:42464 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeDQFUj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 Apr 2018 01:20:39 -0400
Date: Mon, 16 Apr 2018 22:20:35 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] generic/304: only dedupe the last 64k of the single byte file
Message-ID: <20180417052035.GC5201@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

From: Darrick J. Wong <darrick.wong@oracle.com>

Commit 1ddae54555b62 ("common/rc: add missing 'local' keywords") exposed
a long-hidden bug in generic/304 -- previously we'd set len to 8EiB, but
_pwrite_byte reset it to 1 because the helper clumsily polluted the
caller's variable namespace.  Now that's fixed, but we send an 8EiB
dedupe request to the kernel, which on XFS locks up the kernel while
doing this.  The point of this test is to demonstrate that one cannot
dedupe the last byte of a (2^63-1) byte file (that's the way the
interface has behaved historically), so start at 64k below that instead
of offset zero.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/generic/304 |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/304 b/tests/generic/304
index 6c36a68..ff8ddf8 100755
--- a/tests/generic/304
+++ b/tests/generic/304
@@ -63,7 +63,7 @@ _pwrite_byte 0x61 $bigoff 1 $testdir/file3 >> $seqres.full
 _pwrite_byte 0x61 1048575 1 $testdir/file2 >> $seqres.full
 
 echo "Dedupe large single byte file"
-_dedupe_range $testdir/file1 0 $testdir/file3 0 $len \
+_dedupe_range $testdir/file1 $bigoff_64k $testdir/file3 $bigoff_64k 65536 \
 	2>&1 >> $seqres.full | _filter_dedupe_error
 
 echo "Dedupe large empty file"
