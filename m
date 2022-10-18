Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AD6C4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Oct 2022 03:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiJRDRJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Oct 2022 23:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiJRDQk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Oct 2022 23:16:40 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2412E264B9
        for <fstests@vger.kernel.org>; Mon, 17 Oct 2022 20:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1666062704; i=@fujitsu.com;
        bh=IGrvnCntVFuFqBHM/dwQWfXK2cg6G0yAj1IdMcinzrY=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=U0IyvLY4eNtFsfy+dOsFXJzNzoNpBIgDR5YNaQ/VQIz6D3nWs/PdxyZLX+cM3V0Ew
         MJBxR3dcZbLRs37S5mwvWsln+gFRVV9sYJWNt3d5S4PfUIObuQNf9CSDA75FOslxV1
         bzaBVTm1RmQwdhaVjZsiz7NGiAuSXZSEIzPleowmFAXeGiqqsawCx+AjldDwAm4dGj
         lHxvs8AEHNgrOeOpvo7Ypx/7d1N9gCul9z4/20fDSx+dATedDxMpJyTu7npm5pb5qW
         2PjczvPP/ANIJtGOv8brjcspmocDAJ2ssOCa6GfNm9KnegsSm+zwxm2qqpPqoVlKVw
         KZwvzdaCeEE9Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRWlGSWpSXmKPExsViZ8ORpJsv6Zd
  scGAZr8Xrw58YLU637GW32HtyJ6sDs8emVZ1sHu/3XWXz+LxJLoA5ijUzLym/IoE140LfDOaC
  UwoVU//tY2lgvCXdxcjFISSwkVHiy53rLBDOEiaJrdOesEM4exglDu56yNjFyMnBJqAp8axzA
  XMXIweHiICOxM6DMiBhZgEniTnrTjGB2MICDhJtXzrYQEpYBFQljjXogYR5BTwkVl34zAxiSw
  goSEx5+J4ZIi4ocXLmExaIMRISB1+8gKpRlLjU8Y0Rwq6QmDWrjQnCVpO4em4T8wRG/llI2mc
  haV/AyLSK0aw4tagstUjX0EAvqSgzPaMkNzEzRy+xSjdRL7VUtzy1uETXUC+xvFgvtbhYr7gy
  NzknRS8vtWQTIzBgU4pZ4ncwPlz2R+8QoyQHk5Iob8cM32QhvqT8lMqMxOKM+KLSnNTiQ4wyH
  BxKErwrJPyShQSLUtNTK9Iyc4DRA5OW4OBREuF9BZLmLS5IzC3OTIdInWLU5Zg6+99+ZiGWvP
  y8VClx3nyQIgGQoozSPLgRsEi+xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmY9yPIFJ7MvBK
  4Ta+AjmACOiJjvxfIESWJCCmpBiaG6fExa6OKGNVWNf61aWZeJeugL7nWveDkXYkVj9sEsxfk
  rFSZ4a05pz5KYf/t4o7DCYZiCYfPMN8wirrhLNd9c+6PmClx2cv5GqSNi6Yxs975dJSpTFrIc
  npGJ6Mj0/+qm3+4zpyYPEfC8HRL+O+cV8sTotj7WUsmB4XsjFwQ3XTMJDj1nHT/4TsJBkaavk
  9r9/xkrP/+c4Hw3tafG469Cb3hEa6WcWl60GRL7gMfDwu+ra9hil/l9PbfpWWMicenGcTqHzg
  6IcBMqcpBIDgpZRpj/oSExpC7WyaIpIrtujGR7/K9Tae+x9cv2/fdVPtBgee0hZ6LnS6mCYfs
  2vi1732EkcuC1L8tMkK/viixFGckGmoxFxUnAgBmF1zoXwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-591.messagelabs.com!1666062702!466967!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27294 invoked from network); 18 Oct 2022 03:11:43 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-14.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Oct 2022 03:11:43 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id CBDA41AC;
        Tue, 18 Oct 2022 04:11:42 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id C00721AB;
        Tue, 18 Oct 2022 04:11:42 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 18 Oct 2022 04:11:40 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <brauner@kernel.org>, <zlang@redhat.com>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] Add more suid/sgid related cases to perms group
Date:   Tue, 18 Oct 2022 12:12:10 +0800
Message-ID: <1666066330-2006-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Just use the following ways to look for these cases
1) grep -nsr suid or grep -nsr sgid
2) grep -nsr chmod | grep "+s"
3) grep -nsr ISUID/ISGID then search execute program ie(vfstest/idmapped_mounts)

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/generic/193 | 2 +-
 tests/generic/355 | 2 +-
 tests/generic/673 | 2 +-
 tests/generic/674 | 2 +-
 tests/generic/683 | 2 +-
 tests/generic/684 | 2 +-
 tests/generic/685 | 2 +-
 tests/generic/686 | 2 +-
 tests/generic/687 | 2 +-
 tests/overlay/015 | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/generic/193 b/tests/generic/193
index ddaff69b..e2710b07 100755
--- a/tests/generic/193
+++ b/tests/generic/193
@@ -7,7 +7,7 @@
 # Test permission checks in ->setattr
 #
 . ./common/preamble
-_begin_fstest metadata auto quick
+_begin_fstest metadata auto quick perms
 
 _register_cleanup "_cleanup_files"
 tag="added by qa $seq"
diff --git a/tests/generic/355 b/tests/generic/355
index 4bc69eeb..7c108d1b 100755
--- a/tests/generic/355
+++ b/tests/generic/355
@@ -7,7 +7,7 @@
 # Test clear of suid/sgid on direct write.
 #
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick perms
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/673 b/tests/generic/673
index 4d8dc07e..6d1f49ea 100755
--- a/tests/generic/673
+++ b/tests/generic/673
@@ -7,7 +7,7 @@
 # Functional test for dropping suid and sgid bits as part of a reflink.
 #
 . ./common/preamble
-_begin_fstest auto clone quick
+_begin_fstest auto clone quick perms
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/674 b/tests/generic/674
index a3130249..c3ff1b7b 100755
--- a/tests/generic/674
+++ b/tests/generic/674
@@ -7,7 +7,7 @@
 # Functional test for dropping suid and sgid bits as part of a deduplication.
 #
 . ./common/preamble
-_begin_fstest auto clone quick
+_begin_fstest auto clone quick perms
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/683 b/tests/generic/683
index 4c93346d..302f8bb2 100755
--- a/tests/generic/683
+++ b/tests/generic/683
@@ -7,7 +7,7 @@
 # Functional test for dropping suid and sgid bits as part of a fallocate.
 #
 . ./common/preamble
-_begin_fstest auto clone quick
+_begin_fstest auto clone quick perms
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/684 b/tests/generic/684
index 03481e69..19ccb228 100755
--- a/tests/generic/684
+++ b/tests/generic/684
@@ -7,7 +7,7 @@
 # Functional test for dropping suid and sgid bits as part of a fpunch.
 #
 . ./common/preamble
-_begin_fstest auto clone quick
+_begin_fstest auto clone quick perms
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/685 b/tests/generic/685
index 6a108842..a58eccda 100755
--- a/tests/generic/685
+++ b/tests/generic/685
@@ -7,7 +7,7 @@
 # Functional test for dropping suid and sgid bits as part of a fzero.
 #
 . ./common/preamble
-_begin_fstest auto clone quick
+_begin_fstest auto clone quick perms
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/686 b/tests/generic/686
index 4279f76b..ef9ea47a 100755
--- a/tests/generic/686
+++ b/tests/generic/686
@@ -7,7 +7,7 @@
 # Functional test for dropping suid and sgid bits as part of a finsert.
 #
 . ./common/preamble
-_begin_fstest auto clone quick
+_begin_fstest auto clone quick perms
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/687 b/tests/generic/687
index 78cb6202..f4a1c1bb 100755
--- a/tests/generic/687
+++ b/tests/generic/687
@@ -7,7 +7,7 @@
 # Functional test for dropping suid and sgid bits as part of a fcollapse.
 #
 . ./common/preamble
-_begin_fstest auto clone quick
+_begin_fstest auto clone quick perms
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/overlay/015 b/tests/overlay/015
index fd23e373..f0c05579 100755
--- a/tests/overlay/015
+++ b/tests/overlay/015
@@ -7,7 +7,7 @@
 # SGID bit inheritance over whiteout.
 #
 . ./common/preamble
-_begin_fstest auto quick whiteout
+_begin_fstest auto quick whiteout perms
 
 # Import common functions.
 . ./common/filter
-- 
2.27.0

