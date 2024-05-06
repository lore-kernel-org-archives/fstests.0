Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115EB33D8
	for <fstests@vger.kernel.org>; Mon,  6 May 2024 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007694; cv=none; b=ZEVg1G44FQcoY6+zygcRoilSvkayp9jXURlVVUkXLU36Q0hw7Q77mo3zO5dvX+DoFV2iTEiidY3N5uZ93k3/kJd8gHO2jE1NTYRmpOXja+L5RWt9S5QRTieAmdUtPKz0Du1zlmBncaDhQcU/0FOJuc+0B+6VTVTlgcC8q+TY3bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007694; c=relaxed/simple;
	bh=lRPZw7qKGVVFtdy1pmkI6dAUoVXsgVll5j9bhiNGvoU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aonz8eS+gDK76hh6zuxmoUjOLS//2EA1AjXnyRprzZm7n2ZzvO9pn6oC3Bm/vVDbt1hia3oQBrCdtExH4/lLxGp3qY/anhrMHjkQtvCxPJ+KfyCLaozRDuBJF/n2L6hyFAyWEA/J0R8xEkF8hsh9j2BVWERmTtwU+Fjx2j+62Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=OOp2FJHG; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="OOp2FJHG"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VY4Nz3NzVz9stB;
	Mon,  6 May 2024 17:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715007683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TMlEOUc8Xb56DufW1jBS5IclGid3D5IowiJz3VzldR0=;
	b=OOp2FJHGiQB9Fx14UmNOQ70DG4lO/DiDdx/bRdsZtY0Q+a99KxyVAfMwEi9DCBWAaOF748
	n2SIxeNR7K3y4L12zbsK3EkUEou5KwtlzXAEq4P3qwp4Juq6tmviuEzjmDDZyWH0oHnNtV
	JJ6xp8zxVfAJ4YJOdanSztTSMwXt1HtHciPHt1Pqk17mP4TeTRt/XLuOQgLCiadpDUoYDD
	VwdZis48hu/ot//C+BqWfzPf04vuJ0esHVk12GQGX7f2MRq62FWD0CVBHs2nYn4GAuRdV+
	F+v6tTb1wSaRuTLIs5KU57Gws+kUwYBQ3oxa2zlFiMEtY6G1Wo9wPnePv60UDg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org,
	gost.dev@samsung.com,
	mcgrof@kernel.org,
	kernel@pankajraghav.com,
	ritesh.list@gmail.com,
	zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 0/3] more lbs test fixes
Date: Mon,  6 May 2024 17:01:16 +0200
Message-Id: <20240506150119.184097-1-kernel@pankajraghav.com>
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

[1] https://lore.kernel.org/linux-xfs/20240503095353.3798063-1-mcgrof@kernel.org/

Pankaj Raghav (3):
  xfs/161: adapt the test case for 64k FS blocksize
  generic/436: round up bufsz to nearest filesystem blksz
  xfs/008: use block size instead of the pagesize

 src/seek_sanity_test.c |  8 ++++----
 tests/xfs/008          | 19 ++++++++++---------
 tests/xfs/008.out      |  8 ++++----
 tests/xfs/161          | 10 ++++++++--
 4 files changed, 26 insertions(+), 19 deletions(-)


base-commit: b26d68da08e47e6508a96bee72b25823040ab67e
-- 
2.34.1

