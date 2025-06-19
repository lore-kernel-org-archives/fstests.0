Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF42741C6
	for <fstests@vger.kernel.org>; Thu, 19 Jun 2025 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339842; cv=none; b=BRSs85+HK6TNcSg3wP/xk0LCipSxStz6kR3cgkuEdaKq6rknoY+ZuEBgYvEthhLpxf5NXTXNBvjwYTNUg3XZMvTVRQxkQShBUEX2m2Uo6eiGNat9rzGWmGvHvhztcm+hOHDNvlak5AlebGuUPBvwM6KhB85fh03sUiw2iPkLrAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339842; c=relaxed/simple;
	bh=Tc9hm6WjmCZjRacytFaLEXyo6/jS32sN/WroD/Th/74=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sR0p0HewxyfF9Vn3NHQNECs0sSXZ8dTIo7LWy9vClJRHL3/7VFovfh/6i+CduPJGwqMIj+bNBax2jpk0OzjRb5CBri3YSKIAhnpkkfrjoyZkAAjKfQ3lqStlAipu2D6gwIbcf6cAlwfQ/U2Fsx43jBh4yMHenrajee7DrLzCP/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HplOVoEO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WQSSeIma; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HplOVoEO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WQSSeIma"
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out1.suse.de (Postfix) with ESMTP id 6CACF21211
	for <fstests@vger.kernel.org>; Thu, 19 Jun 2025 13:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750339838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5tls9ggucioyBkPY576or77S7B1JMcEBunucyef6Vpc=;
	b=HplOVoEO1DytA11WDg5zD7q6nq+jLm5xIx2MbkZRg0L02DmirrwxYvAvtFLdwFxQHoUwUS
	m/GX1sPOz3KMypL7ITv9P0FsXG5OPBSJJfzZXAQWfpvFmMFEI2Jf2WytVmHcl/5H0vexDe
	yYa4CUWa1FkiPsYGKTbDo2h+Sf0ehGU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750339836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5tls9ggucioyBkPY576or77S7B1JMcEBunucyef6Vpc=;
	b=WQSSeImacZcaFM9YDBUeK2Wu50MhiTTBeRICa6s4lmW8elrSEn+BXzuMysCcvCKNkTA+2g
	jEUsOQvbQt8sglfFzMsUbdxtDoLGDA3qDD48kBVhc+NxXW2yBmF3GSOdjiMnaaYAfy+dkD
	R8T3Ki+GRNBI3Tavf4RMeY1EXU4lM9s=
From: Anthony Iliopoulos <ailiop@suse.com>
To: fstests@vger.kernel.org
Subject: [PATCH] xfs/820: skip test when metadir is not supported
Date: Thu, 19 Jun 2025 15:30:31 +0200
Message-ID: <20250619133031.62511-1-ailiop@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

The test specifically requires metadata directory functionality, so make
it dependent on that as otherwise it fails on kernels older than v6.13
that do not implement the feature.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 tests/xfs/820 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/820 b/tests/xfs/820
index 1dfd0dd32e14..8d739c7f6f3d 100755
--- a/tests/xfs/820
+++ b/tests/xfs/820
@@ -16,7 +16,7 @@ _begin_fstest auto quick quota
 $MKFS_XFS_PROG 2>&1 | grep -q 'uquota' || \
 	_notrun "mkfs does not support uquota option"
 
-_require_scratch
+_require_xfs_scratch_metadir
 _require_xfs_quota
 
 filter_quota_state() {
-- 
2.49.0

