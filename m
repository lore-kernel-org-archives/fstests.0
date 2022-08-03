Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4AFC19F29
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Aug 2022 04:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiHCEwG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 3 Aug 2022 00:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbiHCEv6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Aug 2022 00:51:58 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833345725A
        for <fstests@vger.kernel.org>; Tue,  2 Aug 2022 21:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1659502314; i=@fujitsu.com;
        bh=4B4JsquMbWtk2K8cfe995zUDphujrzVj9EzMk05JRv0=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=yeSD9tQ1N1VOXwU4VfqyZqcOuZrCvInSUfOk1TXji9YAUKC7rlMB1NheKecppMNlr
         E9Gk72otByorqppQPCD4MZ2jm7W1gFwzfqhQLJp6YnbIrE0MJhsXZI6SWzV08w7cIX
         LB47TFyOI5eLy0rHkoR+zRbAlSjhO5UuSe6QWqYUHpluXiLG/Zd48D36kdFb7fMXMo
         O+Qivtdu71igMaBnCkQYKmeX2ZMfFpsjQCVBi5eCuLFFI3Qc0l31y3cXjd/zd5htww
         C4X8uDLK4rQF5SSCF9o506BcMNdJo61Gsfp5SpuPznwhIioXHJlv5LLdgu+/m4pCfH
         fsoBhfgZmh0Xw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRWlGSWpSXmKPExsViZ8ORpPvq38s
  kgxuHOCxOt+xld2D0+LxJLoAxijUzLym/IoE1Y9XcbuaCHSIVr5dfZm1gvCnYxcjJISRwnlFi
  wU+NLkYuIPsQk8Sj5plMEM4eRokD3/azg1SxCehIXFjwlxXEFhGQlfg/YzUTiM0MZO96voANx
  BYWCJLYsuMaM4jNIqAi8endVpYuRg4OXgEXiQ9/lEHCEgIKElMevgcr4RRwlZh95TYrxBEuEh
  cedoON4RUQlDg58wkLxHgJiYMvXjCDjJEQUJKY2R0PMaZCYtasNiYIW03i6rlNzBMYBWch6Z6
  FpHsBI9MqRuukosz0jJLcxMwcXUMDA11DQ1NdY0tdIwMDvcQq3US91FLd8tTiEl0jvcTyYr3U
  4mK94src5JwUvbzUkk2MwABOKVY/sYPx6cqfeocYJTmYlER5Jf+8TBLiS8pPqcxILM6ILyrNS
  S0+xCjDwaEkwesMkhMsSk1PrUjLzAFGE0xagoNHSYSXESTNW1yQmFucmQ6ROsWoy7G24cBeZi
  GWvPy8VClx3qt/gYoEQIoySvPgRsAi+xKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYd5pIKt
  4MvNK4Da9AjqCCegIHa4XIEeUJCKkpBqYVp2fZfL2X4HB94783TvF/5oWSq04tKJkyp7MvhRB
  05kPVUMn2W+ZmeFW/ICp60NFm1H36hftUXMP3313pO771aMXFigLKxSGR75a/bRm36y1s4p+T
  Ln1oVD5gH599/fiq9G6eZWKBa++/2Y46L9wuXPKT8Xgdfs4PyTOW3Px+0I+9dhMK6MuldC9Wt
  aCjzIPP/ez6z/IoqaQVFtsNfPfv6/MwjcXGth2WoiWf1rx2G2rQczJB5e/LjD5Js/4JegkxwR
  Xhi6TlBsZ1XPm+095vPl3upjE/O4kvoSVyWoZfrxut7Qi/34olbgRszdl25UajxDd7Qkys1sP
  HD7ro2j+9tu0yEUc8qpCLgpBDlEmSizFGYmGWsxFxYkAezB5+WcDAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-15.tower-565.messagelabs.com!1659502314!358999!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29877 invoked from network); 3 Aug 2022 04:51:54 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-15.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Aug 2022 04:51:54 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id D4AC21AE
        for <fstests@vger.kernel.org>; Wed,  3 Aug 2022 05:51:53 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id C9BBB1AC
        for <fstests@vger.kernel.org>; Wed,  3 Aug 2022 05:51:53 +0100 (BST)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 3 Aug 2022 05:51:52 +0100
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH v4 3/3] xfs: add memory failure test for partly-reflinked&dax file
Date:   Wed, 3 Aug 2022 04:51:31 +0000
Message-ID: <1659502291-19-4-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1659502291-19-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1659502291-19-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Verify that dax-rmap works for both normal extent and shared extent.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/xfs/902     | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/902.out |  9 ++++++++
 2 files changed, 63 insertions(+)
 create mode 100755 tests/xfs/902
 create mode 100644 tests/xfs/902.out

diff --git a/tests/xfs/902 b/tests/xfs/902
new file mode 100755
index 000000000..39308700d
--- /dev/null
+++ b/tests/xfs/902
@@ -0,0 +1,54 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Fujitsu Limited.  All Rights Reserved.
+#
+# FS QA Test No. 902
+#
+# Test memory failure mechanism when dax and reflink working together
+#   test for partly reflinked file
+#
+. ./common/preamble
+_begin_fstest auto quick clone dax
+
+# Import common functions.
+. ./common/filter
+. ./common/reflink
+
+# real QA test starts here
+_require_check_dmesg
+_require_scratch_reflink
+_require_xfs_scratch_rmapbt
+_require_scratch_dax_mountopt "dax"
+_require_test_program "t_mmap_cow_memory_failure"
+
+echo "Format and mount"
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount "-o dax" >> $seqres.full 2>&1
+
+testdir=$SCRATCH_MNT/test-$seq
+mkdir $testdir
+
+echo "Create the original files"
+nr=16
+blksz=$(get_page_size)
+_pwrite_byte 0x61 0 $((blksz * nr)) $testdir/testfile >> $seqres.full
+_pwrite_byte 0x62 0 $((blksz * nr)) $testdir/poisonfile >> $seqres.full
+seq 0 2 $((nr - 1)) | while read i; do
+	_reflink_range $testdir/testfile $((blksz * i)) \
+		$testdir/poisonfile $((blksz * i)) $blksz >> $seqres.full
+done
+_scratch_cycle_mount "dax"
+
+echo "Inject memory failure (1 page)"
+$here/src/t_mmap_cow_memory_failure -s1 -S1 -R $testdir/testfile -P $testdir/poisonfile
+
+echo "Inject memory failure (2 pages)"
+# poison on reflinked page and not reflinked page
+$here/src/t_mmap_cow_memory_failure -s2 -S2 -R $testdir/testfile -P $testdir/poisonfile
+
+_check_dmesg_for "Sending SIGBUS to t_mmap_cow_memo" || echo "Memory failure didn't kill the process"
+_check_dmesg_for "recovery action for dax page: Recovered" || echo "Failured page didn't recovered"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/902.out b/tests/xfs/902.out
new file mode 100644
index 000000000..ed8ff67ca
--- /dev/null
+++ b/tests/xfs/902.out
@@ -0,0 +1,9 @@
+QA output created by 902
+Format and mount
+Create the original files
+Inject memory failure (1 page)
+Inject poison...
+Process is killed by signal: 7
+Inject memory failure (2 pages)
+Inject poison...
+Process is killed by signal: 7
-- 
2.37.1

