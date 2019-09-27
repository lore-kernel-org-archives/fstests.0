Received: from szxga05-in.huawei.com ([45.249.212.191]:3228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfI0KHF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Sep 2019 06:07:05 -0400
From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] common/defrag: support f2fs
Date: Fri, 27 Sep 2019 18:06:26 +0800
Message-ID: <20190927100627.9086-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

F2FS supports defragment based on file granularity, adjust test suit
to support f2fs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 common/config |  2 ++
 common/defrag | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/common/config b/common/config
index 4c86a492..c43be339 100644
--- a/common/config
+++ b/common/config
@@ -176,6 +176,7 @@ export XFS_COPY_PROG="$(type -P xfs_copy)"
 export FSTRIM_PROG="$(type -P fstrim)"
 export DUMPE2FS_PROG="$(type -P dumpe2fs)"
 export RESIZE2FS_PROG="$(type -P resize2fs)"
+export F2FS_IO_PROG="$(type -P f2fs_io)"
 export FIO_PROG="$(type -P fio)"
 export FILEFRAG_PROG="$(type -P filefrag)"
 export E4DEFRAG_PROG="$(type -P e4defrag)"
@@ -240,6 +241,7 @@ case "$HOSTOS" in
 	export MKFS_BTRFS_PROG=$(set_mkfs_prog_path_with_opts btrfs)
 	export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
 	export DUMP_F2FS_PROG=$(type -P dump.f2fs)
+	export F2FS_IO_PROG=$(type -P f2fs_io)
 	export BTRFS_UTIL_PROG=$(type -P btrfs)
 	export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
 	export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
diff --git a/common/defrag b/common/defrag
index 2bd739c0..9866d3da 100644
--- a/common/defrag
+++ b/common/defrag
@@ -27,6 +27,9 @@ _require_defrag()
 	rm -f $testfile $donorfile 2>&1 > /dev/null
 	DEFRAG_PROG="$E4DEFRAG_PROG"
 	;;
+    f2fs)
+	DEFRAG_PROG="$F2FS_IO_PROG defrag_file"
+	;;
     btrfs)
 	DEFRAG_PROG="$BTRFS_UTIL_PROG filesystem defragment"
 	;;
@@ -140,7 +143,13 @@ _defrag()
 
 	[ ! -z $csum ] && CSUM_BEFORE=`md5sum $1`
 	STAT_BEFORE=`stat -c "a: %x m: %y c: %z" $1`
-	$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
+
+	if [ $FSTYP == "f2fs" ]; then
+		_filesize=`ls -l $1 | $AWK_PROG '{print $5}'`
+		$DEFRAG_PROG 0 $_filesize $1 >> $seqres.full 2>&1
+	else
+		$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
+	fi
 
 	_scratch_cycle_mount
 	STAT_AFTER=`stat -c "a: %x m: %y c: %z" $1`
-- 
2.18.0.rc1
