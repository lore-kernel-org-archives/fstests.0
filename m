Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78EB1EB9E8
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680281; cv=none; b=XJzHSHpAQFvKpIPxQxu0Uy5ZAdfBP4ZMVSe23LeTqkJobxX97ECGvArbKe8lWRrnGXtN0gyiYA+8ZRBVskX6AOsZiLjM6GEH9sOnrZM9c8TklAdd2xvnZpflGjbPQKSrYKpXZAmMgC0sjf7X4PvmTebyVSti6EIiRXRDp777OxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680281; c=relaxed/simple;
	bh=n74Q+Fo38Qqi4LLhMmspI7Gq5r0ceUnTLDVgnA8ssQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUSEut4k56980EQ83IephE1IZN5cCIiYwnyyg61W5zGgwccJd6uj3JLZWtMu/JEsn1aKg4CIc0b/AFAg82vlwfmzEHwPcNBhTDnp7VASz3tEXqL7J3t6IitkUK2EN5buXAXqCEOv5K6UzRX/7/7sDmbqfjNaX+WmJMSYIxfEe7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hs60DmJU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hs60DmJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D5CC4CEEE;
	Tue, 11 Mar 2025 08:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741680280;
	bh=n74Q+Fo38Qqi4LLhMmspI7Gq5r0ceUnTLDVgnA8ssQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hs60DmJUdPqFhpK0PlioTPj/kRvct5XGLFK5rKGlyBP2mpSXBXPd8MxGmVfUuRj3w
	 mHMtTlLpcP9iu3sfs//x7WyoEsq/7MoX9ZgQXFKwJcppp2Xtg3v0XYo0oEnCu5mioR
	 6vN5DQWqPV5wCagPf2oFpS102KNCKCrY4lL7a8J3N6JPAfHhAI1GItG1TyV+qhu3pa
	 olQLAiti65YZauTYiKpbgu5vY5N3kfGcAfmw8HaUTn4GV2KPiDhUqP1FZ6jA1/pqMz
	 VFfK05cNyZd0QDehV4L3wckTuEm8jkHRjzpRjr1hR6dO8ShkxxLjk1Gf757mSAHmI4
	 9aYF+i2SGyXVg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 4/6] common/rc: use -f for mkfs.f2fs by default
Date: Tue, 11 Mar 2025 16:04:28 +0800
Message-ID: <20250311080430.3696582-4-chao@kernel.org>
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

Otherwise, mkfs will fail due to there is an existing filesystem
in the image.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- split change from f2fs/009, and cover both _scratch_mkfs() and
_try_scratch_mkfs_sized()
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

