Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9864FC433F5
	for <linux-fstests@archiver.kernel.org>; Mon,  9 May 2022 06:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiEIGGR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 9 May 2022 02:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbiEIGB1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 May 2022 02:01:27 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3592E16A108
        for <fstests@vger.kernel.org>; Sun,  8 May 2022 22:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1652075786; i=@fujitsu.com;
        bh=dD88wXDEOd97VrA0AfVwwKIf9dVEGjiP5vDuaDwQbFM=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=d/ox0Ji+st38yh4AN6Fso6wfObgLqnrQyIglQnBuFJg0A3vjbcjM+Lf68aMuvbKLm
         /UpZRC/vJiK3JUImjN41ZdImQcnGGHX1T/TlMXwC94JWJpu3+eKYwb6StZwu9DPs2L
         eBc/Zvo4xYUTXSabvgtd1efNqUoMIQVFWfLygijAZsO0ftjx3i+W0sTPOQZxydTPIX
         xBXgNAiM3G9LKiZC8pDJh5Fi6PfGgDI+2m2epeAU7qZVEqQ06REWegz0GytO3mxEvg
         wj4eoXpZu+S6V+oHAG/FAI+PoIkSeICCrLfYHNCxC2WCtlLCQeGN2S3oTyFuPHO/ye
         SUN+SmdqHTRkg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRWlGSWpSXmKPExsViZ8MxRZdrbUW
  SwYZ2NovTLXvZHRg9Pm+SC2CMYs3MS8qvSGDNuN36kq3gElvF3GnT2BoYj7F2MXJxCAl0MEmc
  O9PIAuHsZpR4uvY9excjJwebgKbEs84FzCC2iICsxP8Zq5lAbGYBdYnlk36B2cIC9hLT77aC2
  SwCKhJXps8B6+UV8JA4/HorI4gtIaAgMeXhe2aIuKDEyZlPWCDmSEgcfPGCGaJGUeJSxzeo+g
  qJWbPamCYw8s5C0jILScsCRqZVjBZJRZnpGSW5iZk5uoYGBrqGhqa6hrpGeolVuol6qaW65an
  FJbqGeonlxXqpxcV6xZW5yTkpenmpJZsYgeGVUszItINxWd9PvUOMkhxMSqK8lU0VSUJ8Sfkp
  lRmJxRnxRaU5qcWHGGU4OJQkeN/OA8oJFqWmp1akZeYAQx0mLcHBoyTCy7caKM1bXJCYW5yZD
  pE6xWjMsbbhwF5mjo9/Lu5lFmLJy89LlRLnnQpSKgBSmlGaBzcIFoOXGGWlhHkZGRgYhHgKUo
  tyM0tQ5V8xinMwKgnzPgeZwpOZVwK37xXQKUxAp3wMKAU5pSQRISXVwORsUVqwd2vSAddPJsI
  LI881/z3/Vv9Lt+udq1kpotGuc7Yc/1w4S3Tf9gnLuJhjasUYa3oXtupnmhmwNEnfPHf+7tmA
  g3NOGWrP7Yj5413AvrZ13htPs9MfL2VOK5tdc2RtzNLDFbenzypZ//ni84BUkbvrX9V1vY4uL
  /bLs/WfYzFzi+WG1dpyK6NMInaJLp2jeU9S6+hM7mutrZkVh95f3Fd1UD4v7ZhY8nRB+cLn/y
  7KC+/6tXTFv/9Fge52J2JaJnDw2O4/qvHjo8/R50Vau9nOigt7LYydv7k+OPl8bvrBFT0rc8O
  efjlzr8QjqaZa+ath+4FYuaDlD3RO12k769ux8YQ9jQ1nmREjoqfEUpyRaKjFXFScCAAoombt
  PAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-20.tower-591.messagelabs.com!1652075785!303930!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11052 invoked from network); 9 May 2022 05:56:26 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-20.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 9 May 2022 05:56:26 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 2495uIXT017045
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Mon, 9 May 2022 06:56:25 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 9 May 2022 06:56:16 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] xfs/298: Add 100ms sleep before scratch_umount
Date:   Mon, 9 May 2022 14:56:57 +0800
Message-ID: <1652079417-2255-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When testing this case on my machine, it reports the following error:
umount: /mnt/xfstests/scratch: target is busy.
xfs_db: /dev/sda11 contains a mounted filesystem

scratch_unmount failed, so  _scratch_xfs_db reports scratch_dev is a
mounted filesystem. It seems filesystem has something to be doing.

To avoid this, just add a 100ms sleep before scratch_umount.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/xfs/298 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/xfs/298 b/tests/xfs/298
index b0153ebf..17510379 100755
--- a/tests/xfs/298
+++ b/tests/xfs/298
@@ -51,6 +51,7 @@ while [ $SIZE -lt 1024 ];do
 	rm $SYMLINK_FILE
 # umount and check the number of extents on the inode. Should be 0.
 	cd /
+	sleep 0.1
 	_scratch_unmount >/dev/null 2>&1
 	_scratch_xfs_db  -c "inode $inode" -c "p core.nextents"
 
-- 
2.23.0

