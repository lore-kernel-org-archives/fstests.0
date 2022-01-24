Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFBCC433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Jan 2022 11:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiAXLKy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Jan 2022 06:10:54 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4130 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237216AbiAXLKx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jan 2022 06:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643022654; x=1674558654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TUe9FJuEf7BWKrxSIxqPYK0eG0nCVdO3BScCuHtRrAI=;
  b=hbey1VtwkjN+htkpI+dsTeQH149E7EHnqhXW3X4dCzZoXVKrXunH28LN
   tL0AyILeEmwkBduepMfOIqGKYyny9FKYyR+LhBzkcf4iawkmlDuT/lltT
   qvTPmwgOmctOQHg85UXaMbRtlCNinbsZrrPyiQ3Oye9HtuJMq17T+qpaO
   we0/oAzNJlwOBXG1XQCbEjtIB+mZt311OMp9QeQABUkT1sSfLoK8yYBbk
   FWzhQNXPIpFXLDlboFiY8efDp3ER4icuj14Yx0wMM5aRvcZ7yCFoxpjiX
   t92THNuMt6fbQaEBITw8LUZdc39aA0eGGo5I9Tra72V5MwG3N5aIuh4IK
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,311,1635177600"; 
   d="scan'208";a="192220955"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2022 19:10:54 +0800
IronPort-SDR: Zo8RTylqOOIKfuc1oO4gjaPbgU1WP4cqSfLshqkMmiuxrLLe+0iXmBVKGRf5YeNd81+jO3+acm
 Fnsvx+RalfFsHyTiqYwLb6xKdNzfQLPNR2PJIHqAYAnC+i56Vbc5pXnOqFkA02R2uWJvhQ4SnZ
 q6q+3cih1M6B2QzKuXbm64y9dS2dpMMTSmMWYxRhiYj3EShrVI4uD6nmdPdtbLTHkZO837Bage
 xgzYIwFh/BgVu0CXHNB5CO4uqSUWRugkFGPFIkx+Kx6AMAXbJNrg3aCLe5L715UX6+1UNXTnet
 Fs26C5gk1yYqyVKDDZdN0EnO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 02:44:16 -0800
IronPort-SDR: VZaYk0JC4/LEkEfhJiazXigsG5Y3WrldW3iwK36g8rPED8xE1M9kugifVewQdd7wJizgAC3LSQ
 awrbwXvYCFt9yT/7IRZRbq9toPZ9Ph1+NvJxP1aobO/fF9pdCu/OSXSPP+WFJmITtqWNUw7SAH
 /I5ctWecyk897P4+5QAdgUoJUvCoIuFvxusYsnbdZ+TswKe59E18toiSlMGvAsF+tDEP0qmmwN
 c/JyjOxVsRsXeyjXbbKwU/9Hq+M6AzKKC/jfQT7+1hw2PzeXuaezQFrNo03anYXpqCyLOVkeZF
 T9c=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Jan 2022 03:10:52 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 1/7] common/rc: fix btrfs mixed mode usage in _scratch_mkfs_sized
Date:   Mon, 24 Jan 2022 20:10:44 +0900
Message-Id: <20220124111050.183628-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124111050.183628-1-shinichiro.kawasaki@wdc.com>
References: <20220124111050.183628-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The helper function _scratch_mkfs_sized needs a couple of improvements
for btrfs. At first, the function adds --mixed option to mkfs.btrfs when
the filesystem size is smaller then 256MiB, but this threshold is no
longer correct and it should be 109MiB. Secondly, the --mixed option
shall not be specified to mkfs.btrfs for zoned devices, since zoned
devices does not allow mixing metadata blocks and data blocks.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index b3289de9..eb2493d1 100644
--- a/common/rc
+++ b/common/rc
@@ -1075,10 +1075,10 @@ _scratch_mkfs_sized()
 		;;
 	btrfs)
 		local mixed_opt=
-		# minimum size that's needed without the mixed option.
-		# Ref: btrfs-prog: btrfs_min_dev_size()
-		# Non mixed mode is also the default option.
-		(( fssize < $((256 * 1024 *1024)) )) && mixed_opt='--mixed'
+		# Mixed option is required when the filesystem size is small and
+		# the device is not zoned. Ref: btrfs-progs: btrfs_min_dev_size()
+		(( fssize < $((109 * 1024 * 1024)) )) &&
+			! _scratch_btrfs_is_zoned && mixed_opt='--mixed'
 		$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
 		;;
 	jfs)
-- 
2.34.1

