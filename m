Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5CD1FA265
	for <fstests@vger.kernel.org>; Mon,  4 Nov 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754409; cv=none; b=D0Qhrco/tPObfRDjwIDrMZ2uMrgT30VsGlsFbAR/5u8ZDb+ZyMVd3M5lV8FHZXC5YMbgPmUQjsClgi325ksLkFMVeYzOfghmkjn9z9zlVp0M4ae9duSbuk45eOuJ9UdVAIACp+QacPjMVraCiIFuKO7WEApZNLd5R4jnhYrVK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754409; c=relaxed/simple;
	bh=JQeUGOYMGhYvy1nCBlUXcKTEncScAu3xP5o/VC8o+WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tF/XUUabTamNK8Y6ZjspMWFkRRblZAESu/yt/ura7R1bJwUEbTtQBlyHOHzI1pxp83daoopxzDBVFmQglMNafkwWBwrZOiIGApnK/CDVoTw3V1iEExLHsNnfq6UtBnm0o6fsGkB+NIXb+Ksi323+Ph+oIePoldToLVW6YuDwf8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fNMB/onp; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fNMB/onp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xsE6hZ4rpivvtUCc3DVNzXo8LQg1jshrnIyeT0AudoY=; b=fNMB/onpn4o5rI0Dp/5Qe6vY2R
	R4fXhHf+4VQnajDrPPqE6i4TU+UeQmv0vpTHQh5Z+Q/AknQ/wqyrjOUUJDMFdMi+dVjoMet/HeYvn
	FmPUtKYPCUsrpHm+gt4P4uq/530S4japHnPgjazf9jD1o50S1IroZZhvqVIFPkmiO7m/QEQhtar5k
	D5a1tnaPfiLD8+ZJ1I0FkUQPbi+ExtMBzn9yoJdKNVwFZxcsmHHdwBO9t9ZEZ82WRj0ih0KjzYWcI
	oEkohPrrBdx9PyOc3fIM/uGVQ/CjWwHTXNCeligArfx8m8Ipt2IozQCO1WjWAtyQbhlDw66Lg+xZp
	obn063nw==;
Received: from [177.172.124.78] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t84Hb-001q19-Cf; Mon, 04 Nov 2024 22:06:43 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@kernel.org>,
	kernel-dev@igalia.com,
	Miklos Szeredi <mszeredi@redhat.com>,
	Eryu Guan <guaneryu@gmail.com>,
	krisman@kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2] common/casefold: Support for tmpfs casefold test
Date: Mon,  4 Nov 2024 18:06:36 -0300
Message-ID: <20241104210636.38934-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.47.0
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
The kernel side was accepted and can be currently found at vfs.all tree.

This is the expected test output:

$ sudo TEST_DIR=/tmp/mnt/ SCRATCH_MNT=/tmp/scratch SCRATCH_DEV=/tmp/scratch ./check -tmpfs generic/556
FSTYP         -- tmpfs
PLATFORM      -- Linux/x86_64 archlinux 6.12.0-rc4-00148-g46d491956216 #347 SMP PREEMPT_DYNAMIC Mon Nov  4 18:01:10 -03 2024
MKFS_OPTIONS  -- /tmp/scratch
MOUNT_OPTIONS -- -o size=1G /tmp/scratch /tmp/scratch

generic/556 0s ...  0s
mv: failed to preserve ownership for '/home/user/codes/xfstests-dev/results//check.time': Operation not permitted
Ran: generic/556
Passed all 1 tests

 common/casefold   | 11 +++++++++++
 common/rc         |  3 +++
 tests/generic/556 | 23 +++++++++++++++++------
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/common/casefold b/common/casefold
index d9126f4c..d0be8538 100644
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
+		mount -t tmpfs -o casefold tmpfs $SCRATCH_MNT
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
+		mount -t tmpfs -o casefold,strict_encoding tmpfs $SCRATCH_MNT
+		;;
 	*)
 		_notrun "Don't know how to mkfs with casefold-strict support on $FSTYP"
 		;;
diff --git a/common/rc b/common/rc
index 2af26f23..2ee46e51 100644
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
index 51d2d482..78cdf1bf 100755
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
+		"tmpfs: Using encoding" || \
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
2.47.0

