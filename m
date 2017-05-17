Received: from mail.sigma-star.at ([95.130.255.111]:45999 "EHLO
        mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753849AbdEQJ4R (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 May 2017 05:56:17 -0400
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH] xfstests-bld: add experimental support for ubifs
Date: Wed, 17 May 2017 11:55:31 +0200
Message-Id: <20170517095531.11818-4-david.oberhollenzer@sigma-star.at>
In-Reply-To: <20170517095531.11818-1-david.oberhollenzer@sigma-star.at>
References: <20170517095531.11818-1-david.oberhollenzer@sigma-star.at>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, richard@nod.at, Eric Biggers <ebiggers@google.com>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

This experimental patch adds ubifs support to kvm-xfstests and
gce-xfstests.  Unlike most filesystems ubifs is not block-device based.
Instead it uses an UBI volume, which is layered above an MTD (raw flash)
device.  Fortunately it's possible to use the block2mtd kernel module to
emulate an MTD device given a block device.  This patch adds an ubifs
xfstests-bld config which uses block2mtd to create MTD devices, then UBI
devices and UBI volumes, that are backed by the kvm-xfstests or
gce-xfstests block devices.

Here are the steps to run kvm-xfstests on ubifs after this patch:

1. Apply ubifs support patch to xfstests
2. Build a kernel based on the existing xfstests-bld config but also with:
	CONFIG_MTD=y
	CONFIG_MTD_BLOCK2MTD=y
	CONFIG_MTD_UBI=y
	CONFIG_UBIFS_FS=y
	CONFIG_UBIFS_FS_ENCRYPTION=y
3. Run: kvm-xfstests -c ubifs -g <group> ...

I also tried using QEMU to emulate a MTD device directly, but I couldn't
get it to work; and that definitely won't work for gce-xfstests.

Known issues (other than real test failures):

- The first time ubifs tests are run, it takes a long time to format the
  emulated MTD devices.  I don't know of a way around this other than
  simply using smaller devices.

- Using the same block devices for other filesystems and for MTD
  emulation can cause problems, e.g. without rebooting the VM, it's not
  possible to run tests on another filesystem after ubifs because
  block2mtd does not support removing MTD devices.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
---
 .../files/root/fs/ubifs/cfg/all.list               |   1 +
 .../test-appliance/files/root/fs/ubifs/cfg/default |  11 ++
 .../test-appliance/files/root/fs/ubifs/config      | 167 +++++++++++++++++++++
 kvm-xfstests/test-appliance/files/root/runtests.sh |   4 +-
 kvm-xfstests/test-appliance/xfstests-packages      |   1 +
 5 files changed, 182 insertions(+), 2 deletions(-)
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
index 0000000..91d8de6
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/ubifs/config
@@ -0,0 +1,167 @@
+#
+# Configuration file for ubifs
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
index 8363427..9577f3e 100755
--- a/kvm-xfstests/test-appliance/files/root/runtests.sh
+++ b/kvm-xfstests/test-appliance/files/root/runtests.sh
@@ -272,11 +272,11 @@ do
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
diff --git a/kvm-xfstests/test-appliance/xfstests-packages b/kvm-xfstests/test-appliance/xfstests-packages
index afb6c5d..2f8e4b0 100644
--- a/kvm-xfstests/test-appliance/xfstests-packages
+++ b/kvm-xfstests/test-appliance/xfstests-packages
@@ -30,3 +30,4 @@ time
 uuid-runtime
 udev
 xz-utils
+mtd-utils
-- 
2.12.0

