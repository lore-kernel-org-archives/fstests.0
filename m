Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF1E15EFBF
	for <fstests@vger.kernel.org>; Mon, 27 May 2024 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810529; cv=none; b=tQZF2p6ZdHVhfWx9wwIRQSHQDgyAONrlkVqFyEoFkp5An5tP9m5QGaI65YQ6Rt/IQ1HB+UcCuy+ya8I9SLJx9jRm+AE8FxO2bvXg2FR8uI0MSNsirQ0+EmYkoZCzMHj81F6cqr6WEdftzx89Pj3Cxcny+tJJOsMovxfgOVm5NhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810529; c=relaxed/simple;
	bh=zuzL5nfaIQIIHSzqYDgmn61gy/L2O4cV9E1wdzVl8Hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kddNqpz/9UTOhxEbwZjeOFCdV2GVIY3mMns1WWtEeJ1auaJTu1rkiUDXIY3OUwaQmkNDeoMxfC62xFIjXhG4DeR1vwKsWu/o/ovawkDFtRR2D06Y0kyrhZ2oFdVYZa1sEqD357xP8XHN2EdMNBRE9qvJ9Z0IXcEXN+okvDBYhvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=L848ZWMs; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="L848ZWMs"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Vnv6z6mg3z9sbW;
	Mon, 27 May 2024 13:48:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716810523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dhl1bSfDlQ7rxXfUYk8OjQpvanJ5ZU28X0CW3ib5Vx8=;
	b=L848ZWMs6047xpP4yIDu7n9kK80yu54OiLu77RYUJ88lrYraliBuUT8qMkDQUupoNnAW6C
	DYeYDyHaO9jntgn5ry2yhccy+GBdiXVjBz3z+6Zjrn7iAb35qF9+4/yx05O/4/dULy/qol
	X5rbO9r+nM/yJmHF8v6ZlyyiD64BfQ4CWY/kQgJOzQpNLal7jCmCsgWsxZ8ZVTrw0TGmXa
	Cq6+H+TPjJ1ShbnxaHqWeQY9B6sJRX2wcnr/tQ31Ku4QwWkzZpM8Dt5Zri3ykyvpX0OKCI
	UKhW5anceGyXvdKkld2CZQvZ+64WEa/qMBwz47eOdFRVB8SZF1PxYXbvirsqrQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: fstests@vger.kernel.org
Cc: ritesh.list@gmail.com,
	djwong@kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	zlang@redhat.com,
	kernel@pankajraghav.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 3/3] xfs/008: use block size instead of the pagesize
Date: Mon, 27 May 2024 13:48:34 +0200
Message-Id: <20240527114834.167521-4-kernel@pankajraghav.com>
In-Reply-To: <20240527114834.167521-1-kernel@pankajraghav.com>
References: <20240527114834.167521-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

The testcase estimates to have ratio of 1:3/4 for holes:filesize. This
holds true where the blocksize is always less than or equal to pagesize
and the total size of the file is calculated based on the pagesize.
There is an implicit assumption that blocksize will always be less than
the pagesize.

LBS support will enable bs > ps where a minimum IO size is one block,
which can be greater than a page. Adjust the size calculation to be
based on the blocksize and not the pagesize.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 tests/xfs/008     | 20 +++++++++-----------
 tests/xfs/008.out |  8 ++++----
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/tests/xfs/008 b/tests/xfs/008
index e7d6153b..f42b3ac8 100755
--- a/tests/xfs/008
+++ b/tests/xfs/008
@@ -10,8 +10,7 @@
 _begin_fstest rw ioctl auto quick
 
 status=0	# success is the default!
-pgsize=`$here/src/feature -s`
-
+blksize=$(_get_file_block_size "$TEST_DIR")
 # Override the default cleanup function.
 _cleanup()
 {
@@ -21,7 +20,7 @@ _cleanup()
 
 _filter()
 {
-    sed -e "s/-b $pgsize/-b PGSIZE/g" \
+    sed -e "s/-b $blksize/-b BLKSIZE/g" \
 	-e "s/-l .* -c/-l FSIZE -c/g"
 }
 
@@ -73,18 +72,17 @@ _require_test
 # We are trying to create roughly 50 or 100 holes in a file
 # using random writes. Assuming a good distribution of 50 writes
 # in a file, the file only needs to be 3-4x the size of the write
-# size muliplied by the number of writes. Hence we use 200 * pgsize
-# for files we want 50 holes in and 400 * pgsize for files we want
+# size muliplied by the number of writes. Hence we use 200 * blksize
+# for files we want 50 holes in and 400 * blksize for files we want
 # 100 holes in. This keeps the runtime down as low as possible.
 #
-_do_test 1 50 "-l `expr 200 \* $pgsize` -c 50 -b $pgsize"
-_do_test 2 100 "-l `expr 400 \* $pgsize` -c 100 -b $pgsize"
-_do_test 3 100 "-l `expr 400 \* $pgsize` -c 100 -b 512"   # test partial pages
+_do_test 1 50 "-l `expr 200 \* $blksize` -c 50 -b $blksize"
+_do_test 2 100 "-l `expr 400 \* $blksize` -c 100 -b $blksize"
+_do_test 3 100 "-l `expr 400 \* $blksize` -c 100 -b 512"   # test partial blocks
 
 # rinse, lather, repeat for direct IO
-_do_test 4 50 "-d -l `expr 200 \* $pgsize` -c 50 -b $pgsize"
-_do_test 5 100 "-d -l `expr 400 \* $pgsize` -c 100 -b $pgsize"
-# note: direct IO requires page aligned IO
+_do_test 4 50 "-d -l `expr 200 \* $blksize` -c 50 -b $blksize"
+_do_test 5 100 "-d -l `expr 400 \* $blksize` -c 100 -b $blksize"
 
 # todo: realtime.
 
diff --git a/tests/xfs/008.out b/tests/xfs/008.out
index 5e3ae8e3..0941e218 100644
--- a/tests/xfs/008.out
+++ b/tests/xfs/008.out
@@ -1,10 +1,10 @@
 QA output created by 008
 
-randholes.1 : -l FSIZE -c 50 -b PGSIZE
+randholes.1 : -l FSIZE -c 50 -b BLKSIZE
 ------------------------------------------
 holes is in range
 
-randholes.2 : -l FSIZE -c 100 -b PGSIZE
+randholes.2 : -l FSIZE -c 100 -b BLKSIZE
 ------------------------------------------
 holes is in range
 
@@ -12,10 +12,10 @@ randholes.3 : -l FSIZE -c 100 -b 512
 ------------------------------------------
 holes is in range
 
-randholes.4 : -d -l FSIZE -c 50 -b PGSIZE
+randholes.4 : -d -l FSIZE -c 50 -b BLKSIZE
 ------------------------------------------
 holes is in range
 
-randholes.5 : -d -l FSIZE -c 100 -b PGSIZE
+randholes.5 : -d -l FSIZE -c 100 -b BLKSIZE
 ------------------------------------------
 holes is in range
-- 
2.34.1

