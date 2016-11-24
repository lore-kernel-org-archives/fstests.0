Received: from mx1.redhat.com ([209.132.183.28]:38178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757154AbcKXQGy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 24 Nov 2016 11:06:54 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 321B36365F
        for <fstests@vger.kernel.org>; Thu, 24 Nov 2016 16:06:54 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] common/rc: teach _scratch_mkfs to handle mkfs option conflicts
Date: Fri, 25 Nov 2016 00:06:43 +0800
Message-Id: <20161124160643.2438-1-eguan@redhat.com>
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

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc | 141 ++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 96 insertions(+), 45 deletions(-)

diff --git a/common/rc b/common/rc
index 8c99306..5336524 100644
--- a/common/rc
+++ b/common/rc
@@ -782,51 +782,102 @@ _scratch_cleanup_files()
 
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
+	local extra_mkfs_options=$*
+	local mkfs_cmd=""
+	local mkfs_filter=""
+	local mkfs_status
+
+	case $FSTYP in
+	xfs)
+		_scratch_mkfs_xfs $extra_mkfs_options
+		;;
+	nfs*)
+		# unable to re-create NFS, just remove all files in
+		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
+		# created in previous runs
+		_scratch_cleanup_files
+		;;
+	cifs)
+		# unable to re-create CIFS, just remove all files in
+		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
+		# created in previous runs
+		_scratch_cleanup_files
+		;;
+	ceph)
+		# Don't re-create CephFS, just remove all files
+		_scratch_cleanup_files
+		;;
+	overlay)
+		# unable to re-create overlay, remove all files in $SCRATCH_MNT
+		# to avoid EEXIST caused by the leftover files created in
+		# previous runs
+		_scratch_cleanup_files
+		;;
+	tmpfs)
+		# do nothing for tmpfs
+		;;
+	ext4)
+		_scratch_mkfs_ext4 $extra_mkfs_options
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
+	mkfs_status=$?
+
+	# return immediately if FSTYP is handled by dedicated helpers
+	if [ -z "$mkfs_cmd" ]; then
+		return $mkfs_status
+	fi
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
+	cat $tmp.mkfserr | $mkfs_filter >&2
+
+	return $mkfs_status
 }
 
 # Helper function to get a spare or replace-target device from
-- 
2.9.3

