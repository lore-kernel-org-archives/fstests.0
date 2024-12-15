Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA97C14A90
	for <fstests@vger.kernel.org>; Sun, 15 Dec 2024 05:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734239573; cv=none; b=aXZlKrMJpctbvmbo3APB6xqJIEYqt03li2up39VZra8XLv/bYLLS8PPuuFu3lEC3L8HJU8woFLQk4AmbLQiJ7Jfs/R3kqvhyFylCuYKgwtaWU4bKOYV/3AXj4H/8XGOeKlIJQ5S9dtVXT3otJaGpKJ0nHbIpVcHqW4VfYLzlZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734239573; c=relaxed/simple;
	bh=NqV45Q3MI7QE+DdrecnG4mSoaq1MeTySo5Fw2cH4OiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7V9E3IX9I5nZgjOKz5vSAyrf2vc9xULU/S/MQ3MZkSInqiOtyZw03hx6Zs1IYaHwBmxavR6wa4sskkoKJ/1beiFSKkHPy11uiUIBYjObbIE3OJNAb2dXNuGgkjfFozQiRE3vdauQmouY9EI3DpGRka73tjTjhRHzIYNT/2EJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=aN46evF5; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="aN46evF5"
Received: from cwcc.thunk.org (pool-173-48-82-226.bstnma.fios.verizon.net [173.48.82.226])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4BF5CkOK016315
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Dec 2024 00:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1734239567; bh=HPdy6WfKUXiQn+osnD2FHdJSwH00wfd9S2ZaVh4a6NU=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=aN46evF5IKYu9hQ9ecehnJ2uTEho4KrnUlGNl8uEDvebwim6BdtQTlu6esivLrIi+
	 BRH+HipUzx0MPdvlI9dJackiYuU3pe4SiqTKFwIYlXVPZ3PS3myftGaExq357KAZVa
	 F5VwPWP1GoIfvsD4Zk6y2PE4Wywl9qiFGC4fv/87pgINaugHNrDf1sBwETk49abbhO
	 xmoECppK329gdoGF62Xb3u2gZRIrjv8yrvfvc768hmWTmf6Phlt9hjWb/zMOo5LxWF
	 BYFCNHRDU8XWp4dflhcKIFmCMwsQXEz07VCNhlnpltGxSp26VdhhmcSYT30Rr3J35o
	 NH8NgA5/8yZVA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DAB2715C465C; Sun, 15 Dec 2024 00:12:45 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] generic/530: only use xfs-specific mkfs options when testing on xfs
Date: Sun, 15 Dec 2024 00:12:42 -0500
Message-ID: <20241215051242.3340572-3-tytso@mit.edu>
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

This fixes a regression introduced by commit 000813899afb ("fstests:
scale some tests for high CPU count sanity") where this test
unconditionally tried to use the mkfs option "-l size=256m" which
would break when testing any file sytem other than xfs.

Fix this the same way commit 000813899afb dealt with this for
generic/531; so this was just an oversight.

Fixes: 000813899afb ("fstests: scale some tests for high CPU count sanity")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/530 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/generic/530 b/tests/generic/530
index 18256b870..06d7532f0 100755
--- a/tests/generic/530
+++ b/tests/generic/530
@@ -22,7 +22,11 @@ _require_scratch_shutdown
 _require_metadata_journaling
 _require_test_program "t_open_tmpfiles"
 
-_scratch_mkfs "-l size=256m" >> $seqres.full 2>&1
+if [ $FSTYP = "xfs" ]; then
+    _scratch_mkfs "-l size=256m" >> $seqres.full 2>&1
+else
+    _scratch_mkfs >> $seqres.full 2>&1
+fi
 _scratch_mount
 
 # Set ULIMIT_NOFILE to min(file-max / 2, 50000 files per LOAD_FACTOR)
-- 
2.45.2

