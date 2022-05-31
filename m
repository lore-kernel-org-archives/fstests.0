Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEC0C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 31 May 2022 07:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbiEaHTM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 May 2022 03:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbiEaHTL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 May 2022 03:19:11 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BF1E8B089
        for <fstests@vger.kernel.org>; Tue, 31 May 2022 00:19:09 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AAnPUgql94tj5QYT1pw3JUF3o5gycJERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzJRyWtOXGmDaKnYY2XyL49wOdjko0oE65TUn9JjTlNq+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuiJQUVUj/nSHOKmULe?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZzNRQpJD2R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeyTh6JPMlxSun3zEhq8G4FsNFYMD5utsHXp?=
 =?us-ascii?q?m6/MVMnYOYwqFiubwx6i0ItSALOxLwNLDZdtZ4y8/i2qCS6tOfHwKeI2Sjfcw4?=
 =?us-ascii?q?dv6rpkm8S7iWvck?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Akbi+4arE3GC7QNj63gBJf8IaV5oXeYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG+c536faaslgssQ4b8+xoVJPgfZq+z+8R3WByB8bAYOCOgg?=
 =?us-ascii?q?LBQ72KhrGSoQEIdRefysdtkY9kc4VbTOb7FEVGi6/BizWQIpINx8am/cmT6dvj?=
 =?us-ascii?q?8w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124617701"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 May 2022 15:19:08 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 85E454D17172
        for <fstests@vger.kernel.org>; Tue, 31 May 2022 15:19:06 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 31 May 2022 15:19:06 +0800
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 31 May 2022 15:19:06 +0800
Received: from fedora.g08.fujitsu.local (10.167.223.71) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 31 May 2022 15:19:05 +0800
From:   Liu Yiding <liuyd.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Liu Yiding <liuyd.fnst@fujitsu.com>
Subject: [PATCH] common/rc: Fix _require_batched_discard to skip test correctly
Date:   Tue, 31 May 2022 15:12:52 +0800
Message-ID: <20220531071252.30517-1-liuyd.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 85E454D17172.AD59E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: liuyd.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

xfstest commit ee264b3f ("common/rc: Modify _require_batched_discard to
improve test coverage") changed the way of determing if discard is
supported by checking whether fstrim output contains "not supported"
keywords.

On RHEL, fstrim output below info when discard is not supported
"fstrim: /mnt/share0/: FITRIM ioctl failed: Function not implemented"

Supplyment unsupported keywords to _require_batched_discard.

Signed-off-by: Liu Yiding <liuyd.fnst@fujitsu.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 70a15f9c..eae9afc6 100644
--- a/common/rc
+++ b/common/rc
@@ -4008,7 +4008,7 @@ _require_batched_discard()
 	fi
 	_require_fstrim
 
-	grep -q "not supported" <($FSTRIM_PROG $1 2>&1)
+	grep -q -E "not supported|not implemented" <($FSTRIM_PROG $1 2>&1)
 	if [ "$?" = "0" ]
 	then
 		_notrun "FITRIM not supported on $1"
-- 
2.31.1



