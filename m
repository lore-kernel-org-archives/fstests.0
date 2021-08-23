Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107CCC4338F
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Aug 2021 20:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D849460C51
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Aug 2021 20:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhHWUX2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 23 Aug 2021 16:23:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41096 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232016AbhHWUX1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Aug 2021 16:23:27 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17NKMZP3009496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 16:22:36 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 730A715C3DBB; Mon, 23 Aug 2021 16:22:35 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     Eryu Guan <guan@eryu.me>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v2] ext4: add test to validate the large_dir feature
Date:   Mon, 23 Aug 2021 16:22:31 -0400
Message-Id: <20210823202231.1776276-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <YQ/ixFR3Q4ucAFP3@desktop>
References: <YQ/ixFR3Q4ucAFP3@desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The ext4 large_dir feature supports a directory hash tree with a depth
greater than 2.  Reuse the dirstress program to create a sufficiently
large directory in order to exercise the large_dir code paths.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

Changes from v1:
  - Address review comments
     + Add comments describing how the test works
     + Remove debugging lines
  - Rename the test to ext4/052 since ext4/051 has been used

 src/dirstress.c    |  7 ++++-
 tests/ext4/052     | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/052.out |  2 ++
 3 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100755 tests/ext4/052
 create mode 100644 tests/ext4/052.out

diff --git a/src/dirstress.c b/src/dirstress.c
index 615cb6e3..ec28d643 100644
--- a/src/dirstress.c
+++ b/src/dirstress.c
@@ -16,6 +16,7 @@ int verbose;
 int pid;
 
 int checkflag=0;
+int create_only=0;
 
 #define MKNOD_DEV 0
 
@@ -51,7 +52,7 @@ main(
 	nprocs_per_dir = 1;
 	keep = 0;
         verbose = 0;
-	while ((c = getopt(argc, argv, "d:p:f:s:n:kvc")) != EOF) {
+	while ((c = getopt(argc, argv, "d:p:f:s:n:kvcC")) != EOF) {
 		switch(c) {
 			case 'p':
 				nprocs = atoi(optarg);
@@ -80,6 +81,9 @@ main(
 			case 'c':
                                 checkflag++;
                                 break;
+			case 'C':
+				create_only++;
+				break;
 		}
 	}
 	if (errflg || (dirname == NULL)) {
@@ -170,6 +174,7 @@ dirstress(
 	if (create_entries(nfiles)) {
             printf("!! [%d] create failed\n", pid);
         } else {
+	    if (create_only) return 0;
             if (verbose) fprintf(stderr,"** [%d] scramble entries\n", pid);
 	    if (scramble_entries(nfiles)) {
                 printf("!! [%d] scramble failed\n", pid);
diff --git a/tests/ext4/052 b/tests/ext4/052
new file mode 100755
index 00000000..81d5582e
--- /dev/null
+++ b/tests/ext4/052
@@ -0,0 +1,70 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test 052
+#
+# Test ext4's large_dir feature
+#
+# Create a directory with enough entries that we can exercise the large_dir
+# code paths, and then verify that the resulting file system is valid using
+# e2fsck.
+#
+. ./common/preamble
+_begin_fstest auto quick dir
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+	if [ ! -z "$loop_mnt" ]; then
+		$UMOUNT_PROG $loop_mnt
+		rm -rf $loop_mnt
+	fi
+	[ ! -z "$fs_img" ] && rm -rf $fs_img
+}
+
+# Import common functions.
+# . ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs ext4
+_require_test
+_require_loop
+_require_scratch_ext4_feature "large_dir"
+
+echo "Silence is golden"
+
+loop_mnt=$TEST_DIR/$seq.mnt
+fs_img=$TEST_DIR/$seq.img
+status=0
+
+$XFS_IO_PROG -f -c "truncate 20G" $fs_img >>$seqres.full 2>&1
+
+# We need to create enough files (400,000) so that using a file system
+# with a 1k block size, the hash tree created will have three levels
+# (which is the distringuishing characteristics of a large_dir versus
+# non-large_dir).  We use no journal mode to decrease the run time of
+# the test by 25%.
+${MKFS_PROG} -t ${FSTYP} -b 1024 -N 400020 -O large_dir,^has_journal \
+	     $fs_img 20G >> $seqres.full 2>&1 || _fail "mkfs failed"
+
+mkdir -p $loop_mnt
+_mount -o loop $fs_img $loop_mnt > /dev/null  2>&1 || \
+	_fail "Couldn't do initial mount"
+
+if ! $here/src/dirstress -c -d $loop_mnt -p 1 -f 400000 -C >$tmp.out 2>&1
+then
+    echo "    dirstress failed"
+    cat $tmp.out >> $seqres.full
+    echo "    dirstress failed" >> $seqres.full
+    status=1
+fi
+
+$UMOUNT_PROG $loop_mnt || _fail "umount failed"
+loop_mnt=
+
+$E2FSCK_PROG -fn $fs_img >> $seqres.full 2>&1 || _fail "file system corrupted"
+exit
diff --git a/tests/ext4/052.out b/tests/ext4/052.out
new file mode 100644
index 00000000..93f6b038
--- /dev/null
+++ b/tests/ext4/052.out
@@ -0,0 +1,2 @@
+QA output created by 052
+Silence is golden
-- 
2.31.0

