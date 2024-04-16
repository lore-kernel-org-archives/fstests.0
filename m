Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91397580E
	for <fstests@vger.kernel.org>; Tue, 16 Apr 2024 07:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251912; cv=none; b=Adkeq7NcX17Usnf0yS/CQxbPrpOWas95s773pVo6eYMI+4GPab7yVt5OInc4jmksWSihxm5Cx45EZdl0c5mokLuYYuRxJOk0mSFYTZ2fO5qlLHXMGjqNoztABrcTj4ZTKCSlZoFTrdwepI87/TWEnu2SiZlO+CrKiCXeIyp3qys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251912; c=relaxed/simple;
	bh=d0vPtkb8u3T+cVx/TcUDIO0p0YQj7ucJVBzKcgcqpGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QRtmIyD+l6tzEFJ9jB5cfZ4BubbtA+NDNzWrl5bZtAqJ0oQ4+XvPWm46O6igJ+BFt1dD16s8JCtg5xxRzoVlqAIe/Sy8DLUb3fpkqk/FaHw43SJ9j/jb2L3ajz+MUvPIZWq6WGDCkVOl0Rxg/IQ5a2DKnVPQOS/atfu0sV/F6iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bENvtoB2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bENvtoB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E10C32781;
	Tue, 16 Apr 2024 07:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713251911;
	bh=d0vPtkb8u3T+cVx/TcUDIO0p0YQj7ucJVBzKcgcqpGI=;
	h=From:To:Cc:Subject:Date:From;
	b=bENvtoB2fSQ2J8HD5goldWQCa5HwXhNNbpYG9zIkVev1I/xSHAhBAstHMip8pyiT7
	 AxwjDAUliYIffU9foMgBW+D3xu/4kEf4pUubIGu5dpEKylGnuajyRFJDFx0QaPunJz
	 FX5WozkU8pQ58kTiOnjcrAcyw/4XBjo7HeiwH3z9M4ym45Q5M/NPnVa36sBdmavaR4
	 FvVfbappQCqZSjJhhw9o0E4WH3d14LJDk4DuqM7I3s1amZjuF2OUJIvIhkFaHZqQTg
	 IzbuAca88gVUrj5shS31uQPGqJB6uTbkiUyZol0vSiummPGz8fsAuaeOOmEzh62sNA
	 PE3k0KSg4L3Yg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] common/quota: fix keywords of quota feature in _require_prjquota() for f2fs
Date: Tue, 16 Apr 2024 15:18:19 +0800
Message-Id: <20240416071819.5004-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, in f2fs, sysfile quota feature has different name:
- "quota" in mkfs.f2fs
- and "quota_ino" in dump.f2fs

Now, it has unified the name to "quota" since commit 92cc5edeb7
("f2fs-tools: reuse feature_table to clean up print_sb_state()").

It needs to fix keywords in _require_prjquota() for f2fs, Otherwise,
quota testcase will fail.

generic/383 1s ... [not run] quota sysfile not enabled in this device /dev/vdc

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/quota | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/quota b/common/quota
index 6b529bf4..cfe3276f 100644
--- a/common/quota
+++ b/common/quota
@@ -145,7 +145,7 @@ _require_prjquota()
     if [ "$FSTYP" == "f2fs" ]; then
 	dump.f2fs $_dev 2>&1 | grep -qw project_quota
 	[ $? -ne 0 ] && _notrun "Project quota not enabled in this device $_dev"
-	dump.f2fs $_dev 2>&1 | grep -qw quota_ino
+	dump.f2fs $_dev 2>&1 | grep -qw quota
 	[ $? -ne 0 ] && _notrun "quota sysfile not enabled in this device $_dev"
 	cat /sys/fs/f2fs/features/project_quota | grep -qw supported
 	[ $? -ne 0 ] && _notrun "Installed kernel does not support project quotas"
-- 
2.40.1

