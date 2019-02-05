Received: from bombadil.infradead.org ([198.137.202.133]:59746 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfBESsT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Feb 2019 13:48:19 -0500
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gr5la-0001no-51
        for fstests@vger.kernel.org; Tue, 05 Feb 2019 18:48:18 +0000
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] xfs/252: requires fallocate support for preallocation
Date: Tue,  5 Feb 2019 19:48:16 +0100
Message-Id: <20190205184816.20330-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

xfs/252 has a few feature tests, but misses checking for preallocation
support.  Because of that it will fail instead of not being run for
and XFS file system in always COW mode.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/xfs/252 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/xfs/252 b/tests/xfs/252
index df795b81..42650ad1 100755
--- a/tests/xfs/252
+++ b/tests/xfs/252
@@ -31,6 +31,7 @@ _supported_fs xfs
 _supported_os Linux
 
 _require_test
+_require_xfs_io_command "fallocate"
 _require_xfs_io_command "fpunch"
 _require_xfs_io_command "fiemap"
 
-- 
2.20.1
