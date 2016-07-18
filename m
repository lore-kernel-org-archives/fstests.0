Received: from bombadil.infradead.org ([198.137.202.9]:50388 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbcGRIGu (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 18 Jul 2016 04:06:50 -0400
Received: from [5.61.10.130] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.85_2 #1 (Red Hat Linux))
	id 1bP3Zg-0004S7-Tv
	for fstests@vger.kernel.org; Mon, 18 Jul 2016 08:06:49 +0000
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] generic/071: require falloc -k
Date: Mon, 18 Jul 2016 11:06:44 +0300
Message-Id: <1468829204-24593-1-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

NFSv4.2 supports fallocate, but not the FALLOC_FL_KEEP_SIZE option.
To avoid a spurious failure test for the correct command.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/071 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/071 b/tests/generic/071
index 65ed0c7..9d0d136 100755
--- a/tests/generic/071
+++ b/tests/generic/071
@@ -46,7 +46,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 _supported_os Linux
 _require_scratch
-_require_xfs_io_command "falloc"
+_require_xfs_io_command "falloc" "-k"
 
 rm -f $seqres.full
 
-- 
2.1.4

