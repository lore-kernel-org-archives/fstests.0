Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795075687;
	b=BwC63KyV8RWVdCKY0MPoLZ5fIGkfjgl+eOh+zQ43YMmPN5rEBQvSRzLBPawRyKBQxaoL
	 f/ptQ3nkKu04c3hUHkLSGBczqjm+ABP01aTxYdebDunIz/7aXjdgAEw+tVJRoG68RONVk
	 uVZfdOUywfU9W+9SFbB8XXn6NjOhJuuUeMB45dgmIoOnmdxLf4P9NekJTLAdSNaKViCrY
	 hceYAbAqLsmDTKwDYCPT+EuGmxXZ8IRQ2oBHdhd5h276VHFn9QGis4woy74fBplqa616t
	 x7wfRTVaSsMoTOBsMnOqUgCg4QSN9/5P2SIXc2jNj+8sFnpJDAMv0badgpcVU8s+ivw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795075687;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fCWZLx5X4SsEuhyehHFdeYutdRBt9pKfy4NkWwWUjYQ=;
	b=fuSr20iC3IEMnXmP51t2g76xG5OUDeySX2hJ2SvFxlzY/fyqsESqxrKaRU4gfGh4iuFe
	 kgdLPRBQahVsfD43FgVNXwT0caGGIkFO07oftvrnUK5KH69CK90qVG963rpMRstLdwddp
	 AfZu7yVNsdpqCAhgTui6C9OPBPmmZEq3OW6+EG6MAAiiOhtmht4FKW/ZUX4SqNccRlJ5L
	 QtsSHF6+wChd8R01ASiQLaVo+Q3d4dqHx1Xpocfog+8GoPgpHIaIxIMW2BDKpNAEZkwEo
	 Dd3QWCxAOOqcfXIyzLU1t91N4V2EqqsjY/1K9Dgz9iotC6tDEIFfSVJQFFq+R/MeiIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cEL3i6Kg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB71606A324
	for <fstests@vger.kernel.org>; Thu, 19 Nov 2026 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cEL3i6Kg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C84C1F000C4;
	Thu, 19 Nov 2026 08:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795075686;
	bh=fCWZLx5X4SsEuhyehHFdeYutdRBt9pKfy4NkWwWUjYQ=;
	h=From:To:Cc:Subject:Date;
	b=cEL3i6KgFdfom7mdtOtbhoT2aROhdG64rLVo4SOYa+bFwVhbyTS1ySjgCPT3tH76p
	 cINsz5BJt5efT+oBezMnEdX/1DMoTh1qoQA0NVCn+/shW7VpJBZUp2FfBAAXXCrAji
	 E+eYsdRT8q1Yvbtm3QA8vYNL5eZ7hXt/yQ91mgAsHt0pMseIK9cSpSrKFEc7XKvsMg
	 WuUyM28PN7IFW1crxnui5BQB5wymsiX392PVFXsa0hYRUmRV80CyRDViWNvykReDdD
	 rmzTlO0X+p4sLt+2y0PvAuMSm8XZCVnf8Dg8T7McgnqPTXBqtx/qS4hyaLkI8AE5T+
	 d02ZWJ8IFPWwA==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests@vger.kernel.org,
	zlang@kernel.org
Cc: preichl@redhat.com,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH] xfs: add tests using xfs_admin to the admin group
Date: Thu, 19 Nov 2026 09:07:29 +0100
Message-ID: <20261119080729.3035971-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far, only xfs/156 and xfs/157 are in admin group. Let's include all
the tests which use this script into the group. This script is not that
complex, so, this increased coverage would help with testing '-g admin'.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 tests/xfs/158 | 2 +-
 tests/xfs/160 | 2 +-
 tests/xfs/161 | 2 +-
 tests/xfs/287 | 2 +-
 tests/xfs/548 | 2 +-
 tests/xfs/612 | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/xfs/158 b/tests/xfs/158
index 89bf8c851659..7b218ec09486 100755
--- a/tests/xfs/158
+++ b/tests/xfs/158
@@ -8,7 +8,7 @@
 # everything works properly after the upgrade.
 
 . ./common/preamble
-_begin_fstest auto quick inobtcount
+_begin_fstest auto quick inobtcount admin
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/160 b/tests/xfs/160
index 8cc784e7e1dc..d62b305e4d25 100755
--- a/tests/xfs/160
+++ b/tests/xfs/160
@@ -8,7 +8,7 @@
 # timestamps work properly after the upgrade.
 
 . ./common/preamble
-_begin_fstest auto quick bigtime
+_begin_fstest auto quick bigtime admin
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/161 b/tests/xfs/161
index c35bcabb5eda..bcbc2f951f9d 100755
--- a/tests/xfs/161
+++ b/tests/xfs/161
@@ -9,7 +9,7 @@
 # commit 16b60cb9e315ed for this test to run properly; v4.06 should do.
 
 . ./common/preamble
-_begin_fstest auto quick bigtime quota
+_begin_fstest auto quick bigtime quota admin
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/287 b/tests/xfs/287
index 4537b040f3cd..d8a1e5379721 100755
--- a/tests/xfs/287
+++ b/tests/xfs/287
@@ -8,7 +8,7 @@
 # xfs_db functionality
 #
 . ./common/preamble
-_begin_fstest auto dump quota quick
+_begin_fstest auto dump quota quick admin
 
 # Import common functions.
 . ./common/quota
diff --git a/tests/xfs/548 b/tests/xfs/548
index af72885a9c6e..779db614c0e6 100755
--- a/tests/xfs/548
+++ b/tests/xfs/548
@@ -8,7 +8,7 @@
 # counters.
 #
 . ./common/preamble
-_begin_fstest auto quick metadata
+_begin_fstest auto quick metadata admin
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/612 b/tests/xfs/612
index 4bead570009a..5fc1d0813ac0 100755
--- a/tests/xfs/612
+++ b/tests/xfs/612
@@ -7,7 +7,7 @@
 # Check that we can upgrade v5 only features on a v4 file system
 
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick admin
 
 # Import common functions.
 . ./common/filter
-- 
2.54.0

