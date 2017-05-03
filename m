Received: from mail-pf0-f194.google.com ([209.85.192.194]:34303 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdECXJn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 May 2017 19:09:43 -0400
Received: by mail-pf0-f194.google.com with SMTP id d1so478758pfe.1
        for <fstests@vger.kernel.org>; Wed, 03 May 2017 16:09:43 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] android-xfstests: support userdata on device-mapper device
Date: Wed,  3 May 2017 16:08:54 -0700
Message-Id: <20170503230854.112349-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Update android-xfstests to support setting up the xfstests partitions on
Android devices where the userdata filesystem is located on a
device-mapper device backed by the userdata partition, rather than on
the userdata partition itself.  This is the case for devices using
"full-disk encryption", for example, in which case dm-crypt is used.

We can do things pretty similarly to the non-dm case: just shrink the
raw userdata partition after reformatting the filesystem to be smaller,
then create the test partitions in the newly "free" space.  Shrinking
the dm device itself is not required.  We do however need to make sure
not to clobber any footer, e.g. a crypto footer, that may be present.

Note that it's not possible to create the test partitions on top of the
dm device.  However, it would be possible to add an option to set up
separate dm devices for the test partitions.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 .../test-appliance/android-setup-partitions        | 178 ++++++++++++++++++---
 1 file changed, 152 insertions(+), 26 deletions(-)

diff --git a/kvm-xfstests/test-appliance/android-setup-partitions b/kvm-xfstests/test-appliance/android-setup-partitions
index 5ed5896..61cd001 100755
--- a/kvm-xfstests/test-appliance/android-setup-partitions
+++ b/kvm-xfstests/test-appliance/android-setup-partitions
@@ -34,13 +34,6 @@ BYTES_PER_GIB=$(( 1 << 30 ))
 START_PARTITION_NUMBER=100
 USERDATA_SHRUNKEN_SIZE=$(( 4 * BYTES_PER_GIB ))
 
-# device node for userdata partition, e.g. /dev/block/sda35
-USERDATA_DEV=$(readlink /dev/block/bootdevice/by-name/userdata)
-
-# Device node for disk containing userdata partition, e.g. /dev/block/sda.
-# This is the Android device's internal storage.
-DISK_DEV=${USERDATA_DEV%%[0-9]*}
-
 finished()
 {
     echo "$*" > $RESULT_FILE
@@ -93,6 +86,110 @@ get_partition_start()
     echo $(( start_sector * 512 ))
 }
 
+# Find the device node for the raw userdata partition, e.g. /dev/block/sda35
+find_userdata_partition()
+{
+    local link=/dev/block/bootdevice/by-name/userdata
+    if [ ! -L $link ]; then
+	die "There's no symlink to the userdata partition at $link. " \
+	    "Please update this script to support your device!"
+    fi
+    local dev=$(readlink $link)
+    if [ ! -b $dev ]; then
+	die "Unable to find the userdata partition"
+    fi
+    if ! echo $dev | egrep -q '[0-9]+$'; then
+	die "Name of userdata device node has an unexpected format: \"$dev\""
+    fi
+    echo $dev
+}
+
+# If the named device-mapper device exists, then find its device node.
+find_dm_device_by_name()
+{
+    local dm_device_name=$1
+    if ls /sys/class/block/ | egrep -q 'dm-[0-9]+$'; then
+	for dir in /sys/class/block/dm-*; do
+	    if [ $dm_device_name = $(< $dir/dm/name) ]; then
+		local dev=/dev/block/$(basename $dir)
+		if [ ! -b $dev ]; then
+		    die "Device-mapper device \"$dm_device_name\" exists," \
+		        "but couldn't find its device node.  Expected $dev"
+		fi
+		echo $dev
+		return
+	    fi
+	done
+    fi
+}
+
+# Validate that the given device-mapper device uses only a single target, and
+# that the target is backed by the given underlying ("raw") device, starting
+# from the beginning of the device.
+validate_dm_device()
+{
+    local dm_dev=$1
+    local expected_raw_dev=$2
+
+    local dm_devname=$(< /sys/class/block/$(basename $dm_dev)/dm/name)
+    local num_targets=$(dmsetup table $dm_devname | wc -l)
+    case $num_targets in
+    0)
+	die "device-mapper device \"$dm_devname\" does not exist," \
+	    "or we were unable to display its table."
+	;;
+    1)
+	;;
+    *)
+	die "device-mapper device \"$dm_devname\" contains multiple targets," \
+	    "which is not yet supported."
+	;;
+    esac
+    local table=($(dmsetup table $dm_devname))
+
+    local target_type=${table[2]}
+    case $target_type in
+    crypt)
+	local raw_devno=${table[6]}
+	local start_sector=${table[7]}
+	;;
+    default-key)
+	local raw_devno=${table[5]}
+	local start_sector=${table[6]}
+	;;
+    *)
+	die "device-mapper device \"$dm_devname\" uses target type" \
+	    "\"$target_type\", which is not yet supported."
+	;;
+    esac
+
+    if ! echo "$start_sector" | egrep -q '^[0-9]+$' ||
+       ! echo "$raw_devno" | egrep -q '^[0-9]+:[0-9]+$'; then
+	die "device-mapper device \"$dm_devname\" uses target with" \
+	    "unsupported table format: ${table[@]}"
+    fi
+
+    local expected_raw_major=$(( 0x$(stat -c %t $expected_raw_dev) ))
+    local expected_raw_minor=$(( 0x$(stat -c %T $expected_raw_dev) ))
+    if [ $raw_devno != $expected_raw_major:$expected_raw_minor ]; then
+	die "device-mapper device \"$dm_devname\" is backed by device" \
+	    "$raw_devno, not by $expected_raw_dev as was expected."
+    fi
+    local raw_dev=$expected_raw_dev
+
+    if (( start_sector != 0 )); then
+	die "device-mapper device \"$dm_devname\" is backed by $raw_dev" \
+	    "starting at sector $start_sector, but only a start sector of 0" \
+	    "is supported currently."
+    fi
+
+    if (( $(get_partition_size $dm_dev) > $(get_partition_disk_size $raw_dev) ))
+    then
+	die "device-mapper device \"$dm_devname\" is larger than its" \
+	    "underlying on-disk partition $raw_dev!  This is not expected."
+    fi
+}
+
 # Check whether all the needed partitions are present and are large enough
 all_partitions_present()
 {
@@ -112,14 +209,21 @@ all_partitions_present()
     return 0
 }
 
-# Shrink the userdata partition if it's not fully used by the filesystem on it
+# Transiently shrink the userdata partition, as viewed by the kernel, if it's
+# not fully used by the filesystem on it.
+#
+# We don't currently bother to shrink the dm device, if any, that's above the
+# userdata partition.  That isn't necessary, since resizing the underlying
+# partition to a size smaller than the dm device just causes I/O requests to the
+# truncated region to fail, and normally there should be no I/O occurring beyond
+# the end of the filesystem.
 shrink_userdata_partition()
 {
-    local fs_size=$(dumpe2fs -h $USERDATA_DEV 2>/dev/null | \
+    local fs_size=$(dumpe2fs -h $USERDATA_FS_DEV 2>/dev/null | \
 	    awk '/^Block count:/{blockcount=$3}
 		 /^Block size:/{blocksize=$3}
 		  END { print blockcount * blocksize }')
-    local part_size=$(get_partition_size $USERDATA_DEV)
+    local part_size=$(get_partition_size $USERDATA_RAW_DEV)
 
     if (( fs_size <= 0 )); then
 	die "unable to determine size of userdata filesystem"
@@ -138,7 +242,7 @@ shrink_userdata_partition()
     echo "Shrinking userdata partition..."
     echo "    Old size: $(pprint_bytes $part_size)"
     echo "    New size: $(pprint_bytes $fs_size)"
-    resizepart $DISK_DEV $(get_partition_number $USERDATA_DEV) \
+    resizepart $DISK_DEV $(get_partition_number $USERDATA_RAW_DEV) \
 		$(( fs_size / 512 ))
 }
 
@@ -160,20 +264,26 @@ delete_xfstests_partitions()
 
 create_xfstests_partitions()
 {
-    local userdata_disk_size=$(get_partition_disk_size $USERDATA_DEV)
-    local userdata_used_size=$(get_partition_size $USERDATA_DEV)
-    local start=$(get_partition_start $USERDATA_DEV)
-    local end=$(( start + userdata_disk_size ))
-    local i
-    local alignment=$(( 1 << 20 )) # 1 MiB alignment, for good measure
+    local userdata_start=$(get_partition_start $USERDATA_RAW_DEV)
 
-    if (( userdata_used_size > userdata_disk_size )); then
-	die "Weird: the userdata partition is using $userdata_used_size" \
-	    "bytes, which is more than its on-disk size of" \
-	    "$userdata_disk_size bytes!"
-    fi
+    # Start allocating after the end of the userdata partition as viewed by the
+    # kernel, which may be smaller than the partition on-disk.
+    local start=$(( userdata_start + $(get_partition_size $USERDATA_RAW_DEV) ))
 
-    start=$(( start + userdata_used_size ))
+    if [ $USERDATA_FS_DEV = $USERDATA_RAW_DEV ]; then
+	# Raw partition: we can allocate until the end of the partition on-disk.
+	local end=$(( userdata_start +
+		      $(get_partition_disk_size $USERDATA_RAW_DEV) ))
+    else
+	# DM device: we can allocate only until the end of the dm target.  This
+	# ensures we don't overwrite anything extra like a crypto footer which
+	# may be present on the partition after the dm target.
+	local end=$(( userdata_start +
+		      $(get_partition_size $USERDATA_FS_DEV) ))
+    fi
+    local orig_start=$start
+    local alignment=$(( 1 << 20 )) # 1 MiB alignment, for good measure
+    local i
 
     local total_size_required=0
     for i in ${!PARTITION_NAMES[@]}; do
@@ -196,9 +306,9 @@ create_xfstests_partitions()
 		continue
 	    fi
 	    # Not enough space!  Check whether we should shrink userdata or not.
-	    if (( userdata_used_size > USERDATA_SHRUNKEN_SIZE &&
-		  USERDATA_SHRUNKEN_SIZE + total_size_required <=
-		    userdata_disk_size )); then
+	    local shrunken_start=$(( userdata_start + USERDATA_SHRUNKEN_SIZE ))
+	    if (( orig_start > shrunken_start &&
+		  shrunken_start + total_size_required <= end )); then
 		finished "shrink_userdata"
 	    else
 		finished "insufficient_space"
@@ -211,6 +321,22 @@ create_xfstests_partitions()
     done
 }
 
+# Device node for the raw userdata partition, e.g. /dev/block/sda35
+USERDATA_RAW_DEV=$(find_userdata_partition)
+
+# Device node for disk containing userdata partition, e.g. /dev/block/sda.
+# This is the Android device's internal storage.
+DISK_DEV=${USERDATA_RAW_DEV%%[0-9]*}
+
+# Block device containing the userdata filesystem.  This can be either
+# USERDATA_RAW_DEV or a device-mapper device above USERDATA_RAW_DEV.
+USERDATA_FS_DEV=$(find_dm_device_by_name "userdata")
+if [ -n "$USERDATA_FS_DEV" ]; then
+    validate_dm_device $USERDATA_FS_DEV $USERDATA_RAW_DEV
+else
+    USERDATA_FS_DEV=$USERDATA_RAW_DEV
+fi
+
 if ! all_partitions_present ; then
     # Free up as much space as we can, then create the partitions.
     shrink_userdata_partition
-- 
2.13.0.rc1.294.g07d810a77f-goog

