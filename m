Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B23CC433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Sep 2021 08:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E82C61165
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Sep 2021 08:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348190AbhIHIi0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Sep 2021 04:38:26 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21649 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348087AbhIHIiZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Sep 2021 04:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631090238; x=1662626238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ncRAqpPm84LmFkYJkcgyZX64ncaVLSHOCvLsCT1gNkI=;
  b=mWhPS2XU8RfCF1vUM0GBxpr93WbtgpvO1vvHmBAnCWJOJNVmMPR1zjRE
   nDeo3CwsRqexf+X4igCdwCCySQi28vpOcHIsjc6Z28qdnltt+/tYGmIXW
   pbeQWS3j2m8TdRptRxht33wal9gtp+u/yc6bavDAS7bahbe4bWAT2t6TO
   YlMDNpFjUl4TJUetn/+Gtr5ZRHk/5qV9CgmdVyubl7XllhbrDMLO84LNB
   Qa1S+X4W4P4wT/df1UgzhzxSfKP0SpW9QKfNS0m9m07/2KZVGcLwlUd4Q
   1Ebv14jE/Rs3O6WEPezBwPBk6naQJ6UliViwIdchi89a2xHR86qgFsFh9
   w==;
X-IronPort-AV: E=Sophos;i="5.85,277,1624291200"; 
   d="scan'208";a="291070124"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2021 16:37:18 +0800
IronPort-SDR: 7m9W0dhzQcl3V3c/0v2Gbmwi6qMA5AV/4Gaf9uFoIe/TeT+7mXiTK6pnDQKrq2QVnAYzF+ybH0
 VNUXPb/xQIz6QJdivTt6eWvMnx8VQ49+OOKUuGyI0ft66jsHyyATO3nzRJe/J00eWLRjzY4EJ5
 DjhUKt3XRoW/g4brLNfzgc1NcDI1D/DOEciGQ4som3RxFcJPv6cazW2+4F8EbAvMqYOqymLrDA
 tbW3PrDgixJLpsI2vBrxLjtB6KL31o38bzJAzHzMFUyxzcMjJgcT+7nWTOXPIwjbso5JqOFXtn
 MuRrtemgsKBCSRmEQvBm/vEv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 01:13:55 -0700
IronPort-SDR: foXap7fki7GDoFHbTLGF1YSlDem/XcN7BQ8KpHRbXrv0MCjjQF+LriFgSqZhB1wJyUPUu5duRT
 lzt8aUfvpTphZlfKzWgWud0hhfhqSCTEo45sEHqV8XnHkwbAvsD+GwCisYF00MirloOqDofmPc
 73uymfIy2S7Jslz3yyiz6S6l+XB++y6OeTklDGThCsiJdQbPOfgFAHw9PaDsbVcwepwSBtUK0h
 uTgE5y9OSiA4biGWKzuPWBDg32XiAkURvxthT3NVoqd4m+bI7GocQ46usPn62oGfKq1NMXRcGV
 EYA=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Sep 2021 01:37:18 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 1/3] generic/{628,629}: Fix order of _require_scratch* and _require_dm_target
Date:   Wed,  8 Sep 2021 17:37:13 +0900
Message-Id: <20210908083715.1831067-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908083715.1831067-1-shinichiro.kawasaki@wdc.com>
References: <20210908083715.1831067-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Test cases with dm_target shall call _require_scratch* before
_require_dm_target to ensure that valid SCRATCH_DEV is available for
dm_target. However, the test cases generic/628 and generic/629 call
_require_dm_target before _require_scratch*, then unexpected failure was
reported when SCRATCH_DEV is not specified. Fix the order of function
calls.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/generic/628 | 2 +-
 tests/generic/629 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/628 b/tests/generic/628
index 2ccbbbdc..7dc6dfcd 100755
--- a/tests/generic/628
+++ b/tests/generic/628
@@ -29,8 +29,8 @@ _cleanup()
 
 # real QA test starts here
 _supported_fs generic
-_require_dm_target error
 _require_scratch_reflink
+_require_dm_target error
 _require_xfs_io_command "chattr" "s"
 _require_cp_reflink
 
diff --git a/tests/generic/629 b/tests/generic/629
index abfa90ab..f501555e 100755
--- a/tests/generic/629
+++ b/tests/generic/629
@@ -28,10 +28,10 @@ _cleanup()
 
 # real QA test starts here
 _supported_fs generic
+_require_scratch
 _require_dm_target error
 _require_xfs_io_command "chattr" "s"
 _require_xfs_io_command "copy_range"
-_require_scratch
 
 # Format filesystem and set up quota limits
 _scratch_mkfs > $seqres.full
-- 
2.31.1

