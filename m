Return-Path: <SRS0=/sVf=2C=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC00C43603
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Dec 2019 03:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79378214D8
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Dec 2019 03:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AQ2RtXfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfLLDMB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 Dec 2019 22:12:01 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23982 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfLLDMA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Dec 2019 22:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576120327; x=1607656327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jjp/yZ1MTAPxxCDvrDk1glK+sVxgdkwnsNldO5LMQAA=;
  b=AQ2RtXfXaWqMQFHVPjpwWKKokIWL7VACFbR6RVwU83AX9dGsqbkih33W
   BVNhBP7RpZcEBpzGa2iqXJOuYj1WpiqUdOdrOvYcVh4bdqWJWWFHTKuNn
   uCB8i7fefCXqvZ/9rCM28PBpzOoXB6uWEgj4x0fSXU9DZtsRljrNGkBbZ
   gouFj+uqeXY/ETxoZgMFTZaPkyUr5APiGgjl9aXhBa70ViiAq9So7061P
   yJyYlHA9ByqYYKrG89/mah7Mmfm+yAjaCKHEYwulL7LopgYwtUkkqLdMq
   VU4rJ38laL3QdzzvlWOLT1cdIWcRkagL4egUm/VAHI/UlZkBqOocVk8Eq
   A==;
IronPort-SDR: cxMD6NkaJKRc7RZWmvUzjINCgiMbUVdwnmBHOvh6NL5p00gLk5ZrJP8LMiZpVgP1z/XP9sS18q
 XMNL0I+EdAITIywnHPZ/qBvOeHOLrnPXsGxCMvZ4pqZSeP2ii87Yr6WRUisrRhrY8zEwHq28ad
 u7KjSQSqEK5ex1aqAprb+Wak8dph9POeUH1UhziJy6liWD9LxdVO5V+3lBweBxlIrLnMEoJJ9K
 dqrD2wv2jyKkoiqe/6nLEz5PT2YPL+qV9CTpFHmRsGvJBdWykhpNTh3vjYe4Cx0j6Sb1g87Oy9
 cqQ=
X-IronPort-AV: E=Sophos;i="5.69,304,1571673600"; 
   d="scan'208";a="226668830"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2019 11:12:06 +0800
IronPort-SDR: LWvDwbJJtf+ZPZukqF/aco/riK00CDp4b4uXu2twEuZhqwPpNkeoAiilO+ZOTRpvEtVPVbsqo8
 7HGhBQ5XGtSijOGVnnxJOVTCJkCfGkIcX9JpVwoFHoqrr85zpTCbCRbDCze2U5lsG8HCH46gF2
 iQzODbojaiUPads8EmqwOTnWdNkdexJyUnldUyIqqesqjX7hrp+hxKQpgKv/Fif2ERR5XT62Mb
 vVITluIxPYSzDDyltZyvAyroUU1K412A9jL04Q4tFlaMNPr6iwlQE96dDfphx+ZgXdA61aEhDr
 kSsC3b95zVS4jrFGGLvSsuMc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 19:06:33 -0800
IronPort-SDR: IqNbjB019MfQwHnDpbKz7gdvkjGtU8Ig2TVTyj5xVa95f6uNCVP9iJEJQlyZgI3/0wkC9fFFmM
 sQXwPzxgarb89wOyZBp01Jm5fWSHNT+twrbDSABZZWI3miZWXfgWFFAZNdtlrJlLCKvmyLUx/L
 yUzNDoQbRkbbF9uV47iHhYG/bkV/gHITzfdbFJ+RvcrPePkijR8RjhzjRVju4dCynBxFg0EwKL
 CnbEsRxynPnllP7t4L+VyUNNIgIYYAivgtoyNpY+jlqNxdSnNsjz5Uy9ntbnSIMj3zufNwjQyx
 z5I=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Dec 2019 19:12:00 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] common/filter: prepend 0 to treat offset as octal
Date:   Thu, 12 Dec 2019 12:11:52 +0900
Message-Id: <20191212031152.1906287-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The offsets printed by "od" are octal numbers. So, we need to add "0" at
the head of the $offset to parse it as an octal number.

Fixes: 37520a314bd4 ("fstests: Don't use gawk's strtonum")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/filter | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/filter b/common/filter
index 6140e58368d7..88fcb6ef68ee 100644
--- a/common/filter
+++ b/common/filter
@@ -495,7 +495,7 @@ _filter_od()
 		fi
 
 		offset="${line%% *}"
-		printf '%o%s\n' $((offset / BLOCK_SIZE)) "${line#$offset}"
+		printf '%o%s\n' $(("0$offset" / BLOCK_SIZE)) "${line#$offset}"
 	done
 }
 
-- 
2.24.0

