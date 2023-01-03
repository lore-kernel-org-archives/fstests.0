Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB94C3DA7D
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Jan 2023 15:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjACP2h (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 3 Jan 2023 10:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjACP2g (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 3 Jan 2023 10:28:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA01101D8
        for <fstests@vger.kernel.org>; Tue,  3 Jan 2023 07:28:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4177B80D9F
        for <fstests@vger.kernel.org>; Tue,  3 Jan 2023 15:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5184CC433EF;
        Tue,  3 Jan 2023 15:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672759712;
        bh=Oi7CQzED3JPkJt0k+GEUAJ3KgV2hlR5H9UVIMTL7D54=;
        h=From:Date:Subject:To:Cc:From;
        b=Ob4tmacJlmmSA15h+vqAYDv2NZlAFK9TrBkyCGZMwZQzVivv/Aqx5mvARw5Q9z64V
         MqpmyEqABOh32msmpZHjGhulOBN09ycci6Mpjy9rAMp9fKX/AaTh6FQTO7Gnkg+dOn
         7NxdicDYy8VKgknHHyiZSoPTnnawXBQitQDcJYGqCDnU6ZDIEDSWt0ws+rnZ6/ZT1i
         KrhifSCd/DmlY8o+RtAfK1Tqmx+N7Omw6sn0jm11idjepBengJFWaRQlZ726tgaEuk
         E5ljyThcLLG2ErzZsnFzyxF6ZlOomh7LPRdP5sS+XXkzXbnoLZMALk7qdV/Ld6kpqf
         mK4Lou66B2W/g==
From:   Christian Brauner <brauner@kernel.org>
Date:   Tue, 03 Jan 2023 16:28:20 +0100
Subject: [PATCH] generic: update setgid tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-fstests-setgid-v6-2-v1-1-b8972c303ebe@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJRJtGMC/x2NwQqDMBAFf0X23IVkraX0V0oPMXnqgqQlG6Ug/
 ntDjzMwzEGGojB6dAcV7Gr6zg38paO4hDyDNTUmcdI773qerMKqsaHOmni/sfA1YrgPkryHUCvH
 YOCxhByX1uZtXZv8FEz6/a+er/P8AY8ALQl6AAAA
To:     fstests@vger.kernel.org
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Zorro Lang <zlang@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
X-Mailer: b4 0.12-dev-214b3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11235; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Oi7CQzED3JPkJt0k+GEUAJ3KgV2hlR5H9UVIMTL7D54=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRv8ZxnU/KLZ33VrdtzbyQwMTb27sthaEi6MenSNhbx5Vtf
 1r9n7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjICjaG/1EZmtO2udqfPb2TT2NGql
 r9vNS/i7S+lGpv+Pi7P3zVD3dGhk7FZ4HpF9YefCCxs+Wo2ar7sR4hhSV263g7Wx8nnXZX5gIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Over mutiple kernel releases we have reworked setgid inheritance
significantly due to long-standing security issues, security issues that
were reintroduced after they were fixed, and the subtle and difficult
inheritance rules that plagued individual filesystems. We have lifted
setgid inheritance into the VFS proper in earlier patches. Starting with
kernel v6.2 we have made setgid inheritance consistent between the write
and setattr (ch{mod,own}) paths.

The gist of the requirement is that in order to inherit the setgid bit
the user needs to be in the group of the file or have CAP_FSETID in
their user namespace. Otherwise the setgid bit will be dropped
irregardless of the file's executability. Change the tests accordingly
and annotate them with the commits that changed the behavior.

Note, that only with v6.2 setgid inheritance works correctly for
overlayfs in the write path. Before this the setgid bit was always
retained.

Link: https://lore.kernel.org/linux-ext4/CAOQ4uxhmCgyorYVtD6=n=khqwUc=MPbZs+y=sqt09XbGoNm_tA@mail.gmail.com
Link: https://lore.kernel.org/linux-fsdevel/20221212112053.99208-1-brauner@kernel.org
Link: https://lore.kernel.org/linux-fsdevel/20221122142010.zchf2jz2oymx55qi@wittgenstein
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 tests/generic/673     | 12 +++++++++---
 tests/generic/673.out |  8 ++++----
 tests/generic/683     | 11 ++++++++---
 tests/generic/683.out |  8 ++++----
 tests/generic/684     | 11 ++++++++---
 tests/generic/684.out |  8 ++++----
 tests/generic/685     | 11 ++++++++---
 tests/generic/685.out |  8 ++++----
 8 files changed, 49 insertions(+), 28 deletions(-)

diff --git a/tests/generic/673 b/tests/generic/673
index 6d1f49ea..1d8e4184 100755
--- a/tests/generic/673
+++ b/tests/generic/673
@@ -23,6 +23,12 @@ _require_scratch_reflink
 _scratch_mkfs >> $seqres.full
 _scratch_mount
 _require_congruent_file_oplen $SCRATCH_MNT 1048576
+
+# Due to multiple security issues and potential for subtle bugs around setgid
+# inheritance the rules in the write and chmod/chown paths have been made
+# consistent and are enforced by the VFS since kernel 6.2.
+_fixed_in_kernel_version "v6.2"
+
 chmod a+rw $SCRATCH_MNT/
 
 setup_testfile() {
@@ -102,8 +108,8 @@ setup_testfile
 chmod a+rwxs $SCRATCH_MNT/a
 commit_and_check
 
-#Commit to a non-exec file by an unprivileged user leaves sgid.
-echo "Test 9 - qa_user, non-exec file, only sgid"
+# Commit to a non-exec file by an unprivileged user clears sgid.
+echo "Test 9 - qa_user, non-exec file"
 setup_testfile
 chmod a+rw,g+rws $SCRATCH_MNT/a
 commit_and_check "$qa_user"
@@ -115,7 +121,7 @@ chmod a+rw,g+rwxs $SCRATCH_MNT/a
 commit_and_check "$qa_user"
 
 #Commit to a user-exec file by an unprivileged user clears sgid
-echo "Test 11 - qa_user, user-exec file, only sgid"
+echo "Test 11 - qa_user, user-exec file"
 setup_testfile
 chmod a+rw,u+x,g+rws $SCRATCH_MNT/a
 commit_and_check "$qa_user"
diff --git a/tests/generic/673.out b/tests/generic/673.out
index 0817857d..54e04232 100644
--- a/tests/generic/673.out
+++ b/tests/generic/673.out
@@ -47,11 +47,11 @@ Test 8 - root, all-exec file
 3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
 6777 -rwsrwsrwx SCRATCH_MNT/a
 
-Test 9 - qa_user, non-exec file, only sgid
+Test 9 - qa_user, non-exec file
 310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
 2666 -rw-rwSrw- SCRATCH_MNT/a
 3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
-2666 -rw-rwSrw- SCRATCH_MNT/a
+666 -rw-rw-rw- SCRATCH_MNT/a
 
 Test 10 - qa_user, group-exec file, only sgid
 310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
@@ -59,11 +59,11 @@ Test 10 - qa_user, group-exec file, only sgid
 3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
 676 -rw-rwxrw- SCRATCH_MNT/a
 
-Test 11 - qa_user, user-exec file, only sgid
+Test 11 - qa_user, user-exec file
 310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
 2766 -rwxrwSrw- SCRATCH_MNT/a
 3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
-2766 -rwxrwSrw- SCRATCH_MNT/a
+766 -rwxrw-rw- SCRATCH_MNT/a
 
 Test 12 - qa_user, all-exec file, only sgid
 310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
diff --git a/tests/generic/683 b/tests/generic/683
index eea8d21b..74b72e5b 100755
--- a/tests/generic/683
+++ b/tests/generic/683
@@ -30,6 +30,11 @@ verb=falloc
 _require_xfs_io_command $verb
 _require_congruent_file_oplen $TEST_DIR 65536
 
+# Due to multiple security issues and potential for subtle bugs around setgid
+# inheritance the rules in the write and chmod/chown paths have been made
+# consistent and are enforced by the VFS since kernel 6.2.
+_fixed_in_kernel_version "v6.2"
+
 junk_dir=$TEST_DIR/$seq
 junk_file=$junk_dir/a
 mkdir -p $junk_dir/
@@ -110,8 +115,8 @@ setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a non-exec file by an unprivileged user leaves sgid.
-echo "Test 9 - qa_user, non-exec file $verb, only sgid"
+# Commit to a non-exec file by an unprivileged user clears sgid.
+echo "Test 9 - qa_user, non-exec file $verb"
 setup_testfile
 chmod a+rw,g+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
@@ -123,7 +128,7 @@ chmod a+rw,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
 # Commit to a user-exec file by an unprivileged user clears sgid
-echo "Test 11 - qa_user, user-exec file $verb, only sgid"
+echo "Test 11 - qa_user, user-exec file $verb"
 setup_testfile
 chmod a+rw,u+x,g+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
diff --git a/tests/generic/683.out b/tests/generic/683.out
index ca29f6e6..a7e04e4a 100644
--- a/tests/generic/683.out
+++ b/tests/generic/683.out
@@ -31,17 +31,17 @@ Test 8 - root, all-exec file falloc
 6777 -rwsrwsrwx TEST_DIR/683/a
 6777 -rwsrwsrwx TEST_DIR/683/a
 
-Test 9 - qa_user, non-exec file falloc, only sgid
-2666 -rw-rwSrw- TEST_DIR/683/a
+Test 9 - qa_user, non-exec file falloc
 2666 -rw-rwSrw- TEST_DIR/683/a
+666 -rw-rw-rw- TEST_DIR/683/a
 
 Test 10 - qa_user, group-exec file falloc, only sgid
 2676 -rw-rwsrw- TEST_DIR/683/a
 676 -rw-rwxrw- TEST_DIR/683/a
 
-Test 11 - qa_user, user-exec file falloc, only sgid
-2766 -rwxrwSrw- TEST_DIR/683/a
+Test 11 - qa_user, user-exec file falloc
 2766 -rwxrwSrw- TEST_DIR/683/a
+766 -rwxrw-rw- TEST_DIR/683/a
 
 Test 12 - qa_user, all-exec file falloc, only sgid
 2777 -rwxrwsrwx TEST_DIR/683/a
diff --git a/tests/generic/684 b/tests/generic/684
index 541dbeb4..6fad7f75 100755
--- a/tests/generic/684
+++ b/tests/generic/684
@@ -30,6 +30,11 @@ verb=fpunch
 _require_xfs_io_command $verb
 _require_congruent_file_oplen $TEST_DIR 65536
 
+# Due to multiple security issues and potential for subtle bugs around setgid
+# inheritance the rules in the write and chmod/chown paths have been made
+# consistent and are enforced by the VFS since kernel 6.2.
+_fixed_in_kernel_version "v6.2"
+
 junk_dir=$TEST_DIR/$seq
 junk_file=$junk_dir/a
 mkdir -p $junk_dir/
@@ -110,8 +115,8 @@ setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a non-exec file by an unprivileged user leaves sgid.
-echo "Test 9 - qa_user, non-exec file $verb, only sgid"
+# Commit to a non-exec file by an unprivileged user clears sgid.
+echo "Test 9 - qa_user, non-exec file $verb"
 setup_testfile
 chmod a+rw,g+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
@@ -123,7 +128,7 @@ chmod a+rw,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
 # Commit to a user-exec file by an unprivileged user clears sgid
-echo "Test 11 - qa_user, user-exec file $verb, only sgid"
+echo "Test 11 - qa_user, user-exec file $verb"
 setup_testfile
 chmod a+rw,u+x,g+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
diff --git a/tests/generic/684.out b/tests/generic/684.out
index 2e084ced..5c803cd4 100644
--- a/tests/generic/684.out
+++ b/tests/generic/684.out
@@ -31,17 +31,17 @@ Test 8 - root, all-exec file fpunch
 6777 -rwsrwsrwx TEST_DIR/684/a
 6777 -rwsrwsrwx TEST_DIR/684/a
 
-Test 9 - qa_user, non-exec file fpunch, only sgid
-2666 -rw-rwSrw- TEST_DIR/684/a
+Test 9 - qa_user, non-exec file fpunch
 2666 -rw-rwSrw- TEST_DIR/684/a
+666 -rw-rw-rw- TEST_DIR/684/a
 
 Test 10 - qa_user, group-exec file fpunch, only sgid
 2676 -rw-rwsrw- TEST_DIR/684/a
 676 -rw-rwxrw- TEST_DIR/684/a
 
-Test 11 - qa_user, user-exec file fpunch, only sgid
-2766 -rwxrwSrw- TEST_DIR/684/a
+Test 11 - qa_user, user-exec file fpunch
 2766 -rwxrwSrw- TEST_DIR/684/a
+766 -rwxrw-rw- TEST_DIR/684/a
 
 Test 12 - qa_user, all-exec file fpunch, only sgid
 2777 -rwxrwsrwx TEST_DIR/684/a
diff --git a/tests/generic/685 b/tests/generic/685
index 29eca1a8..56be0a0c 100755
--- a/tests/generic/685
+++ b/tests/generic/685
@@ -30,6 +30,11 @@ verb=fzero
 _require_xfs_io_command $verb
 _require_congruent_file_oplen $TEST_DIR 65536
 
+# Due to multiple security issues and potential for subtle bugs around setgid
+# inheritance the rules in the write and chmod/chown paths have been made
+# consistent and are enforced by the VFS since kernel 6.2.
+_fixed_in_kernel_version "v6.2"
+
 junk_dir=$TEST_DIR/$seq
 junk_file=$junk_dir/a
 mkdir -p $junk_dir/
@@ -110,8 +115,8 @@ setup_testfile
 chmod a+rwxs $junk_file
 commit_and_check "" "$verb" 64k 64k
 
-# Commit to a non-exec file by an unprivileged user leaves sgid.
-echo "Test 9 - qa_user, non-exec file $verb, only sgid"
+# Commit to a non-exec file by an unprivileged user clears sgid.
+echo "Test 9 - qa_user, non-exec file $verb"
 setup_testfile
 chmod a+rw,g+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
@@ -123,7 +128,7 @@ chmod a+rw,g+rwxs $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
 
 # Commit to a user-exec file by an unprivileged user clears sgid
-echo "Test 11 - qa_user, user-exec file $verb, only sgid"
+echo "Test 11 - qa_user, user-exec file $verb"
 setup_testfile
 chmod a+rw,u+x,g+rws $junk_file
 commit_and_check "$qa_user" "$verb" 64k 64k
diff --git a/tests/generic/685.out b/tests/generic/685.out
index e611da3e..788457ba 100644
--- a/tests/generic/685.out
+++ b/tests/generic/685.out
@@ -31,17 +31,17 @@ Test 8 - root, all-exec file fzero
 6777 -rwsrwsrwx TEST_DIR/685/a
 6777 -rwsrwsrwx TEST_DIR/685/a
 
-Test 9 - qa_user, non-exec file fzero, only sgid
-2666 -rw-rwSrw- TEST_DIR/685/a
+Test 9 - qa_user, non-exec file fzero
 2666 -rw-rwSrw- TEST_DIR/685/a
+666 -rw-rw-rw- TEST_DIR/685/a
 
 Test 10 - qa_user, group-exec file fzero, only sgid
 2676 -rw-rwsrw- TEST_DIR/685/a
 676 -rw-rwxrw- TEST_DIR/685/a
 
-Test 11 - qa_user, user-exec file fzero, only sgid
-2766 -rwxrwSrw- TEST_DIR/685/a
+Test 11 - qa_user, user-exec file fzero
 2766 -rwxrwSrw- TEST_DIR/685/a
+766 -rwxrw-rw- TEST_DIR/685/a
 
 Test 12 - qa_user, all-exec file fzero, only sgid
 2777 -rwxrwsrwx TEST_DIR/685/a

---
base-commit: fbd489798b31e32f0eaefcd754326a06aa5b166f
change-id: 20230103-fstests-setgid-v6-2-4ce5852d11e2

Best regards,
-- 
Christian Brauner (Microsoft) <brauner@kernel.org>
