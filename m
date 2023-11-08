Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CF53033C
	for <fstests@vger.kernel.org>; Wed,  8 Nov 2023 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bkZ4FRq2"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075511BF7
	for <fstests@vger.kernel.org>; Wed,  8 Nov 2023 07:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=azupi8CySYiDWI5muYyHeNpk4t4KbNzzZaJjhhjz2EM=; b=bkZ4FRq2AqJGvdiVnsmSLUi+cx
	7OxPCqZfCT7nFapHhBaVjmx8rYT7GNPneMTQBmX09/zsrgtaI+tZ4jUPRDY22hrFb0FwXr99NUlh3
	mCAjYMzKMmcH0EbOiN4TNDmLlykkgHMjyoRhmNLvLt0f5VEjm5+PmexQ96VuO5kfsS61vWp42kLak
	IJSXRM6DPB9eNwV6aCZddT937U8Gck662ZjpCDkLwoAzeSrwCUlWRCwLr7Uyt44vBhI2j978cOZEj
	/PVDuzgoWx1kgM1owd/9mb/Te5HlP471XiNm8emFTmfYnsnrXcsc7Ph/0+1epZ1SdfxcqS6f6QlP8
	8tas6nbw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r0kPW-004BRt-1H;
	Wed, 08 Nov 2023 15:24:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org
Subject: [PATCH] common: fix _require_xfs_io_command for specific swapext versions
Date: Wed,  8 Nov 2023 16:24:01 +0100
Message-Id: <20231108152401.432980-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The xfs_io command (only in Darricks trees and not upstream yet)
supports the -v switch to select the swapext version.  When the selected
swapext version is not supported it reports a 'version must be $foo'
message.  Parse that and don't _notfun the test cases.

This fixes various generic tests trying to use the vfs version that
doesn't exist in most branches implementing the swapext command.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/rc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/rc b/common/rc
index 26a26085..d8a0b19b 100644
--- a/common/rc
+++ b/common/rc
@@ -2706,6 +2706,8 @@ _require_xfs_io_command()
 			_notrun "xfs_io $command $param ioctl support is missing"
 		echo $testio | grep -q "Operation not supported" && \
 			_notrun "xfs_io $command $param kernel support is missing"
+		echo $testio | grep -q "version must" && \
+			_notrun "xfs_io $command $param kernel support is missing"
 		rm -f $testfile.1
 		param_checked="$param"
 		;;
-- 
2.39.2

