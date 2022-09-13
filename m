Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4A4C54EE9
	for <linux-fstests@archiver.kernel.org>; Tue, 13 Sep 2022 08:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiIMIoP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 13 Sep 2022 04:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiIMIoO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Sep 2022 04:44:14 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D03656BB1
        for <fstests@vger.kernel.org>; Tue, 13 Sep 2022 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1663058651; i=@fujitsu.com;
        bh=yKkSFMw3BsUhpehlA6/tc8YzrnOS9yOoXhpQbGhyq8k=;
        h=Message-ID:Date:MIME-Version:From:Subject:References:To:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=fmhuPCP3JyflttpFpqWZiQZM6yuP7imA0F5q4mzCyTJrxA/hJSCfKimLY/FBH0Gkl
         gGwbNMjHakKuoQhDAZS8gxAiekG6FRgLhn/bHmDUfGCgClq5N10lSau+QG++ZlRqMj
         URmcgJjGP29OC5dePfHAW4lJCNGnAgzBpZYKcQtfF3TviLhHU3cMD5W050OkMYykMc
         b52JSBIJ4c7Ax1UOFOClg8Yybo2ZMkHy9nlFUsU4OeeW4vNEeOwsek88PCL9mmSB7T
         anGX/xz7GKolUC435eHV2etc3Bpff+tInNy5sn4qw+nyFLXU3Wl2OydsF5W83ISjT6
         f/CUFIuo+gEEg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRWlGSWpSXmKPExsViZ8ORpHvbSSH
  Z4PhuIYvTLXvZHRg9Pm+SC2CMYs3MS8qvSGDNuNAcVvBBvuJn+zXGBsZjUl2MXBxCAucZJV49
  PsoI4Rxikth68S8bhLONUaL5y0GWLkZODl4BO4n9L5YwgtgsAqoSbZ0TGCHighInZz4BqxEVS
  JboOdHMDmKzCchLPFtxiA3EFhawlvh+aiFrFyMH0FA+iflv8kDCIgKyEv9nrGYCsTkF+CU+X9
  8K1sosYCGx+M1BKFteYvvbOcwgtoSAosSfe4cYIewKicbph5ggbDWJq+c2MU9gFJyF5KJZSEb
  NQjJqASPzKkbrpKLM9IyS3MTMHF1DAwNdQ0NTXWMLINNSL7FKN1EvtVS3PLW4RNdIL7G8WC+1
  uFivuDI3OSdFLy+1ZBMjMLRTitVydzBOWflT7xCjJAeTkijvI0aFZCG+pPyUyozE4oz4otKc1
  OJDjDIcHEoSvAmOQDnBotT01Iq0zBxgnMGkJTh4lER4b9sBpXmLCxJzizPTIVKnGHU5ps7+t5
  9ZiCUvPy9VSpy3G2SGAEhRRmke3AhYzF9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMybAjK
  FJzOvBG7TK6AjmICOMLKWBzmiJBEhJdXAdPzyktNvn5RI1nU/8FPSufMxVe/DynKvtR5qbFEH
  /u/n7ZC5JOXe7JaynnWDWZTC/amWPCdeTUja+15958NpAUf3yUrXcXl4CBnvnvFXVtNI/G2Pi
  ckWg8zYeI5rNiJ5N9dfWXveotpXnHP6Al47Z97/kttdH9tEys+X+pxS/EX8U+uhQ9/DA6eVd5
  7Y6/Cv4ZSiaRvLofhdRn67t2dGXbPiV9YPYI9/t1P6XZpJ/+a5e2KTJn/Y1WrJHqLVqHw83vS
  hxf+XIqwLbhiHP+utj83eEvzOoKmuO74sW3KySfR230WhzYwFIf9z2C7ZBx5b0KV33+aE0qll
  2ies9tq8XHL+meSLSrXfmQ2BghJKLMUZiYZazEXFiQCSjJUadAMAAA==
X-Env-Sender: cuiyue-fnst@fujitsu.com
X-Msg-Ref: server-7.tower-565.messagelabs.com!1663058651!242943!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31475 invoked from network); 13 Sep 2022 08:44:11 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-7.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 13 Sep 2022 08:44:11 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id EDD331AC
        for <fstests@vger.kernel.org>; Tue, 13 Sep 2022 09:44:10 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id E2E741B3
        for <fstests@vger.kernel.org>; Tue, 13 Sep 2022 09:44:10 +0100 (BST)
Received: from [10.167.225.61] (10.167.225.61) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 13 Sep 2022 09:44:09 +0100
Message-ID: <dda772ba-c391-eb9e-2613-a67892b8785f@fujitsu.com>
Date:   Tue, 13 Sep 2022 16:44:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
From:   <cuiyue-fnst@fujitsu.com>
Subject: [PATCH] generic: fix the expected output of sysctl
References: <>
To:     <fstests@vger.kernel.org>
In-Reply-To: <>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.225.61]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


When the version of procps-ng is 3.3.17-6, the output of "sysctl -w" is 
like:
/proc/sys/fs/protected_regular = 0

But when I install procps-ng 3.3.17-4, the output is like:
fs.protected_regular = 0

To avoid this, Just remove the sysctl's stdout from out file.
---
  tests/generic/597     |  8 ++++----
  tests/generic/597.out |  4 ----
  tests/generic/598     | 12 ++++++------
  tests/generic/598.out |  6 ------
  4 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/tests/generic/597 b/tests/generic/597
index ff985ca..30129ac 100755
--- a/tests/generic/597
+++ b/tests/generic/597
@@ -83,9 +83,9 @@ setup_tree
  # is not the link owner.
  echo "== Test symlink follow protection when"
  echo "== process != link owner and dir owner != link owner"
-sysctl -w fs.protected_symlinks=0
+sysctl -w fs.protected_symlinks=0 > /dev/null
  test_symlink
-sysctl -w fs.protected_symlinks=1
+sysctl -w fs.protected_symlinks=1 > /dev/null
  test_symlink
   echo
@@ -96,9 +96,9 @@ echo
  # read-write access to the target
  echo "== Test hardlink create protection when"
  echo "== process != target owner and process cannot read target"
-sysctl -w fs.protected_hardlinks=0
+sysctl -w fs.protected_hardlinks=0 > /dev/null
  test_hardlink
-sysctl -w fs.protected_hardlinks=1
+sysctl -w fs.protected_hardlinks=1 > /dev/null
  test_hardlink
   # success, all done
diff --git a/tests/generic/597.out b/tests/generic/597.out
index c654da7..dc327ae 100644
--- a/tests/generic/597.out
+++ b/tests/generic/597.out
@@ -1,14 +1,10 @@
  QA output created by 597
  == Test symlink follow protection when
  == process != link owner and dir owner != link owner
-fs.protected_symlinks = 0
  successfully followed symlink
-fs.protected_symlinks = 1
  Permission denied
   == Test hardlink create protection when
  == process != target owner and process cannot read target
-fs.protected_hardlinks = 0
  successfully created hardlink
-fs.protected_hardlinks = 1
  ln: failed to create hard link 'TEST_DIR/597/sticky_dir/hardlink' => 
'TEST_DIR/597/target': Operation not permitted
diff --git a/tests/generic/598 b/tests/generic/598
index 769c1b1..4264f33 100755
--- a/tests/generic/598
+++ b/tests/generic/598
@@ -88,11 +88,11 @@ setup_tree
  # sticky directories
   echo "== Test file open when owned by another and file owner != dir 
owner"
-sysctl -w fs.protected_regular=0
+sysctl -w fs.protected_regular=0 > /dev/null
  test_access file
-sysctl -w fs.protected_regular=1
+sysctl -w fs.protected_regular=1 > /dev/null
  test_access file
-sysctl -w fs.protected_regular=2
+sysctl -w fs.protected_regular=2 > /dev/null
  test_access file
   echo
@@ -105,11 +105,11 @@ echo
  # With protection set to 2, the same goes for group-writable
  # sticky directories
  echo "== Test fifo open when owned by another and fifo owner != dir owner"
-sysctl -w fs.protected_fifos=0
+sysctl -w fs.protected_fifos=0 > /dev/null
  test_access fifo
-sysctl -w fs.protected_fifos=1
+sysctl -w fs.protected_fifos=1 > /dev/null
  test_access fifo
-sysctl -w fs.protected_fifos=2
+sysctl -w fs.protected_fifos=2 > /dev/null
  test_access fifo
   # success, all done
diff --git a/tests/generic/598.out b/tests/generic/598.out
index 6d8047d..7903107 100644
--- a/tests/generic/598.out
+++ b/tests/generic/598.out
@@ -1,27 +1,21 @@
  QA output created by 598
  == Test file open when owned by another and file owner != dir owner
-fs.protected_regular = 0
  = group & world writable dir
  = only group writable dir
-fs.protected_regular = 1
  = group & world writable dir
  Permission denied
  = only group writable dir
-fs.protected_regular = 2
  = group & world writable dir
  Permission denied
  = only group writable dir
  Permission denied
   == Test fifo open when owned by another and fifo owner != dir owner
-fs.protected_fifos = 0
  = group & world writable dir
  = only group writable dir
-fs.protected_fifos = 1
  = group & world writable dir
  Permission denied
  = only group writable dir
-fs.protected_fifos = 2
  = group & world writable dir
  Permission denied
  = only group writable dir
-- 
1.8.3.1

