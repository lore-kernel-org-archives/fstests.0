Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86A1125D6
	for <fstests@vger.kernel.org>; Mon, 23 Dec 2024 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734964485; cv=none; b=euzXNXvATA3gZ71eyoEZJshwQKqGzdsrQhzzlUXWPbxInxNIr1cb9KjCJ/6o7ECGAAc1I/GXzh8fVwbtZndhdKGXSur19Y34jRgI4pdufzVX0gHjXBP+L0n2buOM7mRIKrwKqthm+sv6xLt14Hw/GJc7Nk8Sze7OTMVuv5WqdNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734964485; c=relaxed/simple;
	bh=bo1NMs4/YFWYdMJuYiGmiCfBcLSkozOTWwUXUhPmLa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h/Q2BdvgXv+WBL/sjhhdSoyBNrO1BcjI7huRUmssYtqAxwqqp/rYv3Ll2YRyc1Wn475LQVT3Jto5vK62UKSRT5df8+0/324OfAypnCo5wclXMf4fwPCYRBnzFicC9r44uaeMFYXApouzKUey0VVs1jfX3sYBjw26h0DPzTYS1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIX178mm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIX178mm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C811AC4CED3;
	Mon, 23 Dec 2024 14:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734964485;
	bh=bo1NMs4/YFWYdMJuYiGmiCfBcLSkozOTWwUXUhPmLa4=;
	h=From:To:Cc:Subject:Date:From;
	b=pIX178mmbdMEG91W9KDTnkDkLeDx/KModlvqyWdQm6CAwBUqn0BYPQYQgYpywH5on
	 jP84xltWDfx6iVKlwt+bdx+/kpjYg/2ieYAsLYtlhVSg94bctrGOIL4oYyAB+FNZre
	 UI7YwYg9UC5qSsGtarGmc+7tTeSM8HClR1w0NVBhnVgKFDY/+crClDlopnAMj/SoTR
	 zHR+Pwh+f6sdUne2f5hPxhG+UrNwEprrchxFaVhXF0mCpUs0CGv5LnRxaROEiN3CDe
	 Lt/9om+stuEJRoG6iYBlNtpn50U1BJQtcTymjnA3gYDxAIdSA8ySPD4InatpcUn1qE
	 lee+hrqyZ6ksw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 1/2] common/rc: support f2fs in _mkfs_dev()
Date: Sat, 21 Dec 2024 16:23:44 +0800
Message-Id: <20241221082345.196029-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Then, f2fs/* testcases can use this wrapped common helper instead of
raw codes.

Suggested-by: Zorro Lang <zlang@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- adapt _mkfs_dev() to support f2fs, preparing for following use
in f2fs/008.
 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index 7b5bc0b4..ecac2de8 100644
--- a/common/rc
+++ b/common/rc
@@ -833,6 +833,9 @@ _try_mkfs_dev()
     ext2|ext3|ext4)
 	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $*
 	;;
+    f2fs)
+	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $*
+	;;
     xfs)
 	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $*
 	;;
-- 
2.40.1

