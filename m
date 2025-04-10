Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808BD1E1DE4
	for <fstests@vger.kernel.org>; Thu, 10 Apr 2025 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271857; cv=none; b=cHiofL6bKkHuMZPdU9vt5NTBy+Po+NsNbGBmg+a4FNTac3nTb6eLI4PPaRD24BNuvn28Q1Lsk+MM0lqlwdSKHsRrUEaI6u2aSAMMu1Hz2UnB1jAYYyMpRmEHQTJaUgVaErvicIgswaWePZP5BRMxZ2GzfowiimTk6+tF8/Jv5Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271857; c=relaxed/simple;
	bh=nnDBGl319e9qaeF5j+R3VQsIkOqVBCGUOZSppnuNWZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cp8tAXtXNvI3CXGk3vyMWYldm2AIX362EPaq5TtFwvqrYD14NgV8fRVq8es16Basv4S3KaFbNs1Nr+aBvuJf6UNqLpVNG/xF2VFc8s2Gh3tZ6YR6yHwch74xXQZo6kjDilpzN/dsRoDzTPnqJH59hdGfDP3KhAqo9t0zLHwvSDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OcSUiZii; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OcSUiZii"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8xnTs4um1d4qz6Qsr1WQSL2P5lK89Tmn9hHQx1A2ZYg=; b=OcSUiZiih8BWlVnhd+xtsRQDFs
	9ubDFGN8tuXcqEahFWwgw/BgzgNtZ8EhEWuCncU3PfqR0HqBqxxNZmXxw/41MMijmRSRX/W9MQy6W
	QVAI41pcT61yLAqQtWdSIkQuAXrwew690XSl8r+vgB190jfKLKZuiVPcxxA+A8bp5ryU+SK9oqHU+
	tUZ+fQxHypkR/5zz1dmRK1/zZWikWbesGodE0sAErgT34L1RL9LALEGB9Nggem9iRBuqw3ylCLcyv
	56JSjCwt0lW0GSaRwPu3vbbUruM/DXmuNweSYu3nBsfnThTUMlJeT0I2E+ELiag+d9GiMB0U8eSFA
	+l+UNCDg==;
Received: from 2a02-8389-2341-5b80-e089-15ae-3212-d9d7.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e089:15ae:3212:d9d7] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2mn0-00000009e8V-3KDM;
	Thu, 10 Apr 2025 07:57:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: dchinner@redhat.com,
	fstests@vger.kernel.org
Subject: [PATCH, RFC] rename check-parallel to parallel-check
Date: Thu, 10 Apr 2025 09:57:26 +0200
Message-ID: <20250410075731.3800342-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Having two files that start with check is really annoying for tab
completion.  Rename the new check-parallel helper to parallel-check.
Or maybe pcheck might be a better name?  Or just fork off from
check with a --parallel option?

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 check-parallel => parallel-check | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename check-parallel => parallel-check (100%)

diff --git a/check-parallel b/parallel-check
similarity index 100%
rename from check-parallel
rename to parallel-check
-- 
2.47.2

