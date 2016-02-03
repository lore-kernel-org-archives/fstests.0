From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/4] xfstests: 899 requires a working filefrag
Date: Wed,  3 Feb 2016 17:02:08 +0100
Message-Id: <1454515328-1586-5-git-send-email-hch@lst.de>
In-Reply-To: <1454515328-1586-1-git-send-email-hch@lst.de>
References: <1454515328-1586-1-git-send-email-hch@lst.de>
To: darrick.wong@oracle.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

See http://www.infradead.org/rpr.html

NFS has neither FIBMAP nor FIEMAP so filefrag will fail.  Handle this
case gracefully.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/899 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/899 b/tests/generic/899
index 9b3f973..ce3db38 100755
--- a/tests/generic/899
+++ b/tests/generic/899
@@ -67,6 +67,10 @@ nr=64
 _pwrite_byte 0x61 0 $((blksz * nr)) "$testdir/file1" >> "$seqres.full"
 _pwrite_byte 0x62 0 $((blksz * nr)) "$testdir/file3" >> "$seqres.full"
 _pwrite_byte 0x61 0 $((blksz * nr)) "$testdir/file1.chk" >> "$seqres.full"
+
+filefrag -v "$testdir/file1" 2>&1 | grep -q "FIBMAP: Invalid argument" && \
+	_notrun "filefrag not support on file system type \"$FSTYP\""
+
 seq 1 2 $((nr-1)) | while read f; do
 	_reflink_range "$testdir/file1" $((blksz * f)) "$testdir/file3" $((blksz * f)) $blksz >> "$seqres.full"
 done
-- 
2.1.4
