Received: from bombadil.infradead.org ([198.137.202.133]:42534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbfGOIZo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 15 Jul 2019 04:25:44 -0400
Received: from 089144194016.atnat0003.highway.a1.net ([89.144.194.16] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmwIp-0004Vs-2F
        for fstests@vger.kernel.org; Mon, 15 Jul 2019 08:25:44 +0000
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] shared/011: move to generic/
Date: Mon, 15 Jul 2019 10:25:23 +0200
Message-Id: <20190715082523.18387-3-hch@lst.de>
In-Reply-To: <20190715082523.18387-1-hch@lst.de>
References: <20190715082523.18387-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Now that we run the test for all block device based file systems, there
is no reason to keep it out of generic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/{shared/011 => generic/563}         | 0
 tests/{shared/011.out => generic/563.out} | 0
 tests/generic/group                       | 1 +
 tests/shared/group                        | 1 -
 4 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/{shared/011 => generic/563} (100%)
 rename tests/{shared/011.out => generic/563.out} (100%)

diff --git a/tests/shared/011 b/tests/generic/563
similarity index 100%
rename from tests/shared/011
rename to tests/generic/563
diff --git a/tests/shared/011.out b/tests/generic/563.out
similarity index 100%
rename from tests/shared/011.out
rename to tests/generic/563.out
diff --git a/tests/generic/group b/tests/generic/group
index 9ceaf317..284a1d93 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -565,3 +565,4 @@
 560 auto stress dedupe
 561 auto stress dedupe
 562 auto clone
+563 auto quick
diff --git a/tests/shared/group b/tests/shared/group
index 6112c8dd..a8b926d8 100644
--- a/tests/shared/group
+++ b/tests/shared/group
@@ -4,6 +4,5 @@
 # - comment line before each group is "new" description
 #
 002 auto metadata quick log
-011 auto quick
 032 mkfs auto quick
 298 auto trim
-- 
2.20.1
