Return-Path: <SRS0=vVM5=AU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E72CC433DF
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Jul 2020 09:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D00F20708
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Jul 2020 09:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgGIJ4X (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:56:23 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:45168 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726340AbgGIJ4W (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Jul 2020 05:56:22 -0400
X-IronPort-AV: E=Sophos;i="5.75,331,1589212800"; 
   d="scan'208";a="95982683"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Jul 2020 17:56:20 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id A975A4CE5070;
        Thu,  9 Jul 2020 17:56:18 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 9 Jul 2020 17:56:19 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 9 Jul 2020 17:56:19 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v5 3/8] common/rc: Remove unused _require_scratch_dax()
Date:   Thu, 9 Jul 2020 17:49:12 +0800
Message-ID: <20200709094917.13923-4-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200709094917.13923-1-yangx.jy@cn.fujitsu.com>
References: <20200709094917.13923-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: A975A4CE5070.AB691
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 common/rc | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/common/rc b/common/rc
index 498ce230..3e47f935 100644
--- a/common/rc
+++ b/common/rc
@@ -3175,19 +3175,6 @@ _require_scratch_shutdown()
 }
 
 # Does dax mount option work on this dev/fs?
-_require_scratch_dax()
-{
-	_require_scratch
-	_scratch_mkfs > /dev/null 2>&1
-	_try_scratch_mount -o dax || \
-		_notrun "mount $SCRATCH_DEV with dax failed"
-	# Check options to be sure. XFS ignores dax option
-	# and goes on if dev underneath does not support dax.
-	_fs_options $SCRATCH_DEV | grep -qw "dax" || \
-		_notrun "$SCRATCH_DEV $FSTYP does not support -o dax"
-	_scratch_unmount
-}
-
 _require_scratch_dax_mountopt()
 {
 	local mountopt=$1
-- 
2.21.0



