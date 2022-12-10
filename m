Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05F4C4332F
	for <linux-fstests@archiver.kernel.org>; Sat, 10 Dec 2022 02:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLJCbn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 9 Dec 2022 21:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLJCbk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 9 Dec 2022 21:31:40 -0500
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DC72C67C
        for <fstests@vger.kernel.org>; Fri,  9 Dec 2022 18:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1670639498; i=@fujitsu.com;
        bh=VNMWe6LNnjFLgnYQq4iLCR2CvQUJhSbWvqpN6L7lSD4=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=coUJIKQfbaBoWKv5AY1icZaDY3qv/Ex3jZIX2hcmQHCCUu+WJFt+muXpCukPDb/TZ
         z7q8dMVihGZYxSYxkIXZjWO4GHRZJEYSGyl4bTvbUkOMuRorubdVsR20IHisVbv9qZ
         zSf6QE67kdbZPPmM2YDf8jK+UinZkZcthooJ/Xknp5V7iqeerQ633730mAp1Sxv1Ug
         ApA2BZ9KZT4DwqAKga8ZtHKgQTDC2YFDt6YcZAvZq1w1Cbt5UOpY0nuxETkpkyXKgx
         lp5MWnDNY3bnZgnnvrC/N0BjrdVvn3wRvGa09o6+yp2cUsk+fMfAFCHSqcqPtDUPhl
         FsCKaX6nd2Ouw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRWlGSWpSXmKPExsViZ8OxWbfj/eR
  kg+nbeS1Ot+xld2D0+LxJLoAxijUzLym/IoE14/TDrawFt9grFp7+zdTAuI+ti5GLQ0jgHKPE
  jzdNLF2MnEDOQSaJ08fqIBJ7GSXeL7nKDpJgE9CRuLDgLyuILSIgK/F/xmomEJsZyN71fAEbi
  C0s4CrxYOonMJtFQFXiy67ZYDW8Ai4Si8/0gi2QEFCQmPLwPTNEXFDi5MwnLBBzJCQOvngBFO
  cAqlGSmNkdD1FeITFrVhsThK0mcfXcJuYJjPyzkHTPQtK9gJFpFaNZcWpRWWqRrqGhXlJRZnp
  GSW5iZo5eYpVuol5qqW55anGJrqFeYnmxXmpxsV5xZW5yTopeXmrJJkZgIKYUM0zfwfhz2R+9
  Q4ySHExKorzHoicnC/El5adUZiQWZ8QXleakFh9ilOHgUJLg7XwFlBMsSk1PrUjLzAFGBUxag
  oNHSYQ36ilQmre4IDG3ODMdInWKUZdjbcOBvcxCLHn5ealS4ryVb4CKBECKMkrz4EbAIvQSo6
  yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWHe/S+BpvBk5pXAbXoFdAQT0BErv0wEOaIkESEl1cA
  0p6Hx/yKnaV/KF3Me82Of71TO0uz9QkNAj1diemuVPZ/Bj+KnxukLGA9zvLgctPP2nXajjq9s
  GasdT966Kmcs/bl/5vSPBskLz1k/2i1355PHs/wXX9+tMrviFa7qe/UF35rN0g3zD80IC/S/e
  0l4y3EJ198XcuWfHrNMfss+78QZ92BzOdMLsQx/Hxe/eFpsNcFN9WzmKc9TAcJ5ST9fKv4uP2
  BwJc133cIp4ir6Yj0bIq6pvs+972SwK1b4W4XMqaW7d7xvLd07q2PjJrNu8ZypJed28jDzTl5
  df/Xqn2sXVE2Ev0purPvtd+ia+cyOZVeuXVvY+7NX/6xC8OLw98uutP17q//JIe1Qu8Osf0os
  xRmJhlrMRcWJABHVmcdLAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-9.tower-591.messagelabs.com!1670639496!105566!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7702 invoked from network); 10 Dec 2022 02:31:36 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-9.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Dec 2022 02:31:36 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id D79C37B
        for <fstests@vger.kernel.org>; Sat, 10 Dec 2022 02:31:35 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id CB6D073
        for <fstests@vger.kernel.org>; Sat, 10 Dec 2022 02:31:35 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Sat, 10 Dec 2022 02:31:34 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH v2] add files to ignore & chmod 755 tests/generic/692
Date:   Sat, 10 Dec 2022 02:31:05 +0000
Message-ID: <1670639465-53-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1. The executable binary in src/ should be in ignore file.
2. tests/xfs/216.out is a symlink generated at runtime, also should be
   ignored.
3. tests/generic/692 was created with 644.  It should be 755 otherwise
   its mode will be changed and dirty the git tree after test.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
 .gitignore        | 2 ++
 tests/generic/692 | 0
 2 files changed, 2 insertions(+)
 mode change 100644 => 100755 tests/generic/692

diff --git a/.gitignore b/.gitignore
index ad9f45437..a6f433f1d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -79,6 +79,7 @@ tags
 /src/dirstress
 /src/e4compact
 /src/ext4_resize
+/src/fake-dump-rootino
 /src/fault
 /src/feature
 /src/fiemap-tester
@@ -205,6 +206,7 @@ tags
 /tests/xfs/033.out
 /tests/xfs/071.out
 /tests/xfs/096.out
+/tests/xfs/216.out
 
 # cscope files
 cscope.*
diff --git a/tests/generic/692 b/tests/generic/692
old mode 100644
new mode 100755
-- 
2.38.1

