Received: from mail-wr0-f194.google.com ([209.85.128.194]:37878 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbeAWU6R (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 23 Jan 2018 15:58:17 -0500
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 2/7] generic/exportfs: golden output is not silent
Date: Tue, 23 Jan 2018 22:59:07 +0200
Message-Id: <1516741152-20345-3-git-send-email-amir73il@gmail.com>
In-Reply-To: <1516741152-20345-1-git-send-email-amir73il@gmail.com>
References: <1516741152-20345-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/generic/426     | 1 -
 tests/generic/426.out | 1 -
 tests/generic/467     | 1 -
 tests/generic/467.out | 1 -
 4 files changed, 4 deletions(-)

diff --git a/tests/generic/426 b/tests/generic/426
index 68ff169..17639bb 100755
--- a/tests/generic/426
+++ b/tests/generic/426
@@ -90,6 +90,5 @@ create_test_files $testdir
 test_file_handles $testdir -l
 test_file_handles $testdir -u
 
-echo "Silence is golden"
 status=0
 exit
diff --git a/tests/generic/426.out b/tests/generic/426.out
index 9a25123..b84e005 100644
--- a/tests/generic/426.out
+++ b/tests/generic/426.out
@@ -3,4 +3,3 @@ test_file_handles TEST_DIR/426-dir -d
 test_file_handles TEST_DIR/426-dir
 test_file_handles TEST_DIR/426-dir -l
 test_file_handles TEST_DIR/426-dir -u
-Silence is golden
diff --git a/tests/generic/467 b/tests/generic/467
index 6ff9270..56dfcbd 100755
--- a/tests/generic/467
+++ b/tests/generic/467
@@ -114,6 +114,5 @@ mkdir -p $testdir.new
 mv $testdir/* $testdir.new/
 test_file_handles $testdir.new -rp
 
-echo "Silence is golden"
 status=0
 exit
diff --git a/tests/generic/467.out b/tests/generic/467.out
index c649aa0..39d6a95 100644
--- a/tests/generic/467.out
+++ b/tests/generic/467.out
@@ -7,4 +7,3 @@ test_file_handles TEST_DIR/467-dir -ur
 test_file_handles TEST_DIR/467-dir -mr
 test_file_handles TEST_DIR/467-dir.renamed -rp
 test_file_handles TEST_DIR/467-dir.new -rp
-Silence is golden
-- 
2.7.4

