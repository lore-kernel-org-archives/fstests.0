Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDDC153583
	for <fstests@vger.kernel.org>; Mon,  6 May 2024 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007699; cv=none; b=azhgrNvgwgs5l6D9o8r2CmB+yWpsbTuWBrw5JKibWRE1vH7888oB02XLbJb3w+R0QMiV3o0IQyVHSmq8ZxeNbL1Op1PfXeClKM4qI1pe8xJuj/twp7PP0YwW5w+FPSl9AhguI15kUcuPbrhRON7hyoEWL3QW80jPBVRyK7+UpCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007699; c=relaxed/simple;
	bh=L4TG6tYj/GDWzFAr+TSLCyfSzEqEkJQwUyAoznr1w+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EAUmu4FoSqks4vVxwVVS68+L6qMgMF07XgV8TCGhMn4LR3NpQN0M59I4xA2PHNHmey0NFWUfWaaQ4XeedJQgoBdHexSFPMe11qR8pVdkfEZNqAynCgpnWUi6XXpzYHHxhp/JvwuCL/UdGdmVAuelFONe+vvW1eL63X6BURyuoX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=dKDtrPAl; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="dKDtrPAl"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VY4P43fgRz9ssc;
	Mon,  6 May 2024 17:01:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715007688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ns8OkHav60srMaqrqimDjhefxvSm/sAzGhfD09Rsuw4=;
	b=dKDtrPAlqhb7CyrBQfkEwxCRNOapT68f/Z8iLBqxleZusH4kAusgewLjEpAVbIUD/RuTC/
	ZYm+hXI0MguKgpTzuT/kmi26cVJttHF1DgQ9dcUjwIH++8pfg1cITSyfkSvYQLRNm7x7cY
	VRm5cE0H9YXWzy6W0Qz7bTuGej9SccAjZ8Si7ubR3t0jDVMGUY8otQiFXOHdS5P5N/Ykl6
	dsqDsz8b8Oe9FAIqhtpG3vGmp//yPf4ymaRM60EkgIewgFRXBuVizApVyTWuHeWwEY2fmR
	l9JoktMMc0XCdFdmvzZBx90n0m7oC2ZekYgnt2JY1lhjsxmSXoaFMcS5Eimbkg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org,
	gost.dev@samsung.com,
	mcgrof@kernel.org,
	kernel@pankajraghav.com,
	ritesh.list@gmail.com,
	zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 2/3] generic/436: round up bufsz to nearest filesystem blksz
Date: Mon,  6 May 2024 17:01:18 +0200
Message-Id: <20240506150119.184097-3-kernel@pankajraghav.com>
In-Reply-To: <20240506150119.184097-1-kernel@pankajraghav.com>
References: <20240506150119.184097-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

SEEK_HOLE and SEEK_DATA work in filesystem block size granularity. So
while filling up the buffer for test 13 - 16, round up the bufsz to the
closest filesystem blksz.

As we only allowed blocksizes lower than the pagesize, this was never an
issue and it always aligned. Once we have blocksize > pagesize, this
assumption will break.

Fixes the test for LBS configuration.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 src/seek_sanity_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index 48b3ccc0..bc30f77c 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -541,7 +541,7 @@ static int test16(int fd, int testnum)
 {
 	int ret = 0;
 	char *buf = NULL;
-	int bufsz = sysconf(_SC_PAGE_SIZE);
+	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);
 	int filsz = 4 << 20;
 
 	if (!unwritten_extents) {
@@ -591,7 +591,7 @@ static int test15(int fd, int testnum)
 {
 	int ret = 0;
 	char *buf = NULL;
-	int bufsz = sysconf(_SC_PAGE_SIZE);
+	int bufsz = roundup(sysconf(_SC_PAGE_SIZE) * 14, alloc_size);
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

