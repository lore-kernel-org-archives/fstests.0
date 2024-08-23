Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BA518594C
	for <fstests@vger.kernel.org>; Fri, 23 Aug 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434226; cv=none; b=mjOjMQLc0c4cJfEB34ak8hyLsKCcC314dqcCjG3Mn8MqmTiTeCa+BfZg5I7zrtADPUkPTio4PC71gZtCh/KE/sYu7048AUi8DxnPnUJBlPeP9kSVVFtg2DQce1Ojbk2VFb3AOEMIW4alc96PVuwj2Q5difMypAd4nRss5kB1zBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434226; c=relaxed/simple;
	bh=2Va8oLkaxoJZgAcdpQZTnKLWIj03rrNlTYH+9wVFHCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KUjyuMAipv3zHkZy3hL6KePxqVRbKaGuoQ8wBzU99hFp57AmA703ebGdj3ZSdtUyzirFEB9aWdwCGI4AJL49qCpNmK/DKI6FPnWAfRugPmvCU6eUBrcz/TKZFSBOQAyCDrcriyQjTkPAJh0Uu+ZK06yGgMPixHdWtZt8/ZITLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FntepBgz; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FntepBgz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RSKGFCbnZU0waaJHCTH2I4o9q4HW2kL9xOK0uk9Nw6c=; b=FntepBgzXBjBz8FOVjkLpZ9CtC
	YmAm/rfe/t+/cFQkL+pMI2HehKMKvTbaikSA71RD3E2QMfI6vfmiKrnAAIyiy/j0/R/IcmjvhuR9C
	1XwoA26FBnshpLG0AwJ//2BBLypQWRf1tCeITIxuseEthfwK/RZ5A3DKM9VjuE1Mx1t81Rl8zliE/
	tFoKkGjLDwVp6spV7/565Ns1NPivu2FFBV8fROeLrDZwhkzoJRvfUR4tucGBxruJRar30E+5DMHrp
	oiSWJKkcIUcIGnazJ+hFeM4axmFB0JXm5PbQG0CwcnqT7U0YFOl5fB+FyKz9fzI4DKmqUFEAvf9Eu
	65YPu77w==;
Received: from [179.118.186.198] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1shY76-0048Uj-MP; Fri, 23 Aug 2024 19:30:16 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@kernel.org>,
	kernel-dev@igalia.com,
	krisman@kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH] common/casefold: Support for tmpfs casefold test
Date: Fri, 23 Aug 2024 14:30:08 -0300
Message-ID: <20240823173008.280917-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Test casefold support for tmpfs.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 common/casefold   | 11 +++++++++++
 common/rc         |  3 +++
 tests/generic/556 | 23 +++++++++++++++++------
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/common/casefold b/common/casefold
index d9126f4c..8a646ae6 100644
--- a/common/casefold
+++ b/common/casefold
@@ -12,6 +12,9 @@ _has_casefold_kernel_support()
 	f2fs)
 		test -f '/sys/fs/f2fs/features/casefold'
 		;;
+	tmpfs)
+		test -f '/sys/fs/tmpfs/features/casefold'
+		;;
 	*)
 		# defaults to unsupported
 		false
@@ -52,6 +55,10 @@ _scratch_mkfs_casefold()
 	f2fs)
 		_scratch_mkfs -C utf8 $*
 		;;
+	tmpfs)
+		# there's no mkfs for tmpfs, so we just mount it
+		mount -t tmpfs -o casefold=utf8-12.1.0 tmpfs $SCRATCH_MNT
+		;;
 	*)
 		_notrun "Don't know how to mkfs with casefold support on $FSTYP"
 		;;
@@ -67,6 +74,10 @@ _scratch_mkfs_casefold_strict()
 	f2fs)
 		_scratch_mkfs -C utf8:strict
 		;;
+	tmpfs)
+		# there's no mkfs for tmpfs, so we just mount it
+		mount -t tmpfs -o casefold=utf8-12.1.0,strict_encoding tmpfs $SCRATCH_MNT
+		;;
 	*)
 		_notrun "Don't know how to mkfs with casefold-strict support on $FSTYP"
 		;;
diff --git a/common/rc b/common/rc
index afc33bbc..e2f4e4eb 100644
--- a/common/rc
+++ b/common/rc
@@ -374,6 +374,9 @@ _scratch_unmount()
 	btrfs)
 		$UMOUNT_PROG $SCRATCH_MNT
 		;;
+	tmpfs)
+		$UMOUNT_PROG $SCRATCH_MNT
+		;;
 	*)
 		$UMOUNT_PROG $SCRATCH_DEV
 		;;
diff --git a/tests/generic/556 b/tests/generic/556
index 51d2d482..cbc0146b 100755
--- a/tests/generic/556
+++ b/tests/generic/556
@@ -485,11 +485,20 @@ test_strict_mode_invalid_filename()
 
 _scratch_mkfs_casefold >>$seqres.full 2>&1
 
-_scratch_mount
-
-_check_dmesg_for \
-	"\(${sdev}\): Using encoding defined by superblock: utf8" || \
-	_fail "Could not mount with encoding: utf8"
+# casefold tmpfs was already mounted in the mkfs step
+if [ "$FSTYP" != "tmpfs" ]; then
+	_scratch_mount
+fi
+
+if [ "$FSTYP" == "tmpfs" ]; then
+	_check_dmesg_for \
+		"tmpfs: Using encoding provided by mount options: utf8" || \
+		_fail "Could not mount with encoding: utf8"
+else
+	_check_dmesg_for \
+		"\(${sdev}\): Using encoding defined by superblock: utf8" || \
+		_fail "Could not mount with encoding: utf8"
+fi
 
 test_casefold_flag_basic
 test_casefold_lookup
@@ -517,7 +526,9 @@ _check_scratch_fs
 
 # Test Strict Mode
 _scratch_mkfs_casefold_strict >>$seqres.full 2>&1
-_scratch_mount
+if [ "$FSTYP" != "tmpfs" ]; then
+	_scratch_mount
+fi
 
 test_strict_mode_invalid_filename
 
-- 
2.46.0

