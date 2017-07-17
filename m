Received: from mail.kernel.org ([198.145.29.99]:40824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751402AbdGQSKQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 17 Jul 2017 14:10:16 -0400
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2] generic: add a less thorough testing mode for fsync-err program
Date: Mon, 17 Jul 2017 14:10:13 -0400
Message-Id: <20170717181013.19382-1-jlayton@kernel.org>
In-Reply-To: <20170629132947.29939-1-jlayton@kernel.org>
References: <20170629132947.29939-1-jlayton@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: dhowells@redhat.com, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

From: Jeff Layton <jlayton@redhat.com>

Currently we just have this test run on a whitelist of filesystems, but
it would be best to be able to run it on all of them. The problem is
that a lot of filesystems basically shut down once they hit metadata
errors.

Allow the fsync-err testcase to operate in two different modes. One
mode just does basic testing to ensure that we get an error back on
all fd's when we fsync. The other does a more thorough test to ensure
that we get back 0 on subsequent fsyncs when there hasn't been any
write activity.

For now, we just opt-in to the more thorough testing on certain
filesystems: xfs, ext3 and ext4 on the generic test. All other
filesystems will run in simple mode.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 common/rc         |  9 +++++++++
 src/fsync-err.c   | 51 +++++++++++++++++++++++++++++++++------------------
 tests/generic/441 | 23 ++++++++++++++++-------
 3 files changed, 58 insertions(+), 25 deletions(-)

v2: fix _has_logdev test, append command to seqres.full, fix comments

diff --git a/common/rc b/common/rc
index fa1314c649cf..737b773ec28c 100644
--- a/common/rc
+++ b/common/rc
@@ -1738,6 +1738,15 @@ _require_test()
     touch ${RESULT_DIR}/require_test
 }
 
+_has_logdev()
+{
+	ret=0
+	[ -z "$SCRATCH_LOGDEV" -o ! -b "$SCRATCH_LOGDEV" ] && ret=1
+	[ "$USE_EXTERNAL" != yes ] && ret=1
+
+	return $ret
+}
+
 # this test needs a logdev
 #
 _require_logdev()
diff --git a/src/fsync-err.c b/src/fsync-err.c
index 5b3bdd3ada07..4b0205cf2fd4 100644
--- a/src/fsync-err.c
+++ b/src/fsync-err.c
@@ -13,6 +13,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <getopt.h>
+#include <stdbool.h>
 
 /*
  * btrfs has a fixed stripewidth of 64k, so we need to write enough data to
@@ -25,7 +26,7 @@
 
 static void usage()
 {
-	printf("Usage: fsync-err [ -b bufsize ] [ -n num_fds ] -d dmerror path <filename>\n");
+	printf("Usage: fsync-err [ -b bufsize ] [ -n num_fds ] [ -s ] -d dmerror path <filename>\n");
 }
 
 int main(int argc, char **argv)
@@ -35,8 +36,9 @@ int main(int argc, char **argv)
 	char *dmerror_path = NULL;
 	char *cmdbuf;
 	size_t cmdsize, bufsize = DEFAULT_BUFSIZE;
+	bool simple_mode = false;
 
-	while ((i = getopt(argc, argv, "b:d:n:")) != -1) {
+	while ((i = getopt(argc, argv, "b:d:n:s")) != -1) {
 		switch (i) {
 		case 'b':
 			bufsize = strtol(optarg, &buf, 0);
@@ -55,6 +57,15 @@ int main(int argc, char **argv)
 				return 1;
 			}
 			break;
+		case 's':
+			/*
+			 * Many filesystems will continue to throw errors after
+			 * fsync has already advanced to the current error,
+			 * due to metadata writeback failures or other
+			 * issues. Allow those fs' to opt out of more thorough
+			 * testing.
+			 */
+			simple_mode = true;
 		}
 	}
 
@@ -154,16 +165,18 @@ int main(int argc, char **argv)
 		}
 	}
 
-	for (i = 0; i < numfds; ++i) {
-		ret = fsync(fd[i]);
-		if (ret < 0) {
-			/*
-			 * We did a failed write and fsync on each fd before.
-			 * Now the error should be clear since we've not done
-			 * any writes since then.
-			 */
-			printf("Third fsync on fd[%d] failed: %m\n", i);
-			return 1;
+	if (!simple_mode) {
+		for (i = 0; i < numfds; ++i) {
+			ret = fsync(fd[i]);
+			if (ret < 0) {
+				/*
+				 * We did a failed write and fsync on each fd before.
+				 * Now the error should be clear since we've not done
+				 * any writes since then.
+				 */
+				printf("Third fsync on fd[%d] failed: %m\n", i);
+				return 1;
+			}
 		}
 	}
 
@@ -185,12 +198,14 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	for (i = 0; i < numfds; ++i) {
-		ret = fsync(fd[i]);
-		if (ret < 0) {
-			/* The error should still be clear */
-			printf("fsync after healing device on fd[%d] failed: %m\n", i);
-			return 1;
+	if (!simple_mode) {
+		for (i = 0; i < numfds; ++i) {
+			ret = fsync(fd[i]);
+			if (ret < 0) {
+				/* The error should still be clear */
+				printf("fsync after healing device on fd[%d] failed: %m\n", i);
+				return 1;
+			}
 		}
 	}
 
diff --git a/tests/generic/441 b/tests/generic/441
index 2215b64db9a7..075d87723ca1 100755
--- a/tests/generic/441
+++ b/tests/generic/441
@@ -45,15 +45,23 @@ _cleanup()
 . ./common/dmerror
 
 # real QA test starts here
-_supported_fs ext2 ext3 ext4 xfs
 _supported_os Linux
 _require_scratch
 
-# Generally, we want to avoid journal errors in this test. Ensure that
-# journalled fs' have a logdev.
-if [ "$FSTYP" != "ext2" ]; then
-	_require_logdev
-fi
+# Generally, we want to avoid journal errors on the extended testcase. Only
+# unset the -s flag if we have a logdev
+sflag='-s'
+case $FSTYP in
+	btrfs)
+		_notrun "btrfs has a specialized test for this"
+		;;
+	ext3|ext4|xfs)
+		# Do the more thorough test if we have a logdev
+		_has_logdev && sflag=''
+		;;
+	*)
+		;;
+esac
 
 _require_dm_target error
 _require_test_program fsync-err
@@ -70,7 +78,8 @@ _require_fs_space $SCRATCH_MNT 65536
 
 testfile=$SCRATCH_MNT/fsync-err-test
 
-$here/src/fsync-err -d $here/src/dmerror $testfile
+echo "$here/src/fsync-err $sflag -d $here/src/dmerror $testfile" >> $seqres.full
+$here/src/fsync-err $sflag -d $here/src/dmerror $testfile
 
 # success, all done
 _dmerror_load_working_table
-- 
2.13.0

