Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBD614B091
	for <fstests@vger.kernel.org>; Thu, 13 Jun 2024 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317114; cv=none; b=rkNWWh9spyDG+IIU0sBnhYl8ToRI1+0lV9urEE5UUIWBpcqbjXndhBbizMX4z3vTqs6g+4dOsfunjhdXTwZVSMbE3x0ZaWz9ajrRvLUYbc7zyrh3oWdsTrH/Mm4sE7UItuOoRfgnGzgLE2C5vZDa2foy8niEfdM2FO+zDNeBsCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317114; c=relaxed/simple;
	bh=CssM57cUhLIsxQmArXR8ImI0sIHlvaAqlupSra9Xp2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdizXYpX1+CeCN0XFiV91M+T92mc1huebuPTv6JR5GMe/Pr1aVOE9T1HJbYCyzl8xqWw2V5Mh06cjp2OF+jS4Fg5GAK6dyd9IYx2Af/DehRMm/68YOrSpcVl83I0ldSue6KaGMYaZ4k46AD3y0bA3isWUjKMi5ltfLap6vNvBqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bD4VJB6q; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bD4VJB6q"
Received: from cwcc.thunk.org (pool-173-48-115-193.bstnma.fios.verizon.net [173.48.115.193])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45DMIQIO008360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 18:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718317108; bh=clq9l63/IeD7KNqYI85evXaOeOupvwaMZGAqKpr1ipo=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=bD4VJB6qmRCw/ZFtzeFNu6BuEVebbs6Q5VPrOCwKC1zSD25BM64GVdWrLVqKmN1DC
	 LJgnjABwlGikuk/ddIiJ/+i/2ZyLRn4gmcy4fHwSpgjtAFSyOJW0lw+V2gCyckzKfc
	 pIT0PX1c7GM4vZbKC6IQptYZOVQRV1JorMA1jfBwxkYoizuFnuVbibNtAwTszXjxQq
	 BEgR85nv6Yxi+NApAQ+AR6KksZ0GYYRr+qJkxXWaESDT/aYjw1r1aUkBRVr/Q0LAh0
	 LWaHShsiRlbBP7N6K4PUUxso+l2xkOrxvWt2XIUzhcdp6rnw6inY1reXd6G/7qXOex
	 TGYDEcQUUaRtQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 8F84515C0579; Thu, 13 Jun 2024 18:18:26 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] generic/269, generic/475: disable io_uring to prevent umount EBUSY flakes
Date: Thu, 13 Jun 2024 18:18:09 -0400
Message-ID: <20240613221810.803463-1-tytso@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613215639.GE1906022@mit.edu>
References: <20240613215639.GE1906022@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an I/O uring bug which can hold on to file references after
the userspace program exits.  This is causing tests which run fsstress
and then try to unmount the file system to fail in a flaky fashion.
Since the point of these tests is not to test io_uring, and io_uring
has remained buggy since August 2023, let's fix the problem by
disabling io_uring in fsstress for these tests.

We can add a new test which specifically (and reliably) tests for this
io_uring bug.

See the link below for more details.

Link: https://lore.kernel.org/fstests/20230831151837.qexyqjgvrllqaz26@zlang-mailbox/
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/269 | 3 +++
 tests/generic/475 | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tests/generic/269 b/tests/generic/269
index 29f453735..9be7ea9aa 100755
--- a/tests/generic/269
+++ b/tests/generic/269
@@ -13,6 +13,9 @@ _begin_fstest auto rw prealloc ioctl enospc stress
 . ./common/filter
 # Disable all sync operations to get higher load
 FSSTRESS_AVOID="$FSSTRESS_AVOID -ffsync=0 -fsync=0 -ffdatasync=0"
+# io_uring is buggy and causes "fsstress; umount" EBUSY test flakes
+FSSTRESS_AVOID="$FSSTRESS_AVOID -f uring_read=0 -f uring_write=0"
+
 _workout()
 {
 	echo ""
diff --git a/tests/generic/475 b/tests/generic/475
index abd6e89a1..3e9200771 100755
--- a/tests/generic/475
+++ b/tests/generic/475
@@ -45,6 +45,9 @@ _require_metadata_journaling $SCRATCH_DEV
 _dmerror_init
 _dmerror_mount
 
+# io_uring is buggy and causes "fsstress; umount" EBUSY test flakes
+FSSTRESS_AVOID="$FSSTRESS_AVOID -f uring_read=0 -f uring_write=0"
+
 while _soak_loop_running $((50 * TIME_FACTOR)); do
 	($FSSTRESS_PROG $FSSTRESS_AVOID -d $SCRATCH_MNT -n 999999 -p $((LOAD_FACTOR * 4)) >> $seqres.full &) \
 		> /dev/null 2>&1
-- 
2.43.0

