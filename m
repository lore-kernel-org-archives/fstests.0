Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F70EE4996
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Aug 2023 07:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjHVHaQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Aug 2023 03:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjHVHaL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Aug 2023 03:30:11 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362241A4
        for <fstests@vger.kernel.org>; Tue, 22 Aug 2023 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692689410; x=1724225410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qW3UAh4oWyl/SuF7S9j0SYeqPgY1o5OWeATmM40Nk2o=;
  b=kvqPIa+3POotvKMu8/3ANzJ4DodTYZ4d0wEJGJ2xfLhTcNlaXAeENtBY
   JZHpzm9CxsJQu0V7GPlUp1NSpqbFU9g49dv2jmI2JuXhX+yw7QZRjpnNZ
   PZ/x7Cv8uUjyyoGZouUzgelru0PNsU/hjDzQ0j3L6Hprp4pBaoS/yV2Ok
   HdWAns0tPWCWtjnB7lGt5oULTh9CEi+HgWTOy1NzZD6IqxA8TTW5gZfjE
   now1Cb+5njD2He1dPG6dt+WTUReaVKlWzMGuWmOyj6VxmDRYyC2uspzQR
   C8zDWdeDAKEVDDjXTNP6GLHazWuCFj5Rve6EWpMe4q4RnmXKEvLb9HJi2
   g==;
X-IronPort-AV: E=Sophos;i="6.01,192,1684771200"; 
   d="scan'208";a="240045036"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2023 15:30:09 +0800
IronPort-SDR: uajNENFckGZCxgv/hFrv/bb2JujdCRYMGgeEUPIR7l2i6VJ2EcTP0gw77LWddoEk3Qz1256mic
 MWDR0FMOdhRCU3t813MmEPYGoHe2rpkj9857Q2ry+y30PPKXi77cJvx5Arqr7TTstXaZN0Ssms
 v+a7AmnAj0fjMy0rC+eXRwucQ0dOJdUnBOdkpCC71uIcO8PFeNXKN5xl0w4cNnztqH/9BJRe/q
 Q81gT22jEjA8rNtaw/3sIeqZ8tn2eoe6F19Laq10HDllBBFvnHJmKBWyPkR4xdedMkBVX6wF5q
 prw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2023 23:43:20 -0700
IronPort-SDR: ozjBhnx6yz9nxoVOVk/N/MwHOh66Y+M6FAY77+sc8RZJzjM4HnIrM4OYk5sLdlsbdjBCCqjKdQ
 cnRKdWgz+CyF2VfvMNv6AewnneylbrCIP81m/aeoJD0gh53E4F85BrdtZEOOmEY28Um2nQoD4f
 f3oG2iHIVZ+6hOKUkpmFnEQcdmPkf99Zr0eqmQ10sBb1URXoYjow2hJZ6XwP7ZoYnsNQSX38Ga
 zGoMUkhmF2p2TNoPKmvioB/njDyBBDDMNnwuiH4HOUTeqhgF/kgr7VxbHDNeLV4T8JHTc3s14j
 u7M=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Aug 2023 00:30:10 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/3] aio-dio-write-verify: print more info on the error case
Date:   Tue, 22 Aug 2023 16:28:51 +0900
Message-ID: <e4d570e6f5c0e5da4824d196810fd7d56e0cc393.1692688971.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692688971.git.naohiro.aota@wdc.com>
References: <cover.1692688971.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When short read or corruption happened, it is difficult to locate which IO
event failed. Print the address to make it identifiable.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 src/aio-dio-regress/aio-dio-write-verify.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/aio-dio-regress/aio-dio-write-verify.c b/src/aio-dio-regress/aio-dio-write-verify.c
index 90e41b391289..dabbfacde3f8 100644
--- a/src/aio-dio-regress/aio-dio-write-verify.c
+++ b/src/aio-dio-regress/aio-dio-write-verify.c
@@ -267,13 +267,14 @@ static int io_verify(int fd)
 			perror("pread");
 			return 1;
 		} else if (sret != p->param->buf_size) {
-			fprintf(stderr, "short read %zd was less than %zu\n",
-			        sret, p->param->buf_size);
+			fprintf(stderr, "short read %zd was less than %zu at %zu\n",
+			        sret, p->param->buf_size, p->param->offset);
 			return 1;
 		}
 		if (memcmp(p->param->buf,
 		           p->param->cmp_buf, p->param->buf_size)) {
-			printf("Find corruption\n");
+			printf("Find corruption at %zu length %zu\n", p->param->offset,
+			       p->param->buf_size);
 			dump_buffer(p->param->buf, p->param->offset,
 			            p->param->buf_size);
 			corrupted++;
-- 
2.41.0

