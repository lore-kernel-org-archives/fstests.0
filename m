Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C5194AFB
	for <fstests@vger.kernel.org>; Sat,  9 Nov 2024 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731195994; cv=none; b=QeXSM9z1p0yeX6apl0ik/gmrcBeNaIDnaMgoXm0qvVh/Djy387MA6jacfS+e/0YPK0IPOp5YmZ5WPzl3IYBQQuSHIhvkBSSVdHx3LwU4OrkxNCt5xMATr87faYnAIyIJkq2+0T4r6B9mS1av2yoZyaNYPGWpYSwC00wcRVEfgcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731195994; c=relaxed/simple;
	bh=2UsTpVvo5Wb+xXXnvNTA/k++hZ1qlI1HjQ29UfZT9RU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F0FUaE7kKLhASYWZgwZO9R/50Bl9XrXpkzM9/igecwbUMSKphfI7eKAa9AUfRkIu8OMC+WkEVvlSR67TXGvKJC9HnBhn9cojd4zWUeakXptWkaSdxiXPVcWU2B9Pbc27WUnpWUv9py+u++LXM76G15pBRel21WH3YR7sLnw9CS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=d3k2OTkw; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="d3k2OTkw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2wwB1wZIYtoeBYXguuKzmk7bVKw6Ndd2zQbCiKPOq4A=; b=d3k2OTkwUZ7Dc/5ypDFHe5FL/6
	hp7WYyVZ+rtDY9st3N3kFpaFyDN+GrhOX64u+47CUWqGcPwqI2RQ4QU+3gsW7x7+fhXECzNgpOm8V
	V3r2thoGVmdJoRJ2poEzbbHgqk1HmNWteMaq83wtEEEdQ/khjag4impNxWlbR3b9Boc0dCm/5jJdn
	dx37gN8D0Hrr7h2rAjES7ga01SYcyciVyIm/Hz7rEj1JvFZI8U0PFSAFYcmabm2xHrhPXM1gge+sG
	vPnirehJNd4aRvqUv6XeGOsQyYfOiwFRLslV53Tcah5S0UKaUm0obsYKztYXjR6Qw/WGdYRC7hHcA
	KNL8dvtQ==;
Received: from [177.172.124.78] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t9v9v-004s9x-H1; Sun, 10 Nov 2024 00:46:27 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@kernel.org>,
	kernel-dev@igalia.com,
	Miklos Szeredi <mszeredi@redhat.com>,
	Eryu Guan <guaneryu@gmail.com>,
	krisman@kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v3] common/casefold: Support for tmpfs casefold test
Date: Sat,  9 Nov 2024 20:46:18 -0300
Message-ID: <20241109234618.29262-1-andrealmeid@igalia.com>
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
 common/casefold   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 common/rc         |  3 +++
 tests/generic/556 | 12 ++++++++----
 3 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/common/casefold b/common/casefold
index d9126f4c..2aae5e5e 100644
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
@@ -52,6 +55,9 @@ _scratch_mkfs_casefold()
 	f2fs)
 		_scratch_mkfs -C utf8 $*
 		;;
+	tmpfs)
+		# there's no mkfs for tmpfs, just return
+		;;
 	*)
 		_notrun "Don't know how to mkfs with casefold support on $FSTYP"
 		;;
@@ -67,12 +73,52 @@ _scratch_mkfs_casefold_strict()
 	f2fs)
 		_scratch_mkfs -C utf8:strict
 		;;
+	tmpfs)
+		# there's no mkfs for tmpfs, just return
+		;;
 	*)
 		_notrun "Don't know how to mkfs with casefold-strict support on $FSTYP"
 		;;
 	esac
 }
 
+_scratch_mount_casefold()
+{
+	case $FSTYP in
+	ext4)
+		_scratch_mount
+		;;
+	f2fs)
+		_scratch_mount
+		;;
+	tmpfs)
+		mount -t tmpfs -o casefold tmpfs $SCRATCH_MNT
+		;;
+	*)
+		_notrun "Don't know how to mount with casefold support on $FSTYP"
+		;;
+	esac
+}
+
+_scratch_mount_casefold_strict()
+{
+	case $FSTYP in
+	ext4)
+		_scratch_mount
+		;;
+	f2fs)
+		_scratch_mount
+		;;
+	tmpfs)
+		mount -t tmpfs -o casefold,strict_encoding tmpfs $SCRATCH_MNT
+		;;
+	*)
+		_notrun "Don't know how to mount with casefold support on $FSTYP"
+		;;
+	esac
+}
+
+
 # To get the exact disk name, we need some method that does a
 # getdents() on the parent directory, such that we don't get
 # normalized/casefolded results.  'Find' works ok.
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
index 51d2d482..d3396ae3 100755
--- a/tests/generic/556
+++ b/tests/generic/556
@@ -18,7 +18,11 @@ _require_symlinks
 _require_check_dmesg
 _require_attrs
 
-sdev=$(_short_dev ${SCRATCH_DEV})
+if [ "$FSTYP" == "tmpfs" ]; then
+	sdev="tmpfs"
+else
+	sdev="\($(_short_dev ${SCRATCH_DEV})\)"
+fi
 
 filename1="file.txt"
 filename2="FILE.TXT"
@@ -485,10 +489,10 @@ test_strict_mode_invalid_filename()
 
 _scratch_mkfs_casefold >>$seqres.full 2>&1
 
-_scratch_mount
+_scratch_mount_casefold
 
 _check_dmesg_for \
-	"\(${sdev}\): Using encoding defined by superblock: utf8" || \
+	"(${sdev}): Using encoding" || \
 	_fail "Could not mount with encoding: utf8"
 
 test_casefold_flag_basic
@@ -517,7 +521,7 @@ _check_scratch_fs
 
 # Test Strict Mode
 _scratch_mkfs_casefold_strict >>$seqres.full 2>&1
-_scratch_mount
+_scratch_mount_casefold_strict
 
 test_strict_mode_invalid_filename
 
-- 
2.47.0

