Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37706EE57C9
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Sep 2023 05:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbjIHFqh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Sep 2023 01:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjIHFqh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Sep 2023 01:46:37 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CFA19B5
        for <fstests@vger.kernel.org>; Thu,  7 Sep 2023 22:46:32 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="130777415"
X-IronPort-AV: E=Sophos;i="6.02,236,1688396400"; 
   d="scan'208";a="130777415"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 14:46:31 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id ABD41CA1EB
        for <fstests@vger.kernel.org>; Fri,  8 Sep 2023 14:46:28 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id DFFF9BCB72
        for <fstests@vger.kernel.org>; Fri,  8 Sep 2023 14:46:27 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 42F3F4033E;
        Fri,  8 Sep 2023 14:46:27 +0900 (JST)
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     fstests@vger.kernel.org
Cc:     ruansy.fnst@fujitsu.com, Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3] tools/mvtest: ensure testcase is executable (755)
Date:   Fri,  8 Sep 2023 13:43:35 +0800
Message-ID: <20230908054335.13625-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906071349.3643040-1-ruansy.fnst@fujitsu.com>
References: <20230906071349.3643040-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27862.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27862.005
X-TMASE-Result: 10--2.951100-10.000000
X-TMASE-MatchedRID: eOGkqzLLC6otNVV5XI3AlHwsIAe4wcJG37jcLTY9yETfc2Xd6VJ+ytue
        iHTXMaT6p7UNomiOZJwuiOJZr6TrGPXNEkgZOg/OOIQ9GP2P2u/BOVz0Jwcxl6vCrG0TnfVU2d8
        mtRIRsUOtqhvfTy0XN4cR4xN9HQJ7HxPMjOKY7A/+HHE8LDNSg8RB0bsfrpPIcSqbxBgG0w5Lig
        y/6yq4elVgyVSx0dJ1PlQQXz+QxkcdSoZ2qiTUs5Du24PeoPVp8l157DL+/A4MzfQezK2b9/efs
        YyA80u3mDaH1d59Q8pbjBuldNvkMkoq97WSHdFjfupJaud1uZCfRs6uIbkFVw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Some test cases lack executable permission ('x'). Before running each
test case, `./check` checks and grants them 'x' permission. However,
this always leads to a dirty git repo. And the absence of 'x' permission
in test cases is often overlooked during reviews.

Since maintainers use mvtest to assign new case, add this change for
convenience of maintainers.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
 tools/mvtest | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/mvtest b/tools/mvtest
index 99b154142..bd4006eb2 100755
--- a/tools/mvtest
+++ b/tools/mvtest
@@ -34,6 +34,8 @@ did="$(basename "${dest}")"
 
 git mv "tests/${src}" "tests/${dest}"
 git mv "tests/${src}.out" "tests/${dest}.out"
+# make sure testcase is executable
+chmod 755 "tests/${dest}"
 sed -e "s/^# FS[[:space:]]*QA.*Test.*[0-9]\+$/# FS QA Test No. ${did}/g" -i "tests/${dest}"
 sed -e "s/^QA output created by ${sid}$/QA output created by ${did}/g" -i "tests/${dest}.out"
 sed -e "s/test-${sid}/test-${did}/g" -i "tests/${dest}.out"
-- 
2.42.0

