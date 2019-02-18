Received: from bombadil.infradead.org ([198.137.202.133]:42062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfBRJFP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Feb 2019 04:05:15 -0500
Received: from [88.128.83.71] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gverT-0007P8-2Q
        for fstests@vger.kernel.org; Mon, 18 Feb 2019 09:05:15 +0000
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] remove xfs/420 and xfs/420 from the dedup group
Date: Mon, 18 Feb 2019 10:05:02 +0100
Message-Id: <20190218090503.12034-2-hch@lst.de>
In-Reply-To: <20190218090503.12034-1-hch@lst.de>
References: <20190218090503.12034-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

No dedup functionality is exercised by these tests.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/xfs/group | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/group b/tests/xfs/group
index 7b7d69f1..cd4bb72f 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -417,8 +417,8 @@
 417 dangerous_fuzzers dangerous_scrub dangerous_online_repair
 418 dangerous_fuzzers dangerous_scrub dangerous_repair
 419 auto quick swap
-420 auto quick clone dedupe punch
-421 auto quick clone dedupe punch
+420 auto quick clone punch
+421 auto quick clone punch
 422 dangerous_scrub dangerous_online_repair
 423 dangerous_scrub
 424 auto quick db
-- 
2.20.1
