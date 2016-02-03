From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/4] xfstests: make _scratch_mkfs_blocksized usable
Date: Wed,  3 Feb 2016 17:02:06 +0100
Message-Id: <1454515328-1586-3-git-send-email-hch@lst.de>
In-Reply-To: <1454515328-1586-1-git-send-email-hch@lst.de>
References: <1454515328-1586-1-git-send-email-hch@lst.de>
To: darrick.wong@oracle.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

See http://www.infradead.org/rpr.html

The default mkfs.xfs options contain -b size=4096, so all tests
using _scratch_mkfs_blocksized won't actually run unless those
options are changed.  As we're trying to specificly test 1k
blocks we should always override the default option.

BTW, why is _scratch_mkfs_blocksized in the reflink file and not
with more generic helpers?

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/reflink | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/common/reflink b/common/reflink
index 398e505..bb1068a 100644
--- a/common/reflink
+++ b/common/reflink
@@ -201,13 +201,7 @@ _scratch_mkfs_blocksized()
 
     case $FSTYP in
     xfs)
-	# don't override MKFS_OPTIONS that set a block size.
-	echo $MKFS_OPTIONS |egrep -q "b?size="
-	if [ $? -eq 0 ]; then
-		_scratch_mkfs_xfs
-	else
-		_scratch_mkfs_xfs -b size=$blocksize
-	fi
+	_scratch_mkfs_xfs -b size=$blocksize
 	;;
     ext2|ext3|ext4|ocfs2)
 	${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV
-- 
2.1.4
