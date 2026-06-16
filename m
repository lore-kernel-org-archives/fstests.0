Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097084779B1
	for <fstests@vger.kernel.org>; Tue, 16 Jun 2026 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629603; cv=none; b=Zix0UkwvIkIoDxTJN8j4v5gCipvMKZl2LRh1ATU9HFVjvSr8NTIK+j4Snnmd2kfPs7gfhFnKKv7DSxzkFiHPYYtDKYmAbEKJQFEnp9xoBAXPapA4syQHv0ONIgoyM46VxghubBTkxB5fRAqizwypPMdN1K8SISpU1GBfbviw9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629603; c=relaxed/simple;
	bh=tIY2aDNOzVLuP0T18IRDSmySim3LvO53fmY2fSFPMsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c1lu0xalQgaqC5SBMdxB0JDvjdX1s9y+wZNuh847aHjnr1z6vymd332nwui5tRi3JRGyxVnjlmqP44fq4p0p5nwauP6efU1Tb7NV5qSLyBrmOcdPL/4Yld9dvO2WyP08vbK357aoOa6sJ19tD8kYCATAMDfd8jIkdceAGvnTP0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=hqpJn6FS; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="hqpJn6FS"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id D18391D484;
	Tue, 16 Jun 2026 16:58:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me D18391D484
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1781629103; bh=tIY2aDNOzVLuP0T18IRDSmySim3LvO53fmY2fSFPMsM=;
	h=From:To:Cc:Subject:Date:From;
	b=hqpJn6FSJLfaypUP1/baJIJ8nR/ESdOjeiXmGY+nCaengh2wN9Hd+nFiErmgAUftb
	 53Dz5aHYACSkg5P/et8vD++dRPRiA2uJ8+9YkgYYQLrtXJvPLo/baRDkX6tehpQ3hE
	 v5y8tVGYYfJJFx90AzLVSb5JXXJc7V/PUqZEYAco=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id mnLIH62AMWq81QUA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Tue, 16 Jun 2026 16:58:21 +0000
From: David Timber <dxdt@dev.snart.me>
To: Zorro Lang <zlang@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH] generic/740: set env for mkfs.exfat and mkfs.ntfs
Date: Wed, 17 Jun 2026 01:57:31 +0900
Message-ID: <20260616165731.379595-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Foreign filesystem detection is added in exfatprogs version 1.4.1. To
maintain backward compatibility, mkfs.exfat refuses to format the device
only when it's run from terminal with a tty associated to it.

This is similar to how e2fsprogs work around the issue. However,
with exfatprogs, this behaviour can be overridden with the special
environment variable EXFAT_TTY_OVERRIDE to simulate shell invocation by
user.

mkfs.ntfs from NTFS-3G userland package refuses to format the target
if it's backed by a "real" device but not a partition to maintain
compatibility with Windows. When formatting the scratch device in NTFS
for testing, this behaviour has to be overridden so that any type of
blockdev can be used as a scratch device.

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 tests/generic/740 | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tests/generic/740 b/tests/generic/740
index ce55200f..89822480 100755
--- a/tests/generic/740
+++ b/tests/generic/740
@@ -28,6 +28,20 @@ _require_block_device "${SCRATCH_DEV}"
 # not all the FS support zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
 
+mkfs_preop=""
+mkfs_preargs=""
+mkfs_postargs=""
+
+case "$FSTYP" in
+	exfat)
+		# Some fsprogs were slow to implement foreign fs detection.
+		# For backward compatibility, mkfs.exfat refuses to format only
+		# when run from a tty. This env var should override the
+		# behaviour if supported.
+		mkfs_preop="EXFAT_TTY_OVERRIDE=1"
+		;;
+esac
+
 echo "Silence is golden."
 for fs in `echo ${MKFS_PROG}.* | sed -e "s:${MKFS_PROG}.::g"`
 do
@@ -60,8 +74,10 @@ do
 		postargs=2000
 		;;
 	ntfs)
-		# "quick" format that doesn't zero the entire device
-		postargs="--quick"
+		# "quick" format that doesn't zero the entire device. Use -F so
+		# that NTFS-3G mkfs formats the volume even if the scratch
+		# blockdev is not a partition.
+		postargs="-QF"
 		;;
 	reiser4)
 		preop="echo y |"
@@ -83,7 +99,7 @@ do
 		# next, ensure we don't overwrite it
 
 		echo "=== Attempting $FSTYP overwrite of $fs..." >>$seqres.full
-		${MKFS_PROG} -t $FSTYP $SCRATCH_DEV >>$seqres.full 2>&1
+		eval $mkfs_preop ${MKFS_PROG} -t $FSTYP $mkfs_preargs $SCRATCH_DEV $mkfs_postargs >>$seqres.full 2>&1
 
 		[ $? -eq 0 ] && echo "Failed - overwrote fs type ${fs}!"
 	else
-- 
2.54.0

