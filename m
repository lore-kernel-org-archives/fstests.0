Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E1DC4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 10 May 2022 04:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiEJEcU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 May 2022 00:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbiEJEbZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 May 2022 00:31:25 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F28115790B
        for <fstests@vger.kernel.org>; Mon,  9 May 2022 21:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1652156670; i=@fujitsu.com;
        bh=71I3V1DG3HF/NUREWyFzezZaAUuFKpa6H9br1CSJtz4=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=G3sAK/UfWU5Jhfzwk3MCV5RM70oZtdVu52JwsPkjkPaQUcZbFp2oxPA5p6H67oO8+
         bNr7obwDYOge7Y6X2HSzSNQP+OildPzAr4cYgG+1w5uGrEsqY1SAGDdoPjxg/MaVUv
         Yczqy6Qsj2FXw2P9Qc4kf89m2doWC5SYitIA7OOoJaQX6M6h2hVSaU51DykDeBkUIE
         I39CNPbVaN8HVky8Nl4Md2kedTcjWGOXHm89qxoLdwmrY8Ux+Twa0V2h5CfsxAD8ZJ
         THO8utPFCz82Q5sxftBczL824zxrimZ5tj8xpskonODAF/HYZhZLQEedSTzeapQRRi
         I8YZ6wiJIlztA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRWlGSWpSXmKPExsViZ8ORqPv3RWW
  SwdL/GhanW/ayOzB6fN4kF8AYxZqZl5RfkcCa8eHrG/aC6dsZK6bMm8nYwLhvJmMXIxeHkMAl
  Rol/Uy4xQzj7mCRuvD7NDuHsYZT4cnEtaxcjJwebgKbEs84FzCC2iICsxP8Zq5lAbGYBdYnlk
  36B2cIC7hLXVy1lA7FZBFQldn4/wwJi8wp4SFzeegqsV0JAQWLKw/fMEHFBiZMzn7BAzJGQOP
  jiBVSNosSljm+MEHaFxKxZbUwQtprE1XObmCcw8s9C0j4LSfsCRqZVjFZJRZnpGSW5iZk5uoY
  GBrqGhqa6prpGpqZ6iVW6iXqppbrlqcUluoZ6ieXFeqnFxXrFlbnJOSl6eaklmxiBgZlSzPp/
  B2N330+9Q4ySHExKorypPpVJQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4q58C5QSLUtNTK9Iyc
  4BRApOW4OBREuEtfwaU5i0uSMwtzkyHSJ1i1OV4+vzEXmYhlrz8vFQpcd41z4GKBECKMkrz4E
  bAIvYSo6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWFeM5BVPJl5JXCbXgEdwQR0xH5XsCNKEhF
  SUg1MKZ6n3iusOXKH2/lAuXsD8xVH8bhDP9cbbdzwdOrqFRlV3E2NX2PnVMgFROhy7m2rX/yz
  u2e+25f7rNLXDPZ/e1onNWH/iepiWbajn6Yc2fu478Jthx9eGV6p/FOLPlq5uK8Ujn40e2bP1
  Ht3mBb3d3zhrDxgqPReIF0t+OzC3w45z/ns/Tv5T5jcTNdROJRi+ipClq0r/GaBy8eFK9N0V6
  TZupfpTF5qmnlQ53Yxh6r65XkRAdI6apadT90nvQ1s3Wo4c9Oy1JizInPZC/JUPFiMs95xq6Q
  UTDzRt9hxfUKGte0anc8xr3iVo/8tX/5C1zFXdafPTNkjc3jskvWff31aWmNqo/47jcPg+jMl
  luKMREMt5qLiRACymc+3UwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-17.tower-585.messagelabs.com!1652156669!300568!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30130 invoked from network); 10 May 2022 04:24:29 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-17.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 May 2022 04:24:29 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 0B54D100189
        for <fstests@vger.kernel.org>; Tue, 10 May 2022 05:24:29 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id E00BA100184
        for <fstests@vger.kernel.org>; Tue, 10 May 2022 05:24:28 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 10 May 2022 05:24:07 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] generic/68[3-7]: Add separate sgid stripping sub-tests
Date:   Tue, 10 May 2022 13:24:50 +0800
Message-ID: <1652160290-2097-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

Like xfstests commit 298f60c ("generic/673: Add separate sgid stripping sub-tests"),
we should also add separate sgid stripping sub-tests for each fallocate operation.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/generic/683     | 69 +++++++++++++++++++++++++------------------
 tests/generic/683.out | 16 ++++++++++
 tests/generic/684     | 69 +++++++++++++++++++++++++------------------
 tests/generic/684.out | 16 ++++++++++
 tests/generic/685     | 69 +++++++++++++++++++++++++------------------
 tests/generic/685.out | 16 ++++++++++
 tests/generic/686     | 69 +++++++++++++++++++++++++------------------
 tests/generic/686.out | 16 ++++++++++
 tests/generic/687     | 69 +++++++++++++++++++++++++------------------
 tests/generic/687.out | 16 ++++++++++
 10 files changed, 280 insertions(+), 145 deletions(-)

diff --git a/tests/generic/683 b/tests/generic/683
index c512989b..746ead86 100755
--- a/tests/generic/683
+++ b/tests/generic/683
@@ -61,67 +61,78 @@ commit_and_check() {
 	echo
 }
 
-nr=0
-# Commit to a non-exec file by an unprivileged user clears suid but
-# leaves sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, non-exec file $verb"
+# Commit to a non-exec file by an unprivileged user clears suid and sgid.
+echo "Test 1 - qa_user, non-exec file $verb"
 setup_testfile
 chmod a+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a group-exec file by an unprivileged user clears suid and
-# sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, group-exec file $verb"
+# Commit to a group-exec file by an unprivileged user clears suid and sgid.
+echo "Test 2 - qa_user, group-exec file $verb"
 setup_testfile
 chmod g+x,a+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a user-exec file by an unprivileged user clears suid but
-# not sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, user-exec file $verb"
+# Commit to a user-exec file by an unprivileged user clears suid and sgid.
+echo "Test 3 - qa_user, user-exec file $verb"
 setup_testfile
 chmod u+x,a+rws,g-x $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a all-exec file by an unprivileged user clears suid and
-# sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, all-exec file $verb"
+# Commit to a all-exec file by an unprivileged user clears suid and sgid.
+echo "Test 4 - qa_user, all-exec file $verb"
 setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a non-exec file by root clears suid but leaves sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, non-exec file $verb"
+# Commit to a non-exec file by root leaves suid and sgid.
+echo "Test 5 - root, non-exec file $verb"
 setup_testfile
 chmod a+rws $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a group-exec file by root clears suid and sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, group-exec file $verb"
+# Commit to a group-exec file by root leaves suid and sgid.
+echo "Test 6 - root, group-exec file $verb"
 setup_testfile
 chmod g+x,a+rws $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a user-exec file by root clears suid but not sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, user-exec file $verb"
+# Commit to a user-exec file by root leaves suid and sgid.
+echo "Test 7 - root, user-exec file $verb"
 setup_testfile
 chmod u+x,a+rws,g-x $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a all-exec file by root clears suid and sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, all-exec file $verb"
+# Commit to a all-exec file by root leaves suid and sgid.
+echo "Test 8 - root, all-exec file $verb"
 setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
+# Commit to a non-exec file by an unprivileged user leaves sgid.
+echo "Test 9 - qa_user, non-exec file $verb, only sgid"
+setup_testfile
+chmod a+rw,g+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a group-exec file by an unprivileged user clears sgid
+echo "Test 10 - qa_user, group-exec file $verb, only sgid"
+setup_testfile
+chmod a+rw,g+rwxs $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a user-exec file by an unprivileged user clears sgid
+echo "Test 11 - qa_user, user-exec file $verb, only sgid"
+setup_testfile
+chmod a+rw,u+x,g+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a all-exec file by an unprivileged user clears sgid.
+echo "Test 12 - qa_user, all-exec file $verb, only sgid"
+setup_testfile
+chmod a+rwx,g+rwxs $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
 # success, all done
 status=0
 exit
diff --git a/tests/generic/683.out b/tests/generic/683.out
index 9d1c9f80..ca29f6e6 100644
--- a/tests/generic/683.out
+++ b/tests/generic/683.out
@@ -31,3 +31,19 @@ Test 8 - root, all-exec file falloc
 6777 -rwsrwsrwx TEST_DIR/683/a
 6777 -rwsrwsrwx TEST_DIR/683/a
 
+Test 9 - qa_user, non-exec file falloc, only sgid
+2666 -rw-rwSrw- TEST_DIR/683/a
+2666 -rw-rwSrw- TEST_DIR/683/a
+
+Test 10 - qa_user, group-exec file falloc, only sgid
+2676 -rw-rwsrw- TEST_DIR/683/a
+676 -rw-rwxrw- TEST_DIR/683/a
+
+Test 11 - qa_user, user-exec file falloc, only sgid
+2766 -rwxrwSrw- TEST_DIR/683/a
+2766 -rwxrwSrw- TEST_DIR/683/a
+
+Test 12 - qa_user, all-exec file falloc, only sgid
+2777 -rwxrwsrwx TEST_DIR/683/a
+777 -rwxrwxrwx TEST_DIR/683/a
+
diff --git a/tests/generic/684 b/tests/generic/684
index d59f4239..4bebeff0 100755
--- a/tests/generic/684
+++ b/tests/generic/684
@@ -61,67 +61,78 @@ commit_and_check() {
 	echo
 }
 
-nr=0
-# Commit to a non-exec file by an unprivileged user clears suid but
-# leaves sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, non-exec file $verb"
+# Commit to a non-exec file by an unprivileged user clears suid and sgid.
+echo "Test 1 - qa_user, non-exec file $verb"
 setup_testfile
 chmod a+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a group-exec file by an unprivileged user clears suid and
-# sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, group-exec file $verb"
+# Commit to a group-exec file by an unprivileged user clears suid and sgid.
+echo "Test 2 - qa_user, group-exec file $verb"
 setup_testfile
 chmod g+x,a+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a user-exec file by an unprivileged user clears suid but
-# not sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, user-exec file $verb"
+# Commit to a user-exec file by an unprivileged user clears suid and sgid.
+echo "Test 3 - qa_user, user-exec file $verb"
 setup_testfile
 chmod u+x,a+rws,g-x $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a all-exec file by an unprivileged user clears suid and
-# sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, all-exec file $verb"
+# Commit to a all-exec file by an unprivileged user clears suid and sgid.
+echo "Test 4 - qa_user, all-exec file $verb"
 setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a non-exec file by root clears suid but leaves sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, non-exec file $verb"
+# Commit to a non-exec file by root leaves suid and sgid.
+echo "Test 5 - root, non-exec file $verb"
 setup_testfile
 chmod a+rws $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a group-exec file by root clears suid and sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, group-exec file $verb"
+# Commit to a group-exec file by root leaves suid and sgid.
+echo "Test 6 - root, group-exec file $verb"
 setup_testfile
 chmod g+x,a+rws $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a user-exec file by root clears suid but not sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, user-exec file $verb"
+# Commit to a user-exec file by root leaves suid and sgid.
+echo "Test 7 - root, user-exec file $verb"
 setup_testfile
 chmod u+x,a+rws,g-x $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a all-exec file by root clears suid and sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, all-exec file $verb"
+# Commit to a all-exec file by root leaves suid and sgid.
+echo "Test 8 - root, all-exec file $verb"
 setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
+# Commit to a non-exec file by an unprivileged user leaves sgid.
+echo "Test 9 - qa_user, non-exec file $verb, only sgid"
+setup_testfile
+chmod a+rw,g+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a group-exec file by an unprivileged user clears sgid
+echo "Test 10 - qa_user, group-exec file $verb, only sgid"
+setup_testfile
+chmod a+rw,g+rwxs $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a user-exec file by an unprivileged user clears sgid
+echo "Test 11 - qa_user, user-exec file $verb, only sgid"
+setup_testfile
+chmod a+rw,u+x,g+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a all-exec file by an unprivileged user clears sgid.
+echo "Test 12 - qa_user, all-exec file $verb, only sgid"
+setup_testfile
+chmod a+rwx,g+rwxs $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
 # success, all done
 status=0
 exit
diff --git a/tests/generic/684.out b/tests/generic/684.out
index df5b3788..2e084ced 100644
--- a/tests/generic/684.out
+++ b/tests/generic/684.out
@@ -31,3 +31,19 @@ Test 8 - root, all-exec file fpunch
 6777 -rwsrwsrwx TEST_DIR/684/a
 6777 -rwsrwsrwx TEST_DIR/684/a
 
+Test 9 - qa_user, non-exec file fpunch, only sgid
+2666 -rw-rwSrw- TEST_DIR/684/a
+2666 -rw-rwSrw- TEST_DIR/684/a
+
+Test 10 - qa_user, group-exec file fpunch, only sgid
+2676 -rw-rwsrw- TEST_DIR/684/a
+676 -rw-rwxrw- TEST_DIR/684/a
+
+Test 11 - qa_user, user-exec file fpunch, only sgid
+2766 -rwxrwSrw- TEST_DIR/684/a
+2766 -rwxrwSrw- TEST_DIR/684/a
+
+Test 12 - qa_user, all-exec file fpunch, only sgid
+2777 -rwxrwsrwx TEST_DIR/684/a
+777 -rwxrwxrwx TEST_DIR/684/a
+
diff --git a/tests/generic/685 b/tests/generic/685
index 2e990465..03447e00 100755
--- a/tests/generic/685
+++ b/tests/generic/685
@@ -61,67 +61,78 @@ commit_and_check() {
 	echo
 }
 
-nr=0
-# Commit to a non-exec file by an unprivileged user clears suid but
-# leaves sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, non-exec file $verb"
+# Commit to a non-exec file by an unprivileged user clears suid and sgid.
+echo "Test 1 - qa_user, non-exec file $verb"
 setup_testfile
 chmod a+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a group-exec file by an unprivileged user clears suid and
-# sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, group-exec file $verb"
+# Commit to a group-exec file by an unprivileged user clears suid and sgid.
+echo "Test 2 - qa_user, group-exec file $verb"
 setup_testfile
 chmod g+x,a+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a user-exec file by an unprivileged user clears suid but
-# not sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, user-exec file $verb"
+# Commit to a user-exec file by an unprivileged user clears suid and sgid.
+echo "Test 3 - qa_user, user-exec file $verb"
 setup_testfile
 chmod u+x,a+rws,g-x $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a all-exec file by an unprivileged user clears suid and
-# sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, all-exec file $verb"
+# Commit to a all-exec file by an unprivileged user clears suid and sgid.
+echo "Test 4 - qa_user, all-exec file $verb"
 setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a non-exec file by root clears suid but leaves sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, non-exec file $verb"
+# Commit to a non-exec file by root leaves suid and sgid.
+echo "Test 5 - root, non-exec file $verb"
 setup_testfile
 chmod a+rws $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a group-exec file by root clears suid and sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, group-exec file $verb"
+# Commit to a group-exec file by root leaves suid and sgid.
+echo "Test 6 - root, group-exec file $verb"
 setup_testfile
 chmod g+x,a+rws $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a user-exec file by root clears suid but not sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, user-exec file $verb"
+# Commit to a user-exec file by root leaves suid and sgid.
+echo "Test 7 - root, user-exec file $verb"
 setup_testfile
 chmod u+x,a+rws,g-x $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a all-exec file by root clears suid and sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, all-exec file $verb"
+# Commit to a all-exec file by root leaves suid and sgid.
+echo "Test 8 - root, all-exec file $verb"
 setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
+# Commit to a non-exec file by an unprivileged user leaves sgid.
+echo "Test 9 - qa_user, non-exec file $verb, only sgid"
+setup_testfile
+chmod a+rw,g+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a group-exec file by an unprivileged user clears sgid
+echo "Test 10 - qa_user, group-exec file $verb, only sgid"
+setup_testfile
+chmod a+rw,g+rwxs $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a user-exec file by an unprivileged user clears sgid
+echo "Test 11 - qa_user, user-exec file $verb, only sgid"
+setup_testfile
+chmod a+rw,u+x,g+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a all-exec file by an unprivileged user clears sgid.
+echo "Test 12 - qa_user, all-exec file $verb, only sgid"
+setup_testfile
+chmod a+rwx,g+rwxs $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
 # success, all done
 status=0
 exit
diff --git a/tests/generic/685.out b/tests/generic/685.out
index 90b7a0de..e611da3e 100644
--- a/tests/generic/685.out
+++ b/tests/generic/685.out
@@ -31,3 +31,19 @@ Test 8 - root, all-exec file fzero
 6777 -rwsrwsrwx TEST_DIR/685/a
 6777 -rwsrwsrwx TEST_DIR/685/a
 
+Test 9 - qa_user, non-exec file fzero, only sgid
+2666 -rw-rwSrw- TEST_DIR/685/a
+2666 -rw-rwSrw- TEST_DIR/685/a
+
+Test 10 - qa_user, group-exec file fzero, only sgid
+2676 -rw-rwsrw- TEST_DIR/685/a
+676 -rw-rwxrw- TEST_DIR/685/a
+
+Test 11 - qa_user, user-exec file fzero, only sgid
+2766 -rwxrwSrw- TEST_DIR/685/a
+2766 -rwxrwSrw- TEST_DIR/685/a
+
+Test 12 - qa_user, all-exec file fzero, only sgid
+2777 -rwxrwsrwx TEST_DIR/685/a
+777 -rwxrwxrwx TEST_DIR/685/a
+
diff --git a/tests/generic/686 b/tests/generic/686
index 71c3aebb..eae3cbda 100755
--- a/tests/generic/686
+++ b/tests/generic/686
@@ -61,67 +61,78 @@ commit_and_check() {
 	echo
 }
 
-nr=0
-# Commit to a non-exec file by an unprivileged user clears suid but
-# leaves sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, non-exec file $verb"
+# Commit to a non-exec file by an unprivileged user clears suid and sgid.
+echo "Test 1 - qa_user, non-exec file $verb"
 setup_testfile
 chmod a+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a group-exec file by an unprivileged user clears suid and
-# sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, group-exec file $verb"
+# Commit to a group-exec file by an unprivileged user clears suid and sgid.
+echo "Test 2 - qa_user, group-exec file $verb"
 setup_testfile
 chmod g+x,a+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a user-exec file by an unprivileged user clears suid but
-# not sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, user-exec file $verb"
+# Commit to a user-exec file by an unprivileged user clears suid and sgid.
+echo "Test 3 - qa_user, user-exec file $verb"
 setup_testfile
 chmod u+x,a+rws,g-x $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a all-exec file by an unprivileged user clears suid and
-# sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, all-exec file $verb"
+# Commit to a all-exec file by an unprivileged user clears suid and sgid.
+echo "Test 4 - qa_user, all-exec file $verb"
 setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a non-exec file by root clears suid but leaves sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, non-exec file $verb"
+# Commit to a non-exec file by root leaves suid and sgid.
+echo "Test 5 - root, non-exec file $verb"
 setup_testfile
 chmod a+rws $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a group-exec file by root clears suid and sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, group-exec file $verb"
+# Commit to a group-exec file by root leaves suid and sgid.
+echo "Test 6 - root, group-exec file $verb"
 setup_testfile
 chmod g+x,a+rws $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a user-exec file by root clears suid but not sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, user-exec file $verb"
+# Commit to a user-exec file by root leaves suid and sgid.
+echo "Test 7 - root, user-exec file $verb"
 setup_testfile
 chmod u+x,a+rws,g-x $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a all-exec file by root clears suid and sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, all-exec file $verb"
+# Commit to a all-exec file by root leaves suid and sgid.
+echo "Test 8 - root, all-exec file $verb"
 setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
+# Commit to a non-exec file by an unprivileged user leaves sgid.
+echo "Test 9 - qa_user, non-exec file $verb, only sgid"
+setup_testfile
+chmod a+rw,g+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a group-exec file by an unprivileged user clears sgid
+echo "Test 10 - qa_user, group-exec file $verb, only sgid"
+setup_testfile
+chmod a+rw,g+rwxs $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a user-exec file by an unprivileged user clears sgid
+echo "Test 11 - qa_user, user-exec file $verb, only sgid"
+setup_testfile
+chmod a+rw,u+x,g+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a all-exec file by an unprivileged user clears sgid.
+echo "Test 12 - qa_user, all-exec file $verb, only sgid"
+setup_testfile
+chmod a+rwx,g+rwxs $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
 # success, all done
 status=0
 exit
diff --git a/tests/generic/686.out b/tests/generic/686.out
index 6a1179f1..aa1e6471 100644
--- a/tests/generic/686.out
+++ b/tests/generic/686.out
@@ -31,3 +31,19 @@ Test 8 - root, all-exec file finsert
 6777 -rwsrwsrwx TEST_DIR/686/a
 6777 -rwsrwsrwx TEST_DIR/686/a
 
+Test 9 - qa_user, non-exec file finsert, only sgid
+2666 -rw-rwSrw- TEST_DIR/686/a
+2666 -rw-rwSrw- TEST_DIR/686/a
+
+Test 10 - qa_user, group-exec file finsert, only sgid
+2676 -rw-rwsrw- TEST_DIR/686/a
+676 -rw-rwxrw- TEST_DIR/686/a
+
+Test 11 - qa_user, user-exec file finsert, only sgid
+2766 -rwxrwSrw- TEST_DIR/686/a
+2766 -rwxrwSrw- TEST_DIR/686/a
+
+Test 12 - qa_user, all-exec file finsert, only sgid
+2777 -rwxrwsrwx TEST_DIR/686/a
+777 -rwxrwxrwx TEST_DIR/686/a
+
diff --git a/tests/generic/687 b/tests/generic/687
index 7bdfcd5c..0bd421e5 100755
--- a/tests/generic/687
+++ b/tests/generic/687
@@ -61,67 +61,78 @@ commit_and_check() {
 	echo
 }
 
-nr=0
-# Commit to a non-exec file by an unprivileged user clears suid but
-# leaves sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, non-exec file $verb"
+# Commit to a non-exec file by an unprivileged user clears suid and sgid.
+echo "Test 1 - qa_user, non-exec file $verb"
 setup_testfile
 chmod a+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a group-exec file by an unprivileged user clears suid and
-# sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, group-exec file $verb"
+# Commit to a group-exec file by an unprivileged user clears suid and sgid.
+echo "Test 2 - qa_user, group-exec file $verb"
 setup_testfile
 chmod g+x,a+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a user-exec file by an unprivileged user clears suid but
-# not sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, user-exec file $verb"
+# Commit to a user-exec file by an unprivileged user clears suid and sgid.
+echo "Test 3 - qa_user, user-exec file $verb"
 setup_testfile
 chmod u+x,a+rws,g-x $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a all-exec file by an unprivileged user clears suid and
-# sgid.
-nr=$((nr + 1))
-echo "Test $nr - qa_user, all-exec file $verb"
+# Commit to a all-exec file by an unprivileged user clears suid and sgid.
+echo "Test 4 - qa_user, all-exec file $verb"
 setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
-# Commit to a non-exec file by root clears suid but leaves sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, non-exec file $verb"
+# Commit to a non-exec file by root leaves suid and sgid.
+echo "Test 5 - root, non-exec file $verb"
 setup_testfile
 chmod a+rws $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a group-exec file by root clears suid and sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, group-exec file $verb"
+# Commit to a group-exec file by root leaves suid and sgid.
+echo "Test 6 - root, group-exec file $verb"
 setup_testfile
 chmod g+x,a+rws $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a user-exec file by root clears suid but not sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, user-exec file $verb"
+# Commit to a user-exec file by root leaves suid and sgid.
+echo "Test 7 - root, user-exec file $verb"
 setup_testfile
 chmod u+x,a+rws,g-x $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a all-exec file by root clears suid and sgid.
-nr=$((nr + 1))
-echo "Test $nr - root, all-exec file $verb"
+# Commit to a all-exec file by root leaves suid and sgid.
+echo "Test 8 - root, all-exec file $verb"
 setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
+# Commit to a non-exec file by an unprivileged user leaves sgid.
+echo "Test 9 - qa_user, non-exec file $verb, only sgid"
+setup_testfile
+chmod a+rw,g+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a group-exec file by an unprivileged user clears sgid
+echo "Test 10 - qa_user, group-exec file $verb, only sgid"
+setup_testfile
+chmod a+rw,g+rwxs $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a user-exec file by an unprivileged user clears sgid
+echo "Test 11 - qa_user, user-exec file $verb, only sgid"
+setup_testfile
+chmod a+rw,u+x,g+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a all-exec file by an unprivileged user clears sgid.
+echo "Test 12 - qa_user, all-exec file $verb, only sgid"
+setup_testfile
+chmod a+rwx,g+rwxs $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
 # success, all done
 status=0
 exit
diff --git a/tests/generic/687.out b/tests/generic/687.out
index 7f945d72..c5116c27 100644
--- a/tests/generic/687.out
+++ b/tests/generic/687.out
@@ -31,3 +31,19 @@ Test 8 - root, all-exec file fcollapse
 6777 -rwsrwsrwx TEST_DIR/687/a
 6777 -rwsrwsrwx TEST_DIR/687/a
 
+Test 9 - qa_user, non-exec file fcollapse, only sgid
+2666 -rw-rwSrw- TEST_DIR/687/a
+2666 -rw-rwSrw- TEST_DIR/687/a
+
+Test 10 - qa_user, group-exec file fcollapse, only sgid
+2676 -rw-rwsrw- TEST_DIR/687/a
+676 -rw-rwxrw- TEST_DIR/687/a
+
+Test 11 - qa_user, user-exec file fcollapse, only sgid
+2766 -rwxrwSrw- TEST_DIR/687/a
+2766 -rwxrwSrw- TEST_DIR/687/a
+
+Test 12 - qa_user, all-exec file fcollapse, only sgid
+2777 -rwxrwsrwx TEST_DIR/687/a
+777 -rwxrwxrwx TEST_DIR/687/a
+
-- 
2.27.0

