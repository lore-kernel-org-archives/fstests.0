Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27BB1DDC18
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249106; cv=none; b=aTQSqnfV4vablyUr2qYxrCqZJB0eAX2qheLVIP3QunVB1m1AlSis07tknz/cmqIPIlS401tOL4ZK1cdB+h/qi1t92fV0NhmExDWizQOiCYKBilquCzpaTeX+I/mixMQB3PrhniuQkpmnBKiRB1262AFhoHNT4z/rtQCUBFwrZ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249106; c=relaxed/simple;
	bh=97X0iTZrxA/2Izvuw1nyHZZXtS5Ddl1KNxKm5csh1Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCFj2dEy1ekaN+0qWShwc0NkTm7xHqPww4ySKJBapwQO8omx9Jx+qK4xMscvQZSekLkCzKJjkcK0sxdWzUclhyubPYeFD8luncbmy4tvzzhWld/hDv+YzhZnBrKC43poIxBPHkaS3H7/EHqs9KqlEDAt5GFSxTybjORKTipaumU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld7GnxgC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld7GnxgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A14C4CEE4;
	Thu,  6 Mar 2025 08:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741249106;
	bh=97X0iTZrxA/2Izvuw1nyHZZXtS5Ddl1KNxKm5csh1Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ld7GnxgCCzksyPfDkq2XceIM47ieKhQDDLYbNMZOqtcwR5EzLWbIdMMvNneGlSds6
	 dRKHcbFsvEcMXMpd6QlzRZ+O1hozMilMaWU1cg1dnPltUP05775+azQtwFhoe92HaW
	 0R3Nnab8/oot74uynJTeHt1G9TkQWlFlrFWDeHz4F6KVf/o0T5i86prtomfYYadiwN
	 gEvDKI6IYCGSzRLKm+pWNuzo6+rQqRXzkvSNsZ3eRSAepIaK83qDwmi59KJPfcX9lY
	 mEzWKqG+eNZm/EdraDPCd0k7Ujau/VKKr4+dXPw9loKMyNBLOs6Veg8jaoMWE4WXuS
	 +xFKcgrist/Ig==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 3/4] common/rc: support f2fs in _repair_scratch_fs
Date: Thu,  6 Mar 2025 16:18:08 +0800
Message-ID: <20250306081809.2397527-3-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250306081809.2397527-1-chao@kernel.org>
References: <20250306081809.2397527-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support f2fs in _repair_scratch_fs(), and use -f to repair the image
forcely.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index ca755055..bf24da4e 100644
--- a/common/rc
+++ b/common/rc
@@ -1500,6 +1500,9 @@ _repair_scratch_fs()
 	# want the test to fail:
 	_check_scratch_fs
 	;;
+    f2fs)
+	fsck -t $FSTYP -f $SCRATCH_DEV
+	;;
     *)
 	local dev=$SCRATCH_DEV
 	local fstyp=$FSTYP
-- 
2.48.1

