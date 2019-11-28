Return-Path: <SRS0=SzeB=ZU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FADC432C0
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Nov 2019 07:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534C9215E5
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Nov 2019 07:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfK1HKw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 28 Nov 2019 02:10:52 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38422 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726438AbfK1HKv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Nov 2019 02:10:51 -0500
X-IronPort-AV: E=Sophos;i="5.69,252,1571673600"; 
   d="scan'208";a="79208203"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Nov 2019 15:10:29 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 388494CE1C01;
        Thu, 28 Nov 2019 15:02:02 +0800 (CST)
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 28 Nov 2019 15:10:28 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] xfs/148: sort and filter attribute list output
Date:   Thu, 28 Nov 2019 15:10:45 +0800
Message-ID: <1574925045-7334-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: 388494CE1C01.AB2FF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When I backport fixed patches from Darrick tighten-verifiers tree, this case 
also fails. As below:
-----------------------------------------------------------
"diff test/xfs/148.out result/xfs/148.out.bad
7,8d6
< Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
< Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/testfile
9a8
> Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/testfile
10a10,11
> Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
> Attribute "selinux" has a 37 byte value for TEST_DIR/mount-148/testfile
49,50c50,51
< Attribute "a_are_bad/for_you" had a 3 byte value for TEST_DIR/mount-148/testfile:
< heh
> attr_get: No data available
> Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile"
-------------------------------------------------------------
We should sort attribute list output and filter selinux. Also "a_are_bad/for_you"
doesn't exist, we should correct it in output.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/xfs/148     | 2 +-
 tests/xfs/148.out | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/xfs/148 b/tests/xfs/148
index 42cfdab0..06862faa 100755
--- a/tests/xfs/148
+++ b/tests/xfs/148
@@ -76,7 +76,7 @@ test_names+=("too_many" "are_bad/for_you")
 
 access_stuff() {
 	ls $testdir
-	$ATTR_PROG -l $testfile
+	$ATTR_PROG -l $testfile | grep "a_" | sort
 
 	for name in "${test_names[@]}"; do
 		ls "$testdir/f_$name"
diff --git a/tests/xfs/148.out b/tests/xfs/148.out
index c301ecb6..ab3fc25b 100644
--- a/tests/xfs/148.out
+++ b/tests/xfs/148.out
@@ -4,10 +4,10 @@ f_another
 f_are_bad_for_you
 f_something
 f_too_many_beans
+Attribute "a_another" has a 3 byte value for TEST_DIR/mount-148/testfile
+Attribute "a_are_bad_for_you" has a 3 byte value for TEST_DIR/mount-148/testfile
 Attribute "a_something" has a 3 byte value for TEST_DIR/mount-148/testfile
 Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-148/testfile
-Attribute "a_are_bad_for_you" has a 3 byte value for TEST_DIR/mount-148/testfile
-Attribute "a_another" has a 3 byte value for TEST_DIR/mount-148/testfile
 TEST_DIR/mount-148/testdir/f_something
 Attribute "a_something" had a 3 byte value for TEST_DIR/mount-148/testfile:
 heh
@@ -46,5 +46,5 @@ ls: cannot access 'TEST_DIR/mount-148/testdir/f_too_many': No such file or direc
 attr_get: No data available
 Could not get "a_too_many" for TEST_DIR/mount-148/testfile
 ls: cannot access 'TEST_DIR/mount-148/testdir/f_are_bad/for_you': No such file or directory
-Attribute "a_are_bad/for_you" had a 3 byte value for TEST_DIR/mount-148/testfile:
-heh
+attr_get: No data available
+Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile
-- 
2.18.0



