Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB602236EB
	for <fstests@vger.kernel.org>; Fri,  8 Aug 2025 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754640168; cv=none; b=HF6Y1KNaNMIhH/COBgysc8aFvDvxufpV5AC4azBBGsuNBrNSbq1f93bG1h3rlcfDbOvjJocIDrizeN0cNuvi/pJt2P+Rzr5vRX2SVDwxFPV7cHXIo5hmqacPI4VNcGlZb4Mql+Lg0/E9A9qtfcfhmpJXpdi9jBalilQ2WR2KZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754640168; c=relaxed/simple;
	bh=wVvoXIsLPKZCemckHCxMR2iU0Y0WAvi6H54PITfVnvY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gZPcWmtudR8zJ4U1pO03LwdxKG35VUkrQg8Ju4YuYZTrIjyT+/AaexW8iCxQJnsoZsr6h4xNzYQO/gFPksAZIqUqCuQPb8gWpkSx6rBwNiLKifQEhIYFZLkoyzHq3CWwm/1ek8KT0zyKrxZG5wi4Q8hVWtQSZaRvU+iT8gVCGFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufAJ/Anw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufAJ/Anw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F295C4CEED;
	Fri,  8 Aug 2025 08:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754640167;
	bh=wVvoXIsLPKZCemckHCxMR2iU0Y0WAvi6H54PITfVnvY=;
	h=From:To:Cc:Subject:Date:From;
	b=ufAJ/AnwGA7992KOKnCg9JdDYrt3IzChGn7yXZEWfM2FncRfLMq0VYHJhLBSPZ7nl
	 aGUER6ML8Iyqk7PfF/2JmYkLh7uI80eb8v1RTfOZeFdrdeLvg/c8p010MEzEi6oDYF
	 R7gz+6yusmTunqMIJ+wstI9H5HeS9j38OmGtebVLb4c47yxC+XOREWp2cG9LWfP4La
	 RFDyDUBbINM/WQkZFCRN5VY9JLsvo5uQqywVL6Ea5DVRKLAKDOwoIfJPALTXKOHigD
	 EXSgAyvsC/8BzuLdvbZavCkRkbRnxh1qnSknnT59oE3vxw6NzTWrglf1HuP+LmuY7x
	 IKfC9YtCEEv8A==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Daniel Lee <chullee@google.com>
Subject: [PATCH] f2fs/012: adapt lookup_mode=x mount option
Date: Fri,  8 Aug 2025 14:58:03 +0800
Message-Id: <20250808065803.17298-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
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

Cc: Daniel Lee <chullee@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/012 | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/f2fs/012 b/tests/f2fs/012
index b3df9a8f..15fc8f0c 100755
--- a/tests/f2fs/012
+++ b/tests/f2fs/012
@@ -22,6 +22,15 @@ _require_scratch_nocheck
 _require_command "$F2FS_IO_PROG" f2fs_io
 _require_command "$F2FS_INJECT_PROG" inject.f2fs
 
+#check whether f2fs supports "lookup_mode=x" mount option
+mntopt=""
+_scratch_mkfs -O casefold -C utf8 >> $seqres.full
+_try_scratch_mount "-o lookup_mode=auto"
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
2.40.1

