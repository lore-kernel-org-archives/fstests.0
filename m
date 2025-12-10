Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C742D47F4
	for <fstests@vger.kernel.org>; Wed, 10 Dec 2025 05:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765345900; cv=none; b=d//G5ls0vxNM7fQfnHAQ/5JqXcyUzN4MBJ7X+O8YMUkv0w1OFuwgKCFyTm+ZdrV6xoCGIAnq2UygDGL3fR+EUAByMTM9bSZshKfkvQzvcry5iowsiX3oh0ZQIbGxSXffFBJR+FVW6irM6vX0CwN7cUlusYTwdnGizVVOdcitmuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765345900; c=relaxed/simple;
	bh=5jX2bxOxBo+uzOCVWlaOJRHORbHMsE+78AKzAqAUfr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JfbN0dk24oplmhmYwJ055/I5BC5Of+aiml4ashNv9erW02b/g3RaR9rzCOh2KKw6wO06Bc6zGUk+r5MrS2SnSXNTCsWZRiT2fFd5ekkUItcgu4xY3ibwlgGQ+zf4u4DfiK2KgT2qzVWwKGEUbqdE1/bCOoU8Es+mOweN6svXqeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1VXc7F8g; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1VXc7F8g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+0Fcrz1LZYoBpqliaY9JOnO7jwFkZxR85R9cbePYEKI=; b=1VXc7F8gxV4A99l3ICiKbgV54+
	0fG3F+ULDE0zVEz4ZYi011V57WsZOvJyobtInf2gkFw5GuUb82+cGODeUe+3JcpQ3tzHTZcTjcgK9
	DmvkG8ZbBhShYVNkZGuDf7qHEaDz1QOSJmidvb8tq3P60shQKip5FE2PuGQov5yM59dIhCVb2CjoK
	NBFQX+nB1k8X+T36CgajDaSqqfiY1+Vu+EDy6PfmnnhTj/dGiVYFQaqTmuzUSgMHV9KmxAVXV3vqd
	aGSPYigtGmVzACVn7MPbY5tQ+WBmvQmtbI66Nh/Y4BSf2gAvvy7YuJMCFqY/Rg2wX3iO87n2f/jbb
	c4Hj8ceQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTD6v-0000000F9I5-3vLF;
	Wed, 10 Dec 2025 05:51:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org,
	asj@kernel.org
Cc: fstests@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update entry for Anand Jain
Date: Wed, 10 Dec 2025 06:51:34 +0100
Message-ID: <20251210055134.3470190-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The oracle address bounces.  Replaced it with the kernel.org address
found in recent commit logs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a0f50f3d98b4..19e558296809 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -108,7 +108,7 @@ Maintainers List
 	  or reviewer or co-maintainer can be in cc list.
 
 BTRFS
-M:	Anand Jain <anand.jain@oracle.com>
+M:	Anand Jain <asj@kernel.org>
 R:	Filipe Manana <fdmanana@suse.com>
 L:	linux-btrfs@vger.kernel.org
 S:	Supported
-- 
2.47.3

