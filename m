Received: from userp1040.oracle.com ([156.151.31.81]:32460 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755545AbcHYXar (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Aug 2016 19:30:47 -0400
Subject: [PATCH 04/13] generic/159,
 160: deal with EACCESS -> EPERM transition
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Thu, 25 Aug 2016 16:28:44 -0700
Message-ID: <147216772479.32641.3592660842211217853.stgit@birch.djwong.org>
In-Reply-To: <147216769914.32641.55434969009554013.stgit@birch.djwong.org>
References: <147216769914.32641.55434969009554013.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, eguan@redhat.com, darrick.wong@oracle.com
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

As of 4.8 we can receive EPERM (instead of EACCESS) for attempts to
reflink/dedupe to an immutable file.  Fix this up so that we accept
either answer.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/generic/159 |    6 +++++-
 tests/generic/160 |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)


diff --git a/tests/generic/159 b/tests/generic/159
index 8898d58..726333a 100755
--- a/tests/generic/159
+++ b/tests/generic/159
@@ -65,9 +65,13 @@ _pwrite_byte 0x61 0 $sz $testdir1/file1 >> $seqres.full
 _pwrite_byte 0x61 0 $sz $testdir1/file2 >> $seqres.full
 sync
 
+do_filter_output() {
+	_filter_test_dir | sed -e 's/Operation not permitted/Permission denied/g'
+}
+
 echo "Try reflink on immutable files"
 $CHATTR_PROG +i $testdir1/file1 $testdir1/file2
-_reflink_range $testdir1/file1 0 $testdir1/file2 0 $blksz 2>&1 | _filter_test_dir
+_reflink_range $testdir1/file1 0 $testdir1/file2 0 $blksz 2>&1 | do_filter_output
 $CHATTR_PROG -i $testdir1/file1 $testdir1/file2
 
 # success, all done
diff --git a/tests/generic/160 b/tests/generic/160
index 3a91dc8..4946bfc 100755
--- a/tests/generic/160
+++ b/tests/generic/160
@@ -65,9 +65,13 @@ _pwrite_byte 0x61 0 $sz $testdir1/file1 >> $seqres.full
 _pwrite_byte 0x61 0 $sz $testdir1/file2 >> $seqres.full
 sync
 
+do_filter_output() {
+	_filter_test_dir | sed -e 's/Operation not permitted/Permission denied/g'
+}
+
 echo "Try dedupe on immutable files"
 $CHATTR_PROG +i $testdir1/file1 $testdir1/file2
-_dedupe_range $testdir1/file1 0 $testdir1/file2 0 $blksz 2>&1 | _filter_test_dir
+_dedupe_range $testdir1/file1 0 $testdir1/file2 0 $blksz 2>&1 | do_filter_output
 $CHATTR_PROG -i $testdir1/file1 $testdir1/file2
 
 # success, all done

