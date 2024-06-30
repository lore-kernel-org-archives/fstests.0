Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490771649A8
	for <fstests@vger.kernel.org>; Mon,  1 Jul 2024 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845523; cv=none; b=a4BImtsPK9pa64iratR8XF+EFkAAse9wwjivj7rc6/NFpivmLQ/DRm0Qpx/LKTuhUBo00DmPBWyw17k1I3asyvex6MNHb+zxpwjaMkg7L/8umF1cNaDg+o4kYJhs2l2LMyrND8uHzGZm+cR1QCi9yGpMnnRUC8HSEF2cSOlblcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845523; c=relaxed/simple;
	bh=6iOMRTWMwN1CICgLmdW6RtuLUZr17rQ71VUnU3x2zpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ou9HE0iR7y+gIdT5E91sO+Es9g/5W9/1/QHiesFp4c8JPKJYa2XFHL2HSSFnoYhE/2lYadM3m2DcetajrDYs158RckCIrxF8PXZsqEbA6GqOS5ZvuxZMTBc/k/YTUzsA4XuGHilWoivrJSRRsiDptIJZ7vTYlZU+XLg8syZWXIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMfdo6I9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMfdo6I9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAE2BC32781;
	Mon,  1 Jul 2024 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719845523;
	bh=6iOMRTWMwN1CICgLmdW6RtuLUZr17rQ71VUnU3x2zpY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LMfdo6I9JWc4HGDB3nuJGkWHp6k+u4J9fp79lM/Q4NJgd14S4wNEK81rkjcZAuvc7
	 aBpCJIlArSyKlU8rVjZJvEvp/P61I46cHQfLIRdJpaaj7RCFz/XUoh9MVXKhUX2Y3h
	 futpBL6AYxFQQRhTpwQJ44pNdAp6Hi7ZH5xK8UBtrF9IYhkrEW2ujILMY6D9xsSbdq
	 g4kbs0knkhorFLY2U9FluJ255kztow3Vs9d8nSvc3QPPpMhi2gqa8Qlbv6C/YaO1MK
	 bAgSaCop1x9aMxJrfhAgKXBAQ04HBswhQA1vxDrZI5E2U5hNEetIcF9rg0q6TaSbCS
	 pzSGii8J045Xg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5915C3065D;
	Mon,  1 Jul 2024 14:52:02 +0000 (UTC)
From: Daniel Gomez via B4 Relay <devnull+da.gomez.samsung.com@kernel.org>
Date: Sun, 30 Jun 2024 23:52:41 +0200
Subject: [PATCH v2 2/5] common/rc: add recreation support for tmpfs
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240630-common-fixes-v2-2-16d26fb1dee0@samsung.com>
References: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com>
In-Reply-To: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com>
To: fstests@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@redhat.com>, 
 mcgrof@kernel.org, gost.dev@samsung.com, 
 Samsung Samsung <"Daniel Gomez d+samsung"@kruces.com>, 
 Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719784382; l=514;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=NED506XPkdb3zAZGDWJkQ1ARWG9uUpz/0FpeqV97NdA=;
 b=aPBqOoxZ6flCITUcxmd7dJJFfjq+wEpbQWzMi6IVc43UoJuYHYFA4+rK8mSvyu2cmGTpvEncF
 w7gyh1pe+DTAq7eSG/9kXn22939pMx6eryhPQtv8MLqIo4Mx7WQr9G7
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
X-Endpoint-Received: by B4 Relay for da.gomez@samsung.com/20240621 with
 auth_id=175
X-Original-From: Daniel Gomez <da.gomez@samsung.com>
Reply-To: da.gomez@samsung.com

From: Daniel Gomez <da.gomez@samsung.com>

Add support for test device recreation (RECREATE_TEST_DEV=true) for
tmpfs.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index 163041fea..51827119c 100644
--- a/common/rc
+++ b/common/rc
@@ -604,6 +604,9 @@ _test_mkfs()
     pvfs2)
 	# do nothing for pvfs2
 	;;
+	tmpfs)
+	# do nothing for tmpfs
+	;;
     udf)
         $MKFS_UDF_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
 	;;

-- 
2.43.0


