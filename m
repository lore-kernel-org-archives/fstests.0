From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/4] xfstests: 912 requires dedup support
Date: Wed,  3 Feb 2016 17:02:07 +0100
Message-Id: <1454515328-1586-4-git-send-email-hch@lst.de>
In-Reply-To: <1454515328-1586-1-git-send-email-hch@lst.de>
References: <1454515328-1586-1-git-send-email-hch@lst.de>
To: darrick.wong@oracle.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

See http://www.infradead.org/rpr.html

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/912 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/912 b/tests/generic/912
index 910f1ea..7a629bc 100755
--- a/tests/generic/912
+++ b/tests/generic/912
@@ -43,7 +43,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_os Linux
-_require_test_reflink
+_require_test_dedupe
 _require_cp_reflink
 
 rm -f "$seqres.full"
-- 
2.1.4
