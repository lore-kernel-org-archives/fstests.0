Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4E74E1DE
	for <fstests@vger.kernel.org>; Wed, 21 Feb 2024 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517428; cv=none; b=Nxpm1aZ/jC8fWvDCQeRkfDTcPmrqE9XxXHOuriOP44uRBpSRni1tapGiGwnKdUtRCSlGUeo8sNNi1P0pEW/0UhiWyF7HxpIWNQSJEeBOESpJTM5mp305H9GVazavZo43npGB8EdYbQbI9XYy27rOg7vUQOSQaKHhXCmsWZ9flNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517428; c=relaxed/simple;
	bh=cTKzKkRFVmE6yAZf7g6qMldqSZ5LwGDgytBbE2VMY3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ff8NLxqMq2ABW+Fu/5Ad80oY81CKs93wuvOBS4DrCL8ovQnaueHGSNNQu/gSUCWJDJPGAN5+nbUSk3QqLVXXy1GhPzPTbPa7D5iVU9Tzdr+N0Box5UuCUqTKCINaAV3m6LN4zMWzT3wzZnOe/Xy5pOXTibYhRr30Y4kDcN/4TBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OsgtrFDE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OsgtrFDE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=FEGOoeey1swqLSF3oG23zz2HOGjx0D8CJyZRnx8KANw=; b=OsgtrFDEVkwrEYOVK/cuZ0KQgF
	rnfKfkO6fKLIShZN27b73jRff3aqi09QESdVD/6WzYa4b3TrEqu6SBifz8HijCW/jOfk9tJ1cPVYE
	Qykt4BO51b/gr8OqUjoebbKKMiELpENtgdxsQuvcSX2XkM/3RjTtnt9HlFIbpb77zjPrhZVcHZdEP
	u72fyNkDqhTTn8QphTjZencEnzS7O39e5XQaSVKy34oM5+5+oxPtrEGTlLMgQDG36SiKKiuWrkssP
	zZvr+lznIBYb6SoWUZr4XUTOavvAwIQLodh7B5DooB/g0XNKSkS4d1XuBL6bgVistqMnKVuUgFlah
	dNRAh61A==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rclQe-00000000oMN-2iBy;
	Wed, 21 Feb 2024 12:10:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org
Subject: [PATCH] add src/t_reflink_read_race to .gitignore
Date: Wed, 21 Feb 2024 13:10:21 +0100
Message-Id: <20240221121021.3591859-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Just like all the other test programs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 50ca94e98..d66190b13 100644
--- a/.gitignore
+++ b/.gitignore
@@ -165,6 +165,7 @@ tags
 /src/t_readdir_1
 /src/t_readdir_2
 /src/t_readdir_3
+/src/t_reflink_read_race
 /src/t_rename_overwrite
 /src/t_snapshot_deleted_subvolume
 /src/t_stripealign
-- 
2.39.2

