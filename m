Return-Path: <SRS0=3sLM=AM=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86750C433DF
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jul 2020 04:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602A82073E
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jul 2020 04:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgGAEoV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:44:21 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41305 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725862AbgGAEoV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jul 2020 00:44:21 -0400
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; 
   d="scan'208";a="95609099"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 01 Jul 2020 12:43:58 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 0CC234CE4BD0;
        Wed,  1 Jul 2020 12:33:28 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 1 Jul 2020 12:43:57 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 1 Jul 2020 12:43:56 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v4 3/6] common/rc: Remove unused _require_scratch_dax()
Date:   Wed, 1 Jul 2020 12:36:57 +0800
Message-ID: <20200701043700.6473-4-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200701043700.6473-1-yangx.jy@cn.fujitsu.com>
References: <20200701043700.6473-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 0CC234CE4BD0.ADF74
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
index 09b1175d..929ff6c4 100644
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



