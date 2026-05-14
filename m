Received: from mx0.herbolt.com (mx0.herbolt.com [5.59.97.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C569323D7DC
	for <fstests@vger.kernel.org>; Thu, 14 May 2026 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.59.97.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758802; cv=none; b=kpCT6PkIXBnkETR+J5g5m4gVsNjOjd5Dw3jXQeF3SUZi7HIGs/wKWfJu9NHU5YhfEQN8e8sMPpBICupzBPKGFA9cpo7wykkC6pvJEg5e+oY14se9t7WqOjMvDAwgvZ9Zyqf4hz8NyZDBAxV2fZ2Adle1/bcSXQKED+VZuQFdRbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758802; c=relaxed/simple;
	bh=B8EkIJgnoTFnaTIue/ymB+2FovK4q0kXonUWqVlB0gA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1qYd18KevO++z3n4SvTz8cxGKzI3MbZxMQ3mPenGZa71wczsbIsh0ln2xuJX3lquySBdj+xTgt9FFCCM+6UflR/ulp7FkBXqlEpLRWPOSDAtgY8NEXRltxJ43X3/BmoTseSLgBDDuA3/RuWOKDirtArWcbR8+GgC8eu6BzUfu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com; spf=pass smtp.mailfrom=herbolt.com; arc=none smtp.client-ip=5.59.97.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbolt.com
Received: from mx0.herbolt.com (localhost [127.0.0.1])
	by mx0.herbolt.com (Postfix) with ESMTP id 0C389180F2D5;
	Thu, 14 May 2026 13:39:54 +0200 (CEST)
Received: from trufa.intra.herbolt.com.com ([172.168.31.30])
	by mx0.herbolt.com with ESMTPSA
	id uaW8NIm0BWoNiioAKEJqOA
	(envelope-from <lukas@herbolt.com>); Thu, 14 May 2026 13:39:53 +0200
From: Lukas Herbolt <lukas@herbolt.com>
To: zlang@kernel.org,
	djwong@kernel.org
Cc: fstests@vger.kernel.org,
	xfs-linux@kernel.org,
	Lukas Herbolt <lukas@herbolt.com>
Subject: [PATCH v2 0/4] Fixes for mkfs.xfs with high amount of CPUs and SSDs
Date: Thu, 14 May 2026 13:39:07 +0200
Message-ID: <20260514113910.866888-2-lukas@herbolt.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since xfsprogs v6.13.0 mkfs.xfs scales the log size on SSDs with the amount
of CPUs. This leads to various failures from ENOSPC in generic/102 and generic/172
(the xfs log can take up to 256MB on 1GB test FS) or depleting the dmthin 
metadata area in generic/347. Downsize of the percentage change is we cannot 
longer check the exact amount of data xfs_io wrote in the generic/102 test.

The xfs/21{6,7} are testing the old behavior before the concurrency option was 
introduced. Forcing the old behavior on newer mkfs.xfs.

Lukas Herbolt (4):
  common/rc: Add helper to calculate percentage of free space available
  common/xfs: helper function to check if -l/-d/-r concurrency flags.
  generic/{102,172,347}: Adapt test for XFS on systems with 128+CPUs +
    SSDs
  xfs/21{6,7} Use default -l concurrency=0 on mkfs.xfs that supports it

 common/rc             | 10 ++++++++++
 common/xfs            |  9 +++++++++
 tests/generic/102     |  5 +++--
 tests/generic/102.out | 20 ++++++++++----------
 tests/generic/172     |  8 ++++----
 tests/generic/347     |  9 ++++++++-
 tests/xfs/216         |  6 +++++-
 tests/xfs/217         |  7 ++++++-
 8 files changed, 55 insertions(+), 19 deletions(-)

-- 
2.54.0

