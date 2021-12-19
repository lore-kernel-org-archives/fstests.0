Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4295BC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Dec 2021 04:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhLSEQt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 18 Dec 2021 23:16:49 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50025 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229648AbhLSEQt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 18 Dec 2021 23:16:49 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BJ4GhII018501
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Dec 2021 23:16:44 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 999E115C00C8; Sat, 18 Dec 2021 23:16:43 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     ebiggers@kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v2] common/filter: add _filter_bash()
Date:   Sat, 18 Dec 2021 23:16:38 -0500
Message-Id: <20211219041638.1659557-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <Yb6aLm5L+C7H3Z9P@quark.localdomain>
References: <Yb6aLm5L+C7H3Z9P@quark.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This is needed to account for bash 5.1 adding line number annotation
when executing a command via the -c option and it fails.  For example,
"bash -c 'echo foo > /'" will cause bash 5.1 to report:

     bash: line 1: /: Is a directory

instead of:

     bash: /: Is a directory

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/filter     | 11 +++++++++++
 tests/generic/572 | 33 +++++++++++++++++++--------------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/common/filter b/common/filter
index 2efbbd99..c3db7a56 100644
--- a/common/filter
+++ b/common/filter
@@ -661,5 +661,16 @@ _filter_quota_report()
 		s|^(.*?) (\d+) (\d+) (\d+)|$1 @{[$2 * 1024 /'$bsize']} @{[$3 * 1024 /'$bsize']} @{[$4 * 1024 /'$bsize']}|'
 }
 
+#
+# Bash 5.1+ adds "line 1: " when reporting an error when running a
+# command via the -c option.  For example, "bash -c 'echo foo > /'"
+# will result in the error "bash: line 1: /: Is a directory" when
+# earlier versions of bash would omit the "line 1: " annotation.
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

