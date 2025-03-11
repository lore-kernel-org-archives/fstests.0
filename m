Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CCD1EB9E8
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680277; cv=none; b=mvONft/gKtGFV0iwSAToHtiZGObqFW66Bqltj3aOp2HWHrn1y3H8EkwHz3MHs98E45UyOO4YEHIs2q4oFIyZcQ7je0eT1PZUGtCHartXkGGpzvUV3QBFNsfPk0OKTR2LXwF5O5vgksB6eeSKc3crZHoZT8PpLGk1hbeBUT9oQPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680277; c=relaxed/simple;
	bh=xq2sFpKcMwD7O+8IUPL0qAjuOxbSP9sZA5L4A95ecbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdLoV1Qh/nG0d2KF8WcF3XYbArneLiGiUMID4ti+f+7HRQhnf0pvEobjyJhjGS+BqRtswRhdqfeoNNwcB8Ni01VNFYXx5g9/JPE47B0iI7viLtTsk/12dJOlbTKZP3W+UyjKzehkta34tzTrHTfkmFKJcqab7FdJDJTOoLOq+CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1j9gKGW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1j9gKGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E172C4CEEE;
	Tue, 11 Mar 2025 08:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741680277;
	bh=xq2sFpKcMwD7O+8IUPL0qAjuOxbSP9sZA5L4A95ecbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1j9gKGWnVu0TT4SPUr9Usaqoml99nVWcf48BYRLQNPHDQaER0WHXRZQfCaok8R0f
	 M+qRo8dMmyh/iE78KY/V/S9QKvale2+lGFFBUqE3dJwpphfpeZ1XZlIIanZS+M/zEv
	 HCC8sT3vX9A6cufEKMnWMIi2W5unmw+WJDNBV1caVo4hwQCzdKvXFEM/KHl9RLgLds
	 c0QWgP4dkGeGrgKxH8bj6cGcGR6bL/igPbDC6WIJspo+yOSPZC1BLpJwFhwOvVjDjW
	 VFFbJgEZ3mCBZbtn++FOuhOFFFBQekFe4VlsDOFlcWvKD1TklytrrP2z43APenQDIX
	 xYImm0+56j9Bw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 2/6] common/config: export F2FS_INJECT_PROG
Date: Tue, 11 Mar 2025 16:04:26 +0800
Message-ID: <20250311080430.3696582-2-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250311080430.3696582-1-chao@kernel.org>
References: <20250311080430.3696582-1-chao@kernel.org>
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
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
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

