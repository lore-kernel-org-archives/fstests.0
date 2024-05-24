Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2150712E5E
	for <fstests@vger.kernel.org>; Fri, 24 May 2024 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716535872; cv=none; b=HxAJ9rbfDRg3QNrxwxhCJZ8sNYa/PUWUUg/IEjw2nXYeN12LpGIgtl0sdSsVpWwYybwJTnnDV5YN9nVCT32CUnHJXAlCuDrKNa4X0rRqgomiLHj1PyhmITcVvw01PBMRefIDmEIWMQl6v+Lm47HlN1U8jKkHUY2RXnVGwv/Zwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716535872; c=relaxed/simple;
	bh=byAPVmc1MiTPoh3m32NlqCYf++nBydiKZBuacrnukQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rzPBvZ6LO3rb4gy1mKPtQbo0IYQWeta73KjugBM1mUl4ANww3f0UniANzoyJd5tXejPVGtnn64iXFcAJWmVUZ7rHfp7V7D82n/G0imRcAMusVGX6hIrccD7hRp8Sk3eIiNKiqxTrubJh5VP0v40IwPMx/in9qCz1Ak4E4ApNZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx9ESsM2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx9ESsM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A7BC32789;
	Fri, 24 May 2024 07:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716535871;
	bh=byAPVmc1MiTPoh3m32NlqCYf++nBydiKZBuacrnukQw=;
	h=From:To:Cc:Subject:Date:From;
	b=hx9ESsM28QRyrWM6TLRBJkysdaA5To4lN8xTeN+RoCBVd6i/w92M1WDHN7uBeYN91
	 Ra+67S9pb29fwAkWW70bcuaK+rtVdMUJLuUOSLrPMY9Otc6QIjUlrMkRSVsNNZLHI6
	 7KbtTLUOcKviO6CgzuQSMDHIavecihKsIZQgB3kza31jrFjFii4CFXteNFEDcTaRKz
	 OxR40thRBmlDXEcS6Uxv1/AZd6aTtKGg2byQjDvNfcVf8KMGXH32MzTHwXQ/Dyykpl
	 dHeN4vR9JmaiMRKJNmfSF4j8LtcjLuZxZF83p4zLsB9HrrNHs7YMGcCWaHxUhcbZoY
	 HPzIw8PpNBrXA==
From: Chandan Babu R <chandanbabu@kernel.org>
To: fstests@vger.kernel.org
Cc: Chandan Babu R <chandanbabu@kernel.org>,
	zlang@kernel.org
Subject: [PATCH] _test_mkfs: Include external log device (if any) when creating fs on TEST_DEV
Date: Fri, 24 May 2024 13:01:01 +0530
Message-ID: <20240524073104.615253-1-chandanbabu@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test execution fails when testing XFS with external log device and when
RECREATE_TEST_DEV is set to true. This is because _test_mkfs() is invoked as
part of recreating the filesystem on test device and this function does not
include the external log device as part of the mkfs.xfs command line.

_test_mount() invoked later fails since it passes an external log device to
the mount syscall which the kernel does not expect to find.

To fix this bug, this commit modifies _test_mkfs() to invoke _test_options()
in order to compute the value of TEST_OPTIONS and includes the resulting value
in the mkfs.xfs command line.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
---
 common/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 0fe56382..6562ccd7 100644
--- a/common/rc
+++ b/common/rc
@@ -614,7 +614,8 @@ _test_mkfs()
 	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
 	;;
     xfs)
-	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $* $TEST_DEV
+	_test_options mkfs
+	$MKFS_PROG -t $FSTYP -- -f $TEST_OPTIONS $MKFS_OPTIONS $* $TEST_DEV
 	;;
     bcachefs)
 	$MKFS_BCACHEFS_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
-- 
2.43.0

