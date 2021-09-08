Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172F5C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Sep 2021 08:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00ADC6113D
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Sep 2021 08:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348281AbhIHIia (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Sep 2021 04:38:30 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21649 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348087AbhIHIi2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Sep 2021 04:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631090240; x=1662626240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xZZ0/y0TjEni4Q99AKjdi2P7L1OyvpXx+zfrLUNwk/k=;
  b=qZUmG+VmEZU74LRCMfT9vKQTfMeAl/i1+CGmNpOzDCpm6m9UXx5dRKhP
   KodgEj3m6dTzrBAJmu3epoqTERykjK6+h5JLq5nmqQpI1EiwzgEdXgpSZ
   rbRuqA0hmc7YT8soRdEu9NunHMzgnzlXgDPDbp0Zg2bO8LeKhbZlIf1Jp
   sCCvA190rWjk7em4nQK3fyPFZKWu23GaXgUIiorLhX/pn/StgBqMS7L1M
   FF72I8Wl7d+TKbjjztBWq6C94P8wEM4Gkc40LpdiEvjLzz0XCP6s9YYbR
   PguIoXgxe2onaE2Hx/gthGF25EkigBL9vrti3lzdGkU7hBzIXVC17x+3P
   A==;
X-IronPort-AV: E=Sophos;i="5.85,277,1624291200"; 
   d="scan'208";a="291070126"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2021 16:37:20 +0800
IronPort-SDR: 78HOqxLVOUHK0V2beEj8O4jKFjNXDVDuarXn/dLdsaDpYCFZp79wXzohssNv/d9tyS4urPpuc9
 M9DqOlXgYHG0ZJfiCrRRS+nGx1FUQHDDY3BvpICS2RCn+8cEc9C+FtQd7NPiWJW3L4bHPVmVPN
 LBIuc5kWB336TbrCnL4fe7CIQFggaCrsJMMavCYwK4d4WCK7sNxjOu07FDv4ODrOjOlgYd31Mo
 zRF9w0tkngyf73Q05PDccEuxOgUdcCqkl9HVuwDxVqNR9/ppmF/f+9dFJj+SXDCugtpu6ZvC1t
 8oAJG+V5WtuMcfGmkjl0oO+x
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 01:13:57 -0700
IronPort-SDR: NLAuFsiQerUbUYFaRQPk4hqyUJQYSszNt3mRBQ3Zl9uu4DUWVfKLSRuMdsXSKCelEVFG1B710A
 Ienttn+J4eNo2roZU96vXXCpuMca0p6/Rg7edGWCQJLmjcCYddNwiEP45KHPBK6+C7MBhANQHL
 kuyvIp4+3doUCVtBV6o2w7BaL68y3NZOJuD6ugGHOFE4oUDNo3Equ+yulnbe+gsT4CRVhQW3kn
 dxXMsWOJWAslWykG7AmLP3AXtbydNaL8/qKjHhACF5eyGa7RpmUe0fn5SyKNlpILv4+Gt17KwJ
 Kcc=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Sep 2021 01:37:20 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 3/3] common/rc: Check call order of _require_dm_target and _require_scratch*
Date:   Wed,  8 Sep 2021 17:37:15 +0900
Message-Id: <20210908083715.1831067-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908083715.1831067-1-shinichiro.kawasaki@wdc.com>
References: <20210908083715.1831067-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When SCRATCH_DEV is not set and the test case does not call
_require_scratch* before _require_dm_target, _require_block_device
called from _require_dm_target fails to evaluate SCRATCH_DEV and
results in the test case failure. This failure reason is not described
in the error message and it takes some time to catch.

To catch the failure reason easier, check SCRATCH_DEV in
_require_dm_target. If SCRATCH_DEV is not set, fail the test case
and print message which requests to fix call order of _require_scratch*
and _require_dm_target. This improvement follows what _scratch_shutdown
does for _require_scratch_shutdown.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index dda5da06..cbec8aaa 100644
--- a/common/rc
+++ b/common/rc
@@ -1971,6 +1971,9 @@ _require_dm_target()
 
 	# require SCRATCH_DEV to be a valid block device with sane BLKFLSBUF
 	# behaviour
+	if [ -z "$SCRATCH_DEV" ]; then
+		_fail "_require_dm_target: call _require_scratch* first in test"
+	fi
 	_require_block_device $SCRATCH_DEV
 	_require_sane_bdev_flush $SCRATCH_DEV
 	_require_command "$DMSETUP_PROG" dmsetup
-- 
2.31.1

