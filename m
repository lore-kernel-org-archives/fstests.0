Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79F810A3F
	for <fstests@vger.kernel.org>; Mon,  1 Apr 2024 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711965437; cv=none; b=X8AUqjd9+LUl6jIzyT4oj+Xel3Ay6CqMk6wA+QIEn7x/oYXxRegfMSCKXxoWM2wt/YvndepBp2F3vXzjClnji+2PXYLd28sciBP3hh4LFfwaay4++yvWVYYuQ1SLP5D/a4u+XNd8I09XM7n1shC/zOOIiX/gRHSVR2FHaLqjq9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711965437; c=relaxed/simple;
	bh=yX3RnBSTBk6+5tCisu5obdjpygi2qQ4BvtC68gSebwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bEz/G5v2+iVxVx3fdtnr/aHVrkC72UJvARYTGJfzfBZzdSmqhRGiozTZCBAdSd2hVTZWM7GX9tZca0cghY63NYb4FmJxc62H1d1NIHsC611FnAZaESFXqkbaQMaPemqC8CQ5E8lbfhsYUc4JIKq87cSe/ttbdAe+Qy+x71lFiJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aJgy7Zz+; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aJgy7Zz+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711965432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XM1xvNiR22SZfXP9lOskrO1Bea2X8fkihF7ZxXeKfNs=;
	b=aJgy7Zz+XOUE8TYhiRx0ikNnXAymR1xkmNqeOg0X++PXSeDlSdHAkLptu/UK+qyUgdc3Ts
	WKz0M27bMbQ/+LYUbr8Jk8gQ5g64vCYcJz4D8uS1IrqA/QQjSBvCxf8AcJweq99k+BcXf/
	vQIgJeRQFEnqiG2XwDvqan1wv6DPYhc=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	"Darrick J . Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v2] ext4/01{2,9}: fix invalid filesystem option 'journal'
Date: Mon,  1 Apr 2024 10:57:08 +0100
Message-ID: <20240401095709.12304-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Creating an ext4 filesystem using '-O journal' will fail with:

    Invalid filesystem option set: journal

Fix it by replacing it by '-O has_journal', which ensures the filesystem
(ext3 or ext4) is created with a journal.  While there, also redirect stderr
and stdout to the full log.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
changes since v1 (after tytso's review):
- instead of dropping '-O journal', replace it by '-O has_journal'
- redirect std{out,err} to log
- use _scratch_mkfs instead of _scratch_mkfs_ext4

 tests/ext4/012 | 2 +-
 tests/ext4/019 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/ext4/012 b/tests/ext4/012
index c49e8ef4483b..358874a1caf1 100755
--- a/tests/ext4/012
+++ b/tests/ext4/012
@@ -32,7 +32,7 @@ TESTDIR="${SCRATCH_MNT}/scratchdir"
 TESTFILE="${TESTDIR}/testfile"
 
 echo "+ create scratch fs"
-_scratch_mkfs_ext4 -O journal > /dev/null 2>&1
+_scratch_mkfs -O has_journal >> $seqres.full 2>&1
 
 echo "+ mount fs image"
 _scratch_mount
diff --git a/tests/ext4/019 b/tests/ext4/019
index ab5f50c66b6f..f0514093981b 100755
--- a/tests/ext4/019
+++ b/tests/ext4/019
@@ -32,7 +32,7 @@ TESTDIR="${SCRATCH_MNT}/scratchdir"
 TESTFILE="${TESTDIR}/testfile"
 
 echo "+ create scratch fs"
-_scratch_mkfs_ext4 -O journal > /dev/null 2>&1
+_scratch_mkfs -O has_journal >> $seqres.full 2>&1
 
 echo "+ mount fs image"
 _scratch_mount
