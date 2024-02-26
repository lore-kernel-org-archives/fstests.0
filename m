Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C810654279
	for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941808; cv=none; b=Vvv5/uxuAznVt4boWZzvuNMeNiIakWF3aSim7j/op1LCmuPWik0xaR49C7Sc4OkAer6XT7cg7pmYWpOlbd2ioz2H5Nr/5lRhgK8t3bG1TUHYt66KEEBGoV12L+YkEfhgEtNNhqCTT9k1xzxhGwSDuLjmouy10mTn4zZXbpxCRyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941808; c=relaxed/simple;
	bh=e6PNwbV7sdMXi5m+lTN5lYvCO8+UQrBrJMM6j9IruHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GTRl4KLtK/1zW9kXqzeVfe6Ir1M9QiP56op8jAcrSPhiJpzc47/+QoZ1O9CiKEKUNqmA+yBtW7Xy1EJHsICyv8KyM3pmyoF85o+97aBkPT2ph4cSYr30735xTjJ+qtucxAlBuBaN0boKq6M9KOK05QNUDNwBt0jFCjk0t1+/+QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BcEydq5N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BcEydq5N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rUr7IeXW9qM37+oaOEW/b+sWD4Tjk74mqtoHgsx+vaY=; b=BcEydq5NfMP92ZyIb2/z+CfEz1
	eOw/Ed9BDTf0qaFFN+a0AeuMx1u0kIcDMQuINy41oT/nfKp76RW21ZUYIzs+B7w704/gQkt7/CTJB
	yjxjMSnHZtoO3iC4frNiYIGWKYf4XPvelUPhPOdf8xbiZAQV3tMdp1g9lwqcnfQaMHjbcg2gqBHKJ
	7nP8Pslp0ZSOxByFl0d9hYnC81fKijISJLUORRSsS+rNSTJ5Au6lVqJewC2lNasfBhuBqUhXytov8
	T0lm+MYmJC1km82QgsBTSn7ZHufkSb2R0BEh9OiMAICwrm2/lOhhPnC2fbMV1EpIfuU7+jnkZHogQ
	siwDw0vQ==;
Received: from 213-147-167-65.nat.highway.webapn.at ([213.147.167.65] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reXpV-0000000HWW7-1vml;
	Mon, 26 Feb 2024 10:03:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@redhat.com
Cc: fstests@vger.kernel.org,
	jaegeuk@kernel.org
Subject: [PATCH] generic/392: stop checking st_blocks
Date: Mon, 26 Feb 2024 11:03:19 +0100
Message-Id: <20240226100319.280355-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

st_blocks is a rather vaguely defined field.  To quote the Linux stat(2)
man page:

    Use of the st_blocks and st_blksize fields may be less portable.
    (They were introduced in BSD.  The interpretation differs between
    systems, and possibly on a single system when NFS mounts are
    involved.)

or the FreeBSD one:

    st_blocks   Actual number of blocks allocated for the file in
		512-byte units.  As short symbolic links are stored in
		the inode, this number may be zero.

and at least for XFS they include speculative preallocations and
in-flight COW fork allocations, and the numbers can change when the way
how data is stored is reorganized.  Because of that it doesn't make sense
to require st_blocks to not change after a crash even when fsync or
fdatasync was involved.

Remove the st_blocks checks and the now superfluous XFS always_cow
workaround.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/392 | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tests/generic/392 b/tests/generic/392
index c4bb3f4b9..0c9efb6df 100755
--- a/tests/generic/392
+++ b/tests/generic/392
@@ -6,7 +6,7 @@
 #
 # Test inode's metadata after fsync or fdatasync calls.
 # In the case of fsync, filesystem should recover all the inode metadata, while
-# recovering i_blocks and i_size at least for fdatasync.
+# recovering for fdatasync it should at least recovery i_size.
 #
 . ./common/preamble
 _begin_fstest shutdown auto quick metadata punch
@@ -28,16 +28,6 @@ _scratch_mkfs >/dev/null 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _scratch_mount
 
-# This test requires that i_blocks remains unchanged from the start of the
-# check_inode_metadata call until after recovery is complete.  fpunch calls
-# turn into pagecache writes if the arguments are not aligned to the fs
-# blocksize.  If the range being punched is already mapped to a written extent
-# and alwayscow is enabled, i_blocks will increase by the size of the COW
-# staging extent.  This causes stat to report different numbers for %b, which
-# results in a test failure.  Hence do not run this test if XFS is in alwayscow
-# mode.
-test "$FSTYP" = "xfs" && _require_no_xfs_always_cow
-
 testfile=$SCRATCH_MNT/testfile
 
 # check inode metadata after shutdown
@@ -47,9 +37,9 @@ check_inode_metadata()
 
 	# fsync or fdatasync
 	if [ $sync_mode = "fsync" ]; then
-		stat_opt='-c "b: %b s: %s a: %x m: %y c: %z"'
+		stat_opt='-c "s: %s a: %x m: %y c: %z"'
 	else
-		stat_opt='-c "b: %b s: %s"'
+		stat_opt='-c "s: %s"'
 	fi
 
 	before=`stat "$stat_opt" $testfile`
-- 
2.39.2

