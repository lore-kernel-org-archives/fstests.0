Received: from mx2.suse.de ([195.135.220.15]:43692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752059AbeENRD6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 14 May 2018 13:03:58 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8057AAE17
        for <fstests@vger.kernel.org>; Mon, 14 May 2018 17:03:57 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] generic/382: Fix test when report uses /etc/passwd
Date: Mon, 14 May 2018 19:03:50 +0200
Message-Id: <20180514170351.13737-3-jack@suse.cz>
In-Reply-To: <20180514170351.13737-1-jack@suse.cz>
References: <20180514170351.13737-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

On older kernels xfs_quota uses /etc/passwd to report quota entries. In
such case all-zero lines disturb its output and the test fails. Fix the
problem by ignoring all-zero lines in quota report.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/filter     | 8 ++++++++
 tests/generic/382 | 6 +++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/common/filter b/common/filter
index 53874a08f5e3..037799e5cd19 100644
--- a/common/filter
+++ b/common/filter
@@ -344,6 +344,14 @@ _filter_project_quota()
 	_filter_quota | grep -v "^\#0 \|^(null) "
 }
 
+_filter_quota_report()
+{
+	# When xfs_quota uses /etc/passwd for reporting, it may report lines
+	# full of zeros. Ignore them.
+	grep -v -E '^[^ ]+ +0 +0 +0 +00 +\[--------\] +0 +0 +0 +00 +\[--------\]' |
+	grep -v -E '^[^ ]+ +0 +0 +0 +00 +\[--------\]$'
+}
+
 # Account for different "ln" failure messages
 _filter_ln()
 {
diff --git a/tests/generic/382 b/tests/generic/382
index 33326ffa4d1b..02b98a9ef027 100755
--- a/tests/generic/382
+++ b/tests/generic/382
@@ -79,12 +79,12 @@ do_test()
 	$XFS_QUOTA_PROG -x -c "limit bsoft=20M bhard=20M isoft=20 ihard=20 $type -d" $SCRATCH_MNT
 	$XFS_QUOTA_PROG -x -c "limit bsoft=40M bhard=40M isoft=40 ihard=40 $type fsgqa" $SCRATCH_MNT
 	echo "$qname blocks and inode limit"
-	$XFS_QUOTA_PROG -x -c "report $type -N -bi" $SCRATCH_MNT | grep -v ^root | _filter_spaces
+	$XFS_QUOTA_PROG -x -c "report $type -N -bi" $SCRATCH_MNT | grep -v ^root | _filter_quota_report | _filter_spaces
 
 	## blocks default quota test ##
 	_user_do "$XFS_IO_PROG -f -c \"pwrite 0 30M\" -c \"fsync\" $SCRATCH_MNT/data" | _filter_xfs_io
 	echo "$qname blocks quota after write 30M data"
-	$XFS_QUOTA_PROG -x -c "report $type -N -b" $SCRATCH_MNT | grep -v ^root | _filter_spaces
+	$XFS_QUOTA_PROG -x -c "report $type -N -b" $SCRATCH_MNT | grep -v ^root | _filter_quota_report | _filter_spaces
 
 	rm -f ${SCRATCH_MNT}/* >/dev/null 2>&1
 
@@ -95,7 +95,7 @@ do_test()
 	sync
 
 	echo "$qname inode quota after creating 30 inodes"
-	$XFS_QUOTA_PROG -x -c "report $type -N -i" $SCRATCH_MNT | grep -v ^root | _filter_spaces
+	$XFS_QUOTA_PROG -x -c "report $type -N -i" $SCRATCH_MNT | grep -v ^root | _filter_quota_report | _filter_spaces
 
 	rm -f ${SCRATCH_MNT}/* >/dev/null 2>&1
 }
-- 
2.13.6

