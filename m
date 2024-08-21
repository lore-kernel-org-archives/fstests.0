Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9818214F131
	for <fstests@vger.kernel.org>; Wed, 21 Aug 2024 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255879; cv=none; b=hv+tYmd9emaTRgyD1ltcR7rRVL1Z5FPCkY/ZWWx/WRVQOR4xz43tj3N9mmCirjJALxJD5PPponKB5I+ju3803WyxDg0xYuJXnRfeIW/Zl8YW+oSRLRgqOzcCS2O3rW+ADSgw1JnV3Ovd1ovbu0Ih2dnFT1krtIVjQgSPYaxcNeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255879; c=relaxed/simple;
	bh=AzbsvGZwhahZOQwEtWTv5tT+lGfYjVZU6gvJWLa/DKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X3bH5VBVwOBbywuovqSKG9V6vjxfwjFV6s+1b+UEYNaudX/VbG4mcr/GujDrPJaF1LJs7nBxH0nbdx0DbKHHmvR3V0V3TBU5s0wUISw6jwym9nC6df+R5Ksk0gNUJRXCIvihn14joz/GuwW1fC24ElcK/Ar+vRsAjZSG0296r9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Yv4/KUpi; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Yv4/KUpi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Zn6XPipPmy2kon0THQ25c4fMgwsTJ+HwhWWYH/coPQw=; b=Yv4/KUpi6CoOgO/VHwEt/CvYB/
	xyD7v+B8m7M9MFqtL4iEa+4CoFAlxDJBwP3HA1KNzdmrc6KhQiQU/cB+ErLDlBSHLsWWP9llFAv+8
	yCQq4ppd9UWT13ni/4y8dpdyj6bswXmuftRq1MKIW8ONoMPqhpEclovG38Lm3nAsupP2NebFA/ss/
	/pZmBLNAqDJ7Niztx8XyqMz6UOJBD793My9id2rGFG4OzKZBEx99XqQHYfuPJlvrHWtvZu0JQHpfY
	JLjU2aay1O9vXH7jZ2Hcdcb8P3xbmhPMn9sjxeNzr2Lq9GZydDdBZR3VZxIvOMjk3M3lOk4PzJX5Q
	YUxtkN1w==;
Received: from [179.118.186.198] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sgnib-0035h7-Fl; Wed, 21 Aug 2024 17:57:53 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@kernel.org>,
	kernel-dev@igalia.com,
	Miklos Szeredi <mszeredi@redhat.com>,
	Eryu Guan <guaneryu@gmail.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH] common/config: Correctly ignore {TEST|SCRATCH}_DEV for tmpfs
Date: Wed, 21 Aug 2024 12:57:46 -0300
Message-ID: <20240821155746.55828-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As per commit 264e5358e2c2 ("tmpfs: don't require {TEST|SCRATCH}_DEV"),
tmpfs doesn't need TEST or SCRATCH devices due to being a RAM-based
filesystem.

Fix the check by comparing the content of the variable TEST_DEV, instead
of comparing with the string TEST_DEV. Same for SCRATCH_DEV.

Fixes: 264e5358e2c2 ("tmpfs: don't require {TEST|SCRATCH}_DEV")
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 common/config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/config b/common/config
index 22740c0a..307f93fb 100644
--- a/common/config
+++ b/common/config
@@ -829,10 +829,10 @@ get_next_config() {
 	fi
 
 	if [ "$FSTYP" == "tmpfs" ]; then
-		if [ -z "TEST_DEV" ]; then
+		if [ -z "$TEST_DEV" ]; then
 			export TEST_DEV=tmpfs_test
 		fi
-		if [ -z "SCRATCH_DEV" ]; then
+		if [ -z "$SCRATCH_DEV" ]; then
 			export TEST_DEV=tmpfs_scratch
 		fi
 	fi
-- 
2.46.0

