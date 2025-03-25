Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2117259CA0
	for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907528; cv=none; b=uN31jOx74YRSk/PqUGtyo8F/5J1dAo0zEgWkgZFPBENp57UZmyZCpomIvJCOZv36omr87VnCDKX00YX9j8nq92UfLEsCiIJSkHUwZUNGTFGMbzNJj6zjHthqVRz7+pl4OfPnjMinKTu9UrjiGJUt/JEeBCvxPM6/u9/5BGuXyA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907528; c=relaxed/simple;
	bh=ZAcfeHuiPFV3sbyFPlA/8+VKHCU2VRylhvjIEQHs1Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3PVeSH9qEIlLTP4IAgmsbgbfQuVYIJdwY2iSntX2u1gTDBlYHaBlVnjZ4AwiZ6ICU2yg6XHjJdtr1cep03i2ZTYxJmXsffI5ShZKxDtVdYS0KHuDULr1zcvMVTcYTQpvZkjSxQfFxeu7zEyNeUWD6uOQKUXp2kpk5G4c+B9iS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZdQg6jA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZdQg6jA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AE8C4CEE4;
	Tue, 25 Mar 2025 12:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742907528;
	bh=ZAcfeHuiPFV3sbyFPlA/8+VKHCU2VRylhvjIEQHs1Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZdQg6jAdsSbyM56p+QKV/COMjbvZPBpleTyOfMBjrWePpOYa1irzsSszZ6U1X1Ve
	 2WHYJGzS5tz7GgSTpzIuJY2rsOCKvoOeGJfG5E0tIcOj8YQCEAMHrCSp0CLSOf3ecE
	 1O8TGcwWnDqB4Vfk2zlMnqPH2qGVUm7SFT/1A0FBBn76Q6WD0vZQtR3iMMi3gnPW5o
	 p+OJw/W+/4YFsT/rJJGSXmPZwPXhcPCbNuXke88BmDfsBA3pcKVAkvfhdaKjHry7lb
	 B9iqKdu1FwmbFpKXVF06hY8E3MLLyvWNIb3aMeZPROTXcSxEbkrmvJ3r1Wol7b/sL/
	 TMZivhcZ2DERQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Zorro Lang <zlang@redhat.com>
Subject: [PATCH v5 4/6] common/rc: use -f for mkfs.f2fs by default
Date: Tue, 25 Mar 2025 20:58:22 +0800
Message-ID: <20250325125824.3367060-4-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250325125824.3367060-1-chao@kernel.org>
References: <20250325125824.3367060-1-chao@kernel.org>
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
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index e5168638..ac2bac81 100644
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

