Return-Path: <SRS0=IhtW=IG=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B669C433DB
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Mar 2021 01:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F32B65146
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Mar 2021 01:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhCHBX0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 7 Mar 2021 20:23:26 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47944 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232273AbhCHBXB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Mar 2021 20:23:01 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1281Mqs0014635
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 7 Mar 2021 20:22:53 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 57A0215C3AAC; Sun,  7 Mar 2021 20:22:52 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v2] generic: test which tries to exercise AIO/DIO into unwritten space
Date:   Sun,  7 Mar 2021 20:22:47 -0500
Message-Id: <20210308012247.15250-1-tytso@mit.edu>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <YEVdqb9kcOV004ZO@mit.edu>
References: <YEVdqb9kcOV004ZO@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test verifies that the an unwritten extent is properly marked as
written after writing into it.

There was a hard-to-hit bug which would occasionally trigger with ext4
for which this test was a reproducer.  This has been fixed after
moving ext4 to use iomap for Direct I/O's, although as of this
writing, there are still some occasional failures on ext4 when block
size < page size.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

Differences between v1 and v2:
* Addressed review comments from Eryu
* Renumbered from generic/623 to generic/630 (since 623 has been assigned)

 tests/generic/630     | 105 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/630.out |   4 ++
 tests/generic/group   |   1 +
 3 files changed, 110 insertions(+)
 create mode 100755 tests/generic/630
 create mode 100644 tests/generic/630.out

diff --git a/tests/generic/630 b/tests/generic/630
new file mode 100755
index 00000000..7a04b899
--- /dev/null
+++ b/tests/generic/630
@@ -0,0 +1,105 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+#
+# FSQA Test No. 630
+#
+# AIO/DIO stress test
+# Run random AIO/DIO activity on an file system with unwritten regions
+#
+# This test verifies that the an unwritten extent is properly marked
+# as written after writing into it.
+#
+# There was a hard-to-hit bug which would occasionally trigger with
+# ext4 for which this test was a reproducer.  This has been fixed
+# after moving ext4 to use iomap for Direct I/O's, although as of this
+# writing, there are still some occasional failures on ext4 when block
+# size < page size.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+fio_config=$tmp.fio
+fio_out=$tmp.fio.out
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+    rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_require_test
+_require_scratch
+_require_odirect
+_require_aio
+_require_block_device $SCRATCH_DEV
+
+NUM_JOBS=$((4*LOAD_FACTOR))
+BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
+FILE_SIZE=$(((BLK_DEV_SIZE * 512) * 3 / 4))
+
+max_file_size=$((5 * 1024 * 1024 * 1024))
+if [ $max_file_size -lt $FILE_SIZE ]; then
+	FILE_SIZE=$max_file_size
+fi
+SIZE=$((FILE_SIZE / 2))
+
+cat >$fio_config <<EOF
+###########
+# $seq test fio activity
+# Filenames derived from jobsname and jobid like follows:
+# ${JOB_NAME}.${JOB_ID}.${ITERATION_ID}
+[global]
+ioengine=libaio
+bs=128k
+directory=${SCRATCH_MNT}
+filesize=${FILE_SIZE}
+size=${FILE_SIZE}
+io_size=${SIZE}
+iodepth=$((128*$LOAD_FACTOR))
+fallocate=native
+
+# Perform direct aio and verify data
+# This test case should check use-after-free issues
+[aio-dio-verifier]
+numjobs=1
+verify=crc32c-intel
+verify_fatal=1
+verify_dump=1
+verify_backlog=1024
+verify_async=4
+direct=1
+random_generator=lfsr
+blocksize_range=4k-8200k
+rw=randwrite
+filename=test-file
+
+EOF
+
+rm -f $seqres.full
+
+_require_fio $fio_config
+_require_xfs_io_command "falloc"
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+echo ""
+echo "Run fio with random aio-dio pattern"
+echo ""
+cat $fio_config >> $seqres.full
+$FIO_PROG $fio_config --output=$fio_out
+cat $fio_out >> $seqres.full
+
+status=0
+exit
diff --git a/tests/generic/630.out b/tests/generic/630.out
new file mode 100644
index 00000000..7f3adb50
--- /dev/null
+++ b/tests/generic/630.out
@@ -0,0 +1,4 @@
+QA output created by 630
+
+Run fio with random aio-dio pattern
+
diff --git a/tests/generic/group b/tests/generic/group
index 84db3789..1ff896a1 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -628,3 +628,4 @@
 623 auto quick shutdown
 624 auto quick verity
 625 auto quick verity
+630 aio rw stress
-- 
2.30.0

