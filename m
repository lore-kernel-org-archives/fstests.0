Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577324E4A1
	for <fstests@vger.kernel.org>; Thu, 18 Jun 2026 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810591; cv=none; b=oFJ648ATTtKAcRBHRl6dI1zXiCWtz86yytH8fDvKgMMpMViFXNs0zgqviIomtdWli4eVwaqdDsvPs0gg+3XOk9xloHAuooA5RQ/7HQoXOX9NbVI3Zw+tBO6JR6tk+LJNt7YkjSwRdzcCuxRpheGFlQUxs7fIcQSLhgQKNr6flZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810591; c=relaxed/simple;
	bh=+ZrFwN9tZi30mWXlyzdV2DPmSeqvhJRTkBrKjbmjyNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DRATClJG8LGGDB7RgZpvMGICmu8nR5thCdnVe6+DNF6Y2BNXQEVENuMWsf9vXHGVPAKAx8RxQwasNW6YuFVP9vH/LfPfv32M2KSG3dF950boEUOj8WWwohJ5rBEEPw90HwOYXYWMxs363t3EIhzTV7TMOwvrvEEjWVU+f96XMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=LvVL0pVE; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="LvVL0pVE"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 729671D484;
	Thu, 18 Jun 2026 19:23:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 729671D484
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1781810588; bh=+ZrFwN9tZi30mWXlyzdV2DPmSeqvhJRTkBrKjbmjyNE=;
	h=From:To:Cc:Subject:Date:From;
	b=LvVL0pVEmSjomrRDhCDa06NIZgzl3Dc3XDVVPlQVw+zrhBmmiHerTFqz0MyiCPpt3
	 R7xZL5r8jYE9mCE7X0LRYbQZF7f8pettlLL6XeRC/QvYqj2H6RwMKjRrjt2kwk6sYw
	 /xBxLGdQhQMAHj3guKafas/SCuF6+ADh6+Ryj23U=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id SooBCZtFNGqfogYA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Thu, 18 Jun 2026 19:23:07 +0000
From: David Timber <dxdt@dev.snart.me>
To: Zorro Lang <zlang@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH 1/2] generic/740: set env for mkfs.exfat
Date: Fri, 19 Jun 2026 04:22:35 +0900
Message-ID: <20260618192236.654082-1-dxdt@dev.snart.me>
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

Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 tests/generic/740 | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tests/generic/740 b/tests/generic/740
index ce55200f..4f8bf099 100755
--- a/tests/generic/740
+++ b/tests/generic/740
@@ -28,6 +28,18 @@ _require_block_device "${SCRATCH_DEV}"
 # not all the FS support zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
 
+mkfs_preop=""
+mkfs_preargs=""
+mkfs_postargs=""
+
+case "$FSTYP" in
+exfat)
+	# For backward compatibility, mkfs.exfat refuses to format only when run
+	# from a tty. This env var should override the behaviour if supported.
+	mkfs_preop="EXFAT_TTY_OVERRIDE=1"
+	;;
+esac
+
 echo "Silence is golden."
 for fs in `echo ${MKFS_PROG}.* | sed -e "s:${MKFS_PROG}.::g"`
 do
@@ -83,7 +95,8 @@ do
 		# next, ensure we don't overwrite it
 
 		echo "=== Attempting $FSTYP overwrite of $fs..." >>$seqres.full
-		${MKFS_PROG} -t $FSTYP $SCRATCH_DEV >>$seqres.full 2>&1
+		eval $mkfs_preop ${MKFS_PROG} -t $FSTYP $mkfs_preargs $SCRATCH_DEV $mkfs_postargs \
+			>>$seqres.full 2>&1
 
 		[ $? -eq 0 ] && echo "Failed - overwrote fs type ${fs}!"
 	else
-- 
2.54.0

