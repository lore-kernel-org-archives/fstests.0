Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6E1EC8742
	for <linux-fstests@archiver.kernel.org>; Thu,  7 Sep 2023 17:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbjIGRzB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239463AbjIGRzA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Sep 2023 13:55:00 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEBF2118
        for <fstests@vger.kernel.org>; Thu,  7 Sep 2023 10:54:31 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="119450802"
X-IronPort-AV: E=Sophos;i="6.02,235,1688396400"; 
   d="scan'208";a="119450802"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 20:37:55 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 01D9EC68E6
        for <fstests@vger.kernel.org>; Thu,  7 Sep 2023 20:37:53 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 46F58D20B6
        for <fstests@vger.kernel.org>; Thu,  7 Sep 2023 20:37:52 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.234.230])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id ABA592005019A;
        Thu,  7 Sep 2023 20:37:51 +0900 (JST)
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     fstests@vger.kernel.org
Cc:     ruansy.fnst@fujitsu.com
Subject: [PATCH v2] tools/mvtests: ensure testcase is executable (755)
Date:   Thu,  7 Sep 2023 19:35:01 +0800
Message-ID: <20230907113501.4119112-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906071349.3643040-1-ruansy.fnst@fujitsu.com>
References: <20230906071349.3643040-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27860.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27860.007
X-TMASE-Result: 10--2.951100-10.000000
X-TMASE-MatchedRID: eOGkqzLLC6otNVV5XI3AlHwsIAe4wcJG37jcLTY9yETfc2Xd6VJ+ytue
        iHTXMaT6p7UNomiOZJwuiOJZr6TrGPXNEkgZOg/OOIQ9GP2P2u/BOVz0Jwcxl6vCrG0TnfVU2d8
        mtRIRsUOtqhvfTy0XN4cR4xN9HQJ7HxPMjOKY7A/+HHE8LDNSg8RB0bsfrpPIcSqbxBgG0w4rRc
        1wwgwY2x8i6F8kPyMo/klOO5akPH6XFYGWxHeFlzIZFUXalM0W3kJ3jgIv1b/4U1X4bfU+7XCG1
        ZnXAFTkLCg2zPOLyhVbjBuldNvkMkoq97WSHdFjfupJaud1uZCfRs6uIbkFVw==
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
---
 tools/mvtest | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/mvtest b/tools/mvtest
index 99b154142..1ad775a3e 100755
--- a/tools/mvtest
+++ b/tools/mvtest
@@ -34,6 +34,8 @@ did="$(basename "${dest}")"
 
 git mv "tests/${src}" "tests/${dest}"
 git mv "tests/${src}.out" "tests/${dest}.out"
+# make sure testcase is executable
+test $(stat -c '%a' tests/${dest}) == 755 || chmod 755 "tests/${dest}"
 sed -e "s/^# FS[[:space:]]*QA.*Test.*[0-9]\+$/# FS QA Test No. ${did}/g" -i "tests/${dest}"
 sed -e "s/^QA output created by ${sid}$/QA output created by ${did}/g" -i "tests/${dest}.out"
 sed -e "s/test-${sid}/test-${did}/g" -i "tests/${dest}.out"
-- 
2.42.0

