Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3467943E071
	for <fstests@vger.kernel.org>; Mon, 20 Jul 2026 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565770; cv=none; b=QcD+febRp7iN9nzMtpPiXemP/Zz7kH+DW6q5sBMVTO1+DtOyGXAfwcdZAzo7KgJYA5vphtWrYQZdgj4TLGYRXNTQ4Uwhrhac2e2scCs6U4m61zY3//CLanUoDUDCJ1vykJbML8mHceXE+JNx7rjwahykg0B6ris3mM0dPkqzlc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565770; c=relaxed/simple;
	bh=dg9EM+EbSu2g6+939ZA6ti4jEwPEjQJjVDnjxB0sAHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQeNdU46j2Y7hiy85rAEWF8GgYXVmAbDo4YvPeAewrrRtF3mtMOrqxVrBmCyGh+jETBiTcI4FsgIp7mYu1zQaYR+9ucx+VvNtdd/x1ktx+kuInxKo7JuP3okZzJPmgSo0krimb0wRtTbqLvx9uIia39rG8eX5D0kIbbqChq5LkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=EyiHiYet; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="EyiHiYet"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1784565764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RULXTOMmkZHfgaFBkHjp2QpNGtxGhALwp9yHrpl7HLU=;
	b=EyiHiYetwZvwWs/CeN6q4Gk15shyXuILyoVgqAKlt8dbkIP3LE+at0i50mWq9jrgn3TSCd
	+v+LYoMnXXe9zBdLz3sZRnbMqYvlAAZno8vMLFuHHs61IxXioelqsDStzOUL5gaaFsZcq2
	Ncg9brDEUJMP9TA5+0QoxgCGUnvN4kAlRk4SuVq58MpVUGx8chzW78179W/0KQFhUI1HXh
	ytHymqO8qnGIKlSeqMVgA7mbez4yqO+mvPGLirfc/IvgN7i1mEsGPcRPeJavvdsMWsmSQk
	/zsCuDmfpLQVZzzIpMUkNLwZI8XKfZl3TVjFId3kWgAry1aUMuMfVg9IERXEtw==
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
To: smfrench@gmail.com,
	linkinjeon@kernel.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	senozhatsky@chromium.org,
	dhowells@redhat.com,
	metze@samba.org,
	zlang@kernel.org,
	lukas@herbolt.com
Cc: linux-cifs@vger.kernel.org,
	fstests@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH v2 xfstests resend 0/3] add generic/795
Date: Mon, 20 Jul 2026 16:42:04 +0000
Message-ID: <20260720164207.732522-1-chenxiaosong@chenxiaosong.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

v1->v2:
  - Add patch#01 patch#02.
  - Patch#03: some cleanups.

v1: https://lore.kernel.org/linux-cifs/20260713151658.533155-1-chenxiaosong@chenxiaosong.com/

ChenXiaoSong (3):
  src: factor out common stat code
  generic/002: clean up the test
  generic/795: check nlink returned by fstat()

 src/Makefile          |  13 ++-
 src/fstat.c           |  42 ++++++++++
 src/lstat64.c         | 166 +------------------------------------
 src/stat_common.c     | 185 ++++++++++++++++++++++++++++++++++++++++++
 src/stat_common.h     |  16 ++++
 tests/generic/002     |  16 ++--
 tests/generic/002.out |   2 +-
 tests/generic/795     |  60 ++++++++++++++
 tests/generic/795.out |   2 +
 9 files changed, 324 insertions(+), 178 deletions(-)
 create mode 100644 src/fstat.c
 create mode 100644 src/stat_common.c
 create mode 100644 src/stat_common.h
 create mode 100755 tests/generic/795
 create mode 100644 tests/generic/795.out

-- 
2.43.0

