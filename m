Received: from mail-pg0-f66.google.com ([74.125.83.66]:39511 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbeC3BBu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Mar 2018 21:01:50 -0400
Received: by mail-pg0-f66.google.com with SMTP id b9so4142318pgf.6
        for <fstests@vger.kernel.org>; Thu, 29 Mar 2018 18:01:50 -0700 (PDT)
From: Eric Biggers <ebiggers@google.com>
Subject: [xfstests-bld PATCH] android-xfstests: support f2fs
Date: Thu, 29 Mar 2018 18:00:50 -0700
Message-Id: <20180330010050.64034-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Make android-setup-partitions use 'blkid' to detect the type of the
userdata filesystem, and if it is f2fs calculate its size using fields
from the f2fs superblock.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 .../test-appliance/android-setup-partitions   | 55 +++++++++++++++++--
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/kvm-xfstests/test-appliance/android-setup-partitions b/kvm-xfstests/test-appliance/android-setup-partitions
index 61cd001..8d38303 100755
--- a/kvm-xfstests/test-appliance/android-setup-partitions
+++ b/kvm-xfstests/test-appliance/android-setup-partitions
@@ -209,6 +209,49 @@ all_partitions_present()
     return 0
 }
 
+# Extract a little-endian binary field from a file or device.
+extract_binval()
+{
+    local file="$1"
+    local offset="$2"
+    local size="$3"
+
+    od "$file" -j $offset -N $size -t x$size -A none --endian=little \
+	| sed 's/^[[:space:]]*/0x/'
+}
+
+# Get the size of the filesystem on the specified device.
+get_fs_size()
+{
+    local device="$1" fstype="$2"
+
+    case "$fstype" in
+    ext4)
+	dumpe2fs -h "$device" 2>/dev/null | \
+	    awk '/^Block count:/{blockcount=$3}
+		 /^Block size:/{blocksize=$3}
+		  END { print blockcount * blocksize }'
+	;;
+    f2fs)
+	local super_offset=1024
+	local magic log_blocksize block_count
+
+	# see 'struct f2fs_super_block'
+	magic=$(extract_binval "$device" $super_offset 4)
+	log_blocksize=$(extract_binval "$device" $(( super_offset + 16 )) 4)
+	block_count=$(extract_binval "$device" $(( super_offset + 36 )) 8)
+
+	if (( magic != 0xF2F52010 )); then
+	    die "f2fs superblock not found on \"$device\""
+	fi
+	echo $(( block_count * (1 << log_blocksize) ))
+	;;
+    *)
+	die "unsupported filesystem type \"$fstype\" on \"$device\""
+	;;
+    esac
+}
+
 # Transiently shrink the userdata partition, as viewed by the kernel, if it's
 # not fully used by the filesystem on it.
 #
@@ -219,11 +262,10 @@ all_partitions_present()
 # the end of the filesystem.
 shrink_userdata_partition()
 {
-    local fs_size=$(dumpe2fs -h $USERDATA_FS_DEV 2>/dev/null | \
-	    awk '/^Block count:/{blockcount=$3}
-		 /^Block size:/{blocksize=$3}
-		  END { print blockcount * blocksize }')
-    local part_size=$(get_partition_size $USERDATA_RAW_DEV)
+    local fs_size part_size
+
+    fs_size=$(get_fs_size "$USERDATA_FS_DEV" "$USERDATA_FS_TYPE")
+    part_size=$(get_partition_size "$USERDATA_RAW_DEV")
 
     if (( fs_size <= 0 )); then
 	die "unable to determine size of userdata filesystem"
@@ -337,6 +379,9 @@ else
     USERDATA_FS_DEV=$USERDATA_RAW_DEV
 fi
 
+# Type of the userdata filesystem, e.g. ext4 or f2fs
+USERDATA_FS_TYPE=$(blkid -s TYPE -o value "$USERDATA_FS_DEV")
+
 if ! all_partitions_present ; then
     # Free up as much space as we can, then create the partitions.
     shrink_userdata_partition
-- 
2.17.0.rc1.321.gba9d0f2565-goog

