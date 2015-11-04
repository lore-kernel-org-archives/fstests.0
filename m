Received: from mail.kernel.org ([198.145.29.136]:44774 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932339AbbKDJ6F (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 4 Nov 2015 04:58:05 -0500
From: fdmanana@kernel.org
Subject: [PATCH] fstests: add helper function _flakey_drop_and_remount
Date: Wed,  4 Nov 2015 09:57:50 +0000
Message-Id: <1446631070-3969-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

To avoid having many tests repeating the following pattern:

        _load_flakey_table $FLAKEY_DROP_WRITES
        _unmount_flakey

        _load_flakey_table $FLAKEY_ALLOW_WRITES
        _mount_flakey

add the helper function _flakey_drop_and_remount to remove
the existing duplicated code and serve as a shortcut.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/dmflakey   | 15 +++++++++++++++
 tests/btrfs/056   |  9 +--------
 tests/btrfs/095   |  8 +-------
 tests/btrfs/098   |  8 +-------
 tests/generic/034 |  6 +-----
 tests/generic/039 |  9 +--------
 tests/generic/040 |  9 +--------
 tests/generic/041 |  9 +--------
 tests/generic/056 |  7 +------
 tests/generic/057 |  7 +------
 tests/generic/059 |  8 +-------
 tests/generic/065 |  7 +------
 tests/generic/066 | 13 ++-----------
 tests/generic/073 |  7 +------
 tests/generic/090 |  8 +-------
 tests/generic/101 |  7 +------
 tests/generic/104 |  8 +-------
 tests/generic/106 |  8 +-------
 tests/generic/107 |  8 +-------
 tests/generic/321 | 18 ++++++------------
 tests/generic/322 | 12 ++++--------
 tests/generic/325 |  6 +-----
 tests/shared/002  |  8 +-------
 23 files changed, 46 insertions(+), 159 deletions(-)

diff --git a/common/dmflakey b/common/dmflakey
index e55aefd..dec85c1 100644
--- a/common/dmflakey
+++ b/common/dmflakey
@@ -74,3 +74,18 @@ _load_flakey_table()
 	$DMSETUP_PROG resume flakey-test
 	[ $? -ne 0 ] && _fatal  "failed to resumeflakey-test"
 }
+
+# Silently drop all writes and unmount/remount to simulate a crash/power
+# failure.
+_flakey_drop_and_remount()
+{
+	_load_flakey_table $FLAKEY_DROP_WRITES
+	_unmount_flakey
+
+	if [ "x$1" = "xyes" ]; then
+		_check_scratch_fs $FLAKEY_DEV
+	fi
+
+	_load_flakey_table $FLAKEY_ALLOW_WRITES
+	_mount_flakey
+}
diff --git a/tests/btrfs/056 b/tests/btrfs/056
index add8288..66a59b8 100755
--- a/tests/btrfs/056
+++ b/tests/btrfs/056
@@ -97,14 +97,7 @@ test_btrfs_clone_fsync_log_recover()
 	$CLONER_PROG -s 0 -d 0 -l 3500 $SCRATCH_MNT/foo2 $SCRATCH_MNT/bar2
 	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar2
 
-	_load_flakey_table $FLAKEY_DROP_WRITES
-	_unmount_flakey
-
-	# Verify that there are no consistency errors.
-	_check_scratch_fs $FLAKEY_DEV
-
-	_load_flakey_table $FLAKEY_ALLOW_WRITES
-	_mount_flakey
+	_flakey_drop_and_remount yes
 
 	# Verify the cloned range was persisted by fsync and the log recovery
 	# code did its work well.
diff --git a/tests/btrfs/095 b/tests/btrfs/095
index 854ba40..1b4ba90 100755
--- a/tests/btrfs/095
+++ b/tests/btrfs/095
@@ -129,11 +129,6 @@ $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
 echo "File digest before power failure:"
 md5sum $SCRATCH_MNT/foo | _filter_scratch
 
-# Silently drop all writes and ummount to simulate a crash/power failure.
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-# Allow writes again, mount to trigger log replay and validate file contents.
 # During log replay, the btrfs delayed references implementation used to run the
 # deletion of back references before the addition of new back references, which
 # made the addition fail as it didn't find the key in the extent tree that it
@@ -142,8 +137,7 @@ _unmount_flakey
 # log replay - when running the delayed references at transaction commit time,
 # btrfs was applying the deletion before the insertion, resulting in a failure
 # of the insertion that ended up turning the fs into read-only mode.
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_flakey_drop_and_remount
 
 echo "File digest after log replay:"
 md5sum $SCRATCH_MNT/foo | _filter_scratch
diff --git a/tests/btrfs/098 b/tests/btrfs/098
index f12df5f..8aef119 100755
--- a/tests/btrfs/098
+++ b/tests/btrfs/098
@@ -84,11 +84,6 @@ $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
 echo "File digest before power failure:"
 md5sum $SCRATCH_MNT/foo | _filter_scratch
 
-# Silently drop all writes and ummount to simulate a crash/power failure.
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-# Allow writes again, mount to trigger log replay and validate file contents.
 # The fsync log replay first processes the file extent item corresponding to the
 # file offset 400K (the one which refers to the [20K, 40K[ sub-range of our 100K
 # extent) and then processes the file extent item for file offset 800K. It used
@@ -109,8 +104,7 @@ _unmount_flakey
 #  "BTRFS warning (device dm-0): csum failed ino 257 off 917504 csum 1322675045\
 #    expected csum 0"
 #
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_flakey_drop_and_remount
 
 echo "File digest after log replay:"
 # Must match the same digest he had after cloning the extent and before the
diff --git a/tests/generic/034 b/tests/generic/034
index ee889c2..1065c70 100755
--- a/tests/generic/034
+++ b/tests/generic/034
@@ -75,15 +75,11 @@ touch $SCRATCH_MNT/test_dir/bar
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/test_dir
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/test_dir/bar
 
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-_load_flakey_table $FLAKEY_ALLOW_WRITES
 # In the original btrfs bug, log replay would update the directory's inode
 # i_size incorrectly - it would sum again the size of dentry 'foo' (3) to
 # the inode's i_size, which is incorrect because the dentry was already
 # persisted before (in the fs/subvol tree).
-_mount_flakey
+_flakey_drop_and_remount
 
 [ -f $SCRATCH_MNT/test_dir/foo ] || echo "file foo is missing"
 [ -f $SCRATCH_MNT/test_dir/bar ] || echo "file bar is missing"
diff --git a/tests/generic/039 b/tests/generic/039
index 35cb7a4..21c04d2 100755
--- a/tests/generic/039
+++ b/tests/generic/039
@@ -78,14 +78,7 @@ sync
 rm -f $SCRATCH_MNT/a/b/bar
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/a/b/foo
 
-# Simulate a crash/power loss. This makes sure the next mount
-# will see an fsync log and will replay that log.
-
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_flakey_drop_and_remount
 
 # Remove the last hard link of the file and attempt to remove its parent
 # directory - this failed in btrfs because the fsync log and replay code
diff --git a/tests/generic/040 b/tests/generic/040
index 3142bbb..7e90e00 100755
--- a/tests/generic/040
+++ b/tests/generic/040
@@ -94,14 +94,7 @@ sync
 ln $SCRATCH_MNT/foo $SCRATCH_MNT/foo_link_3001
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
 
-# Simulate a crash/power loss. This makes sure the next mount
-# will see an fsync log and will replay that log.
-
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_flakey_drop_and_remount
 
 # Now after the fsync log replay btrfs left our inode with a wrong link count N,
 # which was smaller than the correct link count M (N < M).
diff --git a/tests/generic/041 b/tests/generic/041
index 506d8a9..7816389 100755
--- a/tests/generic/041
+++ b/tests/generic/041
@@ -103,14 +103,7 @@ ln $SCRATCH_MNT/foo $SCRATCH_MNT/foo_link_3002
 ln $SCRATCH_MNT/foo $SCRATCH_MNT/foo_link_3003
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
 
-# Simulate a crash/power loss. This makes sure the next mount
-# will see an fsync log and will replay that log.
-
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_flakey_drop_and_remount
 
 # Check that the number of hard links is correct, we are able to remove all
 # the hard links and read the file's data. This is just to verify we don't
diff --git a/tests/generic/056 b/tests/generic/056
index 2ec155f..b720690 100755
--- a/tests/generic/056
+++ b/tests/generic/056
@@ -83,12 +83,7 @@ $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar
 echo "File content before:"
 od -t x1 $SCRATCH_MNT/foo
 
-# Simulate a crash/power loss.
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_flakey_drop_and_remount
 
 # After the fsync log replay, because the fsync log had a value of 0 for our
 # inode's i_size, we couldn't read anymore the 4Kb of data that we previously
diff --git a/tests/generic/057 b/tests/generic/057
index c11c329..fa4d17a 100755
--- a/tests/generic/057
+++ b/tests/generic/057
@@ -93,12 +93,7 @@ $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar
 echo "File content before:"
 od -t x1 $SCRATCH_MNT/foo
 
-# Simulate a crash/power loss.
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_flakey_drop_and_remount
 
 # After mounting the fs again, the fsync log was replayed.
 # The btrfs fsync log replay code didn't update the i_size of the persisted
diff --git a/tests/generic/059 b/tests/generic/059
index 4b9184a..de4e7ce 100755
--- a/tests/generic/059
+++ b/tests/generic/059
@@ -103,13 +103,7 @@ $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
 echo "File content before:"
 od -t x1 $SCRATCH_MNT/foo
 
-# Simulate a crash/power loss.
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-# Enable writes and mount the fs. This makes the fsync log replay code run.
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_flakey_drop_and_remount
 
 # Because the last fsync didn't do anything, here the file content matched what
 # it was after the first fsync, before the holes were punched, and not what it
diff --git a/tests/generic/065 b/tests/generic/065
index ddab687..37077d5 100755
--- a/tests/generic/065
+++ b/tests/generic/065
@@ -101,12 +101,7 @@ $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/mydir
 # no bad influence on this fsync.
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/hello
 
-# Simulate a crash/power loss.
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_flakey_drop_and_remount
 
 # Verify the content of our file 'foo' remains the same as before, 8192 bytes,
 # all with the value 0xaa.
diff --git a/tests/generic/066 b/tests/generic/066
index 211152d..3c215bd 100755
--- a/tests/generic/066
+++ b/tests/generic/066
@@ -63,15 +63,6 @@ _require_dm_target flakey
 _require_attrs
 _require_metadata_journaling $SCRATCH_DEV
 
-_crash_and_mount()
-{
-	# Simulate a crash/power loss.
-	_load_flakey_table $FLAKEY_DROP_WRITES
-	_unmount_flakey
-	_load_flakey_table $FLAKEY_ALLOW_WRITES
-	_mount_flakey
-}
-
 rm -f $seqres.full
 
 _scratch_mkfs >> $seqres.full 2>&1
@@ -91,7 +82,7 @@ sync
 $SETFATTR_PROG -x user.attr2 $SCRATCH_MNT/foobar
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foobar
 
-_crash_and_mount
+_flakey_drop_and_remount
 
 # After the fsync log is replayed, the file should have only 2 xattrs, the ones
 # named user.attr1 and user.attr3. The btrfs fsync log replay bug left the file
@@ -111,7 +102,7 @@ ln $SCRATCH_MNT/foobar $SCRATCH_MNT/foobar_link
 touch $SCRATCH_MNT/qwerty
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/qwerty
 
-_crash_and_mount
+_flakey_drop_and_remount
 
 # Now only the xattr with name user.attr3 should be set in our file.
 echo "xattr names and values after second fsync log replay:"
diff --git a/tests/generic/073 b/tests/generic/073
index 759098d..1c92c66 100755
--- a/tests/generic/073
+++ b/tests/generic/073
@@ -98,12 +98,7 @@ $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir_1
 # happened when we fsynced the parent directory.
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
 
-# Simulate a crash/power loss.
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_flakey_drop_and_remount
 
 # Now check that all data we wrote before are available.
 echo "File content after log replay:"
diff --git a/tests/generic/090 b/tests/generic/090
index 3890fc1..1bc9b16 100755
--- a/tests/generic/090
+++ b/tests/generic/090
@@ -93,13 +93,7 @@ $XFS_IO_PROG -c "pwrite -S 0xbb 32K 32K" \
 echo "File content after fsync and before crash:"
 od -t x1 $SCRATCH_MNT/foo
 
-# Simulate a crash/power loss.
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-# Allow writes again and mount. This makes the fs replay its fsync log.
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_flakey_drop_and_remount
 
 echo "File content after crash and log replay:"
 od -t x1 $SCRATCH_MNT/foo
diff --git a/tests/generic/101 b/tests/generic/101
index ea98a89..8771a17 100755
--- a/tests/generic/101
+++ b/tests/generic/101
@@ -96,12 +96,7 @@ $XFS_IO_PROG -c "truncate 0" \
 		-c "fsync" \
 		$SCRATCH_MNT/bar
 
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-# Allow writes again, mount to trigger log replay and validate file contents.
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_flakey_drop_and_remount
 
 # We expect foo to have a size of 125Kb, the first 64Kb of data all having the
 # value 0xaa and the remaining 61Kb to be a hole (all bytes with value 0x00).
diff --git a/tests/generic/104 b/tests/generic/104
index 2eee638..ceab94b 100755
--- a/tests/generic/104
+++ b/tests/generic/104
@@ -72,13 +72,7 @@ ln $SCRATCH_MNT/testdir/bar $SCRATCH_MNT/testdir/bar_link
 ln $SCRATCH_MNT/testdir/foo $SCRATCH_MNT/testdir/foo_link
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir/bar
 
-# Silently drop all writes on our scratch device to simulate a power failure.
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-# Allow writes again and mount the fs to trigger log/journal replay.
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_flakey_drop_and_remount
 
 # Now verify both our files have a link count of 2.
 echo "Link count for file foo: $(stat -c %h $SCRATCH_MNT/testdir/foo)"
diff --git a/tests/generic/106 b/tests/generic/106
index e4f9cae..9dd2e6b 100755
--- a/tests/generic/106
+++ b/tests/generic/106
@@ -71,13 +71,7 @@ unlink $SCRATCH_MNT/testdir/bar
 echo 2 > /proc/sys/vm/drop_caches
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir/foo
 
-# Silently drop all writes on our scratch device to simulate a power failure.
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-# Allow writes again and mount the fs to trigger log/journal replay.
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_flakey_drop_and_remount
 
 # Now verify our directory entries.
 echo "Entries in testdir:"
diff --git a/tests/generic/107 b/tests/generic/107
index 7503e40..6b5f2bb 100755
--- a/tests/generic/107
+++ b/tests/generic/107
@@ -76,13 +76,7 @@ unlink $SCRATCH_MNT/testdir/foo3
 # is not the directory "testdir".
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
 
-# Silently drop all writes and unmount to simulate a crash/power failure.
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-# Allow writes again and mount the fs to trigger log/journal replay.
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_flakey_drop_and_remount
 
 # After the journal/log is replayed we expect to not see the "foo3" link anymore
 # and we should be able to remove all names in the directory "testdir" and then
diff --git a/tests/generic/321 b/tests/generic/321
index 1a89880..7c6c823 100755
--- a/tests/generic/321
+++ b/tests/generic/321
@@ -63,11 +63,9 @@ _directory_test()
 	_mount_flakey
 	mkdir $SCRATCH_MNT/bar
 	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar
-	_load_flakey_table $FLAKEY_DROP_WRITES
-	_unmount_flakey
 
-	_load_flakey_table $FLAKEY_ALLOW_WRITES
-	_mount_flakey
+	_flakey_drop_and_remount
+
 	_ls_l $SCRATCH_MNT | tail -n +2 | awk '{ print $1, $9 }'
 	_unmount_flakey
 	_check_scratch_fs $FLAKEY_DEV
@@ -85,11 +83,9 @@ _rename_test()
 	mv $SCRATCH_MNT/foo $SCRATCH_MNT/bar/foo
 	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar
 	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar/foo
-	_load_flakey_table $FLAKEY_DROP_WRITES
-	_unmount_flakey
 
-	_load_flakey_table $FLAKEY_ALLOW_WRITES
-	_mount_flakey
+	_flakey_drop_and_remount\
+
 	_ls_l $SCRATCH_MNT | tail -n +2 | awk '{ print $1, $9 }'
 	_ls_l $SCRATCH_MNT/bar | tail -n +2 | awk '{ print $1, $9 }'
 	_unmount_flakey
@@ -114,11 +110,9 @@ _replay_rename_test()
 	setfattr -n user.foo -v blah $SCRATCH_MNT/bar/foo >> $seqres.full 2>&1
 
 	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar/foo
-	_load_flakey_table $FLAKEY_DROP_WRITES
-	_unmount_flakey
 
-	_load_flakey_table $FLAKEY_ALLOW_WRITES
-	_mount_flakey
+	_flakey_drop_and_remount
+
 	_ls_l $SCRATCH_MNT | tail -n +2 | awk '{ print $1, $9 }'
 	_ls_l $SCRATCH_MNT/bar | tail -n +2 | awk '{ print $1, $9 }'
 	_unmount_flakey
diff --git a/tests/generic/322 b/tests/generic/322
index 324022b..9c925a4 100755
--- a/tests/generic/322
+++ b/tests/generic/322
@@ -65,12 +65,10 @@ _rename_test()
 		> $seqres.full 2>&1 || _fail "xfs_io failed"
 	mv $SCRATCH_MNT/foo $SCRATCH_MNT/bar
 	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar
-	_load_flakey_table $FLAKEY_DROP_WRITES
 	md5sum $SCRATCH_MNT/bar | _filter_scratch
-	_unmount_flakey
 
-	_load_flakey_table $FLAKEY_ALLOW_WRITES
-	_mount_flakey
+	_flakey_drop_and_remount
+
 	md5sum $SCRATCH_MNT/bar | _filter_scratch
 	_unmount_flakey
 	_check_scratch_fs $FLAKEY_DEV
@@ -87,12 +85,10 @@ _write_after_fsync_rename_test()
 		-c "sync_range -b" $SCRATCH_MNT/foo > $seqres.full 2>&1 || _fail "xfs_io failed"
 	mv $SCRATCH_MNT/foo $SCRATCH_MNT/bar
 	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar
-	_load_flakey_table $FLAKEY_DROP_WRITES
 	md5sum $SCRATCH_MNT/bar | _filter_scratch
-	_unmount_flakey
 
-	_load_flakey_table $FLAKEY_ALLOW_WRITES
-	_mount_flakey
+	_flakey_drop_and_remount
+
 	md5sum $SCRATCH_MNT/bar | _filter_scratch
 	_unmount_flakey
 }
diff --git a/tests/generic/325 b/tests/generic/325
index 94d30be..0994ff6 100755
--- a/tests/generic/325
+++ b/tests/generic/325
@@ -92,11 +92,7 @@ $XFS_IO_PROG \
 echo "File content before crash/reboot:"
 od -t x1 $SCRATCH_MNT/foo
 
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_flakey_drop_and_remount
 
 echo "File content after crash/reboot and fs mount:"
 od -t x1 $SCRATCH_MNT/foo
diff --git a/tests/shared/002 b/tests/shared/002
index cf02fcf..eb8713b 100755
--- a/tests/shared/002
+++ b/tests/shared/002
@@ -98,13 +98,7 @@ $XFS_IO_PROG -c "pwrite -S 0xbb 8K 16K" \
 		-c "fsync" \
 		$SCRATCH_MNT/foo | _filter_xfs_io
 
-# Simulate a crash/power loss.
-_load_flakey_table $FLAKEY_DROP_WRITES
-_unmount_flakey
-
-# Allow writes again and mount. This makes the fs replay its fsync log.
-_load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_flakey_drop_and_remount
 
 echo "File content after crash and log replay:"
 od -t x1 $SCRATCH_MNT/foo
-- 
2.1.3

