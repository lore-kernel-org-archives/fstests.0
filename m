Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75546C43334
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Jun 2022 13:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiF0N3l (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Jun 2022 09:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiF0N3k (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Jun 2022 09:29:40 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610DD6449
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 06:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1656336577; i=@fujitsu.com;
        bh=bRBtFAask37PU8j/rdug8roebnBBqYlG1f1+XaIjhOo=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=pdrUzsAdcH+lfw75rMcRQG2XhsDXx/C2ydSJyMNZE8tCzKgpU0hTZ/jgZpzLJAFTh
         qah4wyosDw89L1GpYC2PckTczxJnKSrR7hLNnhzU1GJtj3d/ytmwurwrmVJiHIufL/
         6X3Y/CcrxFpCVShhBbqFipYbC37gX0JG42LuegyYvFMMCddHj5TKVrHp6ORLsBNkLh
         96QD8Eq4QjYemWLbimO13r0RO8FWZGyDkP5jPY5csdFsIPjQOD34a6oiuEfHwZAKw8
         NmmVTq/py44pDLmzPtGyEJ/2qJGIKfVY6HneJhdKWD2kQRPGm0oF0a9gL3gAZX1WkD
         IlrY0CEijI5VA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRWlGSWpSXmKPExsViZ8MxSffghp1
  JBruu8lmcbtnL7sDo8XmTXABjFGtmXlJ+RQJrxv4j/AXfxSq2zvvA2sC4TriLkYtDSOASo8S+
  n6cYuxg5gZyjTBIzlutDJPYwSqx5OIsNJMEmoCnxrHMBM4gtIiAr8X/GaiYQm1lAXWL5pF9gt
  rCAk8SFrYfAalgEVCXunusAs3kFPCSOt30Eq5EQUJCY8vA9UJyDg1PAU+Lv80SIvR4SP092sk
  KUC0qcnPmEBWK8hMTBFy+YIVoVJS51fGOEsCskXh++BBVXk7h6bhPzBEbBWUjaZyFpX8DItIr
  ROqkoMz2jJDcxM0fX0MBA19DQVNfYRNfI0EIvsUo3US+1VLc8tbhE10gvsbxYL7W4WK+4Mjc5
  J0UvL7VkEyMwgFOKlW7tYNyw6qfeIUZJDiYlUd7V1TuThPiS8lMqMxKLM+KLSnNSiw8xynBwK
  EnwCiwFygkWpaanVqRl5gCjCSYtwcGjJMJ7cj1Qmre4IDG3ODMdInWK0ZJjbcOBvcwcfz/9BZ
  Kd+7sOMAux5OXnpUqJ85aDNAiANGSU5sGNg0X8JUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjEr
  CvLdApvBk5pXAbX0FdBAT0EF+E3eAHFSSiJCSamAKvPpkd5hPgm2eyINpPkvm7fPkbi5YdkNi
  X34H10LllL58Jnb2FxuE1h+vbVy/95/91L5U/wbWUIMU+1++JlK8sVeWsE6S6lgbd1xf69O7m
  s32Li/YW5y4VWuqV3AZ2vtL8amsnZabwBDS2GtxbN6RGRt/zeWMmTN77vGKdM3wfbb59ouWqv
  kIMIp2La6yu18aKbNmbt6l/gsn40032T8q0nPULbO/ntn6Yedd8Z88q3d+cW88U+c949xuo6P
  cm3aIxYb02F6VYN2W8UzHMymr8e1nbp2ueQubnMLE+kLmtr/auuXs37m6/I1MkybU/BLhj7qS
  rfBy+aOiRHaFvbPmyjMpc79lumCYObfKWImlOCPRUIu5qDgRADp0rQNzAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-565.messagelabs.com!1656336577!260881!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31477 invoked from network); 27 Jun 2022 13:29:37 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-4.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Jun 2022 13:29:37 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id DB34D1000CC
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 14:29:36 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id CED6A1000C0
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 14:29:36 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 27 Jun 2022 14:29:35 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH 2/2] xfs/082: Add xfs_db get value regression test
Date:   Mon, 27 Jun 2022 22:30:03 +0800
Message-ID: <1656340203-2322-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656340203-2322-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1656340203-2322-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This case is a regression test for xfsprogs commit
f4afdcb0a ("xfs_db: clean up the salvage read callsites in set_cur()").

I found this because xfs/270 on older xfsprogs can hit this bug.
The code is pasted from xfs/270 but remove mount rw/ro test.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/xfs/082     | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/082.out |  2 ++
 2 files changed, 69 insertions(+)
 create mode 100755 tests/xfs/082
 create mode 100644 tests/xfs/082.out

diff --git a/tests/xfs/082 b/tests/xfs/082
new file mode 100755
index 00000000..7a5ece8f
--- /dev/null
+++ b/tests/xfs/082
@@ -0,0 +1,67 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+#
+# FS QA Test 082
+#
+# Today xfs_db set_cur whether clean up the LIBXFS_READBUF_SALVAGE
+# call sites so that we use the return value directly instead of
+# scraping it out later.
+# 
+# It is a regression test for xfsprogs
+# f4afdcb0a ("xfs_db: clean up the salvage read callsites in set_cur()").
+#
+
+. ./common/preamble
+_begin_fstest auto quick mount
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+_supported_fs xfs
+# skip fs check because superblock contains unknown ro-compat features
+_require_scratch_nocheck
+# Only V5 XFS disallow rw mount/remount with unknown ro-compat features
+_require_scratch_xfs_crc
+
+_scratch_mkfs_xfs >>$seqres.full 2>&1
+
+# set the highest bit of features_ro_compat, use it as an unknown
+# feature bit. If one day this bit become known feature, please
+# change this case.
+
+ro_compat=$(_scratch_xfs_get_metadata_field "features_ro_compat" "sb 0")
+echo $ro_compat | grep -q -E '^0x[[:xdigit:]]$'
+if [[ $? != 0  ]]; then
+	echo "features_ro_compat has an invalid value."
+fi
+
+ro_compat=$(echo $ro_compat | \
+		    awk '/^0x[[:xdigit:]]+/ {
+				printf("0x%x\n", or(strtonum($1), 0x80000000))
+			}')
+
+# write the new ro compat field to the superblock
+_scratch_xfs_set_metadata_field "features_ro_compat" "$ro_compat" "sb 0" \
+				> $seqres.full 2>&1
+
+# read the newly set ro compat filed for verification
+new_ro_compat=$(_scratch_xfs_get_metadata_field "features_ro_compat" "sb 0" \
+					>$seqres.full 2>&1)
+
+# verify the new ro_compat field is empty
+# Without xfsprog patch, xfs_db set_cur function doesn't return directly when
+# meeting error by using LIBXFS_READBUF_SALVAGE flag. So cache_purge will complain
+# about this.
+if [ -z $new_ro_compat ]; then
+	grep -q "cache_purge: shake on cache" $seqres.full && \
+		echo "Hit xfsprogs set_cur bug"
+	echo "Unable to get new ro compat filed"
+fi
+
+echo "Silence is golden."
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/082.out b/tests/xfs/082.out
new file mode 100644
index 00000000..6ed56cb1
--- /dev/null
+++ b/tests/xfs/082.out
@@ -0,0 +1,2 @@
+QA output created by 082
+Silence is golden.
-- 
2.27.0

