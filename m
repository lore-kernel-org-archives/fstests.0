Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADE9C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Apr 2022 07:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243770AbiDZH6a (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Apr 2022 03:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241468AbiDZH63 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Apr 2022 03:58:29 -0400
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA415585
        for <fstests@vger.kernel.org>; Tue, 26 Apr 2022 00:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650959720; i=@fujitsu.com;
        bh=bqfUcbNC6F9kdUMgdDjX1IlvxHAsB0yqgO+WS09VdB0=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Tiv7XjZr2dbAdzKsf8II7fA2VZK3p675I4wCgMrQEhq12Kx8SyX3xif+i++kFnMVt
         63ONSPJojPFxu4tonSx0sVphw3ZIjNvgQ4WP4UYKLANX9IIz/le1YMErHR4kXcIn3z
         mt4r6C+BFGOEEAW+LnWDmti8VpJVQjcxFrbJTe721czhR10yl18Y6f0yUvaudwOZYW
         7OVF5dgWwrwGf/PLtaKvNEfcbzdJaJMrIZkv31CO1S7wbdJSraRP7194kvBbhFsgjF
         VLSii1jOX4Dz7aKrUEdbj26BW7tbw0MmIUuh7xHNdhkzEQYNDkGnmuaNTcuDVj8WQo
         GWdMG3gu7N5PQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRWlGSWpSXmKPExsViZ8ORqJu+ND3
  JYNpkG4vLT/gsTrfsZXdg8ti0qpPN4/MmuQCmKNbMvKT8igTWjJ8PL7AUfFWoePj4NlMD4wSZ
  LkYuDiGBLYwSa/+8YodwFjBJPGo/wAbh7GGU2HzoFFMXIycHm4CmxLPOBcwgtoiAuMTjRbfA4
  swCThJz1kHUCAu4SHQd3As0iYODRUBV4t4hWZAwr4CHxIP2JWCtEgIKElMevmeGiAtKnJz5hA
  VijITEwRcvoGoUJS51fGOEsCskZs1qY4Kw1SSuntvEPIGRfxaS9llI2hcwMq1itE0qykzPKMl
  NzMzRNTQw0DU0NNU1s9A1MtFLrNJN1Est1U1OzSspSgTK6iWWF+ulFhfrFVfmJuek6OWllmxi
  BIZqSrGLxA7Gm30/9Q4xSnIwKYnyKi5OTxLiS8pPqcxILM6ILyrNSS0+xCjDwaEkwcu1CCgnW
  JSanlqRlpkDjBuYtAQHj5IIb+ZUoDRvcUFibnFmOkTqFKMux9PnJ/YyC7Hk5eelSonz/gKZLw
  BSlFGaBzcCFsOXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzGiwBmsKTmVcCt+kV0BFMQEd
  8qk0FOaIkESEl1cDUr9IdvUDG6+DxFd2P7Q83Ruw5vfmJ7Lkp15cIxpRFLxdTlL1tKOWcUfbo
  pFMD+7cY6Qa7fp4pzRwu67bx3WwXWrD+x0e36x89szUcO+6Z7yq8EPT3s64K77aFl1WuJKu9b
  lpWrbwtdXHaagWPz6IeiVKuS8/21FZpz2093dZ4+Llw+FYmje5VdZOnMeboHFOsE9NjTReovH
  VzjfOJTzf59+y8E99m6Wxj8M95QerurvOy3UuWcO1bIv/ao8DfZ8+Z1ew7185istqXL3J1l55
  s4a4fVUdWq5tn3itif/qy2cb5k1qZEIN/re4U4ctnL7iwVV1LV3/V8tPg1vK0NSfUDqb0xKcl
  mIQueO6WW6bEUpyRaKjFXFScCABzWQuPXAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-528.messagelabs.com!1650959719!76653!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11467 invoked from network); 26 Apr 2022 07:55:19 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-14.tower-528.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Apr 2022 07:55:19 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 4D0B01001A7;
        Tue, 26 Apr 2022 08:55:19 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 230BE100192;
        Tue, 26 Apr 2022 08:55:19 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 26 Apr 2022 08:55:11 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <djwong@kernel.org>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [RESEND] generic/673: Add separate sgid stripping sub-tests
Date:   Tue, 26 Apr 2022 16:55:45 +0800
Message-ID: <1650963345-2577-1-git-send-email-xuyang2018.jy@fujitsu.com>
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
 tests/generic/673     | 37 ++++++++++++++++++++++++++++++-------
 tests/generic/673.out | 24 ++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/tests/generic/673 b/tests/generic/673
index 0377c5f6..e40e672a 100755
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
@@ -78,30 +77,54 @@ setup_testfile
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
 
+#Commit to a non-exec file by an unprivileged user leaves sgid.
+echo "Test 9 - qa_user, non-exec file, only sgid"
+setup_testfile
+chmod a+rw,g+rws $SCRATCH_MNT/a
+commit_and_check "$qa_user"
+
+#Commit to a group-exec file by an unprivileged user clears sgid
+echo "Test 10 - qa_user, group-exec file, only sgid"
+setup_testfile
+chmod a+rw,g+rwxs $SCRATCH_MNT/a
+commit_and_check "$qa_user"
+
+#Commit to a user-exec file by an unprivileged user clears sgid
+echo "Test 11 - qa_user, user-exec file, only sgid"
+setup_testfile
+chmod a+rw,u+x,g+rws $SCRATCH_MNT/a
+commit_and_check "$qa_user"
+
+#Commit to a all-exec file by an unprivileged user clears sgid.
+echo "Test 12 - qa_user, all-exec file, only sgid"
+setup_testfile
+chmod a+rwx,g+rwxs $SCRATCH_MNT/a
+commit_and_check "$qa_user"
+
 # success, all done
 status=0
 exit
diff --git a/tests/generic/673.out b/tests/generic/673.out
index 4d18bca2..0817857d 100644
--- a/tests/generic/673.out
+++ b/tests/generic/673.out
@@ -47,3 +47,27 @@ Test 8 - root, all-exec file
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
+Test 11 - qa_user, user-exec file, only sgid
+310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
+2766 -rwxrwSrw- SCRATCH_MNT/a
+3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
+2766 -rwxrwSrw- SCRATCH_MNT/a
+
+Test 12 - qa_user, all-exec file, only sgid
+310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
+2777 -rwxrwsrwx SCRATCH_MNT/a
+3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
+777 -rwxrwxrwx SCRATCH_MNT/a
+
-- 
2.27.0

