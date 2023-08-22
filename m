Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACECEE49AC
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Aug 2023 07:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjHVHaQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Aug 2023 03:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjHVHaN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Aug 2023 03:30:13 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F112132
        for <fstests@vger.kernel.org>; Tue, 22 Aug 2023 00:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692689411; x=1724225411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nID1n2RgGWOjjqK3F/9xfo2uvrhIvcdw2axqFf1HudY=;
  b=bciIL+pzSlmxDqu6JW/Hhy5+qZr5z6du713NStmHso5rSfM0NhZuuMLs
   4bkUar3oOqFWbMzCTGdxCoY8zs9CvbBePhAmTDu6Ftl5IfjRqXnSlgSg7
   w2D/cYpodl7bpnuISFQ9QtvfLu4PoWfhbWL7rtZjBtjxOF1bWI8EbC7cH
   PRZftJRiV5VmgnZ2jrMQowRroxTohOO9Il0ziJNydpM5gWR+9aAs5pMse
   h9BaCQHgHvVjk89KS+2DJ1b7ut9JBfmejLEfvGqy9RgYXwgoFwNXPEZa3
   /Bu+W1S+K478A1KTJ+VxubXgKm27qA6RLyrAYG6jTra52CWLTNjn5BGRY
   w==;
X-IronPort-AV: E=Sophos;i="6.01,192,1684771200"; 
   d="scan'208";a="240045038"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2023 15:30:10 +0800
IronPort-SDR: gKVq02BlCbpjdha8Wa6/lqUDmDUHcluzDzWzsXsG/jgwPb5ytkIwe45NKOK952grWmUeStpSTW
 pujl8Zx+HaFqIOmFfruHkaFJaP8dtoHBmp4t/eBqJKRjB/YE4rTeozffsWFBTtnqCnvZdUNFNq
 iy9ftFOhlknWAnod1JzEwT2qyUGi3qdKEHYc5ORy9txLEj5m5v/eOrePi80tKrq9nICJWhn0Od
 y9aYa6+camvmlO7V3dSe2Q7wrC/G6uR0rLHWZRWGqLAKuyT0Mw9Cx02IcBENcf7pLRVq5nmQRa
 K/o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2023 23:43:20 -0700
IronPort-SDR: HRAYuHY1STQMocAgxcHfob+1FOzXB917v05mqTuyegjw4K1bOP1V4gokMaDX5wlmPAgciJMJQd
 HBh9i2T0BwUuBZpR21qltaI86q1iIueQ6XmBhPAd5xt04/bq4I00bZNY2Eq8TPT0zE1tmnRPol
 5f5Lklkiw5daeAFnLboRunLvAaPiO3IBk6yF9nQ9aUWUtwjnq+uUMIu420tgmv6zdoO2OilHII
 HwNQP6e0qXFx493uCwvmRmx3ol3dOU9n7Gk3jKIqP3ulX9YOa4ts4LPBzqkHHrct/WH+uI8oiW
 LKU=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Aug 2023 00:30:10 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/3] generic/551: bail out test if aio-dio-write-verify failed
Date:   Tue, 22 Aug 2023 16:28:52 +0900
Message-ID: <5054cad7e003bfc51bcc3ecd7ba39e389375a6f5.1692688971.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692688971.git.naohiro.aota@wdc.com>
References: <cover.1692688971.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When the AIO program failed, it is better to bail out the test to keep the
failed state intact.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/generic/551 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/generic/551 b/tests/generic/551
index 2689270aa3dd..58c7f9a516c7 100755
--- a/tests/generic/551
+++ b/tests/generic/551
@@ -56,16 +56,18 @@ do_test()
 	truncsize=$(((RANDOM * diosize + RANDOM % diosize) % max_io_size_b))
 
 	$AIO_TEST -t $truncsize $oper_list $localfile
-	if [ $? -ne 0 ];then
+	ret=$?
+	if [ $ret -ne 0 ];then
 		echo "$AIO_TEST -t $truncsize $oper_list $localfile"
 		echo "==========^^ Fail ^^=========="
 	fi
+	return $ret
 }
 
 testimes=$((LOAD_FACTOR * 100))
 while [ $testimes -gt 0 ]; do
 	echo > $localfile
-	do_test
+	do_test || break
 	((testimes--))
 done
 
-- 
2.41.0

