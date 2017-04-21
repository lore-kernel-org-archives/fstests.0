Received: from cn.fujitsu.com ([59.151.112.132]:64519 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1037683AbdDUKKw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 21 Apr 2017 06:10:52 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH 2/2] btrfs: use $FILEFRAG_PROG instead of filefrag
Date: Fri, 21 Apr 2017 18:10:40 +0800
Message-ID: <1492769440-12413-2-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <1492769440-12413-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1492769440-12413-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

$FILEFRAG_PROG has been defined in common/config, so
we could apply it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/btrfs/004 | 4 ++--
 tests/btrfs/079 | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/004 b/tests/btrfs/004
index 3f8330f..1b5b124 100755
--- a/tests/btrfs/004
+++ b/tests/btrfs/004
@@ -53,7 +53,7 @@ _require_scratch
 _require_no_large_scratch_dev
 _require_btrfs_command inspect-internal logical-resolve
 _require_btrfs_command inspect-internal inode-resolve
-_require_command "/usr/sbin/filefrag" filefrag
+_require_command "$FILEFRAG_PROG" filefrag
 
 rm -f $seqres.full
 
@@ -82,7 +82,7 @@ _filter_extents()
 
 _check_file_extents()
 {
-	cmd="filefrag -v $1"
+	cmd="$FILEFRAG_PROG -v $1"
 	echo "# $cmd" >> $seqres.full
 	out=`$cmd | _filter_extents`
 	if [ -z "$out" ]; then
diff --git a/tests/btrfs/079 b/tests/btrfs/079
index ed4eb72..560d5ec 100755
--- a/tests/btrfs/079
+++ b/tests/btrfs/079
@@ -60,7 +60,7 @@ _supported_os Linux
 _require_scratch
 # Since xfs_io's fiemap always use SYNC flag and can't be unset,
 # we must use filefrag to call fiemap without SYNC flag.
-_require_command "/usr/sbin/filefrag" filefrag
+_require_command "$FILEFRAG_PROG" filefrag
 _require_xfs_io_command "falloc"
 
 filesize=$((10 * 1024 * 1024 * 1024)) #10G size
@@ -95,7 +95,7 @@ _filter_error() {
 fiemap_work() {
 	filename=$1
 	while true; do
-		filefrag $filename 2> $tmp.output 1> /dev/null
+		$FILEFRAG_PROG $filename 2> $tmp.output 1> /dev/null
 		ret=$?
 		err=`cat $tmp.output | _filter_error`
 		if [ $ret -ne 0 -o -n "$err" ]; then
-- 
1.8.3.1



