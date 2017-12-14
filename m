Received: from mail-it0-f49.google.com ([209.85.214.49]:38069 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdLNCFl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Dec 2017 21:05:41 -0500
Received: by mail-it0-f49.google.com with SMTP id r6so7471254itr.3
        for <fstests@vger.kernel.org>; Wed, 13 Dec 2017 18:05:40 -0800 (PST)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH v2] xfstests-bld: add support for UBIFS using block2mtd
Date: Wed, 13 Dec 2017 18:03:48 -0800
Message-Id: <20171214020348.185463-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, linux-mtd@lists.infradead.org, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Hi Ted, are you interested in taking this UBIFS support patch into
xfstests-bld now?  The 'block2mtd' approach hasn't gotten any better
from when I sent this patch out originally, but it's better than nothing
(it's useful to me, at least).  Also, xfstests itself supports UBIFS
now, so only xfstests-bld support is missing.

---8<---

This patch adds UBIFS support to the xfstests-bld test runners
(kvm-xfstests, gce-xfstests, etc.).

Unlike most filesystems, UBIFS is not block-device based.  Instead it
uses an UBI volume, which is layered above an MTD (raw flash) device.
Still, it's possible to use the block2mtd kernel module to emulate an
MTD device given a block device.  Therefore, the xfstests-bld config for
UBIFS uses block2mtd to create MTD devices, then UBI devices and UBI
volumes, that are backed by the xfstests partitions.

This approach has some limitations.  First, it takes a long time to
'ubiformat' the emulated MTD devices the first time UBIFS tests are run.
Second, block2mtd doesn't support removing MTD devices, which prevents
the underlying partitions from being reused to test other filesystems
after UBIFS until the VM is rebooted.  Still, it's better than having no
way to test UBIFS.

I also tried using QEMU to emulate a MTD device directly, but I couldn't
get it to work; and that definitely won't work for gce-xfstests.  Also,
David Oberhollenzer had tried using nandsim instead of block2mtd, but
said the following:

    "Modifying the xfstests-bld patch to use nandsim (which simulates a
     NAND flash MTD device) instead of block2mtd has been considered,
     however the default size of 128MiB is slightly too small for
     generic/129.

     Nandsim does not have an option to directly specify the size of the
     backing buffer but instead requires a set of NAND ID bytes that
     imply (among other things) the size of the chip (example, see 1).
     The ID bytes would have to be added to the kernel arguments for the
     UBIFS case. It might be desirable to document this somehow, for the
     next person who has to adjust the size, once a new test exhausts
     it.  Also, it would be ultimately limted by available RAM and what
     can be encoded using the NAND ID bytes."

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 .../files/root/fs/ubifs/cfg/all.list               |   1 +
 .../test-appliance/files/root/fs/ubifs/cfg/default |  11 ++
 .../test-appliance/files/root/fs/ubifs/config      | 180 +++++++++++++++++++++
 kvm-xfstests/test-appliance/files/root/runtests.sh |   4 +-
 kvm-xfstests/test-appliance/gce-xfstests-bld.sh    |   1 +
 kvm-xfstests/test-appliance/xfstests-packages      |   1 +
 6 files changed, 196 insertions(+), 2 deletions(-)
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/ubifs/cfg/all.list
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/ubifs/cfg/default
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/ubifs/config

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ubifs/cfg/all.list b/kvm-xfstests/test-appliance/files/root/fs/ubifs/cfg/all.list
new file mode 100644
index 0000000..4ad96d5
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/ubifs/cfg/all.list
@@ -0,0 +1 @@
+default
diff --git a/kvm-xfstests/test-appliance/files/root/fs/ubifs/cfg/default b/kvm-xfstests/test-appliance/files/root/fs/ubifs/cfg/default
new file mode 100644
index 0000000..be3ba67
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/ubifs/cfg/default
@@ -0,0 +1,11 @@
+SIZE=small
+
+# set up UBI volumes for our block devices
+export TEST_DEV=$(__blkdev_to_ubi_volume $SM_TST_DEV)
+export TEST_DIR=$SM_TST_MNT
+export SCRATCH_DEV=$(__blkdev_to_ubi_volume $SM_SCR_DEV)
+export SCRATCH_MNT=$SM_SCR_MNT
+
+export MKFS_OPTIONS=""
+export UBIFS_MOUNT_OPTIONS=""
+TESTNAME="ubifs"
diff --git a/kvm-xfstests/test-appliance/files/root/fs/ubifs/config b/kvm-xfstests/test-appliance/files/root/fs/ubifs/config
new file mode 100644
index 0000000..3755e4d
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/ubifs/config
@@ -0,0 +1,180 @@
+#
+# Configuration file for ubifs
+#
+# UBIFS is a filesystem for unmanaged flash memory devices, so it needs an
+# emulation layer to use block devices.  Currently we use 'blockmtd' to emulate
+# MTD devices on top of the xfstests partitions, then make UBI devices and UBI
+# volumes on top of them.  This approach has some limitations (it takes a long
+# time to 'ubiformat' the emulated MTD devices, and the partitions cannot be
+# reused to test other filesystems until the VM is rebooted), but it's better
+# than nothing.
+#
+
+DEFAULT_MKFS_OPTIONS=""
+
+function check_filesystem()
+{
+    # there is no fsck.ubifs yet
+    :
+}
+
+# Find the MTD device which is backed by the specified block device
+function __mtd_find()
+{
+    local blkdev=$1 mtd_dir
+
+    for mtd_dir in /sys/class/mtd/*; do
+	if [[ $mtd_dir =~ ^.*/mtd[0-9]+$ ]] &&
+	   [[ $(awk '/^block2mtd:/{print $2}' $mtd_dir/name) == $blkdev ]]
+	then
+	    echo /dev/$(basename $mtd_dir)
+	    return
+	fi
+    done
+}
+
+# Find or create the MTD device which is backed by the specified block device
+function __mtd_find_or_create()
+{
+    local blkdev=$1 mtd
+
+    if [ ! -e /sys/module/block2mtd ]; then
+	echo 1>&2 "Error: CONFIG_MTD_BLOCK2MTD=y is required to emulate flash device for ubifs!"
+	return
+    fi
+
+    mtd=$(__mtd_find $blkdev)
+    if [ ! -c "$mtd" ]; then
+	# Create a new block2mtd device.  For now choose an eraseblock size of
+	# 128 KiB.  I'm not sure if that's the best value or not.
+	echo "$blkdev,131072" > /sys/module/block2mtd/parameters/block2mtd
+	mtd=$(__mtd_find $blkdev)
+    fi
+    echo $mtd
+}
+
+# Find the UBI device which has the specified mtd device attached
+function __ubi_find()
+{
+    local mtd_num="${1#/dev/mtd}" ubi_dir
+
+    for ubi_dir in /sys/class/ubi/*; do
+	if [[ $ubi_dir =~ ^.*/ubi[0-9]+$ ]] &&
+	   [[ $(<$ubi_dir/mtd_num) == $mtd_num ]]
+	then
+	    echo /dev/$(basename $ubi_dir)
+	    return
+	fi
+    done
+}
+
+# Find or create the UBI device which has the specified mtd device attached
+function __ubi_find_or_create()
+{
+    local mtd="$1" ubi
+
+    ubi=$(__ubi_find $mtd)
+    if [ ! -c "$ubi" ]; then
+	if ! ubiattach -p $mtd &> /dev/null; then
+	    # ubiattach didn't work; try formatting the MTD device first.
+	    # Note: since this requires writing to the entire device, it may be
+	    # *very* slow...
+	    echo 1>&2 "Formatting $mtd with ubiformat (this may take a while!)..."
+	    ubiformat -e 0 -y $mtd > /dev/null
+	    ubiattach -p $mtd > /dev/null
+	fi
+	ubi=$(__ubi_find $mtd)
+    fi
+    echo $ubi
+}
+
+
+#
+# Find or create the UBI volume backed by the specified block device.
+#
+# There are four types of devices in play here.  Here's an example:
+#
+#	/dev/vdb     --- Block device
+#	/dev/mtd0    --- MTD device backed by /dev/vdb using block2mtd
+#	/dev/ubi0    --- UBI device to which /dev/mtd0 is attached
+#	/dev/ubi0_0  --- UBI volume within /dev/ubi0
+#
+# In this example, this function would take in /dev/vdb as $1 and echo back
+# /dev/ubi0_0, creating it and the two intermediary devices if needed.
+#
+function __blkdev_to_ubi_volume()
+{
+    local blkdev=$1 mtd ubi ubivol
+
+    if [ ! -b "$blkdev" ]; then
+	echo 1>&2 "Error: block device \"$blkdev\" not found!"
+	return
+    fi
+
+    mtd=$(__mtd_find_or_create $blkdev)
+    if [ ! -c "$mtd" ]; then
+	echo 1>&2 "Error: Failed to create MTD device from $blkdev!"
+	return
+    fi
+
+    ubi=$(__ubi_find_or_create $mtd)
+    if [ ! -c "$ubi" ]; then
+	echo 1>&2 "Error: Failed create UBI device from $mtd!"
+	return
+    fi
+
+    ubivol=${ubi}_0
+    if [ ! -c "$ubivol" ]; then
+	ubimkvol $ubi -N vol -m > /dev/null
+	if [ ! -c "$ubivol" ]; then
+	    echo 1>&2 "Error: Failed to create UBI volume $ubivol from $ubi"
+	    return
+	fi
+    fi
+    echo $ubivol
+}
+
+function format_filesystem()
+{
+    local dev="$1"
+    local opts="$2"
+
+    mkfs.ubifs -y $opts "$dev"
+}
+
+function setup_mount_opts()
+{
+    if test -n "$MNTOPTS" ; then
+	if test -n "$UBIFS_MOUNT_OPTIONS" ; then
+	    UBIFS_MOUNT_OPTIONS="$UBIFS_MOUNT_OPTIONS,$MNTOPTS"
+	else
+	    UBIFS_MOUNT_OPTIONS="-o $MNTOPTS"
+	fi
+    fi
+}
+
+function get_mkfs_opts()
+{
+    echo "$MKFS_OPTIONS"
+}
+
+function show_mkfs_opts()
+{
+    echo MKFS_OPTIONS: "$MKFS_OPTIONS"
+}
+
+function show_mount_opts()
+{
+    echo UBIFS_MOUNT_OPTIONS: "$UBIFS_MOUNT_OPTIONS"
+}
+
+function test_name_alias()
+{
+    echo "$1"
+}
+
+function reset_vars()
+{
+    unset UBIFS_MOUNT_OPTIONS
+    unset MKFS_OPTIONS
+}
diff --git a/kvm-xfstests/test-appliance/files/root/runtests.sh b/kvm-xfstests/test-appliance/files/root/runtests.sh
index bf237e8..a44f389 100755
--- a/kvm-xfstests/test-appliance/files/root/runtests.sh
+++ b/kvm-xfstests/test-appliance/files/root/runtests.sh
@@ -285,11 +285,11 @@ do
 	    */ovl) ;;
 	    *:/*) ;;
 	    *)
-		if ! test -b $TEST_DEV ; then
+		if ! [ -b $TEST_DEV -o -c $TEST_DEV ]; then
 		    echo "Test device $TEST_DEV does not exist, skipping $i config"
 		    continue
 		fi
-		if ! test -b $SCRATCH_DEV ; then
+		if ! [ -b $SCRATCH_DEV -o -c $SCRATCH_DEV ]; then
 		    echo "Scratch device $SCRATCH_DEV does not exist, skipping $i config"
 		    continue
 		fi
diff --git a/kvm-xfstests/test-appliance/gce-xfstests-bld.sh b/kvm-xfstests/test-appliance/gce-xfstests-bld.sh
index 6127e4a..a7ad6e9 100644
--- a/kvm-xfstests/test-appliance/gce-xfstests-bld.sh
+++ b/kvm-xfstests/test-appliance/gce-xfstests-bld.sh
@@ -43,6 +43,7 @@ PACKAGES="bash-completion \
 	liblzo2-2 \
 	lighttpd \
 	lvm2 \
+	mtd-utils \
 	nano \
 	openssl \
 	perl \
diff --git a/kvm-xfstests/test-appliance/xfstests-packages b/kvm-xfstests/test-appliance/xfstests-packages
index b0fc878..aa1d2e8 100644
--- a/kvm-xfstests/test-appliance/xfstests-packages
+++ b/kvm-xfstests/test-appliance/xfstests-packages
@@ -22,6 +22,7 @@ liblzo2-2
 libbsd0
 lvm2
 makedev
+mtd-utils
 perl
 procps
 psmisc
-- 
2.15.1.504.g5279b80103-goog

