Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5E51DDCA
	for <fstests@vger.kernel.org>; Thu,  9 Nov 2023 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4NyXwsfa"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8684171A
	for <fstests@vger.kernel.org>; Thu,  9 Nov 2023 08:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=kvTNwVc22fVf8ri+5dUVn/aNv8LHMK34UME4uUWjpA8=; b=4NyXwsfayUIWI7DnizVyfvqxzy
	ff2k8zhL36NFfqup5v2fT2FurpodMo8bJkaCbHK2m6eB4NrelnmTccezEsG+EnyvOQE0nLns00kZe
	1G9Nja/x7pILG7r/NhdLZQiRu+xCzFTvTky/C6/ePoXR9QhyY0V5EJTD/QM7Ub9WViEFgMbQgQmJH
	Bmqt1qfsNCCNU9OnRewH6cOjT8G1FV0fJ1m54rDoDQqtHmwaZlGRvAcUjmWvssYHDUyIzRM7lLyeg
	IgPn6xIiHpsfVYVAOGESw0L6bR4vOz0HhCkmGjeGMs2RlNdvchmlnkVIcX+Mi9UYBomIF4Hu/PdYQ
	IVjcd/1w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r18E1-006qNj-0s
	for fstests@vger.kernel.org;
	Thu, 09 Nov 2023 16:49:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: fstests@vger.kernel.org
Subject: [PATCH] xfs/146: require fallocate support
Date: Thu,  9 Nov 2023 17:49:47 +0100
Message-Id: <20231109164947.736069-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

xfs/146 uses the xfs_io falloc subcommand and thus kernel fallocate
support.  Ensure the support is present.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/xfs/146 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/xfs/146 b/tests/xfs/146
index 123bdff5..c8268a52 100755
--- a/tests/xfs/146
+++ b/tests/xfs/146
@@ -24,6 +24,7 @@ _begin_fstest auto quick rw realtime
 _supported_fs xfs
 _require_scratch
 _require_realtime
+_require_xfs_io_command "falloc"
 _require_test_program "punch-alternating"
 
 # Format filesystem to get the block size
-- 
2.39.2

