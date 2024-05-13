Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CB215098C
	for <fstests@vger.kernel.org>; Mon, 13 May 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605991; cv=none; b=QMoJ/u0QULsFtcUpXai4gYZJW1vC5SPiLMokXYxLeoTgmw9S8wuEAjbAcFqKClyL+WdEjhg3U9qOifGjzqrhU1STTR+Ddwxu+mRWUP73Pfv3IKq8h9H6vL5D1dxuqrfBGK0dv6SsFYdLNIHC4TaMyqV0mc0THt84zSB/FTqRBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605991; c=relaxed/simple;
	bh=NA0Eu2BjkSvyQbWDjNwBg7L44zjuYFp7vij2sJKsMqM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ri0yInb3CuAlJRO63CBOegBu8KVGxOY82g9T7wKulKEA+SJ1W9DOULjkNFfgb1TkmvdfuknbDEp4R8BgqdPZaVcVJKuY0vxPyoPbcmRUdxbrT+I/VnXmkYjfxGXPSxryDS6QTGNmlvB9MxbKowiIuGWOUjIu/Rp6Edrmmw9nxj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=mX2NjVoq; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="mX2NjVoq"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VdKfg5ZzZz9scW;
	Mon, 13 May 2024 15:12:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715605979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p8JS9TruiLHw47pjTWPkUwudiShTnZb1aKXYGKVwYDc=;
	b=mX2NjVoqI21cN5LdhkDjWNNwqYnOP3ZvjWy20VU11SxL0/xT1B9TzIj9Cfawkx2bB393of
	6Lg6NudV9MIwVP5uQtzCYMrAiX3fzvlGMC8Y9PgcVmFdGSwtIReBC2NUYzynKpZLW8CwgI
	Lxd4t+skFn62KRHI8Zaa1Uq0sBMnN2ZrF5ULPkHHPJQOrMNgwEkQWpwZ5vaJt87qPh79HT
	FY1vBZZiji0ujVwkO8a6JjXCbE7fh/lDQiqrhBndpRIivQnDuU5SzHfdKFkTy9UX3Gg9i7
	fCECCCe6fMtSbwAP83jqVq2LSt5TYYO3sq2PBKFhxtg8zgk23UBpPZU73LpinQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: fstests@vger.kernel.org
Cc: kernel@pankajraghav.com,
	gost.dev@samsung.com,
	mcgrof@kernel.org,
	ritesh.list@gmail.com,
	djwong@kernel.org,
	zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 0/3] more lbs test fixes
Date: Mon, 13 May 2024 07:12:51 -0600
Message-Id: <20240513131254.92412-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

These are some of the tests that failed when we were working on LBS
patches [1].

generic/436 and xfs/008 are adapted to work with bs > ps systems.

xfs/161 is an upstream failure, and it happens even on bs <= ps systems.

Changes since v1:
- Corrected copy pasta error in generic/436
- xfs/161 removed hardcoded and incorporated ritesh's comments

[1] https://lore.kernel.org/linux-xfs/20240503095353.3798063-1-mcgrof@kernel.org/

Pankaj Raghav (3):
  xfs/161: adapt the test case for 64k FS blocksize
  generic/436: round up bufsz to nearest filesystem blksz
  xfs/008: use block size instead of the pagesize

 src/seek_sanity_test.c |  8 ++++----
 tests/xfs/008          | 19 ++++++++++---------
 tests/xfs/008.out      |  8 ++++----
 tests/xfs/161          | 16 ++++++++++++----
 4 files changed, 30 insertions(+), 21 deletions(-)


base-commit: b26d68da08e47e6508a96bee72b25823040ab67e
-- 
2.34.1

