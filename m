Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676D91171C
	for <fstests@vger.kernel.org>; Sun, 15 Dec 2024 05:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734239573; cv=none; b=NkGFXLNZMoZ9hyoIsv7JiOHjevZyQ+osRdtNzd4z9S6W1gneO2o07oRIFVC6a3wXrBoMGtsau8bs3V7K+7deGZ6Ek+xx180L4Hvd63sA8Qwl3WeLW0sh9a6oqL3yhFbI6xZLPUdS/8z/rHFodkBIi4fws36a7FDw4IOUmt1GmmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734239573; c=relaxed/simple;
	bh=q0sk3h3qgAddoHSrwi7Cdb/bYY18njVifbQOC7DEXKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucZEVODEObKRQu0fWIr0SpjTOorOQludUqaOmHJ9pOUG0UJMVT8r7xrET3L1cs7lus6vWP9FSeDhZtqPzT9EsUDrC1WHAMwYR+MuVGol4AEvLk2yTkAcWTPWIi0Z7yX5VAnF6UDpVUSKNB3i+pS4fhQEGpapY2H1rLONeEHpoyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=MdD3Qip2; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="MdD3Qip2"
Received: from cwcc.thunk.org (pool-173-48-82-226.bstnma.fios.verizon.net [173.48.82.226])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4BF5Ckxg016316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 00:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1734239567; bh=ya9O4/QMoXOLACAN8kt4FSBolz5nz9im9mq5riMKkyc=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=MdD3Qip2LozOBNLQFteNaS0Mh7nyZ0fYuPmPetR3H65GOx7xRoqUHOOMWKVd5Rf6q
	 7ffEjWL5bmLd/4bwYcLNjhZSOr8EvKQBH1ETTymFPboQkaTi5b3qD0e6iJX3ug9NLa
	 fmVW32F5NOrxJkSF/Q9zFj32o95Bv4X4VOZwz+0y2AoSw0FGj+w/l6EU+5fY2AoLfj
	 BL4nmeRfBfK/kZOiMHL8YTPPAjaNjgCZBnTuJ/Ilfk7A5AuvdVRNhmVUjGvmf3b+Bf
	 2Ugub3FEJLLYYHqC6Y2cLAQXpNcQEMVLkGwNLjrBidniw6rTK9CFKTNwKu49ThyB6P
	 swMOlQZZMfECQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D685815C4656; Sun, 15 Dec 2024 00:12:45 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/2] Fix recent regressions from for_next
Date: Sun, 15 Dec 2024 00:12:40 -0500
Message-ID: <20241215051242.3340572-1-tytso@mit.edu>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I don't think I saw an announcement for the most recent for_next
update, but I just happened to pull it and try it out, and found the
following regressions.  Fortunately they were easy fixes.

Theodore Ts'o (2):
  generic/135: don't try to rm $SCRATCH_MNT/*
  generic/530: only use xfs-specific mkfs options when testing on xfs

 tests/generic/135 | 2 --
 tests/generic/530 | 6 +++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.45.2

