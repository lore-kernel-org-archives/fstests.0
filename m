Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8C6C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Apr 2022 07:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbiDZHcT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Apr 2022 03:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbiDZHcS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Apr 2022 03:32:18 -0400
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2CEC9B54
        for <fstests@vger.kernel.org>; Tue, 26 Apr 2022 00:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650958150; i=@fujitsu.com;
        bh=kztbDjfK1itE6HYyXVP6fknLPTyvYOhEDangVwWCs9k=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=US8fyU0qy00smqo0LQf3Qm/Nj9zkuCTObnCBWOPO4jYTcSTDMDnAO7k5KL2y/ijZj
         jlM87YjyDjouz/ub34CRsQIk6FsojtOkBaD6ifpJkSXVmCgK/wQRnloJb9onCdVrpv
         2VtnogZPYN9USJRyxal+jid2HtSsY5M9zHwzPwbzWr25QlU8dWUJuCmwpZdT2MQ7hz
         88aZ7nGKqDfDBHdJFysp6UZ9r1cSS6A/QZfGvbYWs7GA54+slVN6Fe5SgJYRLWTT3z
         n7WfyKgaklpQ20f1qxPZGNzh/LHPWwI/UJ0Xy4hpal6/qO1eUy80VombMZEndwefaw
         88EAIWX0hfovQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRWlGSWpSXmKPExsViZ8ORqOs6Pz3
  JoGm1jsXlJ3wWp1v2sjsweWxa1cnm8XmTXABTFGtmXlJ+RQJrxouLfcwFR2Qrnk1qYWpgnCTZ
  xcjFISSwhVFi6prNzBDOAiaJ7ScmskI4exgl9m8/yNTFyMnBJqAp8axzATOILSIgLvF40S2wO
  LOAk8ScdafAbGEBZ4m21tlsIDaLgKrEuZ1Hwep5BTwkXj6+zQJiSwgoSEx5+B4qLihxcuYTFo
  g5EhIHX7xghqhRlLjU8Y0Rwq6QmDWrjQnCVpO4em4T8wRG/llI2mchaV/AyLSK0S6pKDM9oyQ
  3MTNH19DAQNfQ0FTXzEzX0MJML7FKN1EvtVQ3OTWvpCgRKK2XWF6sl1pcrFdcmZuck6KXl1qy
  iREYrinFTrt2MB7s+6l3iFGSg0lJlPddU3qSEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQneitlAO
  cGi1PTUirTMHGDswKQlOHiURHgzpwKleYsLEnOLM9MhUqcYdTmePj+xl1mIJS8/L1VKnDd1Hl
  CRAEhRRmke3AhYHF9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMzbDTKFJzOvBG7TK6AjmIC
  O+FSbCnJESSJCSqqBiYv/ONvTi/srjSRZ5c1qDOVV1VfJzHq9ft75RPvb+w+rsW788nG/WoJL
  emDrrNfh8xVcPS5bN7je1npkPHeevICMh+qhLfbqdhv+B2SrX7dn+3Km0qAnmzchZfdqfdVXK
  9UnRS47YHky+9/c3U/V+W4Kh/2ND5g4l/vw1FLLpElJXx0CLbj15tgGrTnEKq4TNs2Jb+3/xW
  9VzgXKvi2enXmOfWeLw/r1My0use7S8iuVX3Pd784caxO5ogO70zam/LzwY6V/6DuJPtVdct/
  WM3bHN86dcM60KbHO4+WFKY3P9v9cNUX1r9b6g7/0UzleZPuIOCQ8frTPjt1PSmyz6sesFeFb
  wpiY/4izP9mfoMRSnJFoqMVcVJwIAO0wuS9eAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-17.tower-532.messagelabs.com!1650958149!227783!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21843 invoked from network); 26 Apr 2022 07:29:09 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-17.tower-532.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Apr 2022 07:29:09 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 2D6B8100199;
        Tue, 26 Apr 2022 08:29:09 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 0770F10004E;
        Tue, 26 Apr 2022 08:29:09 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 26 Apr 2022 08:28:55 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <djwong@kernel.org>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] generic/673: Add separate sgid stripping sub-tests
Date:   Tue, 26 Apr 2022 16:30:06 +0800
Message-ID: <1650961806-2219-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

Even kernel doesn't get ATTR_KILL_SGID mask and get ATTR_KILL_SUID mask,
we still can strip S_ISGID mode in setattr_prepare and setattr_copy.

We should check separate sgid stripping logic whether works well
on different filesystems.

Also fix comments error.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/generic/673     | 31 ++++++++++++++++++++++++-------
 tests/generic/673.out | 18 ++++++++++++++++++
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/tests/generic/673 b/tests/generic/673
index 0377c5f6..572abb7b 100755
--- a/tests/generic/673
+++ b/tests/generic/673
@@ -53,8 +53,7 @@ commit_and_check() {
 	echo
 }
 
-# Commit to a non-exec file by an unprivileged user clears suid but leaves
-# sgid.
+# Commit to a non-exec file by an unprivileged user clears suid and sgid
 echo "Test 1 - qa_user, non-exec file"
 setup_testfile
 chmod a+rws $SCRATCH_MNT/a
@@ -66,7 +65,7 @@ setup_testfile
 chmod g+x,a+rws $SCRATCH_MNT/a
 commit_and_check "$qa_user"
 
-# Commit to a user-exec file by an unprivileged user clears suid but not sgid.
+# Commit to a user-exec file by an unprivileged user clears suid and sgid.
 echo "Test 3 - qa_user, user-exec file"
 setup_testfile
 chmod u+x,a+rws,g-x $SCRATCH_MNT/a
@@ -78,30 +77,48 @@ setup_testfile
 chmod a+rwxs $SCRATCH_MNT/a
 commit_and_check "$qa_user"
 
-# Commit to a non-exec file by root clears suid but leaves sgid.
+# Commit to a non-exec file by root leaves suid and sgid.
 echo "Test 5 - root, non-exec file"
 setup_testfile
 chmod a+rws $SCRATCH_MNT/a
 commit_and_check
 
-# Commit to a group-exec file by root clears suid and sgid.
+# Commit to a group-exec file by root leaves suid and sgid.
 echo "Test 6 - root, group-exec file"
 setup_testfile
 chmod g+x,a+rws $SCRATCH_MNT/a
 commit_and_check
 
-# Commit to a user-exec file by root clears suid but not sgid.
+# Commit to a user-exec file by root leaves suid and sgid.
 echo "Test 7 - root, user-exec file"
 setup_testfile
 chmod u+x,a+rws,g-x $SCRATCH_MNT/a
 commit_and_check
 
-# Commit to a all-exec file by root clears suid and sgid.
+# Commit to a all-exec file by root leaves suid and sgid.
 echo "Test 8 - root, all-exec file"
 setup_testfile
 chmod a+rwxs $SCRATCH_MNT/a
 commit_and_check
 
+#Commit to a non-exec file by unprivileged user leaves sgid.
+echo "Test 9 - qa_user, non-exec file, only sgid"
+setup_testfile
+chmod a+rw,g+rws $SCRATCH_MNT/a
+commit_and_check "$qa_user"
+
+#Commit to a non-exec file by unprivileged user clears sgid
+echo "Test 10 - qa_user, group-exec file, only sgid"
+setup_testfile
+chmod a+rw,g+rwxs $SCRATCH_MNT/a
+commit_and_check "$qa_user"
+
+#Commit to a non-exec file by unprivileged user clears sgid.
+echo "Test 11 - qa_user, all-exec file, only sgid"
+setup_testfile
+chmod a+rwx,g+rwxs $SCRATCH_MNT/a
+commit_and_check "$qa_user"
+
 # success, all done
 status=0
 exit
diff --git a/tests/generic/673.out b/tests/generic/673.out
index 4d18bca2..767251f2 100644
--- a/tests/generic/673.out
+++ b/tests/generic/673.out
@@ -47,3 +47,21 @@ Test 8 - root, all-exec file
 3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
 6777 -rwsrwsrwx SCRATCH_MNT/a
 
+Test 9 - qa_user, non-exec file, only sgid
+310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
+2666 -rw-rwSrw- SCRATCH_MNT/a
+3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
+2666 -rw-rwSrw- SCRATCH_MNT/a
+
+Test 10 - qa_user, group-exec file, only sgid
+310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
+2676 -rw-rwsrw- SCRATCH_MNT/a
+3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
+676 -rw-rwxrw- SCRATCH_MNT/a
+
+Test 11 - qa_user, all-exec file, only sgid
+310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
+2777 -rwxrwsrwx SCRATCH_MNT/a
+3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
+777 -rwxrwxrwx SCRATCH_MNT/a
+
-- 
2.27.0

