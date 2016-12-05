Received: from mx1.redhat.com ([209.132.183.28]:35156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750849AbcLEInr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 5 Dec 2016 03:43:47 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D816A58BB
        for <fstests@vger.kernel.org>; Mon,  5 Dec 2016 08:43:46 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v3] fstests: teach _scratch_mkfs to handle mkfs option conflicts
Date: Mon,  5 Dec 2016 16:42:56 +0800
Message-Id: <20161205084256.4593-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Currently in _scratch_mkfs only xfs and ext4 could handle the mkfs
failure caused by conflicts between $MKFS_OPTIONS and mkfs options
specified by tests, because of _scratch_mkfs_xfs and
_scratch_mkfs_ext4. This is a very useful functionality that allows
tests to specify mkfs options safely and to test specific fs
configurations, without worrying about mkfs failures caused by these
options.

Now teach _scratch_mkfs to handle such mkfs option conflicts for
other filesystems too, i.e. mkfs again only with mkfs options
specified by tests. Also add the ability to filter unnecessary
messages from mkfs stderr.

Also update some btrfs tests to throw away _scratch_mkfs stdout,
because previously _scratch_mkfs did this for btrfs.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---

v3:
- rebase against master HEAD, some changes go to common/xfs

v2:
- return in each case if fstyp is special-handled in _scratch_mkfs
- introduce _scratch_do_mkfs helper and convert _scratch_mkfs_xfs and
  _scratch_mkfs_ext4 to use it too. I'm not good at naming functions,
  please suggest if it's badly named..
- update some btrfs tests to avoid failures caused by mkfs stdout output

 common/rc       | 180 +++++++++++++++++++++++++++++++++-----------------------
 common/xfs      |  47 ++++-----------
 tests/btrfs/028 |   2 +-
 tests/btrfs/121 |   2 +-
 tests/btrfs/122 |   2 +-
 tests/btrfs/123 |   2 +-
 tests/btrfs/126 |   2 +-
 7 files changed, 126 insertions(+), 111 deletions(-)

diff --git a/common/rc b/common/rc
index 2719b23..7e45c14 100644
--- a/common/rc
+++ b/common/rc
@@ -410,6 +410,52 @@ _scratch_mkfs_options()
     echo $SCRATCH_OPTIONS $MKFS_OPTIONS $* $SCRATCH_DEV
 }
 
+# Do the actual mkfs work on SCRATCH_DEV. Firstly mkfs with both MKFS_OPTIONS
+# and user specified mkfs options, if that fails (due to conflicts between mkfs
+# options), do a second mkfs with only user provided mkfs options.
+#
+# First param is the mkfs command without any mkfs optoins and device.
+# Second param is the filter to remove unnecessary messages from mkfs stderr.
+# Other extra mkfs options are followed.
+_scratch_do_mkfs()
+{
+	local mkfs_cmd=$1
+	local mkfs_filter=$2
+	shift 2
+	local extra_mkfs_options=$*
+	local mkfs_status
+	local tmp=`mktemp`
+
+	# save mkfs output in case conflict means we need to run again.
+	# only the output for the mkfs that applies should be shown
+	eval "$mkfs_cmd $MKFS_OPTIONS $extra_mkfs_options $SCRATCH_DEV" \
+		2>$tmp.mkfserr 1>$tmp.mkfsstd
+	mkfs_status=$?
+
+	# a mkfs failure may be caused by conflicts between $MKFS_OPTIONS and
+	# $extra_mkfs_options
+	if [ $mkfs_status -ne 0 -a -n "$extra_mkfs_options" ]; then
+		(
+		echo -n "** mkfs failed with extra mkfs options "
+		echo "added to \"$MKFS_OPTIONS\" by test $seq **"
+		echo -n "** attempting to mkfs using only test $seq "
+		echo "options: $extra_mkfs_options **"
+		) >> $seqres.full
+
+		# running mkfs again. overwrite previous mkfs output files
+		eval "$mkfs_cmd $extra_mkfs_options $SCRATCH_DEV" \
+			2>$tmp.mkfserr 1>$tmp.mkfsstd
+		mkfs_status=$?
+	fi
+
+	# output stored mkfs output, filtering unnecessary output from stderr
+	cat $tmp.mkfsstd
+	eval "cat $tmp.mkfserr | $mkfs_filter" >&2
+
+	rm -f $tmp*
+	return $mkfs_status
+}
+
 _scratch_metadump()
 {
 	dumpfile=$1
@@ -484,34 +530,18 @@ _setup_large_ext4_fs()
 
 _scratch_mkfs_ext4()
 {
-	# extra mkfs options can be added by tests
-	local extra_mkfs_options=$*
+	local mkfs_cmd="$MKFS_EXT4_PROG -F"
+	local mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
+	local tmp=`mktemp`
+	local mkfs_status
 
-	local tmp_dir=/tmp/
-
-	$MKFS_EXT4_PROG -F $MKFS_OPTIONS $extra_mkfs_options $SCRATCH_DEV \
-			2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
-	local mkfs_status=$?
-
-	# a mkfs failure may be caused by conflicts between
-	# $MKFS_OPTIONS and $extra_mkfs_options
-	if [ $mkfs_status -ne 0 -a ! -z "$extra_mkfs_options" ]; then
-		(
-		echo -n "** mkfs failed with extra mkfs options "
-		echo "added to \"$MKFS_OPTIONS\" by test $seq **"
-		echo -n "** attempting to mkfs using only test $seq "
-		echo "options: $extra_mkfs_options **"
-		) >> $seqres.full
 
-		# running mkfs again. overwrite previous mkfs output files
-		$MKFS_EXT4_PROG -F $extra_mkfs_options $SCRATCH_DEV \
-				2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
-		local mkfs_status=$?
-	fi
+	_scratch_do_mkfs "$mkfs_cmd" "$mkfs_filter" $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
+	mkfs_status=$?
 
 	if [ $mkfs_status -eq 0 -a "$LARGE_SCRATCH_DEV" = yes ]; then
 		# manually parse the mkfs output to get the fs size in bytes
-		fs_size=`cat $tmp_dir.mkfsstd | awk ' \
+		fs_size=`cat $tmp.mkfsstd | awk ' \
 			/^Block size/ { split($2, a, "="); bs = a[2] ; } \
 			/ inodes, / { blks = $3 } \
 			/reserved for the super user/ { resv = $1 } \
@@ -521,10 +551,9 @@ _scratch_mkfs_ext4()
 		mkfs_status=$?
 	fi
 
-	# output stored mkfs output
-	grep -v -e ^Warning: -e "^mke2fs " $tmp_dir.mkfserr >&2
-	cat $tmp_dir.mkfsstd
-	rm -f $tmp_dir.mkfserr $tmp_dir.mkfsstd
+	# output mkfs stdout and stderr
+	cat $tmp.mkfsstd
+	cat $tmp.mkfserr >&2
 
 	return $mkfs_status
 }
@@ -613,51 +642,58 @@ _scratch_cleanup_files()
 
 _scratch_mkfs()
 {
-    case $FSTYP in
-    xfs)
-        _scratch_mkfs_xfs $*
-	;;
-    nfs*)
-	# unable to re-create NFS, just remove all files in $SCRATCH_MNT to
-	# avoid EEXIST caused by the leftover files created in previous runs
-        _scratch_cleanup_files
-	;;
-    cifs)
-	# unable to re-create CIFS, just remove all files in $SCRATCH_MNT to
-	# avoid EEXIST caused by the leftover files created in previous runs
-        _scratch_cleanup_files
-	;;
-    ceph)
-	# Don't re-create CephFS, just remove all files
-	_scratch_cleanup_files
-	;;
-    overlay)
-	# unable to re-create overlay, remove all files in $SCRATCH_MNT to
-	# avoid EEXIST caused by the leftover files created in previous runs
-        _scratch_cleanup_files
-	;;
-    udf)
-        $MKFS_UDF_PROG $MKFS_OPTIONS $* $SCRATCH_DEV > /dev/null
-	;;
-    btrfs)
-        $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV > /dev/null
-	;;
-    ext2|ext3)
-	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $SCRATCH_DEV
-	;;
-    ext4)
-	_scratch_mkfs_ext4 $*
-	;;
-    tmpfs)
-	# do nothing for tmpfs
-	;;
-    f2fs)
-        $MKFS_F2FS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV > /dev/null
-	;;
-    *)
-	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $SCRATCH_DEV
-	;;
-    esac
+	local mkfs_cmd=""
+	local mkfs_filter=""
+	local mkfs_status
+
+	case $FSTYP in
+	nfs*|cifs|ceph|overlay)
+		# unable to re-create this fstyp, just remove all files in
+		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
+		# created in previous runs
+		_scratch_cleanup_files
+		return 0
+		;;
+	tmpfs)
+		# do nothing for tmpfs
+		return 0
+		;;
+	ext4)
+		_scratch_mkfs_ext4 $*
+		return $?
+		;;
+	xfs)
+		_scratch_mkfs_xfs $*
+		return $?
+		;;
+	udf)
+		mkfs_cmd="$MKFS_UDF_PROG"
+		mkfs_filter="cat"
+		;;
+	btrfs)
+		mkfs_cmd="$MKFS_BTRFS_PROG"
+		mkfs_filter="cat"
+		;;
+	ext2|ext3)
+		mkfs_cmd="$MKFS_PROG -t $FSTYP -- -F"
+		mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
+		;;
+	f2fs)
+		mkfs_cmd="$MKFS_F2FS_PROG"
+		mkfs_filter="cat"
+		;;
+	ocfs2)
+		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
+		mkfs_filter="grep -v -e ^mkfs\.ocfs2"
+		;;
+	*)
+		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
+		mkfs_filter="cat"
+		;;
+	esac
+
+	_scratch_do_mkfs "$mkfs_cmd" "$mkfs_filter" $*
+	return $?
 }
 
 # Helper function to get a spare or replace-target device from
diff --git a/common/xfs b/common/xfs
index 53cd4de..fbd139a 100644
--- a/common/xfs
+++ b/common/xfs
@@ -55,7 +55,7 @@ _scratch_mkfs_xfs_opts()
 
 	_scratch_options mkfs
 
-	$MKFS_XFS_PROG $SCRATCH_OPTIONS $mkfs_opts $SCRATCH_DEV
+	echo "$MKFS_XFS_PROG $SCRATCH_OPTIONS $mkfs_opts"
 }
 
 
@@ -79,38 +79,20 @@ _scratch_mkfs_xfs_supported()
 
 _scratch_mkfs_xfs()
 {
-	# extra mkfs options can be added by tests
-	local extra_mkfs_options=$*
+	local mkfs_cmd="`_scratch_mkfs_xfs_opts`"
+	local mkfs_filter="sed -e '/less than device physical sector/d' \
+			       -e '/switching to logical sector/d'"
+	local tmp=`mktemp`
+	local mkfs_status
 
-	local tmp_dir=/tmp/
-
-	# save mkfs output in case conflict means we need to run again.
-	# only the output for the mkfs that applies should be shown
-	_scratch_mkfs_xfs_opts $MKFS_OPTIONS $extra_mkfs_options \
-		2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
-	local mkfs_status=$?
+	_scratch_do_mkfs "$mkfs_cmd" "$mkfs_filter" $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
+	mkfs_status=$?
 
 
-	# a mkfs failure may be caused by conflicts between
-	# $MKFS_OPTIONS and $extra_mkfs_options
-	if [ $mkfs_status -ne 0 -a ! -z "$extra_mkfs_options" ]; then
-		(
-		echo -n "** mkfs failed with extra mkfs options "
-		echo "added to \"$MKFS_OPTIONS\" by test $seq **"
-		echo -n "** attempting to mkfs using only test $seq "
-		echo "options: $extra_mkfs_options **"
-		) >> $seqres.full
-
-		# running mkfs again. overwrite previous mkfs output files
-		_scratch_mkfs_xfs_opts $extra_mkfs_options \
-			2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
-		local mkfs_status=$?
-	fi
-
 	if [ $mkfs_status -eq 0 -a "$LARGE_SCRATCH_DEV" = yes ]; then
 		# manually parse the mkfs output to get the fs size in bytes
 		local fs_size
-		fs_size=`cat $tmp_dir.mkfsstd | perl -ne '
+		fs_size=`cat $tmp.mkfsstd | perl -ne '
 			if (/^data\s+=\s+bsize=(\d+)\s+blocks=(\d+)/) {
 				my $size = $1 * $2;
 				print STDOUT "$size\n";
@@ -119,13 +101,10 @@ _scratch_mkfs_xfs()
 		mkfs_status=$?
 	fi
 
-	# output stored mkfs output, filtering unnecessary warnings from stderr
-	cat $tmp_dir.mkfsstd
-	cat $tmp_dir.mkfserr | sed \
-		-e '/less than device physical sector/d' \
-		-e '/switching to logical sector/d' \
-		>&2
-	rm -f $tmp_dir.mkfserr $tmp_dir.mkfsstd
+	# output mkfs stdout and stderr
+	cat $tmp.mkfsstd
+	cat $tmp.mkfserr >&2
+	rm -f $tmp*
 
 	return $mkfs_status
 }
diff --git a/tests/btrfs/028 b/tests/btrfs/028
index 1425609..34d4008 100755
--- a/tests/btrfs/028
+++ b/tests/btrfs/028
@@ -52,7 +52,7 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 
-_scratch_mkfs
+_scratch_mkfs >/dev/null
 _scratch_mount
 
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
diff --git a/tests/btrfs/121 b/tests/btrfs/121
index 011c5a8..5a73235 100755
--- a/tests/btrfs/121
+++ b/tests/btrfs/121
@@ -56,7 +56,7 @@ _require_scratch
 
 rm -f $seqres.full
 
-_scratch_mkfs
+_scratch_mkfs >/dev/null
 _scratch_mount
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
 # The qgroup '1/10' does not exist and should be silently ignored
diff --git a/tests/btrfs/122 b/tests/btrfs/122
index 82252ab..5279c52 100755
--- a/tests/btrfs/122
+++ b/tests/btrfs/122
@@ -54,7 +54,7 @@ rm -f $seqres.full
 
 # Force a small leaf size to make it easier to blow out our root
 # subvolume tree
-_scratch_mkfs "--nodesize 16384"
+_scratch_mkfs "--nodesize 16384" >/dev/null
 _scratch_mount
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
 
diff --git a/tests/btrfs/123 b/tests/btrfs/123
index e89d541..a89f8f6 100755
--- a/tests/btrfs/123
+++ b/tests/btrfs/123
@@ -54,7 +54,7 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 
-_scratch_mkfs
+_scratch_mkfs >/dev/null
 # Need to use inline extents to fill metadata rapidly
 _scratch_mount "-o max_inline=2048"
 
diff --git a/tests/btrfs/126 b/tests/btrfs/126
index cc51f4a..b9b2eb7 100755
--- a/tests/btrfs/126
+++ b/tests/btrfs/126
@@ -50,7 +50,7 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 
-_scratch_mkfs
+_scratch_mkfs >/dev/null
 # Use enospc_debug mount option to trigger restrict space info check
 _scratch_mount "-o enospc_debug"
 
-- 
2.9.3

