Return-Path: <SRS0=KSdQ=YK=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F8BC4CECE
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Oct 2019 07:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706A521848
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Oct 2019 07:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408058AbfJQHTT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:19:19 -0400
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171]:63728 "EHLO
        mgwkm04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408044AbfJQHTS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Oct 2019 03:19:18 -0400
X-Greylist: delayed 668 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Oct 2019 03:19:17 EDT
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [192.168.231.132]) by mgwkm04.jp.fujitsu.com with smtp
         id 505c_9d4f_370c5b29_f3bb_47ca_9e8e_ca073d2f21a1;
        Thu, 17 Oct 2019 16:08:03 +0900
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
        by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id DA066AC0127
        for <fstests@vger.kernel.org>; Thu, 17 Oct 2019 16:07:51 +0900 (JST)
Received: from g01jpexchyt38.g01.fujitsu.local (unknown [10.128.193.4])
        by g01jpfmpwyt03.exch.g01.fujitsu.local (Postfix) with ESMTP id 1DE6B46E763
        for <fstests@vger.kernel.org>; Thu, 17 Oct 2019 16:07:51 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 g01jpexchyt38.g01.fujitsu.local (10.128.193.68) with Microsoft SMTP Server id
 14.3.439.0; Thu, 17 Oct 2019 16:07:50 +0900
From:   Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2] xfstest: Update skip condition of generic/469,499
Date:   Thu, 17 Oct 2019 16:15:22 +0900
Message-ID: <20191017071522.323-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

These test require fallocate keep size/zero range/punch hole.
Update the skip condition to avoid false negative on unsupported FS.

Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
---
 tests/generic/469 | 3 +++
 tests/generic/499 | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tests/generic/469 b/tests/generic/469
index 47fdf0cf..8a5a2483 100755
--- a/tests/generic/469
+++ b/tests/generic/469
@@ -40,6 +40,9 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_xfs_io_command "falloc" "-k"
+_require_xfs_io_command "fzero"
+_require_xfs_io_command "fpunch"
 
 run_fsx()
 {
diff --git a/tests/generic/499 b/tests/generic/499
index 773eab2e..b3363ac4 100755
--- a/tests/generic/499
+++ b/tests/generic/499
@@ -28,6 +28,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch
+_require_xfs_io_command "falloc" "-k"
 _require_xfs_io_command "fcollapse"
 _require_xfs_io_command "fzero"
 
-- 
2.21.0

