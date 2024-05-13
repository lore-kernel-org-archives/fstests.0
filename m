Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD656152160
	for <fstests@vger.kernel.org>; Mon, 13 May 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606002; cv=none; b=qf4iEOxux8CLrk7lei50fkil/2YZVt/UBGmvJxk28T2Mo255c92FtEHDibM+FKZo9Gd6YvGgvRHYu36z2B/Tf5/YaE6mwATXhhY0VHFrQNCD5wUONkrnjGF0DOy9ULRAp1GvXCfks1bPOOLaOUfNTa+m3YS4nTz4sizS6t4b0Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606002; c=relaxed/simple;
	bh=Q0H8ea/sbyTIKMAp4TgU/TlVrwDzkkCJnv2mOhH4PfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RLdY93MBzT5c2bxakV5cbZarrjwVdrhWyRFNaMyz8m9WMLTaUD7uWJslnQdzK+TyXYXgVQ4zJDXU/ihqysSP8Qsz81BRutcd+uJjaV15vFDY3409sRRRsKDxP2A/v/yxFz3uLkFNxSp0feqJIWzWschcNkc6Ka371NWJ00qBAzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=MfikmgC2; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="MfikmgC2"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VdKfv5q1wz9srx;
	Mon, 13 May 2024 15:13:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715605991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2nvOnTMHzBEUAYH76/SY4dYMSM35Bc03j95IUmJPiJI=;
	b=MfikmgC2rqBstXdYo9AQCoieV0dVIzptvjax2HD0pSulUHWPZNL2S2mHAHJ7AV6n5YmffC
	Ow9FVVHV5II58vUCi/csGw7hLB6Dvuc2zGUkran/kgD6f7GSg3oBXpGZYMjW/NYAsxuQLp
	/cwdFjZjxUjYdRYgosarw0YaqGQ1GVOCxii+1HNPpXLtKGxBz61f9Hds82qRtC5DOJw1Uo
	YRQ9EkBVjoBjHvdxq7RZlPlkWPyCNwhAHk/MN/Z99cYfaWUMZ/+SkDt/o+xLvhG8ILvZCk
	UadMbgkWZToiqFHLVrQe3RlDZ9rj7V0LiXr4fy1TB2wpwlCVwy7K0T+h30Fg6A==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: fstests@vger.kernel.org
Cc: kernel@pankajraghav.com,
	gost.dev@samsung.com,
	mcgrof@kernel.org,
	ritesh.list@gmail.com,
	djwong@kernel.org,
	zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 2/3] generic/436: round up bufsz to nearest filesystem blksz
Date: Mon, 13 May 2024 07:12:53 -0600
Message-Id: <20240513131254.92412-3-kernel@pankajraghav.com>
In-Reply-To: <20240513131254.92412-1-kernel@pankajraghav.com>
References: <20240513131254.92412-1-kernel@pankajraghav.com>
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

