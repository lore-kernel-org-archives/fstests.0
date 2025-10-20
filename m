Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698FB298CBC
	for <fstests@vger.kernel.org>; Mon, 20 Oct 2025 02:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760927479; cv=none; b=mfYsYQlXE+45cuLMN3WySxyDgeZfs4HENc+6O56m2Rin2g+FWrR9MD5wPICf0Pg11bXgXUCbQ0YtyNkGMuPE3Z6p+tPk+g5Ak7CfsjH5lGmBhxlN98j3nA5sHyWGkV9cMZW8acxxyMDumRfMh/hQg83cYbi99bmcCkFtFjRQ25k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760927479; c=relaxed/simple;
	bh=BpyPGac38NiCmM9sPUZhtik3i8wnnjFRlyJevgabVWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4bi9vDnkzJRUF+f2wtvlDjx1mDoT5owE3iBt/A002DAAgeKS+pO0g9v87L+g5QnMK+dOb6/oXTG1ZNTYLkJC+zb2hk83GFdfMDbxLvBp1Kpqq5dPR6Dx2S03ZUv51d3L1YjS8UyLAd/lbH3qgJuVDyWNWdSVJ7B3wEzk/7nXd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCAMMqap; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCAMMqap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD5BC4CEF1;
	Mon, 20 Oct 2025 02:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760927478;
	bh=BpyPGac38NiCmM9sPUZhtik3i8wnnjFRlyJevgabVWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KCAMMqapAl4BAqMASbAsCnf5vbJvDtZuV8+MScXKfASzJRig2jlaz+IP0ecj21c7d
	 xau55/3GMEqSJWoHdWTPb5JdTe5RV6KbtFfPfY8+Zir1pxQCbOBeAYlQd/lWgRvb/8
	 LHeCDR33x8J4W/Jz3iMEFD385aXIgMZlcDPLgYQGDDKCPkmPEXchj5oJFaMw0NLdvA
	 Ub8Dussbffl6Od/xIQx44wEojNfzSJihWXh9padBv/MsM6vGIkxGaP2ng3f98UeX8F
	 AwJVBE+XjFQ/OK68b2vf2LuBgBxh0cVVuKQVLuq2Qe5JKg1fejB4pmtys2yExYp42R
	 7cOmSzM3H87RQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs/022: fix to run testcase correctly
Date: Mon, 20 Oct 2025 10:31:08 +0800
Message-ID: <20251020023108.327728-2-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
In-Reply-To: <20251020023108.327728-1-chao@kernel.org>
References: <20251020023108.327728-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs/022 will report failure as below:

f2fs/022       - output mismatch (see /share/git/fstests/results//f2fs/022.out.bad)
    --- tests/f2fs/022.out      2025-10-20 10:18:47.075968669 +0800
    +++ /share/git/fstests/results//f2fs/022.out.bad    2025-10-20 10:25:20.000000000 +0800
    @@ -1,2 +1,5 @@
     QA output created by 022
    +wrote 8388608/8388608 bytes at offset 0
    +8 MiB, 2048 ops; 0.0018 sec (4.300 GiB/sec and 1127132.6362 ops/sec)
    +fallocate: Operation not supported
     Silence is golden
    ...
    (Run 'diff -u /share/git/fstests/tests/f2fs/022.out /share/git/fstests/results//f2fs/022.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
      xxxxxxxxxxxx f2fs: fix to do sanity check on node footer for non inode dnode

Fix this testcase as below:

- fix a typo "$SCARTCH_MNT"
- fix to update output to "fallocate: Structure needs cleaning"
- relocate output of "$XFS_IO_PROG $foo_path -c "pwrite 0 8M"" to
$seqres.full

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/022     | 8 +++-----
 tests/f2fs/022.out | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/f2fs/022 b/tests/f2fs/022
index f6d77c96..728ef4e8 100755
--- a/tests/f2fs/022
+++ b/tests/f2fs/022
@@ -24,15 +24,15 @@ _require_inject_f2fs_command node i_nid
 # remove all mkfs options to avoid layout change of on-disk inode
 export MKFS_OPTIONS=""
 
-foo_path=$SCARTCH_MNT/foo
-bar_path=$SCARTCH_MNT/bar
+foo_path=$SCRATCH_MNT/foo
+bar_path=$SCRATCH_MNT/bar
 
 _scratch_mkfs >> $seqres.full
 _scratch_mount
 
 touch $foo_path
 touch $bar_path
-$XFS_IO_PROG $foo_path -c "pwrite 0 8M"
+$XFS_IO_PROG $foo_path -c "pwrite 0 8M" >> $seqres.full
 sync
 foo_ino=`stat -c '%i' $foo_path`
 bar_ino=`stat -c '%i' $bar_path`
@@ -48,7 +48,5 @@ _scratch_mount
 $XFS_IO_PROG $foo_path -c "fpunch 6984k 4k"
 _scratch_unmount
 
-echo "Silence is golden"
-
 status=0
 exit
diff --git a/tests/f2fs/022.out b/tests/f2fs/022.out
index 394c6a7c..5307e3d7 100644
--- a/tests/f2fs/022.out
+++ b/tests/f2fs/022.out
@@ -1,2 +1,2 @@
 QA output created by 022
-Silence is golden
+fallocate: Structure needs cleaning
-- 
2.49.0

