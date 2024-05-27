Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309BB15E5BB
	for <fstests@vger.kernel.org>; Mon, 27 May 2024 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810525; cv=none; b=JqXZW65Apg1LyUYbuP40vqBcfpnt5UAvFlyNqJ79xV4+S37amxJwXu+HIbCzLJIsTNm+T4kyWQyN66/FTe29MyML8dKwcsId4KPfE4mFK4PpblcRocCwChvTjgr3P7soDu8LdkhuyBtOG8GzDl3J8vG3GudBU+E6yIbAnZff140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810525; c=relaxed/simple;
	bh=6Ss4vLKXdgRGorm3qHADhxaCMwLy9KLfP33zrh3Q6bY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rMtrICYB+38cdKKikbCVZN4xH8MP9AGMBkr1nwKPTEyS2ICFierU5J6TPhyvrpRCdbxLstGUsAdrINqV1qDTW40zH9V7Zgr4jApZzJMOHEqoVIopqlKr/gPfdVhAVLkViEMTmWQ67ZDC4ucmH8TqZpak31vdZ4qAaHd1VmxiFdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=peQLYaux; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="peQLYaux"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Vnv6r5lm8z9sSs;
	Mon, 27 May 2024 13:48:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716810516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GEtepb5L0fMHjOgtK7fXoEsYdfKI47INCSlk8NAYI/A=;
	b=peQLYauxk2jdOx2hs+Q6F7qAbD5Jy/dCKeii2KryNQuG5dd1fCMijnME6TATdWlymG5vZ8
	EMtlKRMhLIhfabP790LYV9wa0rxSOGes2Ca158Gpp9ahz2pHw/6tvyaoBb9g+NDQHZS5+H
	Hj0q5pXBaF8pPT6cfxpQayxlzVR9wZ2vkJmeaUGe3HmxgknByKNpBeTJtQDGfuvV8cChBD
	VfNrT4luTb76t4Q/193K4+kGHzHPLDT8RZvuRTwqvxcafotz/6P5cvyqWcZwlOWQ0OOStB
	Eo7E96Jys034dKP5gieG6KXPjhpdyUrDE3tkTiYUtpfoNE+OyXjCTVDmvTTZHA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: fstests@vger.kernel.org
Cc: ritesh.list@gmail.com,
	djwong@kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	zlang@redhat.com,
	kernel@pankajraghav.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 0/3] more lbs test fixes
Date: Mon, 27 May 2024 13:48:31 +0200
Message-Id: <20240527114834.167521-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Vnv6r5lm8z9sSs

From: Pankaj Raghav <p.raghav@samsung.com>

These are some of the tests that failed when we were working on LBS
patches [1].

generic/436 and xfs/008 are adapted to work with bs > ps systems.

xfs/161 is an upstream failure, and it happens even on bs <= ps systems.

Changes since v2:
- Addes RVB tags
- Removed pgsize fallback in xfs/008 (Ritesh)

Changes since v1:
- Corrected copy pasta error in generic/436
- xfs/161 removed hardcoded and incorporated ritesh's comments

[1] https://lore.kernel.org/linux-xfs/20240503095353.3798063-1-mcgrof@kernel.org/

Pankaj Raghav (3):
  xfs/161: adapt the test case for 64k FS blocksize
  generic/436: round up bufsz to nearest filesystem blksz
  xfs/008: use block size instead of the pagesize

 src/seek_sanity_test.c |  8 ++++----
 tests/xfs/008          | 20 +++++++++-----------
 tests/xfs/008.out      |  8 ++++----
 tests/xfs/161          | 16 ++++++++++++----
 4 files changed, 29 insertions(+), 23 deletions(-)


base-commit: 9837971383733ad59ead121dcc4b13f89829d389
-- 
2.34.1

