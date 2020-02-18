Return-Path: <SRS0=z/AK=4G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D657FC34031
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Feb 2020 07:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC44024125
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Feb 2020 07:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgBRHXx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:23:53 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:29088 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726318AbgBRHXx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Feb 2020 02:23:53 -0500
X-IronPort-AV: E=Sophos;i="5.70,455,1574092800"; 
   d="scan'208";a="83483584"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Feb 2020 15:23:45 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id ED25350A997A;
        Tue, 18 Feb 2020 15:14:05 +0800 (CST)
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 18 Feb 2020 15:23:42 +0800
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 18 Feb 2020 15:23:41 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <darrick.wong@oracle.com>, <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH v1 1/2] generic/054,055: add _require_v2log
Date:   Tue, 18 Feb 2020 15:24:10 +0800
Message-ID: <1582010652-1124-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: ED25350A997A.AC683
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This two case fail on my server machine with GPT disklabe type,
info as below:
mount failed: -o logbsize=32k
dmesg info as below:
[92633.871954] XFS (sda7): logbuf size must be greater than or equal to log stripe size

The min logbuf size is 256k on my server machine. It needs to use _require_v2log to check.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 common/log        | 1 +
 tests/generic/054 | 1 +
 tests/generic/055 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/common/log b/common/log
index c7921f50..f82919a6 100644
--- a/common/log
+++ b/common/log
@@ -494,6 +494,7 @@ _log_version()
 
 _require_v2log()
 {
+    [ "$FSTYP" != xfs ] && return 0
     # test out mkfs to see if it supports "-l version=2"
     export MKFS_OPTIONS="-l version=2"
     if ! _scratch_mkfs_xfs >>$seqres.full 2>&1; then
diff --git a/tests/generic/054 b/tests/generic/054
index 95d40c3c..b4b74615 100755
--- a/tests/generic/054
+++ b/tests/generic/054
@@ -30,6 +30,7 @@ rm -f $seqres.full $tmp.*
 _require_scratch
 _require_scratch_shutdown
 _require_logstate
+_require_v2log
 
 echo "*** init FS"
 _scratch_unmount >/dev/null 2>&1
diff --git a/tests/generic/055 b/tests/generic/055
index 9715f27b..071c4eaf 100755
--- a/tests/generic/055
+++ b/tests/generic/055
@@ -57,6 +57,7 @@ rm -f $seqres.full $tmp.*
 _require_scratch
 _require_scratch_shutdown
 _require_logstate
+_require_v2log
 
 QUOTA_OPTION=`_get_quota_option`
 
-- 
2.18.0



