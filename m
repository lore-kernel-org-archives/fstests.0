Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A618E22371A
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607840; cv=none; b=h4bF8EMtzy6m6dKJ+z8uAfXd/fRXuqzCZ0haGgJz1TmE1Nbe7UK/AhOGJcTV1b5yb/MZzH/nRwoMGVvYllg81x1oykodn+zUxN7f94xZU/R4ZI1QtPSei3x4VzSnz3Igz1/dlq1AzlBO7JT2+8bVcyln4TyGZfV7D/naM4S2X4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607840; c=relaxed/simple;
	bh=TcXToLudWTQwm7xd0ZSu/ToMb6dIoRlNojiaHCyBt3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxhYVtxYiAFaSfEL+HFBmSeavZghXX6nn4uKbsrU5dis8HE6h2tCV+kQ7xirJHtWPUvfyi5Dm5dIAwps3bEyS6Ao2cz/s6jtWrbV2AEYDhGxb5mQgC+Rx9ViMvH3mh2u/fS0uATOk2nJu6o8Eye5zoXjpLSIlhH7y/nfyxFMQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKo7kXTo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKo7kXTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255A6C4CEEA;
	Mon, 10 Mar 2025 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741607840;
	bh=TcXToLudWTQwm7xd0ZSu/ToMb6dIoRlNojiaHCyBt3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKo7kXTo2TCLKoX9opEo1CaRafE0jLrx6MtjmU5LMgHYglLVOuWzhHD2BzC71DSK+
	 vTZKcusBwPchQm/JTtAQZ/G1/r30W05YWwGGir8FwtKmvt0abFjj8htNXovlBWfGiV
	 B8S9W98R1iOzb3NPWSmb+ixkPL3WFOaUe/WynwUSC10tL/l4ISCo4+3cFNxzXb3O1R
	 a8XEYf02e/YZnAyN8VcCK9rzIbC90Tg68udo00dHs+NIVgl9PFvG4vdYQg2AKI48U2
	 Jz7iZvTiGywVz9qtYzk7L299potKrUTOEeFipDEzsUStwuABxuXhfCvXd2IWVDg96H
	 o6iDRv/WTtlyQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 2/4] common/config: export F2FS_INJECT_PROG
Date: Mon, 10 Mar 2025 19:56:19 +0800
Message-ID: <20250310115621.3441518-2-chao@kernel.org>
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

export F2FS_INJECT_PROG w/ inject.f2fs, it can be used for fault injection.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
Reviewed-by: David Disseldorp <ddiss@suse.de>
---
v2:
- no changes
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index aa525825..7d017a05 100644
--- a/common/config
+++ b/common/config
@@ -316,6 +316,7 @@ export MKFS_BTRFS_PROG=$(set_mkfs_prog_path_with_opts btrfs)
 export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
 export DUMP_F2FS_PROG=$(type -P dump.f2fs)
 export F2FS_IO_PROG=$(type -P f2fs_io)
+export F2FS_INJECT_PROG=$(type -P inject.f2fs)
 export BTRFS_UTIL_PROG=$(type -P btrfs)
 export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
 export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
-- 
2.48.1

