Return-Path: <fstests-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51661 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224AbbAVQ3D (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 22 Jan 2015 11:29:03 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 92549AD37
	for <fstests@vger.kernel.org>; Thu, 22 Jan 2015 16:29:02 +0000 (UTC)
From: David Sterba <dsterba@suse.cz>
Subject: [PATCH] common: helper to find out options to print raw byte output from qgroup show
Date: Thu, 22 Jan 2015 17:29:01 +0100
Message-Id: <1421944141-4442-1-git-send-email-dsterba@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.cz>
List-ID: <fstests@vger.kernel.org>

Newer versions of btrfs-progs change the default output of 'qgroup
show', we have to check what version is running and use the right option
if needed.

Signed-off-by: David Sterba <dsterba@suse.cz>
---
 common/rc       |  7 +++++++
 tests/btrfs/017 |  3 ++-
 tests/btrfs/022 | 12 +++++++-----
 tests/btrfs/057 |  3 ++-
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/common/rc b/common/rc
index 5377ba08d216..f6a603de5cbf 100644
--- a/common/rc
+++ b/common/rc
@@ -2799,6 +2799,13 @@ _btrfs_stress_replace()
 	done
 }
 
+# find the right option to force output in bytes, older versions of btrfs-progs
+# print that by default, newer print human readable numbers with unit suffix
+_btrfs_qgroup_units()
+{
+	$BTRFS_UTIL_PROG qgroup show --help 2>&1 | grep -q -- --raw && echo "--raw"
+}
+
 # return device size in kb
 _get_device_size()
 {
diff --git a/tests/btrfs/017 b/tests/btrfs/017
index d00d7c85159b..f8855e3d893a 100755
--- a/tests/btrfs/017
+++ b/tests/btrfs/017
@@ -79,7 +79,8 @@ rm -fr $SCRATCH_MNT/snap/foo*
 
 sync
 
-$BTRFS_UTIL_PROG qgroup show $SCRATCH_MNT | $AWK_PROG '/[0-9]/ {print $2" "$3}'
+units=`_btrfs_qgroup_units`
+$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | $AWK_PROG '/[0-9]/ {print $2" "$3}'
 
 # success, all done
 status=0
diff --git a/tests/btrfs/022 b/tests/btrfs/022
index 16e1eadc1f6f..5c1a82d79757 100755
--- a/tests/btrfs/022
+++ b/tests/btrfs/022
@@ -52,7 +52,7 @@ _basic_test()
 	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
 	_run_btrfs_util_prog quota enable $SCRATCH_MNT/a
 	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
-	$BTRFS_UTIL_PROG qgroup show $SCRATCH_MNT | grep $subvolid >> \
+	$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid >> \
 		$seqres.full 2>&1
 	[ $? -eq 0 ] || _fail "couldn't find our subvols quota group"
 	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
@@ -62,10 +62,10 @@ _basic_test()
 
 	# the shared values of both the original subvol and snapshot should
 	# match
-	a_shared=$($BTRFS_UTIL_PROG qgroup show $SCRATCH_MNT | grep $subvolid)
+	a_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid)
 	a_shared=$(echo $a_shared | awk '{ print $2 }')
 	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT b)
-	b_shared=$($BTRFS_UTIL_PROG qgroup show $SCRATCH_MNT | grep $subvolid)
+	b_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid)
 	b_shared=$(echo $b_shared | awk '{ print $2 }')
 	[ $b_shared -eq $a_shared ] || _fail "shared values don't match"
 }
@@ -81,12 +81,12 @@ _rescan_test()
 	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
 		$FSSTRESS_AVOID
 	sync
-	output=$($BTRFS_UTIL_PROG qgroup show $SCRATCH_MNT | grep $subvolid)
+	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid)
 	echo $output >> $seqres.full
 	refer=$(echo $output | awk '{ print $2 }')
 	excl=$(echo $output | awk '{ print $3 }')
 	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
-	output=$($BTRFS_UTIL_PROG qgroup show $SCRATCH_MNT | grep $subvolid)
+	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid)
 	echo $output >> $seqres.full
 	[ $refer -eq $(echo $output | awk '{ print $2 }') ] || \
 		_fail "reference values don't match after rescan"
@@ -118,6 +118,8 @@ _limit_test_noexceed()
 	[ $? -eq 0 ] || _fail "should have been allowed to write"
 }
 
+units=`_btrfs_qgroup_units`
+
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 _basic_test
diff --git a/tests/btrfs/057 b/tests/btrfs/057
index f6f4e0e8949f..605bd020b09e 100755
--- a/tests/btrfs/057
+++ b/tests/btrfs/057
@@ -74,7 +74,8 @@ _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
 rm -rf $SCRATCH_MNT/* >& /dev/null
 
 _run_btrfs_util_prog filesystem sync $SCRATCH_MNT
-$BTRFS_UTIL_PROG qgroup show $SCRATCH_MNT | $SED_PROG -n '/[0-9]/p' \
+units=`_btrfs_qgroup_units`
+$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | $SED_PROG -n '/[0-9]/p' \
 	| $AWK_PROG '{print $2" "$3}'
 
 status=0
-- 
2.1.3

