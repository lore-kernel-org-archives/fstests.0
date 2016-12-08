Received: from cn.fujitsu.com ([222.73.24.84]:39199 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751567AbcLHIM7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 8 Dec 2016 03:12:59 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH v2 1/2] fstests: common: rename and enhance _require_btrfs to _require_btrfs_command
Date: Thu,  8 Dec 2016 16:12:12 +0800
Message-Id: <20161208081213.19675-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Rename _require_btrfs() to _require_btrfs_command() to avoid
confusion, as all other _require_btrfs_* has a quite clear suffix, like
_require_btrfs_mkfs_feature() or _require_btrfs_fs_feature().

Also enhance _require_btrfs_command() to accept 2nd level commands or
options.
Options will be determined by the first "-" char.
This is quite useful for case like "btrfs inspect-internal dump-tree"
and "btrfs check --qgroup-report".

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
v2:
  Replace _subcommand with _command.
  Rebase to latest master
  Use grep -w and -q to make it safer and less noisy
  Update the _notrun string
  Fix typo _not_run
---
 common/btrfs    | 22 ++++++++++++++++++++--
 tests/btrfs/004 |  3 ++-
 tests/btrfs/048 |  2 +-
 tests/btrfs/059 |  2 +-
 tests/btrfs/131 |  2 +-
 5 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index ab6497d..302edc6 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -10,16 +10,34 @@ _btrfs_get_subvolid()
 	$BTRFS_UTIL_PROG sub list $mnt | grep $name | awk '{ print $2 }'
 }
 
+# _require_btrfs_command <command> [<subcommand>|<option>]
 # We check for btrfs and (optionally) features of the btrfs command
-_require_btrfs()
+# It can both subfunction like "inspect-internal dump-tree" and
+# options like "check --qgroup-report"
+_require_btrfs_command()
 {
 	cmd=$1
+	param=$2
+
 	_require_command "$BTRFS_UTIL_PROG" btrfs
 	if [ -z "$1" ]; then
 		return 1;
 	fi
-	$BTRFS_UTIL_PROG $cmd --help >/dev/null 2>&1
+	$BTRFS_UTIL_PROG $cmd --help &> /dev/null
 	[ $? -eq 0 ] || _notrun "$BTRFS_UTIL_PROG too old (must support $cmd)"
+
+	test -z "$param" && return
+
+	# If $param is an option, replace leading "-"s for grep
+	if [ ${param:0:1} == "-" ]; then
+		safe_param=$(echo $param | sed 's/^-*//')
+		$BTRFS_UTIL_PROG $cmd --help | grep -wq $safe_param || \
+			_notrun "$BTRFS_UTIL_PROG too old (must support $cmd $param)"
+		return
+	fi
+
+	$BTRFS_UTIL_PROG $cmd $param --help &> /dev/null
+	[ $? -eq 0 ] || _notrun "$BTRFS_UTIL_PROG too old (must support $cmd $param)"
 }
 
 _run_btrfs_util_prog()
diff --git a/tests/btrfs/004 b/tests/btrfs/004
index 905770a..3f8330f 100755
--- a/tests/btrfs/004
+++ b/tests/btrfs/004
@@ -51,7 +51,8 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_no_large_scratch_dev
-_require_btrfs inspect-internal
+_require_btrfs_command inspect-internal logical-resolve
+_require_btrfs_command inspect-internal inode-resolve
 _require_command "/usr/sbin/filefrag" filefrag
 
 rm -f $seqres.full
diff --git a/tests/btrfs/048 b/tests/btrfs/048
index 0b907b0..e03b3c5 100755
--- a/tests/btrfs/048
+++ b/tests/btrfs/048
@@ -48,7 +48,7 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_require_btrfs "property"
+_require_btrfs_command "property"
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/059 b/tests/btrfs/059
index 8f106d2..2d1ec23 100755
--- a/tests/btrfs/059
+++ b/tests/btrfs/059
@@ -51,7 +51,7 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_require_btrfs "property"
+_require_btrfs_command "property"
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/131 b/tests/btrfs/131
index d1a11d2..ce486e6 100755
--- a/tests/btrfs/131
+++ b/tests/btrfs/131
@@ -48,7 +48,7 @@ rm -f $seqres.full
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_btrfs inspect-internal
+_require_btrfs_command inspect-internal dump-super
 
 mkfs_v1()
 {
-- 
2.7.4



