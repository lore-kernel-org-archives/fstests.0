Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D912F44
	for <fstests@vger.kernel.org>; Wed, 12 Mar 2025 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741764206; cv=none; b=kP8kIt7NvzA35/upFrgZcTMQdplyqj0fpqTwFgcG31egdZZSrdAiLgIolIfoRGCRMnp068MroIDSKnlWQqb9BjtyvR+O8ap4wJA/F7zM7FPc42PvltfJ5tWNRtQzoylEGXo3ZnIZwpQyuAdLP5xiFmPUsT5Dw3ap6lotUlRkN+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741764206; c=relaxed/simple;
	bh=q00hiySpvhpXJYh+xrABq/hBgwJTyFyvPK4VSBpvgqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loFVeM+hBC6PGRToGRuh/MJ3uFxNPfQBdbeyBS0pWBHKPBRv+RQsFQAApSRARmH9wKtSj9mcATNEHMhXxrJs3Zll92DdactER9er61cl3oPzArFnMVZVo9cyq4Ws3ng6c+fUnrMDIry1yzqB+C61HIsU4VM/F0hmuJhBOzod9pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/QUBTOB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/QUBTOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F38EC4CEEF;
	Wed, 12 Mar 2025 07:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741764205;
	bh=q00hiySpvhpXJYh+xrABq/hBgwJTyFyvPK4VSBpvgqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h/QUBTOB5FODJqVSRUlgf/zrfZSgVH173w4GXnvTibnBIrjC30fU3CxgJTuFu4DQn
	 k3A+fWHkOyDqtz7WyAK5Cz1v5mHzOWcvXrpRbwjoHnDMzbyJfotgzX4BBE/+BQUYa/
	 /jeJxK4zSn3K8NbZuX5INgaE4YByw40SueyiQnuYbu7jAbSEpdUvEiTw6fJaiHnXv+
	 RdgzmYuTmKqFlNuUd96jwdP/s/gCzfboIdxp70v3ahQN10EaTSPxudxeq86t/U7IsI
	 VWt69Q9Ecw0UNGsZrCJDqxPzeFVuO/w/Av4VnD3lm831hQ1wu3TZKiaWnRInh9jjFH
	 Fxl/YCoXFg1Bg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Zorro Lang <zlang@redhat.com>
Subject: [PATCH v4 3/6] common/config: export F2FS_FSCK_PROG
Date: Wed, 12 Mar 2025 15:23:06 +0800
Message-ID: <20250312072309.3989074-3-chao@kernel.org>
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

Let's export F2FS_FSCK_PROG, then we can use it in
_check_f2fs_filesystem() later.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- no changes
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index 7d017a05..79bec87f 100644
--- a/common/config
+++ b/common/config
@@ -317,6 +317,7 @@ export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
 export DUMP_F2FS_PROG=$(type -P dump.f2fs)
 export F2FS_IO_PROG=$(type -P f2fs_io)
 export F2FS_INJECT_PROG=$(type -P inject.f2fs)
+export F2FS_FSCK_PROG=$(type -P fsck.f2fs)
 export BTRFS_UTIL_PROG=$(type -P btrfs)
 export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
 export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
-- 
2.48.1

