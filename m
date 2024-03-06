Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A661BF3B
	for <fstests@vger.kernel.org>; Wed,  6 Mar 2024 01:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709688175; cv=none; b=CnUetzhIyjepEMH3Z13+xoeL7aq7nKYdcdFEyAP4ra0eD0RMSLSJyCJq9t0qUDzmILpya59VZ7JCne+Vg3Q1VFxSU8ROk3dYGkZSaT28T9qL4YO3HJKDEthn/uq6QR4gT/qONEsYy7DERCMTyvyqsSlL4oeJNyTlK7ShWa7CydU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709688175; c=relaxed/simple;
	bh=HfZ2cf411PMQaEI5hxMVHdIWGe96vH82XhotXvef7Ew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mUIS+MKN5a4bum/YyI4rB9V1Pzqf9hkYcpVektIKabo4klZ47D2ojK890Smm4+f37VVZktnnFLs5G/zxzniWvX8zCOJTH7H2av9R08KZXMgwmoNP6AR4byUBwr+k3gWaIYEJudMYzTI6xLXMn372fXisjlgnamOrf9oC0Fn7rsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vz+wv1Pr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vz+wv1Pr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5/s3YYegi2uefwhNdSbPPv3H1w1kEfchnzw69RfAvIo=; b=vz+wv1Pr6WzdPGyGNt1UC8FQvn
	z4NHKO0qbdAEBQpnvjTqHCvLqlfdxr46VPAcROXYRVGAC/2X/YRZETjnlmzUBG39xE9QGgpZfMnq1
	Sh6zY6602/hv2CwcpBY1+fYZTcGNTEAsbXKfnWe95dMnX9N712fP3IAS9Lt1wJWdmsZgAXoREywmM
	3QJb/NwYvXrMF7O6AX/R3IJtNpmf/dLOZXevajYGKvYznc/pEYyYZo1ypC0bCdwczuMYjPaibVj1G
	nhnEYB/vDTAzzOw4HJTIv553LKTfjclJIf4QFb9qhtDuGKe9FSwnZ6N9JTR2hYUzW3A+ev685pZeR
	th4JubxQ==;
Received: from [66.60.99.14] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhfzb-0000000FrFn-2tGy;
	Wed, 06 Mar 2024 01:22:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: zlang@kernel.org
Cc: djwong@kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] shared/298: call fs commands on the loop device
Date: Tue,  5 Mar 2024 18:22:46 -0700
Message-Id: <20240306012246.162729-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

In general calling fs tools is best done on the block device used for
the file system and not the backing device of a loop file.  Thus switch
shared/298 to call all fs commands on the loop device.  Also add a
common on why the xfs_io fiemap command is called on the backing file,
and to have a good place for the comment stop passing the backing file
as the argument to get_holes function and just use it implicitly as
the other helpers to with the loop device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/shared/298 | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tests/shared/298 b/tests/shared/298
index a6e368143..1d4e8d943 100755
--- a/tests/shared/298
+++ b/tests/shared/298
@@ -46,7 +46,11 @@ get_holes()
 	# to established convention which requires the filesystem to be
 	# unmounted while we probe the underlying file.
 	$UMOUNT_PROG $loop_mnt
-	$XFS_IO_PROG -F -c fiemap $1 | grep hole | $SED_PROG 's/.*\[\(.*\)\.\.\(.*\)\].*/\1 \2/'
+
+	# FIEMAP only works on regular files, so call it on the backing file
+	# and not the loop device like everything else
+	$XFS_IO_PROG -F -c fiemap $img_file | grep hole | \
+		$SED_PROG 's/.*\[\(.*\)\.\.\(.*\)\].*/\1 \2/'
 	_mount $loop_dev $loop_mnt
 }
 
@@ -55,7 +59,7 @@ get_free_sectors()
 	case $FSTYP in
 	ext4)
 	$UMOUNT_PROG $loop_mnt
-	$DUMPE2FS_PROG $img_file  2>&1 | grep " Free blocks" | cut -d ":" -f2- | \
+	$DUMPE2FS_PROG $loop_dev  2>&1 | grep " Free blocks" | cut -d ":" -f2- | \
 		tr ',' '\n' | $SED_PROG 's/^ //' | \
 		$AWK_PROG -v spb=$sectors_per_block 'BEGIN{FS="-"};
 		     NF {
@@ -77,15 +81,15 @@ get_free_sectors()
 		local device_size=$($BTRFS_UTIL_PROG filesystem show --raw $loop_mnt 2>&1 \
 			| sed -n "s/^.*size \([0-9]*\).*$/\1/p")
 
-		local nodesize=$($BTRFS_UTIL_PROG inspect-internal dump-super $img_file  \
+		local nodesize=$($BTRFS_UTIL_PROG inspect-internal dump-super $loop_dev \
 			| sed -n 's/nodesize\s*\(.*\)/\1/p')
 
 		# Get holes within block groups
-		$BTRFS_UTIL_PROG inspect-internal dump-tree -t extent $img_file \
+		$BTRFS_UTIL_PROG inspect-internal dump-tree -t extent $loop_dev \
 			| $AWK_PROG -v sectorsize=512 -v nodesize=$nodesize -f $here/src/parse-extent-tree.awk
 
 		# Get holes within unallocated space on disk
-		$BTRFS_UTIL_PROG inspect-internal dump-tree -t dev $img_file \
+		$BTRFS_UTIL_PROG inspect-internal dump-tree -t dev $loop_dev \
 			| $AWK_PROG -v sectorsize=512 -v devsize=$device_size -f $here/src/parse-dev-tree.awk
 
 	;;
@@ -159,7 +163,7 @@ done
 
 # Get reference fiemap, this can contain i.e. uninitialized inode table
 sync
-get_holes $img_file > $fiemap_ref
+get_holes > $fiemap_ref
 
 # Delete some files
 find $loop_mnt -type f -print | $AWK_PROG \
@@ -173,7 +177,7 @@ echo "done."
 echo -n "Detecting interesting holes in image..."
 # Get after-trim fiemap
 sync
-get_holes $img_file > $fiemap_after
+get_holes > $fiemap_after
 echo "done."
 
 echo -n "Comparing holes to the reported space from FS..."
-- 
2.39.2

