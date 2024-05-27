Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E41515EFDE
	for <fstests@vger.kernel.org>; Mon, 27 May 2024 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810532; cv=none; b=pZEdxcJN3z6hbjS3n5a8pMqh5SK2zdgfB+epRN/pBqXNCUSRFv3cLfoTxdwtu0h3fR6TpimJINWMCt2R80A1vHK+yq//dUYX0YD9SVSQLa8M7WZGoJvBCwL6QXiVxVc6qYznKOP7OnhjjXhus7GB7r35WDzXJ/GpIE/v7IGvXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810532; c=relaxed/simple;
	bh=mIbnH9MpfyLgHjbyh8IB0c176EH4YIqiTuyHzxxmnGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZS6ClFmEckh32lz9nmc+5Ob3hk+kK2/3Kn5pXoBB0Usdv/ONkTUiuVsLIf3egt3fXaMOaasaP9Bu0AhjgzWEYy0ciUzYYRnsqlaiCc+EsOM569kfQ5cCjBTAGA2yv4/EDQZFUY41l6jF0MAZpal/t53+niMeWCpZyKaZrht2Ykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=JosLrGHS; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="JosLrGHS"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Vnv6x2S5kz9sSL;
	Mon, 27 May 2024 13:48:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716810521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5l450ZBuJ7ldSfEOjWi5nXAKsSV5S1BbygnedTjqk0U=;
	b=JosLrGHSPqgzscQxzmRsvAi627yGbfOrdaKD1mmzo16O8QpXm9KQdp1uiMPiK+y9Xp40F7
	/XYcmFlq3TJSQ0NymIEnmocRlLPrgMtzfv9cvKLnrw5EZq0w3o880qbm+wIA4uXFoQbeXJ
	IfqnL9cqoRBZwd54k3CQyPNTz13FVFY3ivktpxRUCsEheGBea2wPSMps+ddfoCpeKulEhL
	ulCdJFTHyfshei9pLBmitFlbcgyKWYkK/Jm3ebZpMAxmGGM6Dy4psLv41mTbNV0vzPMgFe
	UgZfkyPCHamL/BLawIqSgex4m1CFu1h1winWOnTqr+vTcHi7ni5Ls7SnPRxawg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: fstests@vger.kernel.org
Cc: ritesh.list@gmail.com,
	djwong@kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	zlang@redhat.com,
	kernel@pankajraghav.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 2/3] generic/436: round up bufsz to nearest filesystem blksz
Date: Mon, 27 May 2024 13:48:33 +0200
Message-Id: <20240527114834.167521-3-kernel@pankajraghav.com>
In-Reply-To: <20240527114834.167521-1-kernel@pankajraghav.com>
References: <20240527114834.167521-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Vnv6x2S5kz9sSL

From: Pankaj Raghav <p.raghav@samsung.com>

SEEK_HOLE and SEEK_DATA work in filesystem block size granularity. So
while filling up the buffer for test 13 - 16, round up the bufsz to the
closest filesystem blksz.

As we only allowed blocksizes lower than the pagesize, this was never an
issue and it always aligned. Once we have blocksize > pagesize, this
assumption will break.

Fixes the test for LBS configuration.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 src/seek_sanity_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index 48b3ccc0..a61ed3da 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -541,7 +541,7 @@ static int test16(int fd, int testnum)
 {
 	int ret = 0;
 	char *buf = NULL;
-	int bufsz = sysconf(_SC_PAGE_SIZE);
+	int bufsz = roundup(sysconf(_SC_PAGE_SIZE), alloc_size);
 	int filsz = 4 << 20;
 
 	if (!unwritten_extents) {
@@ -591,7 +591,7 @@ static int test15(int fd, int testnum)
 {
 	int ret = 0;
 	char *buf = NULL;
-	int bufsz = sysconf(_SC_PAGE_SIZE);
+	int bufsz = roundup(sysconf(_SC_PAGE_SIZE), alloc_size);
 	int filsz = 4 << 20;
 
 	if (!unwritten_extents) {
@@ -643,7 +643,7 @@ static int test14(int fd, int testnum)
 {
 	int ret = 0;
 	char *buf = NULL;
-	int bufsz = sysconf(_SC_PAGE_SIZE) * 14;
+	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);
 	int filsz = 4 << 20;
 
 	if (!unwritten_extents) {
@@ -692,7 +692,7 @@ static int test13(int fd, int testnum)
 {
 	int ret = 0;
 	char *buf = NULL;
-	int bufsz = sysconf(_SC_PAGE_SIZE) * 14;
+	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);
 	int filsz = 4 << 20;
 
 	if (!unwritten_extents) {
-- 
2.34.1

