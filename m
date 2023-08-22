Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C85FEE4993
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Aug 2023 07:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjHVHaO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Aug 2023 03:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjHVHaL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Aug 2023 03:30:11 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9E7186
        for <fstests@vger.kernel.org>; Tue, 22 Aug 2023 00:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692689408; x=1724225408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uL328NY7PVBEuDr5qiw/CJXQmy59bQVW39cyVH+jfFc=;
  b=kt1BFU2dFTp7abwpN+S8742YHV9RUYLtkQCtowSMkAgv97Z3Wz+S+ai2
   /Llwhosf2m1Aw6qKz/GPG8kyYXZV8BNvZpimTS8qwBkcWoMCBc4iKcTml
   iz8J8nJMKZLPOq9mdXC4zUlRFrm6+8A2y/XPl9e3DuE9kohVP/OgLKn0S
   KlFMg7V3HZA5X7gzpEP2uA8yYWlPDs1ZNElm+Q31AxELWVmC2e5D87beP
   ducWFHVUbqymg1WmLQIrKLnCPJX9gitBq7p8awql7mowpyCzm6fS0vvrp
   RujgjjQVSI3ZZ612Uq3XchdicaWYjpnAvzkC/GMduoYF9S0GwNhO5xdJ3
   w==;
X-IronPort-AV: E=Sophos;i="6.01,192,1684771200"; 
   d="scan'208";a="240045034"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2023 15:30:08 +0800
IronPort-SDR: D4uccoPn4QpKCrqIHn3/pVLj20uaqwz7BQl2mUncEtQP2uK/Hi1m+baWhM0tAlnoRYzbXXDNGK
 vzm91zG6YvTd8xARBdCmmp0Qetoolhb6OmjgAvBklT3Xh7/D3C5S9yPdi4yF/ichK8P5pRhKk1
 CfqnQBSWnOHp+ksujg3bf06mTWpuBXRQe6hbKGpxj9KmEdOwDiziQr32TYjqSo4sDBnSDGBRQC
 KiXgn0SG5fhRGp8TnUk71Gbd5XS+gdUdEyp6SZjF3VwPdW7Shd2ZeX6lIXE6QjyhazMX1uXqVk
 +os=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2023 23:43:18 -0700
IronPort-SDR: OL0Qc45GI/lv3CLqFuPODhFfPxHbSq7KQMauFp94Ab3g0Xszw5NkTrU0vTFllne6026WHzOhHB
 QxwwkzmHDDLEjwjVkgGiKBZL5NLLAmQz9Z7u+1/CAiNl0pph0LSkHLZkkiEZE3eYssdiaOP2UG
 atsOgefNEsHdwPnkVB1sk9hV0TnjXBIngHo50rMbFo/UA2fnaFFdfwLTT8z5AvHJhI5SPwKk9o
 48h16iNb0h5WQwTFgp7ClQ4iGnJraqAOky3IZlegIITVFZb5zggtZWXJ38ovYzAfCJsZvzfc8a
 6t4=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Aug 2023 00:30:08 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/3] generic/551: improve error reporting and handling
Date:   Tue, 22 Aug 2023 16:28:49 +0900
Message-ID: <cover.1692688971.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When generic/551 failed, it is difficult to investigate the root cause
because (1) it continues working after an error, corrupting the disk state,
(2) there is no detail info printed, and (3) aio-dio-write-verify failed to
check the event errors.

So, this series addresses these issues.

Naohiro Aota (3):
  aio-dio-write-verify: check for the IO errors
  aio-dio-write-verify: print more info on the error case
  generic/551: bail out test if aio-dio-write-verify failed

 src/aio-dio-regress/aio-dio-write-verify.c | 17 ++++++++++++++---
 tests/generic/551                          |  6 ++++--
 2 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.41.0

