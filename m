Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A7CC433F5
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Sep 2021 07:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1690610A3
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Sep 2021 07:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240047AbhIGHm0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Sep 2021 03:42:26 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:17427 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240073AbhIGHmZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Sep 2021 03:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631000479; x=1662536479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3KzcvPdXhnAtt9cPAgowHM5QfbW1GbV8qpnnLu3qQG0=;
  b=b3aziK6nhGIinMlXSapGq2+WF5yjJKdzfFHtLfk7GHEABXjYaJnUE9NU
   J9U3oJCTHBgJW/4EKczeAD2UIOWIM0hwqgpoI6s5sxhhWkU748ePfqEs5
   9dH9dU7SYGWgfQwGmKfhEhtPgtokxYab6SmddVVWGSI6znIc8pOfbFq3z
   JTC1OFLfD9GjjSNWCkiEqkFh4vw1EPDMHlpFhhOyiJs2j/HKQm5inusTX
   W2WxeCk0xY/juJHH2RYa6Uy//WCLeNyeKN8FkwNsnebhPqDkzMMXvrRI/
   1Un6xpO7gADDCjSWC7HxG4mvSzXZxkeo3UMYwbDA/0bE9wa1TvvBpSEKO
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,274,1624291200"; 
   d="scan'208";a="290967932"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2021 15:41:18 +0800
IronPort-SDR: VwbOWsUeRHis2N5BSD3aeuUXHz0FFX6uz7V8nDgg6vEj5ikzr1+rkvHbcncbKfN0eE9yWrX4S5
 WHw0xq6SSdzmES7+cq2IE0f89F7w6HfGGy9N+GsLD3shRDB/gt8cwZTwuTxK8Su7goP29+1gSP
 ImMFad0mZzkHfNPbZGsfAPVoOqgjWh3H9V2aS7CcTl6QKSDYue4QE26tZApBB2mG3oc6Sc1oPd
 pWz8XIuVUl7Sr9hnqUMnFiShUD3VVW9zw2V7TU8yLFbz1Rtvz0DzMl+2LE6RACYXPpvVyIEd+7
 q8JZLrZhziK0p62yw+P7oy1s
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 00:17:56 -0700
IronPort-SDR: EbhXhxoq/oGEmBeSfYnYqZUD4+Mz9nXeqWsjf2t8Okb3lc1CjWrWhIC5lFVWhQdT9mAKp/PA/L
 SopLR5CCbBo4BL2bu2dc82ZSs5MEpoMMDdQ4Gj13Fhbrt3mleLMuoOOvMMehd8wU8sW2exGWtJ
 sSxSlHSoPyEEKKtazEw4le69sN3pUoz65fPGcC0VpuJkpDP0dVi+dAfeFWk6ChYB7YoxlmBnaD
 GCPr6eb1SmUEBxFOw9HaqjREqSEVTaIAKH3fz9MLuVOZiQOrDSYRVBIs63+qzY8eLHNKNFacct
 OqA=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Sep 2021 00:41:17 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] common/rc: Check SCRATCH_DEV in _require_dm_target()
Date:   Tue,  7 Sep 2021 16:41:16 +0900
Message-Id: <20210907074116.1799114-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When SCRATCH_DEV is not set and the test case does not call
_require_scratch*() before _require_dm_target(), _require_block_device()
called from _require_dm_target() fails to evaluate SCRATCH_DEV and
results in the test case failure. This failure was observed with
generic/628 and generic/629.

To avoid the failures, check SCRATCH_DEV in _require_dm_target(). With
this change, test cases do not need to call _require_scratch*() before
_require_dm_target(). To check SCRATCH_DEV, use simple variable check
instead of _require_scratch*() helper functions, so that each test case
can choose an appropriate function from _require_scratch*().

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index dda5da06..b4966af7 100644
--- a/common/rc
+++ b/common/rc
@@ -1971,6 +1971,9 @@ _require_dm_target()
 
 	# require SCRATCH_DEV to be a valid block device with sane BLKFLSBUF
 	# behaviour
+	if [ -z "$SCRATCH_DEV" ]; then
+		_notrun "This test requires a valid \$SCRATCH_DEV for dm $target"
+	fi
 	_require_block_device $SCRATCH_DEV
 	_require_sane_bdev_flush $SCRATCH_DEV
 	_require_command "$DMSETUP_PROG" dmsetup
-- 
2.31.1

