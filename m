Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACB92F44
	for <fstests@vger.kernel.org>; Wed, 12 Mar 2025 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741764204; cv=none; b=arvS6AatMHulbc0GPJaKGnpiSs6xr6/EA8OrCxirXZSI4SaWsAYu9W79wYj9RDpgba/sw26dvtO4qHmfPNWLH7A6yMgZYyGFKw4qDDD68rsf6+Y/17baZQ/78jr3+epaHMP8NUAmWzQ0m0tB28QEwFZielxb1GXfWk5Cl0b6smM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741764204; c=relaxed/simple;
	bh=ZjQBCbVNJ2p7dPP/EufdPPhi1TlsTlE8Tg2dAj0UrIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8DYI+MCOV4u0H98gPKD9yYJpfP4S4C9RxZZ7XbhKHhp4J0FunDCCQOzrWNu43EYEWYRv4SlSX2ENFQitZdx/N+jNmHZMbRt7Vqt2KmpWFx+9+4I89bvz8GUFICYppC5uEWFqaOuLbujgVv/Xh6P1kjx3Z+40YH+TorNQDuNLWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEcthYLT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEcthYLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510C3C4CEEA;
	Wed, 12 Mar 2025 07:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741764203;
	bh=ZjQBCbVNJ2p7dPP/EufdPPhi1TlsTlE8Tg2dAj0UrIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tEcthYLTFarRzRpboTGmFuBf9HI32xOrBtr2u+ZzoW53cmysUW7SBUnGQ2va508kr
	 5mOGfOnrcfCu66dM9aH3blbV8itS/V2C/xiwX3vcmcrAs1puZHrwUPdiwwBv9k+37E
	 FZmEEsfng89tG/he10sRY4eDjUvuB5a/b/U2pl4bJ1nMkcrKPx06UUXjHeAyWF7wPk
	 KQW9IDmmctAIgcgRb66AfAfEYWZmTih3eQxSlmiuNLG1uRXcSjqyLHOXr5fbmoZz48
	 e7hl0DvgRS6HPQgwMzUSsx+rzhg7fyn5+FSLERETCTjve2mUymRceup6zF54ojamyr
	 +0L0euQnhNajA==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	David Disseldorp <ddiss@suse.de>,
	Zorro Lang <zlang@redhat.com>
Subject: [PATCH v4 2/6] common/config: export F2FS_INJECT_PROG
Date: Wed, 12 Mar 2025 15:23:05 +0800
Message-ID: <20250312072309.3989074-2-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250312072309.3989074-1-chao@kernel.org>
References: <20250312072309.3989074-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

export F2FS_INJECT_PROG w/ inject.f2fs, it can be used for fault injection.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
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

