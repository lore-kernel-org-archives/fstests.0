Received: from bombadil.infradead.org ([198.137.202.133]:42518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbfGOIZi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 15 Jul 2019 04:25:38 -0400
Received: from 089144194016.atnat0003.highway.a1.net ([89.144.194.16] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmwIi-0004VI-Ty
        for fstests@vger.kernel.org; Mon, 15 Jul 2019 08:25:37 +0000
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] shared/011: run for all block device based file systems
Date: Mon, 15 Jul 2019 10:25:22 +0200
Message-Id: <20190715082523.18387-2-hch@lst.de>
In-Reply-To: <20190715082523.18387-1-hch@lst.de>
References: <20190715082523.18387-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Cgroupv2 writeback support can't be easily detected.  But it is
kindof expected from block based file systems and can be easily
added, so just assume support and fail if it doesn't work.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/shared/011 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/shared/011 b/tests/shared/011
index a0ac375d..b4cdc5ed 100755
--- a/tests/shared/011
+++ b/tests/shared/011
@@ -39,11 +39,14 @@ rm -f $seqres.full
 # real QA test starts here
 
 # Modify as appropriate.
-_supported_fs ext4 btrfs
+_supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_cgroup2 io
 
+# cgroup v2 writeback is only support on block devices so far
+_require_block_device $SCRATCH_DEV
+
 smajor=$((0x`stat -L -c %t $SCRATCH_DEV`))
 sminor=$((0x`stat -L -c %T $SCRATCH_DEV`))
 cgdir=$CGROUP2_PATH
-- 
2.20.1
