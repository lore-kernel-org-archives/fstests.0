Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6A2C432BE
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Aug 2021 11:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9171E61131
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Aug 2021 11:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbhH3Lm7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Aug 2021 07:42:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49928 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236430AbhH3Lm6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Aug 2021 07:42:58 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17UBg2Lc025474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Aug 2021 07:42:02 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 110A115C3CE6; Mon, 30 Aug 2021 07:42:02 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] common/filter: add _filter_bash()
Date:   Mon, 30 Aug 2021 07:41:56 -0400
Message-Id: <20210830114156.1106699-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This is needed to account for bash 5.1 adding line number annotation
when a command like "bash -c /etc/passwd" fails, e.g., with

     bash: line 1: /etc/passwd: Permission denid

instead of:

     bash: /etc/passwd: Permission denid

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/filter     | 11 +++++++++++
 tests/generic/572 | 33 +++++++++++++++++++--------------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/common/filter b/common/filter
index 2efbbd99..4b250e8b 100644
--- a/common/filter
+++ b/common/filter
@@ -661,5 +661,16 @@ _filter_quota_report()
 		s|^(.*?) (\d+) (\d+) (\d+)|$1 @{[$2 * 1024 /'$bsize']} @{[$3 * 1024 /'$bsize']} @{[$4 * 1024 /'$bsize']}|'
 }
 
+#
+# Bash 5.1+ adds "line 1: " when printing an error running an executable
+# for example, "bash -c /etc/passwd" will result in the error
+# "bash: line 1: /etc/passwd: Permission denied" where as earlier
+# versions of bash will omit the "line 1: " annotation.
+#
+_filter_bash()
+{
+	sed -e "s/^bash: line 1: /bash: /"
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/generic/572 b/tests/generic/572
index f131c7ed..cded9ac6 100755
--- a/tests/generic/572
+++ b/tests/generic/572
@@ -36,6 +36,11 @@ _scratch_mount
 fsv_orig_file=$SCRATCH_MNT/file
 fsv_file=$SCRATCH_MNT/file.fsv
 
+filter_output()
+{
+    _filter_bash | _filter_scratch
+}
+
 verify_data_readable()
 {
 	local file=$1
@@ -48,41 +53,41 @@ verify_data_unreadable()
 	local file=$1
 
 	# try both reading just the first data block, and reading until EOF
-	head -c $FSV_BLOCK_SIZE $file 2>&1 >/dev/null | _filter_scratch
-	md5sum $file |& _filter_scratch
+	head -c $FSV_BLOCK_SIZE $file 2>&1 >/dev/null | filter_output
+	md5sum $file |& filter_output
 }
 
 _fsv_scratch_begin_subtest "Enabling verity on file with verity already enabled fails with EEXIST"
 _fsv_create_enable_file $fsv_file
 echo "(trying again)"
-_fsv_enable $fsv_file |& _filter_scratch
+_fsv_enable $fsv_file |& filter_output
 
 _fsv_scratch_begin_subtest "Enabling verity with invalid hash algorithm fails with EINVAL"
-_fsv_create_enable_file $fsv_file --hash-alg=257 |& _filter_scratch
+_fsv_create_enable_file $fsv_file --hash-alg=257 |& filter_output
 verify_data_readable $fsv_file
 
 _fsv_scratch_begin_subtest "Enabling verity with invalid block size fails with EINVAL"
-_fsv_create_enable_file $fsv_file --block-size=1 |& _filter_scratch
+_fsv_create_enable_file $fsv_file --block-size=1 |& filter_output
 verify_data_readable $fsv_file
 
 _fsv_scratch_begin_subtest "Enabling verity on directory fails with EISDIR"
 mkdir $SCRATCH_MNT/dir
-_fsv_enable $SCRATCH_MNT/dir |& _filter_scratch
+_fsv_enable $SCRATCH_MNT/dir |& filter_output
 
 _fsv_scratch_begin_subtest "Enabling verity with too-long salt fails with EMSGSIZE"
-_fsv_create_enable_file $fsv_file --salt=$(perl -e 'print "A" x 1000') |& _filter_scratch
+_fsv_create_enable_file $fsv_file --salt=$(perl -e 'print "A" x 1000') |& filter_output
 verify_data_readable $fsv_file
 
 _fsv_scratch_begin_subtest "Enabling verity on file on read-only filesystem fails with EROFS"
 echo foo > $fsv_file
 _scratch_remount ro
-_fsv_enable $fsv_file |& _filter_scratch
+_fsv_enable $fsv_file |& filter_output
 _scratch_remount rw
 
 _fsv_scratch_begin_subtest "Enabling verity on file open for writing fails with ETXTBSY"
 echo foo > $fsv_file
 exec 3<> $fsv_file
-_fsv_enable $fsv_file |& _filter_scratch
+_fsv_enable $fsv_file |& filter_output
 exec 3<&-
 verify_data_readable $fsv_file
 
@@ -103,7 +108,7 @@ dd if=/dev/zero of=$fsv_file bs=1 count=0 seek=$((1 << 34)) status=none
 start_time=$(date +%s)
 $FSVERITY_PROG enable $fsv_file &
 sleep 0.5
-_fsv_enable $fsv_file |& _filter_scratch
+_fsv_enable $fsv_file |& filter_output
 kill %1
 wait
 
@@ -112,11 +117,11 @@ _fsv_create_enable_file $fsv_file >> $seqres.full
 echo "* reading"
 $XFS_IO_PROG -r $fsv_file -c ''
 echo "* xfs_io writing, should be O_RDWR"
-$XFS_IO_PROG $fsv_file -c '' |& _filter_scratch
+$XFS_IO_PROG $fsv_file -c '' |& filter_output
 echo "* bash >>, should be O_APPEND"
-bash -c "echo >> $fsv_file" |& _filter_scratch
+bash -c "echo >> $fsv_file" |& filter_output
 echo "* bash >, should be O_WRONLY|O_CREAT|O_TRUNC"
-bash -c "echo > $fsv_file" |& _filter_scratch
+bash -c "echo > $fsv_file" |& filter_output
 
 _fsv_scratch_begin_subtest "verity file can be read"
 _fsv_create_enable_file $fsv_file >> $seqres.full
@@ -160,7 +165,7 @@ _get_filesize $fsv_file
 
 _fsv_scratch_begin_subtest "Trying to measure non-verity file fails with ENODATA"
 echo foo > $fsv_file
-_fsv_measure $fsv_file |& _filter_scratch
+_fsv_measure $fsv_file |& filter_output
 verify_data_readable $fsv_file
 
 # Test files <= 1 block in size.  These are a bit of a special case since there
-- 
2.31.0

