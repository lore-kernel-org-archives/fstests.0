Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D01C2248A8
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607843; cv=none; b=faATW2362iaMaDIIHVG491o8kUjx6b3WkznFewLkXEBudmjI5dAvcEmqVsPCooc6ISNHrKdc49VYk3J2BL0x21Z8qYnkdRcaQd9ddnS61pVk9/+lH4OCTFoEFAU7np3Wb73C6sSgwRISZ9X5BhxHQf6Tx7Sd19zu8iI+5puiGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607843; c=relaxed/simple;
	bh=APeSVQrXiPnNxYprcQjSueJT4IeOKzONOtuiiyk7ccg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ubbobo67f1ZZ5UzJitPtk9NZyTd03r5ET/fp/eUlheLpOqHsQiCEg9aaEoMHgEpCKtIYxTX3AaKUBEVNYhwdVUPtIDhu58o3I8cdy09UkwJ2LeBUPAxEMKxd3tKohgG/fwmMtJLpy1Q3NV0HtnE8rX+gBMDWX56MYxzbQMrjH/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYNgfe4D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYNgfe4D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F32FC4CEEF;
	Mon, 10 Mar 2025 11:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741607842;
	bh=APeSVQrXiPnNxYprcQjSueJT4IeOKzONOtuiiyk7ccg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gYNgfe4DdC0I6mGTorwXb4AwNSt9FvSx7wjvo6i2EfOcNW/YLlqqXbHkMI7zQA4ZT
	 we1Wx/1kVE/Zt75TvFMg4NkCiqf7iHGgFwlMASxxtCf44KB3rEtB8ROH/BMMJDA1BU
	 jIWOf6rsuTJVvMOqs6zAJTWEIHYL5m94KvrO7LcF/27+ScktWTBsgd/ucHNaP4y6k8
	 TnX+USBWptYGGYN8C/eQiPAT4dUN43f0hj/8moparKNp1OyTgbMK9EOyobk2eDL1HI
	 kihnr6QMOUMzWff4IGZzdkbm6XZtCKaYZuOFnEGsmH8LGxUszj6rqremdKbhRJxpQP
	 x8aCsuN7PZ0TQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 3/4] common/rc: support f2fs in _repair_scratch_fs
Date: Mon, 10 Mar 2025 19:56:20 +0800
Message-ID: <20250310115621.3441518-3-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250310115621.3441518-1-chao@kernel.org>
References: <20250310115621.3441518-1-chao@kernel.org>
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
Reviewed-by: David Disseldorp <ddiss@suse.de>
---
v2:
- no changes
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

