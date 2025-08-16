Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E9F2264B6
	for <fstests@vger.kernel.org>; Sat, 16 Aug 2025 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755329380; cv=none; b=twzUK9B07wkOIjM4UswlI6gHhVs5vDB1CSFPDud8Av+/dqytMkVWLugnzrsv5nirJgjSrjijBiil7Ae938OGsMN7vbsjxZJP5uNL93sBrX118RIrrHmkN9i22COD11G4TVHzecJpXkVU9mR1NOHPswURwrd6Jl5oJ/fYIGcWbUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755329380; c=relaxed/simple;
	bh=GxtuMTwBofj1WPDmtFWNrME/+hUfY/PdUIy66GYMHjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M3YhNretM9iLZ2kF/ZOENzTAq0XX/7gJUNNGEWfSh2CHTZCMxSemT54ft9wj1fWOA7tWCDqAa8ZTCE19wd/iWJmD4W2jItKrHeU8Hz5wqmFM9IDkbg3MRFEpnlG6aZdm5VprYR64qEUkEPFHIc98MZBVCduQcQ7PutGzhsRvu7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNo+UWz7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNo+UWz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83543C4CEEF;
	Sat, 16 Aug 2025 07:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755329377;
	bh=GxtuMTwBofj1WPDmtFWNrME/+hUfY/PdUIy66GYMHjE=;
	h=From:To:Cc:Subject:Date:From;
	b=sNo+UWz7VVp1l8Ia7d1g/t/2otoYQbXVGhrwVi0HPzYLvCPQdgnJJOzh6N9LwDM4c
	 rkLpW2lAH6xaroj5ErUZIRXsJGzTnvxaVao4SrkLQayD4LCaQagwaVEZZhAvbqy2Bz
	 QRNkIPdCe+uEVLVlXU7DHFrcx74lON42jVZNbmW94TCPRnMk4jRwA06peut48Lt0DY
	 9bB434wckRPMoH59t7eUb3aL1UXJz3m0IbKJ0icp04mE38Reu/+lZG6x4MmSWmvfTp
	 QDxbNUorZBLJoSO39E38/KkLFIp4o5t0C5wHjUZ6Bm7wpuBoxdgjrWR7R6k0oUB2WV
	 fy2Rzz2EBRecg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Daniel Lee <chullee@google.com>
Subject: [PATCH v2] f2fs/012: adapt lookup_mode=x mount option
Date: Sat, 16 Aug 2025 15:29:09 +0800
Message-ID: <20250816072909.2844349-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

w/ below change [1], f2fs will enable lookup_mode=perf by default, it
will change f2fs dirent lookup method from linear based lookup to hash
based lookup.

So that, f2fs will ignore sb.s_encoding_flags by default, which is not
compatible w/ f2fs/012 testcase, in where it will control lookup method
by configuring this flag w/ fsck.f2fs.

To avoid failure of f2fs/012, let's check whether f2fs has supported
"lookup_mode=auto" mount option, mount w/ the option if it can,
otherwise, don't.

[1] https://lore.kernel.org/linux-f2fs-devel/20250805065228.1473089-1-chullee@google.com

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daniel Lee <chullee@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- ignore error from _try_scratch_mount "-o lookup_mode=auto"
 tests/f2fs/012 | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/f2fs/012 b/tests/f2fs/012
index b3df9a8f..7438d9ce 100755
--- a/tests/f2fs/012
+++ b/tests/f2fs/012
@@ -22,6 +22,15 @@ _require_scratch_nocheck
 _require_command "$F2FS_IO_PROG" f2fs_io
 _require_command "$F2FS_INJECT_PROG" inject.f2fs
 
+#check whether f2fs supports "lookup_mode=x" mount option
+mntopt=""
+_scratch_mkfs -O casefold -C utf8 >> $seqres.full
+_try_scratch_mount "-o lookup_mode=auto" >> $seqres.full 2>&1
+if [ $? == 0 ]; then
+	mntopt="-o lookup_mode=auto"
+	_scratch_unmount
+fi
+
 check_lookup()
 {
 	local nolinear_lookup=$1
@@ -30,7 +39,7 @@ check_lookup()
 	local redheart=$dir/$'\u2764\ufe0f'
 
 	_scratch_mkfs -O casefold -C utf8 >> $seqres.full
-	_scratch_mount
+	_scratch_mount $mntopt
 
 	mkdir $dir
 	$F2FS_IO_PROG setflags casefold $dir >> $seqres.full
@@ -52,7 +61,7 @@ check_lookup()
 
 	$F2FS_INJECT_PROG --dent --mb d_hash --nid $ino --val 0x9a2ea068 $SCRATCH_DEV >> $seqres.full
 
-	_scratch_mount
+	_scratch_mount $mntopt
 	if [ $nolinear_lookup == "1" ]; then
 		[ -f $redheart ] && _fail "red heart file should not exist"
 	else
-- 
2.49.0

