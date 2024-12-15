Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677239450
	for <fstests@vger.kernel.org>; Sun, 15 Dec 2024 05:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734239573; cv=none; b=dVk3ImMCh71d9IyQayg/EOqmGIjcR18aFAThDVCw4bVxNsg11X4PMtTUibp9RsxNNeuJDtl4LjKhjbjjNZD7FLHvFKGyT8dT5wygnwJ9O1rq/Rd+wDeCegcNEKWVZlR3zGX5LnGUup01WCZ8eQtebUREuP7VbR18CoHEpIPo1e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734239573; c=relaxed/simple;
	bh=UV7DP3/rkim2gIJG5rzeZ27iqYxV/z/+FDZmynz3IBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IL0Oq7g4/LuEll6cMlk/SNT+3s4meZKeam/BT1kSQmMcBQNqQmTnmV6n2QJhFhiqgCYpFB4WhbgeLkJWzBJTJ+tDTRSYbITDetL2QQtrqEJGWPpriRrgZ7RBbyHXqpoi3wVNj7MXMhifFfos0XIN6laGBEMs+a22TLuz6W1eYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=i5vTt4M7; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="i5vTt4M7"
Received: from cwcc.thunk.org (pool-173-48-82-226.bstnma.fios.verizon.net [173.48.82.226])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4BF5Ckwk016317
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 00:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1734239567; bh=3j2Z8iw2rO+eZLaywIqn8SZcjLivo0CXS/EClIwCa4s=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=i5vTt4M7apFbh/MjLSw7Bjl5nU8Z1+e7m0Mtz86Jiv5ilKrLqsmMle8Rvj8yYn0u2
	 lZYECE6oQ1vFF+hf0s1imhEnLDoRZNBIacHqUv8Fjy3ibN15edTiDtqPQJPfWbjZWe
	 FAi7IEtTdSc0Czl3tz0HXHehlK7t5KB4Tmg7qIv/CEgRZ7gp4nQi7BgNMMZcIHe46g
	 mkYKqSn/AaDrKxiqYsRMZiKMqOTpjpZrpiuPA1JVvWnyqaCbJ1ItIntMSmGslqqGhd
	 IwzTCt41RDhL7f2mXwwq8D9vXmhKIJHZw2GX5Ytt2ga1r7lkuCIhdDixm0tkg3rRhq
	 q17N7gzU8d0mw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D7ADF15C465A; Sun, 15 Dec 2024 00:12:45 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] generic/135: don't try to rm $SCRATCH_MNT/*
Date: Sun, 15 Dec 2024 00:12:41 -0500
Message-ID: <20241215051242.3340572-2-tytso@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241215051242.3340572-1-tytso@mit.edu>
References: <20241215051242.3340572-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a regression for ext4 introduced by commit 32e14cb90b88
("fstests: don't use directory stacks"), which replaced a number of
files at the top-level of the scratch file system:

    async_file sync_file direct_file trunc_file

with "rm $SCRATCH_MNT/*".  This causes a test failure on ext4 file
systems caused by a failed attempt to unlink the lost+found directory.
The thing, is these files are all super small (4k or 16k) and the
scratch file system is going to get reformatted before it gets used
again.  So just dropping the delete is the simplest way to solve the
problem.

Fixes: 32e14cb90b88 ("fstests: don't use directory stacks")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/135 | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/generic/135 b/tests/generic/135
index 392fee6fc..f74e144f3 100755
--- a/tests/generic/135
+++ b/tests/generic/135
@@ -40,7 +40,5 @@ od -Ad -x $SCRATCH_MNT/sync_file
 od -Ad -x $SCRATCH_MNT/direct_file
 od -Ad -x $SCRATCH_MNT/trunc_file
 
-rm -f $SCRATCH_MNT/*
-
 status=0
 exit 
-- 
2.45.2

