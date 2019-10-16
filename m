Return-Path: <SRS0=dVie=YJ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4748FA3728
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Oct 2019 10:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C0821848
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Oct 2019 10:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404676AbfJPK5R (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:57:17 -0400
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40]:26105 "EHLO
        mgwym01.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfJPK5Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Oct 2019 06:57:16 -0400
X-Greylist: delayed 662 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Oct 2019 06:57:15 EDT
Received: from yt-mxoi1.gw.nic.fujitsu.com (unknown [192.168.229.67]) by mgwym01.jp.fujitsu.com with smtp
         id 1ad9_206b_f7be589f_9899_4603_a783_a176a8b0a9f7;
        Wed, 16 Oct 2019 19:46:10 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
        by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id B353CAC0130
        for <fstests@vger.kernel.org>; Wed, 16 Oct 2019 19:46:10 +0900 (JST)
Received: from G01JPEXCHKW14.g01.fujitsu.local (G01JPEXCHKW14.g01.fujitsu.local [10.0.194.53])
        by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id F0350BD676A
        for <fstests@vger.kernel.org>; Wed, 16 Oct 2019 19:46:09 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 G01JPEXCHKW14.g01.fujitsu.local (10.0.194.53) with Microsoft SMTP Server id
 14.3.439.0; Wed, 16 Oct 2019 19:46:10 +0900
From:   Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH] generic/469: Skip the test if fallocate keep_size is not supported
Date:   Wed, 16 Oct 2019 19:53:47 +0900
Message-ID: <20191016105347.16650-1-misono.tomohiro@jp.fujitsu.com>
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

This test requires fallocate keep_size. So, skip the test if
a target FS does not support the function to avoid false negative.

Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
---
 tests/generic/469 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/469 b/tests/generic/469
index 47fdf0cf..0c6f8ae5 100755
--- a/tests/generic/469
+++ b/tests/generic/469
@@ -40,6 +40,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_test
+_require_xfs_io_command "falloc" "-k"
 
 run_fsx()
 {
-- 
2.21.0

