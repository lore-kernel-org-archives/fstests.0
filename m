Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7524EB8FAD
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Sep 2023 07:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjIFHQv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 Sep 2023 03:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjIFHQu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Sep 2023 03:16:50 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68B1CE9
        for <fstests@vger.kernel.org>; Wed,  6 Sep 2023 00:16:43 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="130971083"
X-IronPort-AV: E=Sophos;i="6.02,231,1688396400"; 
   d="scan'208";a="130971083"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 16:16:42 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6A403DB3C7
        for <fstests@vger.kernel.org>; Wed,  6 Sep 2023 16:16:39 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id B28CDD3F24
        for <fstests@vger.kernel.org>; Wed,  6 Sep 2023 16:16:38 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 130976BEFF;
        Wed,  6 Sep 2023 16:16:38 +0900 (JST)
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     fstests@vger.kernel.org
Cc:     ruansy.fnst@fujitsu.com
Subject: [PATCH] tools/mvtest: ensure testcase is executable (755)
Date:   Wed,  6 Sep 2023 15:13:49 +0800
Message-ID: <20230906071349.3643040-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27858.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27858.005
X-TMASE-Result: 10--1.085100-10.000000
X-TMASE-MatchedRID: BLb+Xlu1owUtNVV5XI3AlHwsIAe4wcJG37jcLTY9yETfc2Xd6VJ+ytue
        iHTXMaT6p7UNomiOZJwuiOJZr6TrGPXNEkgZOg/OOIQ9GP2P2u/BOVz0Jwcxl6vCrG0TnfVU2d8
        mtRIRsUOveSUy9VcQXIAy6p60ZV62To3UJuRLIoTdB/CxWTRRu+rAZ8KTspSzRFP2iJGRa//RxY
        vj9ibMg0m8bfzU2BNfXNIxJxluf6/P/JFN9vSqTSSrlzG234vcZpKqjVQET6Wre7lmajpKTVMcP
        J/P4typIcmnZRhVxyrE4HwnSlEuHInEpJmLAFfpC1FNc6oqYVV+3BndfXUhXQ==
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
index 99b154142..e839f0256 100755
--- a/tools/mvtest
+++ b/tools/mvtest
@@ -28,6 +28,8 @@ append() {
 test "${src}" != "${dest}" || die "Test \"${src}\" is the same as dest."
 test -e "tests/${src}" || die "Test \"${src}\" does not exist."
 test ! -e "tests/${dest}" || die "Test \"${src}\" already exists."
+# make sure testcase is executable
+test `stat -c '%a' tests/${src}` == 755 || chmod 755 "tests/${src}"
 
 sid="$(basename "${src}")"
 did="$(basename "${dest}")"
-- 
2.42.0

