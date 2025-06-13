Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A3257449
	for <fstests@vger.kernel.org>; Fri, 13 Jun 2025 06:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749795261; cv=none; b=OwDGBf7iM7n+VdlJkeAxUhFE6ujdvqCq3T2BWDf4kV9F7CSE/2A57PkY06SPcjJIFr5tYeAX2zAYfgN9H+7HS3X17Pe4RjL2/F+6w+QaknwYFIhcR9ZRna9x+1Cji1FU+4s4EYHA1YIB9r28UFYFpKZNLbk4AzqEJeRxF9phASk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749795261; c=relaxed/simple;
	bh=vcGh1/eDDIylqZ0WHXhjrZprYHgE6n4KK5/SGODqzwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOnzpSlTdTeeR4CQ7x2sJxeYhgKpG/aHMMVoWk3FROdxYZ7nOAw6LAGimrMNo2pURvVOGNzOLfO0gOZNOj9OKUUVcg5EWOG7yP4pRTv0wAw3etZr1HASxJzSygOSqPWGMZPY0tJMb8tLNr4RCZ+YnlP79qnmHBzrOPoD9Mx/ko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QXD0t6W6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QXD0t6W6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PxpoA+XEtceBKX7c9/HMMmuJSIwyyIbcbo06h3EgBqU=; b=QXD0t6W6lil6cZ2EcnFKNJmTIN
	mwVic66Qo0sopUx9jzLEeFQmgvknHLftmyrdN0c0EVVi2Eqk62ZQ9vJ+cxOWIA7r4RYz3s+1X0anh
	vgeUroX0TVch/rNCmNDDW6fiMhUpQpB1wj6pAwNSrX8Cdp/oIBFaeqIHf8EW1RWUVh1PWQCPgRbJS
	NqKN9C5UooOSYVt43diPuMnHZoNEi14l98Y9iRikR7dBNXlXdP8/VbL0sWYqF7o2wuVBMB6j21/Hb
	9KBxmFSudVDvIf7i2eZQQeSjFUMrho/HvZC2ZD3UcpaH84k7MUx2q9kjHa+RtF/jd5UyGO3zprQzY
	kpLQc8sQ==;
Received: from [2001:4bb8:2dc:c98c:c28:9c64:750:170f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPxgB-0000000FSeA-3MLK;
	Fri, 13 Jun 2025 06:14:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org
Subject: [PATCH] generic/740: move checking for a scratch device up
Date: Fri, 13 Jun 2025 08:14:17 +0200
Message-ID: <20250613061417.2794099-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Commit 3ae8a19f97d0 ("generic/740: enable by default") moved these checks
down accidentally.  Move them back up to make the test exit gracefully
when no scratch device is provided.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/740 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/generic/740 b/tests/generic/740
index c0a634f2302b..ce55200f7bc3 100755
--- a/tests/generic/740
+++ b/tests/generic/740
@@ -21,13 +21,13 @@ _exclude_fs jfs
 _exclude_fs ocfs2
 _exclude_fs udf
 
+_require_scratch_nocheck
+_require_no_large_scratch_dev
+
 _require_block_device "${SCRATCH_DEV}"
 # not all the FS support zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
 
-_require_scratch_nocheck
-_require_no_large_scratch_dev
-
 echo "Silence is golden."
 for fs in `echo ${MKFS_PROG}.* | sed -e "s:${MKFS_PROG}.::g"`
 do
-- 
2.47.2

