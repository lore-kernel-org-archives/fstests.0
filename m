Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7E574402
	for <fstests@vger.kernel.org>; Thu, 14 Mar 2024 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710437123; cv=none; b=miXDnEqamGC1Ml1E8uUw1gNtoKFaPheBSWYOHEsxCSqvbnzcIdPny8TKYauzSRmruOrYYTN+5Dkch0poR9bTb8tDSu8T+ejHRWWxr409SFLL0yUGdOgIxP5WlHI/AailVlNfWvPhGYaJ579XqT37ykkoN4eh+P/Rskkbzvgur3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710437123; c=relaxed/simple;
	bh=3WcrKOnroxR1wCoEYoq23lmwTQG56pdtf1XoDOEmKLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lc7lSo/Ue0bATP3ecdODAfCKRV30YOYRzjM1DI8bnMgJr6KgPcj7iZHYglP1QN8dYrqcFX+3lozE5dS+Ac90sa/y+287a0fG6p2fn3V2+cjbuHMcPQR23/YWu/w8088tXT5KZQuK1Qnud2niqaWbU1nClUHK9fAgfaQ+fa1eeiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OYA77r0U; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OYA77r0U"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710437118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSzi4TYIYn6HT3X71ge76r1k+/3aqZUPVPQMBX8erdg=;
	b=OYA77r0UfnhkiW99f8x+SLREcgVFBgBW+oeFe02MFB7mT3oitN+qUbsev3owXwW0WjTj8Y
	XlxhHLywpm/+WWiOFrjjhTo2xikxBrl6pqoyy6b1nXnnX70NeIOjoZoe9E7P8qMQDgXDfe
	CIQlxM4KRfHjWyeipAXuHPw+vh3JwNg=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: fstests@vger.kernel.org
Cc: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH 1/2] common/fuzzy: make _scratch_fuzz_modify work for non-xfs filesystems
Date: Thu, 14 Mar 2024 17:25:11 +0000
Message-ID: <20240314172512.28293-2-luis.henriques@linux.dev>
In-Reply-To: <20240314172512.28293-1-luis.henriques@linux.dev>
References: <20240314172512.28293-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since commit 9bab148bb3c7 ("common/fuzzy: exercise the filesystem a little
harder after repairing") funtion _scratch_fuzz_modify() has become
xfs-specific due to the use of some functions that assume this filesytem,
namely _xfs_force_bdev() and _xfs_has_feature().

Ensure _scratch_fuzz_modify() works again with other filesystems by using
these functions only when testing xfs.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 common/fuzzy | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/common/fuzzy b/common/fuzzy
index f5d45cb28f07..218fe1654386 100644
--- a/common/fuzzy
+++ b/common/fuzzy
@@ -8,15 +8,17 @@
 _scratch_fuzz_modify() {
 	echo "+++ stressing filesystem"
 	mkdir -p $SCRATCH_MNT/data
-	_xfs_force_bdev data $SCRATCH_MNT/data
+	[ "$FSTYP" == "xfs" ] && _xfs_force_bdev data $SCRATCH_MNT/data
 	$FSSTRESS_PROG -n $((TIME_FACTOR * 10000)) -p $((LOAD_FACTOR * 4)) -d $SCRATCH_MNT/data
 
-	if _xfs_has_feature "$SCRATCH_MNT" realtime; then
-		mkdir -p $SCRATCH_MNT/rt
-		_xfs_force_bdev realtime $SCRATCH_MNT/rt
-		$FSSTRESS_PROG -n $((TIME_FACTOR * 10000)) -p $((LOAD_FACTOR * 4)) -d $SCRATCH_MNT/rt
-	else
-		echo "+++ xfs realtime not configured"
+	if [ "$FSTYP" = "xfs" ]; then
+		if _xfs_has_feature "$SCRATCH_MNT" realtime; then
+			mkdir -p $SCRATCH_MNT/rt
+			_xfs_force_bdev realtime $SCRATCH_MNT/rt
+			$FSSTRESS_PROG -n $((TIME_FACTOR * 10000)) -p $((LOAD_FACTOR * 4)) -d $SCRATCH_MNT/rt
+		else
+			echo "+++ xfs realtime not configured"
+		fi
 	fi
 }
 
