Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE412381AA
	for <fstests@vger.kernel.org>; Mon,  6 May 2024 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007695; cv=none; b=GllOxbIDWKuOGPaJyEcTI6X9RfEXnPBOouQH0MdlXhrOJcMWd4m/OfH4o0hXUNq8w6PyXfcNDknXSBa9NWc5Xwik2sW2N9jaXjTysySx1LSuyOb+0HFNoGW3aNnzCwcZPl9G/oC8bXelabsitqU8wZ+7HeGYHo3b3h7JmjLEuwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007695; c=relaxed/simple;
	bh=9W2sGn9wdTvsb3JWOMrBE6XRt62bAsJBPqJuqtkSBQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q5ZPrU4q/jZPaDY1r4fdehI1KPChBBknsZfwha+jAUoODawrSgLGWHUuTM+D1q9htmPaESl3+aI9zuql2ETdE4e2NVc89oCz/XfqAmuWXrYUxvbSZB9V+vKtIG9nSfdTyhd0yMji8rCK6gzEXOuuj44BBGM7az9jmecAZyGBdmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=TZeD/rUE; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="TZeD/rUE"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VY4P62BNkz9srB;
	Mon,  6 May 2024 17:01:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715007690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TGyfVBrG6tNYQTV0BLRkKxECl/ct9ngRV14U8/xO28s=;
	b=TZeD/rUEZF/ixuFRj6XG8uywzjCsHOOWFH95cER6OmnRkshLIwAdZlck64T/nmye3BsbyR
	kA4s5zshqOE6Ern7nLmtlXV7dkKl6dnhn6/QoAiQklekQRTwik7Tm58mhWwUMreLDI4IN8
	1Z3rjGLLGulU7xwLBI0xPb3K30oG96rWeysKtWKGFe1AZrryNHjIctFjfXbQ+N+NgCXjag
	MSOyO7O3eEmlSb9dFPg3GdLoLvf9OC1nKKlmvOUYlxY8cpUfcHMoTa/aFuOxCtjuK+YPZl
	Ere812euqMlm62Ypb13oXET/uGQO8S8opiPd0Q2AYqh2s8Ztb+Oz2mlW5HIOiA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org,
	gost.dev@samsung.com,
	mcgrof@kernel.org,
	kernel@pankajraghav.com,
	ritesh.list@gmail.com,
	zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 3/3] xfs/008: use block size instead of the pagesize
Date: Mon,  6 May 2024 17:01:19 +0200
Message-Id: <20240506150119.184097-4-kernel@pankajraghav.com>
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
 tests/xfs/008     | 19 ++++++++++---------
 tests/xfs/008.out |  8 ++++----
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/tests/xfs/008 b/tests/xfs/008
index e7d6153b..e37e435a 100755
--- a/tests/xfs/008
+++ b/tests/xfs/008
@@ -11,7 +11,8 @@ _begin_fstest rw ioctl auto quick
 
 status=0	# success is the default!
 pgsize=`$here/src/feature -s`
-
+fileblksize=$(_get_file_block_size "$TEST_DIR")
+blksize=$((fileblksize > pgsize ? fileblksize : pgsize))
 # Override the default cleanup function.
 _cleanup()
 {
@@ -21,7 +22,7 @@ _cleanup()
 
 _filter()
 {
-    sed -e "s/-b $pgsize/-b PGSIZE/g" \
+    sed -e "s/-b $blksize/-b BLKSIZE/g" \
 	-e "s/-l .* -c/-l FSIZE -c/g"
 }
 
@@ -73,17 +74,17 @@ _require_test
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
+_do_test 4 50 "-d -l `expr 200 \* $blksize` -c 50 -b $blksize"
+_do_test 5 100 "-d -l `expr 400 \* $blksize` -c 100 -b $blksize"
 # note: direct IO requires page aligned IO
 
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

