Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D631C433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Sep 2021 08:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2589B61155
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Sep 2021 08:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348212AbhIHIi1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Sep 2021 04:38:27 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21649 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348087AbhIHIi1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Sep 2021 04:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631090239; x=1662626239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jI559oOxWQ5A5QCbMq+iuxgSJhyw/Ttb4fecz/61RoQ=;
  b=W6uPIzut0HXH+eW/N3zX0uUEO3sktJE8A1AsuBzukpsrqJ2lVRzGkKQG
   Vz6ba7KbHfgBobG9Sz9j3nT6EQ0BlxExji1StObmIfq1UR7Yv0g58owCw
   iXCx+T1xcazk+ibQhLaFqPEGwOkePon0ZgWUo45NnQijCrPQQvlkiRoSg
   T1h+1dNnWgTUUBzJMM3I7pfaq/0wYFqR3iDicjyoLrW85DWDPTfEHpWi9
   KR11k8KEaURCBE8iBib++9aWlz7ZYW+WiolbIu2u/eBXXDiMtBbwjkhr4
   zISvWMRRZlcWUJZuJ7pWdXvBYRqfcY5JwceW95J4qsWGOlZCa0w7sGxPG
   w==;
X-IronPort-AV: E=Sophos;i="5.85,277,1624291200"; 
   d="scan'208";a="291070125"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2021 16:37:19 +0800
IronPort-SDR: NKYgN84jE4CEFwLNqBiPWxZhsBJNukr/JT0gwKsJb6Ede8h/74zi8NtoiUrJRFw644wdlXstLI
 YN3V/FW4YgRA/63+kMDVCawM2sE1rA54+10/9EcnJze1zNNhUMnfo4Nrl49KH0JiCgGWMDMstq
 U0z9iK1h7vKgb0i49flTgjpQtCt2JlfsjvuZRTZK4+Iwre/MJmjzsxC7BWbL1L/tL1eSYq4Q33
 o14M6qsHxLZEdqfBwxegKVwgf2IfD5O8QposeupcbePkSqmaSVsV6/V87wAq3G9iGiDE7cPPVH
 riNmmpMFvvvImQi2/KhDQMza
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 01:13:56 -0700
IronPort-SDR: +G3fOFsCDBeDHpkR5P1aatEjrr8Mt9N/jg1y/9ikfuhQvGWBSUHb/ayW0XEEOdbAz1kkTsv5ee
 KCuUMhH9LJqEIkDYO4gcue1KFSGU/4HeY+TGwk7QWKo9SDulyoUpbKkaSstCQYOjbt0wARptsT
 5KR/NuCrUVNuzI6d1x5+mG8gwM+F+KLy7TBJY751cL2l7y/VTavYiD4EjhoL2Co67snKd5uOpT
 AZuqnt+K9AE2Y1+8WaK9vjz7P30aymG5E6HXr5cYLddZmFuswSe6C0LKrjYYWwZEc74Oa7g/t8
 uUk=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Sep 2021 01:37:19 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 2/3] btrfs/146: Add _require_scratch_dev_pool before _require_dm_target
Date:   Wed,  8 Sep 2021 17:37:14 +0900
Message-Id: <20210908083715.1831067-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908083715.1831067-1-shinichiro.kawasaki@wdc.com>
References: <20210908083715.1831067-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The test case btrfs/146 calls _require_dm_target which depends on
SCRATCH_DEV. The test case assumes that valid devices are set in
SCRATCH_DEV_POOL, and one of the devices is propagated to SCRATCH_DEV.
However, when SCRATCH_DEV_POOL is not set, valid value is not propagated
to SCRATCH_DEV and _require_dm_target causes unexpected test case
failure. To avoid the failure, add _require_scratch_dev_pool call before
_require_dm_target call to detect invalid SCRATCH_DEV_POOL beforehand.

Of note is that the test case replaces SCRATCH_DEV_POOL value internally
and calls _require_scratch_dev_pool for the replaced SCRATCH_DEV_POOL.
With this fix, the test case will call _require_scratch_dev_pool twice
for the original SCRATCH_DEV_POOL and the replaced SCRATCH_DEV_POOL.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/btrfs/146 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/btrfs/146 b/tests/btrfs/146
index 64c3513f..eee1a286 100755
--- a/tests/btrfs/146
+++ b/tests/btrfs/146
@@ -26,6 +26,7 @@ _cleanup()
 
 # real QA test starts here
 _supported_fs btrfs
+_require_scratch_dev_pool
 _require_dm_target error
 _require_test_program fsync-err
 _require_test_program dmerror
-- 
2.31.1

