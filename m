Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B414719F13C
	for <fstests@vger.kernel.org>; Thu, 26 Dec 2024 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735220206; cv=none; b=Yaa3nhqGIk+WFka0VwiegcMfV+5n50rAUtH6b5j8/ckHlBhRIzABlScF+Paavhq9pqTJxswSlHksY6iJqUWVMSsj8RlPB/Wog3Skb1qFdii8jMbgphw/XlCplPrFrJ7x2QJkMuiyMWRikJX1K1Vu0wERphfJFe+aFuXQcq07V1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735220206; c=relaxed/simple;
	bh=axv6cSW2RM8W3th5e/Zgs1HjJR+2PNuK3eljvf43enM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k06IcDxJd8ZmpcYjia6dKKPakGLVkg6usRPVuZJNSAzZyAju/gPev3TFtXIF8fdFIzBwDtrn3KkzbWXZmi+6j6EeZVTpluZ+oL4/hxsXrpJJ3aYSPoqpOMfUFWUkKAD6n3BYtgDi+8c3oW4cnZ3HnReH78PJNt3gLdOf7C4R4nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnQ8DIKW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnQ8DIKW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7378C4CED1;
	Thu, 26 Dec 2024 13:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735220206;
	bh=axv6cSW2RM8W3th5e/Zgs1HjJR+2PNuK3eljvf43enM=;
	h=From:To:Cc:Subject:Date:From;
	b=YnQ8DIKWQqx2ck8QXYCSpB7KIBaf1sVUzsoIUeTLWw7l2QrX6pwbNn/FcsgTS3qIH
	 elLbzYzCk7xDkpsgVGfwn0qvUZItU93rJr4bBNC+DcjQTyA3wJYYjNasHMF1oAFNuO
	 kci53t6yB+j9hJ6Md8wd3GeNVwZdYMwpOjGD6LOKTNsh5sPfUkF/hEr3B45zMO/Ex+
	 YuStr/l4K+WcPb7Oj0vxUr3FWMVGAIrIL2qHt0ix77+KhDcCmBtddwgbDuUcdjLX5h
	 XZYbjkTcWz+7mGbO3GjVbDC/f5r04uMNJXnqsBlVbjDqetzwuMKAIuaMzPvOu/HoB2
	 PEWiMcAAjF2GQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v4 1/2] common/rc: support f2fs in _mkfs_dev()
Date: Thu, 26 Dec 2024 21:36:30 +0800
Message-Id: <20241226133631.9486-1-chao@kernel.org>
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
v4:
- no updates
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

