Received: from mail.kernel.org ([198.145.29.99]:38560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbeIEXlG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 5 Sep 2018 19:41:06 -0400
From: Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH resend] android-xfstests: fix finding FS_TYPE when userdata is on dm device
Date: Wed,  5 Sep 2018 12:07:00 -0700
Message-Id: <20180905190700.66123-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

If the userdata filesystem is on a device-mapper device, then shrinking
the partition underneath it breaks 'blkid' probing, which
android-setup-partitions now uses find the filesystem type.  Use blkid's
'-p' and '-S' options to do a low-level probe with explicitly specified
size, which still works in this case.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/android-setup-partitions | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kvm-xfstests/test-appliance/android-setup-partitions b/kvm-xfstests/test-appliance/android-setup-partitions
index 8d38303..ddaa252 100755
--- a/kvm-xfstests/test-appliance/android-setup-partitions
+++ b/kvm-xfstests/test-appliance/android-setup-partitions
@@ -259,7 +259,8 @@ get_fs_size()
 # userdata partition.  That isn't necessary, since resizing the underlying
 # partition to a size smaller than the dm device just causes I/O requests to the
 # truncated region to fail, and normally there should be no I/O occurring beyond
-# the end of the filesystem.
+# the end of the filesystem.  Exception: this makes 'blkid' stop reporting
+# information about the device, unless blkid's -p and -S options are used.
 shrink_userdata_partition()
 {
     local fs_size part_size
@@ -380,7 +381,9 @@ else
 fi
 
 # Type of the userdata filesystem, e.g. ext4 or f2fs
-USERDATA_FS_TYPE=$(blkid -s TYPE -o value "$USERDATA_FS_DEV")
+USERDATA_FS_TYPE=$(blkid -s TYPE -o value \
+		   -p -S $(get_partition_size "$USERDATA_RAW_DEV") \
+		   "$USERDATA_FS_DEV")
 
 if ! all_partitions_present ; then
     # Free up as much space as we can, then create the partitions.
-- 
2.19.0.rc2.392.g5ba43deb5a-goog
