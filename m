Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715471D7E31
	for <fstests@vger.kernel.org>; Tue, 10 Dec 2024 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733813682; cv=none; b=F4Hof2CV615PtmnxH0rmZvAEautSL9naNmMuSK/FBX4osEXz6omXyjSP/GDjVxQYjwvCePHkOHLBDW5VKuj0HbdzK4rv3pc8G+aYATOxRHZh/0tBT76j4QCttes+rWChS2Yg2wjEOwfG2cJNwESCk9TiHpRIec6BEmmNPLLxXiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733813682; c=relaxed/simple;
	bh=uRoYxNRI7EATjqxqUUP1LEmchfd/bw6oJKay3LdS55c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUXH0bH2qlxlhMZE9WAcyMh4TInLq5RzkrPgodekUrMYrKQ4XAwz2hVAMyxMTJeH2w7mgLmqHnB2XE/TtLhEv3kprKMafO7ReqAlVds1/Dk4rTiEDWllsyOVhD8Vs3hDbMCG12Z+QTzrgIHD7Ld0w04To55LM0wjOKWe0cxZZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=v3K51Jrv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v3K51Jrv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=NlOSgcEPCYbKQkk+dPrFEa1s3En8j4rjDQbOHpvngQk=; b=v3K51Jrv5clnEBLURrdOKBPyPQ
	leobpUYMlvCxghPOHuBGWtgjfVb6YRZA9IhQvaT2pw/SgZfOyV/WMXCP63u9p3jZ3XGLkhL/Wis1Z
	7GNT8gVGfrwRqawlsPv5PUPiFdqZ21/I07sPK/gsxtSLqxFks1uqeeFloj8WX2+nRKrgnUKRY+LsD
	fh2MX5jBjy5yE8DUKcRJ/ngrHccuDge9gBiQV5H7PSk2iHRPFnyhWGSC0917IG1Tfl3KwaFpuL8zp
	eHMNxgqZmWs6r2aWe2WEetFb23dbiz5JpUA7GjhYU1mCd5MWms62ATTuz/HnULKf3pnPXfUAcum0y
	VSwDPGSw==;
Received: from 2a02-8389-2341-5b80-e2a6-542f-4e27-82ec.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e2a6:542f:4e27:82ec] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKu8k-0000000ATxw-20KI;
	Tue, 10 Dec 2024 06:54:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: djwong@kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] common: cleanup scratch_mkfs_sized
Date: Tue, 10 Dec 2024 07:54:35 +0100
Message-ID: <20241210065435.1234629-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Move the XFS RT specific code into the file system type switch
statement.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/rc | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/common/rc b/common/rc
index 1b2e4508d767..906905daa92d 100644
--- a/common/rc
+++ b/common/rc
@@ -1152,7 +1152,6 @@ _try_scratch_mkfs_sized()
 	shift
 	local def_blksz
 	local blocksize_opt
-	local rt_ops
 
 	case $FSTYP in
 	xfs)
@@ -1202,14 +1201,18 @@ _try_scratch_mkfs_sized()
 		[ "$fssize" -gt "$devsize" ] && _notrun "Scratch device too small"
 	fi
 
-	if [ "$FSTYP" = "xfs" ] && [ -b "$SCRATCH_RTDEV" ]; then
-		local rtdevsize=`blockdev --getsize64 $SCRATCH_RTDEV`
-		[ "$fssize" -gt "$rtdevsize" ] && _notrun "Scratch rt device too small"
-		rt_ops="-r size=$fssize"
-	fi
-
 	case $FSTYP in
 	xfs)
+		local rt_ops
+
+		if [ -b "$SCRATCH_RTDEV" ]; then
+			local rtdevsize=`blockdev --getsize64 $SCRATCH_RTDEV`
+			if [ "$fssize" -gt "$rtdevsize" ]; then
+				_notrun "Scratch rt device too small"
+			fi
+			rt_ops="-r size=$fssize"
+		fi
+
 		# don't override MKFS_OPTIONS that set a block size.
 		echo $MKFS_OPTIONS |grep -E -q "b\s*size="
 		if [ $? -eq 0 ]; then
-- 
2.45.2

