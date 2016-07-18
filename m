Received: from bombadil.infradead.org ([198.137.202.9]:50605 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbcGRIHh (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 18 Jul 2016 04:07:37 -0400
Received: from [5.61.10.130] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.85_2 #1 (Red Hat Linux))
	id 1bP3aS-0004cj-Mt
	for fstests@vger.kernel.org; Mon, 18 Jul 2016 08:07:37 +0000
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] generic/120: requires working *atime mount options
Date: Mon, 18 Jul 2016 11:07:33 +0300
Message-Id: <1468829253-24664-1-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

So call _require_atime to avoid spurious failures on NFS.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/120 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/generic/120 b/tests/generic/120
index 4271344..9cf4ea8 100755
--- a/tests/generic/120
+++ b/tests/generic/120
@@ -40,6 +40,8 @@ _supported_fs generic
 _supported_os Linux IRIX
 
 _require_scratch
+_require_atime
+
 _scratch_mkfs >/dev/null 2>&1 || _fail "mkfs failed"
 
 _compare_access_times()
-- 
2.1.4

