Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35D835957
	for <fstests@vger.kernel.org>; Fri, 14 Nov 2025 01:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763082175; cv=none; b=nLTBECiAArVak1dQPIcO3tMFBvcuhZqboaDmis8+ilM71uYMcci2gl6Pip4XMZme5E19ckXlBSpGzSSlQYn5WGPIyp9naYanUO+PkGP00SZkYc2zzbFj6D9u/ENhnDiPqbVf/cAA7U0XNuyHBiu/ndsDSNXa6KYXSrZK4OvZF9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763082175; c=relaxed/simple;
	bh=3xe85HA/1czSxmL7nCgRY6ULTgCxgCzYhRT130ACms0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NafkYqxFP6JYte5Uw8o75TtQZrEHj/GPagWFCrLr0/4Vw5JZzITOSVHFkqw+91ZXo50HkUfqngkD/CioySN54K++pGG9ZPPX//MUJuML0ZJrzBMDcsAe31jxeHEqW5JSdmB59Hs/5HvXUFzVOMkhHds/ulCieHhW/mt+K7NU9P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=cvucctQr; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="cvucctQr"
Received: from trampoline.thunk.org (pool-173-48-82-200.bstnma.fios.verizon.net [173.48.82.200])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AE12io6013898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 20:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1763082166; bh=mPon4wbQ6WvSI1i08sBcmuTwM2MyzZxPZubwjqdLtHs=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=cvucctQrSIZzsmBZyN+LglFT+Ebi6c2tXe31TML5bB5LMlP1OvEGYq+OTxmELwjrV
	 49PbePYgVq2RpORA3+prbxeMObE8/m1YLaD/tOrU9RxHGnAdc+VN3pNgHbXOhNTooP
	 93gVmSinuNyPEbkXhmLPuxc/g9PFrZ4k6n7IcjUFuOFfkN4AlPz7w9RW7JCYPiWF+z
	 ztcU+VUOSAT9AGF5QvvbDChsqjnzKr9Ys0IywGEhVDf1pgHT9/h2zLn+8G76Sod6nz
	 K3JKZJK/KWmrQi+ETwsr+GRtDwIa6FCMqbWvMtcuVRgcXeSwSUT/lkqPtizOPYBEHA
	 Aeu4rmu/bz3og==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 869752E00D9; Thu, 13 Nov 2025 20:02:44 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: fstests@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Zorro Lang <zlang@kernel.org>
Subject: [PATCH] generic/773: fix expected output "QA output created by 1226"
Date: Thu, 13 Nov 2025 20:02:38 -0500
Message-ID: <20251114010238.2173413-1-tytso@mit.edu>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test generic/773 was apparently submitted as generic/1226, but
when it was renamed to pack the test namespace, apparently the test
output wasn't adjusted to reflect the new test name, leading to the
test failing on sytems that have devices that support atomic writes.

Fixes: 1499d4ff2365 ("generic: Add atomic write test using fio crc ...")
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@kernel.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/773     | 2 +-
 tests/generic/773.out | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/773 b/tests/generic/773
index 7ad745546..0a30ac7f4 100755
--- a/tests/generic/773
+++ b/tests/generic/773
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2025 IBM Corporation. All Rights Reserved.
 #
-# FS QA Test 1226
+# FS QA Test 773
 #
 # Validate FS atomic write using fio crc check verifier.
 #
diff --git a/tests/generic/773.out b/tests/generic/773.out
index 6dce0ea52..8626114df 100644
--- a/tests/generic/773.out
+++ b/tests/generic/773.out
@@ -1,2 +1,2 @@
-QA output created by 1226
+QA output created by 773
 Silence is golden
-- 
2.51.0

