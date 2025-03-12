Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9669E2F44
	for <fstests@vger.kernel.org>; Wed, 12 Mar 2025 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741764208; cv=none; b=W7785STgZNmL56n/GjHApdjPNyoLlGbCi4TgLAeE0SikxuJamaMVBBcTAnagpFSAKBbikCdrmLofpwM+raaGR/69P+jXpebVJC1Yl+IfBlEPphcUuiw3FrBFaKKd1ySbwZNhvkmgI2Izbzx0JZjhnGyFALQTASJH490JRsb0i8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741764208; c=relaxed/simple;
	bh=cd+rCG/ipnPKChVuIm09pBZmrpsxF9olOrDqMKmbeGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpGav5ZLRIWV603xII7a3bwwbmlLr0BZ3hdJ1i97a5a3spT+TCduSEx+L2Qc4oeWvRET6SwqRxZevDDbJE/Bds443P1h6JEjOyRgWFVE9HW3cnNQPAlsNdfcWyH10Zx5KBbEK+V/ZOePH8liCYnhobQmrLjtPo3EJpPopAbJen0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOuPcy6z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOuPcy6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0559EC4CEED;
	Wed, 12 Mar 2025 07:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741764208;
	bh=cd+rCG/ipnPKChVuIm09pBZmrpsxF9olOrDqMKmbeGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOuPcy6zA+By6MHxZD982Mg752TlPJh1k5LYgMd3aoyUUKjzZBSVupzrul+LNvRdM
	 GdQP6CksiTpeh8r0NRxyrI7O/UHdpzsfd/vrswST+yS4YFoD0m02iS6JSrzYa73sbW
	 H8skeVykcE03j5Eu+ag+GMQPYJ4MznaabZwDrkMSEiJO47ZVuE5lRzYF3cKX/MqTqb
	 80mLbs9kBW/cLEXGNv79+9eLavJOZulav/363tXRBbru7CoLlAQt9KTde7xo4SyHSv
	 YZCVf7TLQ2qOj3FYtbEygT5gd//nAycryuMXllbBCaYcTKyNAPVWJf8Ai2eaJzEcIC
	 ao4o/EWlLs9ww==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Zorro Lang <zlang@redhat.com>
Subject: [PATCH v4 4/6] common/rc: use -f for mkfs.f2fs by default
Date: Wed, 12 Mar 2025 15:23:07 +0800
Message-ID: <20250312072309.3989074-4-chao@kernel.org>
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

Otherwise, mkfs will fail due to there is an existing filesystem
in the image.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- no changes
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index ca755055..23b642f4 100644
--- a/common/rc
+++ b/common/rc
@@ -993,7 +993,7 @@ _scratch_mkfs()
 		mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
 		;;
 	f2fs)
-		mkfs_cmd="$MKFS_F2FS_PROG"
+		mkfs_cmd="$MKFS_F2FS_PROG -f"
 		mkfs_filter="cat"
 		;;
 	ocfs2)
@@ -1336,7 +1336,7 @@ _try_scratch_mkfs_sized()
 	f2fs)
 		# mkfs.f2fs requires # of sectors as an input for the size
 		local sector_size=`blockdev --getss $SCRATCH_DEV`
-		$MKFS_F2FS_PROG $MKFS_OPTIONS "$@" $SCRATCH_DEV `expr $fssize / $sector_size`
+		$MKFS_F2FS_PROG -f $MKFS_OPTIONS "$@" $SCRATCH_DEV `expr $fssize / $sector_size`
 		;;
 	tmpfs)
 		local free_mem=`_free_memory_bytes`
-- 
2.48.1

