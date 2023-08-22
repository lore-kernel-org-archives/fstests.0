Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1828EE49A8
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Aug 2023 07:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjHVHaQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Aug 2023 03:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjHVHaL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Aug 2023 03:30:11 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0249919E
        for <fstests@vger.kernel.org>; Tue, 22 Aug 2023 00:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692689410; x=1724225410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+LHgde+NARKxsljIznK+Pf/Lfxji6/IdOHuAcQ55oU=;
  b=XRrSZ34TR6RpB55SEA7oWWtD86T0gpkJCmeUdj5tp7DwBiyyWnSIbZ30
   tE3zlvQZa+VVEuGOPlw2xzVqErLkR86diVZIBB+xZRYld5ltCcGcKZQ88
   xXpTx6K7M/e4D1XnwX7G7mgtpHPIaTSweO7D67JgkBo58GRANSiHTfwg7
   fgiO0Rmu0I1Db3zdiPLZq15D8UhpkyDm5YIDF/+gdBob/s6hel3UUqQhE
   HCZu2PD3jmLFLXMlscDphAJHkmQdTpORLA6oi8viN6wDwhFlXuOJNeVSW
   OitNZ3ARiWj04ZmgDfHrI32qx9RYAWmdoySFD1Jrkjb33W9cdXwADufu7
   A==;
X-IronPort-AV: E=Sophos;i="6.01,192,1684771200"; 
   d="scan'208";a="240045035"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2023 15:30:09 +0800
IronPort-SDR: b1vm5jONA1Xj9b1ZnWHtuxKdBze2fdNF1gwYltGLsqghxyTRcBO776HaagJTBioU8YEtBVjMsA
 QPsXH5BTcb394TsXcF15zyGfttCFP1A/zpOT3HWkSUJ16l09RXyXDDqr2GDrMmm9lcqcLQ0uaB
 /oECM8FOHTNI9+e1fMNIL74RVbUkd9cN58bEJAN4jkqC13DQrsXX65zvt927d3+AcOePbTjdX/
 +goLrpGFuC6sV87SkU+C2nsKWSUhGW7XrieU5NMHn8Wf+DM0seLH83eaOhU72q6GeNyDwz4p3z
 r3U=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2023 23:43:19 -0700
IronPort-SDR: yTaJ9tTu6xHdqb5KLRHsEMmfH9ZS1B4p4WXzaeRjSGPdoveYQ+XtziwbRL7wC+oMlTEWUhRYSI
 iEdP6Ep58XCYX9tY47Pp5j1fQFdZs0iEud7VzY46AWaL+1jWOYXT5lQ9vFEfjxPxyEpPdW5/T+
 9klbc2ygRXMssJLUF63PIACze2A8cF61OEEROX90aH1/2rIUPg3SwviYsGcJmUMRsCZsOsWc3O
 /Cbbnd0A8CHAiQWK7TvIK+Z8EbkjnVbjKxHki/cUdYUOvVQ3LhwwijqD4yh9I+YjvwuhbXhin9
 vSw=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Aug 2023 00:30:09 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/3] aio-dio-write-verify: check for the IO errors
Date:   Tue, 22 Aug 2023 16:28:50 +0900
Message-ID: <2c9519c024e39b6eb4a3bb93f448752cedd83894.1692688971.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692688971.git.naohiro.aota@wdc.com>
References: <cover.1692688971.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The async write IOs can return some errors, which may lead to a short read or
corruption in io_verify() stage. Catch an error early to identify the root
cause easily.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 src/aio-dio-regress/aio-dio-write-verify.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/aio-dio-regress/aio-dio-write-verify.c b/src/aio-dio-regress/aio-dio-write-verify.c
index 302b8fe4a096..90e41b391289 100644
--- a/src/aio-dio-regress/aio-dio-write-verify.c
+++ b/src/aio-dio-regress/aio-dio-write-verify.c
@@ -238,6 +238,16 @@ static int io_write(int fd, int num_events)
 		return 1;
 	}
 
+	for (i = 0; i < num_events; i++) {
+		int err = (int)evs[i].res;
+
+		if (err < 0) {
+			fprintf(stderr, "error %s with event %d\n",
+				strerror(err), i);
+			return 1;
+		}
+	}
+
 	/* Try to destroy at here, not necessary, so don't check result */
 	io_destroy(ctx);
 
-- 
2.41.0

