Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42FF136999
	for <fstests@vger.kernel.org>; Thu, 28 Mar 2024 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645589; cv=none; b=cu5g3Jipd7jEOhjLa+6V8YM/AvvbrlKfJ/aUH228PlO3dq1BC7JiU7I407tDq6aaHVxZss3lMGxC1S+g7Dj1ZKnZkRc0Dpmppae8H3mluzdPbYB7F1ug9PM4wiY2ccRW+8GNtFs7VHQs6Ivc3QbFUNxFaeFP9mq41ZhkVV9OBZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645589; c=relaxed/simple;
	bh=/pfSktUye0tYaGs5AI89Rn3G8OcP7NAIHbCV6MfEfUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TkgLt49jKXX3x2ELzY6KITzvDlVItHmfftfxB/olYffhgj1eRk4Nxl7OL7LqGnaXqFS8xAOE8ueP3bWdGG+IqmZPuY/rpq5XR4fHHWPtRsIx49rMw5Ukd2QpXIqHJE789ymJzr2s6NVPCQYAN1G+QhXsvPE6cebB0nug+4gYmVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UARvQd8t; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UARvQd8t"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711645584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gHTlUnfrQHhfZDJBa4bCnOIJSd1F9BLxv3CM7iDmmZ4=;
	b=UARvQd8tAVforfvVnksFZBGKYS1t7WFOGAWlQecppdAxu3nacifWsAnuZjzWbOtpZYqRZu
	SExBBEDyeiP/mNz4v7ddrwI3OwwGamEgK1AGY0nGfmOAOAvbNgbyhp/8Z+He8A3BnhB4Xz
	B/apQf2UU7oeaT1QMTvLgMSpPe7a57U=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: fstests@vger.kernel.org
Cc: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH] ext4/01{2,9}: remove invalid filesystem option 'journal'
Date: Thu, 28 Mar 2024 17:06:20 +0000
Message-ID: <20240328170620.334-1-luis.henriques@linux.dev>
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

I didn't do any archaeological investigation to check if this option ever
existed, but the two tests using it will fail to create the scratch
filesystems.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 tests/ext4/012 | 2 +-
 tests/ext4/019 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/ext4/012 b/tests/ext4/012
index c49e8ef4483b..4cef19bf6be5 100755
--- a/tests/ext4/012
+++ b/tests/ext4/012
@@ -32,7 +32,7 @@ TESTDIR="${SCRATCH_MNT}/scratchdir"
 TESTFILE="${TESTDIR}/testfile"
 
 echo "+ create scratch fs"
-_scratch_mkfs_ext4 -O journal > /dev/null 2>&1
+_scratch_mkfs_ext4 > /dev/null 2>&1
 
 echo "+ mount fs image"
 _scratch_mount
diff --git a/tests/ext4/019 b/tests/ext4/019
index ab5f50c66b6f..9db7f23bb608 100755
--- a/tests/ext4/019
+++ b/tests/ext4/019
@@ -32,7 +32,7 @@ TESTDIR="${SCRATCH_MNT}/scratchdir"
 TESTFILE="${TESTDIR}/testfile"
 
 echo "+ create scratch fs"
-_scratch_mkfs_ext4 -O journal > /dev/null 2>&1
+_scratch_mkfs_ext4 > /dev/null 2>&1
 
 echo "+ mount fs image"
 _scratch_mount
