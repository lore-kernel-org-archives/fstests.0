Received: from mx0.herbolt.com (mx0.herbolt.com [5.59.97.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD88426697
	for <fstests@vger.kernel.org>; Thu, 30 Apr 2026 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.59.97.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555260; cv=none; b=hKWo1iTqI/RNwA/wdbnWT9nz6aLxiLWgd4NN5H+/qf+qyx0XrW43s7FQKwG+lo1hQw65rpHkSDACc74ecU16pQpFZh+bIU0FuD5fAC/TOpyuXYNn8AFpwOD4JAedQgZvmacQxRPi+Q6I8ej918VNa+uBMGG/7N5idVxIb5pMoT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555260; c=relaxed/simple;
	bh=MsWY0rHsP6pdIL4qzhswEem5xWe4J83P2G7hzfIkf2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OgEIBU35PZ7mwdw2LnUKvWjydNAbx3trTu52fNjeQdsszarpS/Et7MOjn8/5ZvIVGLjbtMpK4C1OLGV26X7LVgQ0lr7w/PSoUlCvqN9O4gD7vFG4cf04YXWKJg8ny7wkIIRuuvIO1EAjzRIQmh/7wTc2Z+QDHc4dxZaB1eaBkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com; spf=pass smtp.mailfrom=herbolt.com; arc=none smtp.client-ip=5.59.97.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbolt.com
Received: from mx0.herbolt.com (localhost [127.0.0.1])
	by mx0.herbolt.com (Postfix) with ESMTP id C8BD9180F243;
	Thu, 30 Apr 2026 15:13:42 +0200 (CEST)
Received: from trufa.intra.herbolt.com.com ([172.168.31.30])
	by mx0.herbolt.com with ESMTPSA
	id HBgTK4ZV82m0DRoAKEJqOA
	(envelope-from <lukas@herbolt.com>); Thu, 30 Apr 2026 15:13:42 +0200
From: Lukas Herbolt <lukas@herbolt.com>
To: zlang@kernel.org,
	djwong@kernel.org
Cc: fstests@vger.kernel.org,
	Lukas Herbolt <lukas@herbolt.com>
Subject: [PATCH 0/4] Fixes for mkfs.xfs with high amount of CPUs and SSDs
Date: Thu, 30 Apr 2026 15:13:14 +0200
Message-ID: <20260430131317.693845-2-lukas@herbolt.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since xfsprogs v6.13.0 mkfs.xfs scales the log size on SSDs with the amount
of CPUs. This leads to various failures from ENOSPC in generic/102 and generic172
(the xfs log can take up to 256MB on 1GB test FS) or depleting the dmthin 
metadata area in generic/347. Downsize of the percentage change is we cannot 
longer check the exact amount of data xfs_io wrote in the generic/102 test.

The xfs/21{6,7} are testing the old behavior before the concurrency option was 
introduced. Forcing the old behavior on newer mkfs.xfs.


Lukas Herbolt (4):
  common/rc:  Add helper to calculate percetage of free space available
  common/xfs: helper function to check if -l/-d/-r concurrecy flags.
  generic/{102,172,347}: Adapt test for XFS on systems with 128+CPUs +
    SSDs
  xfs/216 xfs/217 Use default -l conccurency=0 on mkfs.xfs that supports
    it

 common/rc             |  8 ++++++++
 common/xfs            |  6 ++++++
 tests/generic/102     |  5 +++--
 tests/generic/102.out | 20 ++++++++++----------
 tests/generic/172     |  8 ++++----
 tests/generic/347     |  9 ++++++++-
 tests/xfs/216         |  9 +++++++--
 tests/xfs/217         | 17 +++++++++++++++--
 8 files changed, 61 insertions(+), 21 deletions(-)

-- 
2.53.0

