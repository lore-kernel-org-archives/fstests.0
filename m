Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003BBC19F28
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Aug 2022 04:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbiHCEwF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 3 Aug 2022 00:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiHCEv5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Aug 2022 00:51:57 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6442157250
        for <fstests@vger.kernel.org>; Tue,  2 Aug 2022 21:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1659502313; i=@fujitsu.com;
        bh=E2HYjI76NXu1Hr0N5WUHwLLkectp1ro1dnA7uoAJB+w=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=dthN0GlnVYz+LU0saJWZKxqvW4JIXP6E0r7TW9Fb/l1v2FVIcdTVUfvzD0UA/QTBl
         GFne5UInDXmyXB2S1kTfpgJ6bvLEL2A8yttxkOLM3NhHDTjDWA8XLysKtbeDxo4jtH
         6IxLohOuFxQLiHlPmNlysbqHHTWf6uOpyp8VjIhFH52qy+jeRwlmj1x39nBkKZ0Sv5
         Qd/c3OWbOlvitAPtDCm8qoOUZGLsYkAVqdjHyyHooXDmhBu49h5jaA1HlDRSNknDu/
         5nC8VoWft6CshoHOMUvQFBUjc3dbGXalqZ6CNsTx3zFLkIn1DWxqgoXlFTV9NsBzHX
         4LLr5qUvbbY2g==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRWlGSWpSXmKPExsViZ8OxWffFv5d
  JBud+a1icbtnL7sDo8XmTXABjFGtmXlJ+RQJrxprDj1kKDglXfJ7dytrA+Fugi5GLQ0jgHKPE
  7OdH2CCcQ0wS1zZ1sEI4exgl1u5dwt7FyMnBJqAjcWHBX1YQW0RAVuL/jNVMIDYzkL3r+QI2E
  FtYwFNi5q8NYDUsAioSR37fA6rh4OAVcJHoupkFEpYQUJCY8vA9M4jNKeAqMfvKbbByIaCSCw
  +7wcbwCghKnJz5hAVivITEwRcvmEHGSAgoSczsjocYUyExa1YbE4StJnH13CbmCYyCs5B0z0L
  SvYCRaRWjbVJRZnpGSW5iZo6uoYGBrqGhKZA20jU0NdZLrNJN1Est1c3LLyrJ0DXUSywv1kst
  LtYrrsxNzknRy0st2cQIDOOU4rSZOxi37Puld4hRkoNJSZRX8s/LJCG+pPyUyozE4oz4otKc1
  OJDjDIcHEoSvM4gOcGi1PTUirTMHGBMwaQlOHiURHgZQdK8xQWJucWZ6RCpU4y6HGsbDuxlFm
  LJy89LlRLnvfoXqEgApCijNA9uBCy+LzHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5p0Gsoo
  nM68EbtMroCOYgI7Q4XoBckRJIkJKqoEpfN6Joz933N/fbLIo5/JW7bhjX7UXHbpUKpa9Im/i
  TJkDpU/de2x+5Ezd0rzRVCl/wYvdvx4/FTLer78+biPHf40JDhPaTn+dw1/Kz9IW9s6xJKbAc
  r/0hvQ34hE8cWqBtVbz9SdKLDBj3jNxz3mztsZyuaYFew6fnx/zd72hT+JjISPe5r27El5Pjl
  yZJTDLY9XtKXHT/1tMvqq107UoSCLI8E7+wuYDjErztKLYShS0PvxYr/Qz8V+5k3HetPLNvWG
  8N3Y9K1Va+2bSzSv3JyjdqN57+pX/h1W7L7H8Xnz+Q6ar4wvnJ1NTLhoHVpWazU1Y8L6r9VP3
  nxY90TdLxD7+Tc4ICTn0V8HMQ/O4vBJLcUaioRZzUXEiABgwmJVqAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-13.tower-732.messagelabs.com!1659502312!112536!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20349 invoked from network); 3 Aug 2022 04:51:52 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-13.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Aug 2022 04:51:52 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 1B64575
        for <fstests@vger.kernel.org>; Wed,  3 Aug 2022 05:51:52 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 0E67314C
        for <fstests@vger.kernel.org>; Wed,  3 Aug 2022 05:51:52 +0100 (BST)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 3 Aug 2022 05:51:50 +0100
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH v4 2/3] xfs: add memory failure test for dax&reflink mode
Date:   Wed, 3 Aug 2022 04:51:30 +0000
Message-ID: <1659502291-19-3-git-send-email-ruansy.fnst@fujitsu.com>
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

Verify that the dax-rmap feature works.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/xfs/901     | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/901.out |  9 +++++++++
 2 files changed, 60 insertions(+)
 create mode 100755 tests/xfs/901
 create mode 100644 tests/xfs/901.out

diff --git a/tests/xfs/901 b/tests/xfs/901
new file mode 100755
index 000000000..166683da8
--- /dev/null
+++ b/tests/xfs/901
@@ -0,0 +1,51 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Fujitsu Limited.  All Rights Reserved.
+#
+# FS QA Test No. 901
+#
+# Test memory failure mechanism when dax and reflink working together
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
+_require_cp_reflink
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
+filesize=65536
+_pwrite_byte 0x61 0 $filesize $testdir/testfile >> $seqres.full
+_cp_reflink $testdir/testfile $testdir/poisonfile >> $seqres.full
+_scratch_cycle_mount "dax"
+
+echo "Inject memory failure (1 page)"
+# create two processes:
+#  process1: mread 1 page to cause page fault, and wait
+#  process2: mread 1 page to cause page fault, then inject poison on this page
+$here/src/t_mmap_cow_memory_failure -s1 -S1 -R $testdir/testfile -P $testdir/poisonfile
+
+echo "Inject memory failure (2 pages)"
+$here/src/t_mmap_cow_memory_failure -s2 -S2 -R $testdir/testfile -P $testdir/poisonfile
+
+_check_dmesg_for "Sending SIGBUS to t_mmap_cow_memo" || echo "Memory failure didn't kill the process"
+_check_dmesg_for "recovery action for dax page: Recovered" || echo "Failured page didn't recovered"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/901.out b/tests/xfs/901.out
new file mode 100644
index 000000000..0b91167c0
--- /dev/null
+++ b/tests/xfs/901.out
@@ -0,0 +1,9 @@
+QA output created by 901
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

