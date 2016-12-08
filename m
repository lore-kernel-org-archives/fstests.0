Received: from cn.fujitsu.com ([222.73.24.84]:48550 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1753177AbcLHCLW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 7 Dec 2016 21:11:22 -0500
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH 1/2] fstests: common: rename and enhance _require_btrfs to _require_btrfs_subcommand
Date: Thu,  8 Dec 2016 10:04:55 +0800
Message-Id: <20161208020456.16116-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Rename _require_btrfs() to _require_btrfs_subcommand() to avoid
confusion, as all other _require_btrfs_* has a quite clear suffix, like
_require_btrfs_mkfs_feature() or _require_btrfs_fs_feature().

Also enhance _require_btrfs_subcommand() to accept 2nd level commands or
options.
Options will be determined by the first "-" char.
This is quite useful for case like "btrfs inspect-internal dump-tree"
and "btrfs check --qgroup-report".

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 common/rc       | 29 ++++++++++++++++++++++++-----
 tests/btrfs/004 |  3 ++-
 tests/btrfs/048 |  2 +-
 tests/btrfs/059 |  2 +-
 tests/btrfs/131 |  2 +-
 5 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/common/rc b/common/rc
index 8c99306..1703232 100644
--- a/common/rc
+++ b/common/rc
@@ -3019,15 +3019,34 @@ _require_deletable_scratch_dev_pool()
 }
 
 # We check for btrfs and (optionally) features of the btrfs command
-_require_btrfs()
+# _require_btrfs_subcommand <subcommand> [<subfunction>|<option>]
+# It can handle both subfunction like "inspect-internal dump-tree"
+# and options like "check --qgroup-report"
+_require_btrfs_subcommand()
 {
-	cmd=$1
-	_require_command "$BTRFS_UTIL_PROG" btrfs
 	if [ -z "$1" ]; then
-		return 1;
+		echo "Usage: _require_btrfs_subcommand command [subcommand]" 1>&2
+		exit 1
 	fi
-	$BTRFS_UTIL_PROG $cmd --help >/dev/null 2>&1
+	cmd=$1
+	param=$2
+
+	_require_command "$BTRFS_UTIL_PROG" btrfs
+	$BTRFS_UTIL_PROG $cmd --help &>/dev/null
 	[ $? -eq 0 ] || _notrun "$BTRFS_UTIL_PROG too old (must support $cmd)"
+
+	test -z "$param" && return
+
+	# if $param is an option, replace leading "-"s for grep
+	if [ ${param:0:1} == "-" ]; then
+		param=$(echo $param | sed 's/^-*//')
+		$BTRFS_UTIL_PROG $cmd --help | grep $param > /dev/null || \
+			_not_run "$BTRFS_UTIL_PROG too old (must support $cmd $param)"
+		return
+	fi
+
+	$BTRFS_UTIL_PROG $cmd $param --help &>/dev/null
+	[ $? -eq 0 ] || _notrun "$BTRFS_UTIL_PROG too old (must support $cmd $param)"
 }
 
 # Check that fio is present, and it is able to execute given jobfile
diff --git a/tests/btrfs/004 b/tests/btrfs/004
index 905770a..e60a034 100755
--- a/tests/btrfs/004
+++ b/tests/btrfs/004
@@ -51,7 +51,8 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_no_large_scratch_dev
-_require_btrfs inspect-internal
+_require_btrfs_subcommand inspect-internal logical-resolve
+_require_btrfs_subcommand inspect-internal inode-resolve
 _require_command "/usr/sbin/filefrag" filefrag
 
 rm -f $seqres.full
diff --git a/tests/btrfs/048 b/tests/btrfs/048
index 0b907b0..ac731d1 100755
--- a/tests/btrfs/048
+++ b/tests/btrfs/048
@@ -48,7 +48,7 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_require_btrfs "property"
+_require_btrfs_subcommand "property"
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/059 b/tests/btrfs/059
index 8f106d2..fd67ebb 100755
--- a/tests/btrfs/059
+++ b/tests/btrfs/059
@@ -51,7 +51,7 @@ _supported_fs btrfs
 _supported_os Linux
 _require_test
 _require_scratch
-_require_btrfs "property"
+_require_btrfs_subcommand "property"
 
 rm -f $seqres.full
 
diff --git a/tests/btrfs/131 b/tests/btrfs/131
index d1a11d2..d7c7f12 100755
--- a/tests/btrfs/131
+++ b/tests/btrfs/131
@@ -48,7 +48,7 @@ rm -f $seqres.full
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-_require_btrfs inspect-internal
+_require_btrfs_subcommand inspect-internal dump-super
 
 mkfs_v1()
 {
-- 
2.7.4



