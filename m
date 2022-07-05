Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC11AC43334
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Jul 2022 08:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiGEITo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 5 Jul 2022 04:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiGEITn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Jul 2022 04:19:43 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EED1CC0
        for <fstests@vger.kernel.org>; Tue,  5 Jul 2022 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1657009181; i=@fujitsu.com;
        bh=yHKRRYonPX8Nzdlpvx/avnsQbwbreqsHT+jHmJHGD3U=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=TVmQQLR9ZDeupSxbC51D4UyAQfftkNLnME1+ioLND8TYVnHq1CnIWdoIwIIZPRsfp
         T6eAIAsjaCfeTGTx7qnouRWCVKE5uB1qoWGuwZc3pVWIWnDEg+9be+Gi1BvjlVaWLu
         vG/vzdKRWl+Ql8lLsRLXz257C9mif63giBtvHShi0NMWy/mC3+HfPaygMx6LOqDdEl
         Zt6aVhmPMBKRS/iHzXZKcACwjRog6AMVffh3jIJt/Z6NTh6Icl7CBHMVAoIyv69gBH
         scZ/1ddbNwIj0FywybJZV9rcAERR4bHZA56nSX9sHEXYyPmDl1tcEkpdzUhDyDFXHE
         mxXdAx4mGmFiA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRWlGSWpSXmKPExsViZ8ORqCvz5XC
  SQcceXYvTLXvZHRg9Pm+SC2CMYs3MS8qvSGDN+LP1B3PBfN6KH5dfMTYwzuXuYuTiEBK4xCjx
  9mwLC4RzlEli3sMljBDObkaJRS8bWbsYOTnYBDQlnnUuYAaxRQRkJf7PWM0EYjMLqEssn/QLz
  BYWcJC4uOg9G4jNIqAiMXvXRkYQm1fAQ+LVlnnsILaEgILElIfvweZwCnhKvDlxECwuBFQz5W
  sfM0S9oMTJmU9YIOZLSBx88YIZoldR4lLHN0YIu0Li9eFLUHE1iavnNjFPYBSchaR9FpL2BYx
  Mqxgtk4oy0zNKchMzc3QNDQx0DQ1NdY11Lcz0Eqt0E/VSS3XLU4tLdA31EsuL9VKLi/WKK3OT
  c1L08lJLNjECQzilmDlsB+Of3p96hxglOZiURHlvPTycJMSXlJ9SmZFYnBFfVJqTWnyIUYaDQ
  0mCd95HoJxgUWp6akVaZg4wnmDSEhw8SiK8pSBp3uKCxNzizHSI1ClGS461DQf2MnNMnf1vPz
  NH5/6uA8xCLHn5ealS4rzTPgE1CIA0ZJTmwY2DxfwlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hy
  MSsK8DJ+BpvBk5pXAbX0FdBAT0EE3qg6AHFSSiJCSamDS53l4/qE7T/WamF7jjEX2O8NszK9Z
  Wh8Rfx1Tkssvde+Rvu/Pqx3zVi/c5tKwK1rpmt6D7MdL1s+7mWuu/7905lZdsaiihvVFMpqfz
  8R87osOPrZ7Q/TXPv7m0hgT5d3Xj0vHPft0WntywLS1VXumpPEVHdeYIDQt83N8r5HrO/GlHH
  OWiDLt6zL1k6gvVhBn5dmW6rH22R+1u3Y/TQxu9KV9Fuv98m73hFMaa2vU5uZIS8XbCG/5U2s
  SEB2xrdxmap3vyf0sF1Kzi8P+Cn/sY1HY9i6snodLzydx26xlrcWxG8w6ea3lJv2xmyemFNmi
  w1v5aMO38OsrAo7wHimpc7yXckluTkK1eu8jOSWW4oxEQy3mouJEACoJWp10AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-17.tower-587.messagelabs.com!1657009180!259491!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10320 invoked from network); 5 Jul 2022 08:19:40 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-17.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Jul 2022 08:19:40 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 5896C100191
        for <fstests@vger.kernel.org>; Tue,  5 Jul 2022 09:19:40 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 4C91510018D
        for <fstests@vger.kernel.org>; Tue,  5 Jul 2022 09:19:40 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 5 Jul 2022 09:19:38 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 2/2] xfs/191: test xfs_db get corrupted value
Date:   Tue, 5 Jul 2022 17:20:08 +0800
Message-ID: <1657012808-2204-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657012808-2204-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1657012808-2204-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This is a regression test that xfs_db code doesn't clean up the
LIBXFS_READBUF_SALVAGE call sites in set_cur so that we
can't use the return value directly and scraping it out later.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/xfs/191     | 33 +++++++++++++++++++++++++++++++++
 tests/xfs/191.out |  5 +++++
 2 files changed, 38 insertions(+)
 create mode 100755 tests/xfs/191
 create mode 100644 tests/xfs/191.out

diff --git a/tests/xfs/191 b/tests/xfs/191
new file mode 100755
index 00000000..98e9e186
--- /dev/null
+++ b/tests/xfs/191
@@ -0,0 +1,33 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+#
+# FS QA Test 191
+#
+# Regression test for xfsprogs commit
+# f4afdcb0ad11 ("xfs_db: clean up the salvage read callsites in set_cur()")
+#
+# This case test xfs_db whether can get the new magicnum field value even we
+# just have corrupted this field value.
+#
+
+. ./common/preamble
+_begin_fstest auto quick
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+_supported_fs xfs
+
+_scratch_mkfs_xfs >>$seqres.full 2>&1
+
+# write the bad magicnum field value(0) to the superblock
+_scratch_xfs_set_metadata_field "magicnum" "0" "sb 1"
+
+#Even magicnum filed has been corrupted, we still can read this filed value
+_scratch_xfs_get_metadata_field "magicnum" "sb 1"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/191.out b/tests/xfs/191.out
new file mode 100644
index 00000000..71826198
--- /dev/null
+++ b/tests/xfs/191.out
@@ -0,0 +1,5 @@
+QA output created by 191
+Allowing write of corrupted data with good CRC
+magicnum = 0
+bad magic number
+0
-- 
2.27.0

