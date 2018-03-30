Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:48934 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751893AbeC3CLB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Mar 2018 22:11:01 -0400
From: Eryu Guan <eguan@linux.alibaba.com>
Subject: [PATCH 1/2] kvm-xfstests: add virtfs/9p test support
Date: Fri, 30 Mar 2018 10:10:39 +0800
Message-Id: <20180330021040.23748-1-eguan@linux.alibaba.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eryu Guan <eguan@linux.alibaba.com>
List-ID: <fstests@vger.kernel.org>

Add 9p test support, introduce three new configurable variables

- VIRTFS_TEST_PATH: path to be exported to kvm guest as TEST_DEV
- VIRTFS_SCRATCH_PATH: path to be exported to kvm guest as SCRATCH_DEV
- VIRTFS_MODEL: security model, "none" as default

The mount tags in guest are 9ptest and 9pscratch.

Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
---
 kvm-xfstests/config.kvm                            |  5 +++++
 kvm-xfstests/kvm-xfstests                          | 19 +++++++++++++++++--
 kvm-xfstests/test-appliance/files/root/runtests.sh |  2 +-
 kvm-xfstests/util/parse_cli                        | 12 ++++++++++++
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/kvm-xfstests/config.kvm b/kvm-xfstests/config.kvm
index a08236fdc11e..fc20a1497ed5 100644
--- a/kvm-xfstests/config.kvm
+++ b/kvm-xfstests/config.kvm
@@ -48,3 +48,8 @@ CONSOLE=" -serial mon:stdio"
 # Native AIO is probably better for our goal which is test proofing
 # production systems.
 AIO=",aio=native"
+
+# Exported test/scratch dirs for 9p test in kvm guest, and virtfs security model
+#VIRTFS_TEST_PATH=/tmp/9ptest
+#VIRTFS_SCRATCH_PATH=/tmp/9pscratch
+#VIRTFS_MODEL=mapped
diff --git a/kvm-xfstests/kvm-xfstests b/kvm-xfstests/kvm-xfstests
index ccc8ae96fc8e..a02beab80e71 100755
--- a/kvm-xfstests/kvm-xfstests
+++ b/kvm-xfstests/kvm-xfstests
@@ -78,6 +78,22 @@ fi
 if test -z "$VIRTFS_PATH"; then
     VIRTFS_PATH=/tmp/kvm-xfstests-$USER
 fi
+VIRTFS="-fsdev local,id=v_tmp,path=$VIRTFS_PATH,security_model=none "
+VIRTFS+="-device virtio-9p-pci,fsdev=v_tmp,mount_tag=v_tmp "
+
+if test -z "$VIRTFS_MODEL"; then
+    VIRTFS_MODEL=none
+fi
+if test -n "$VIRTFS_TEST_PATH"; then
+    VIRTFS+="-fsdev local,id=p9test,path=$VIRTFS_TEST_PATH,"
+    VIRTFS+="security_model=$VIRTFS_MODEL "
+    VIRTFS+="-device virtio-9p-pci,fsdev=p9test,mount_tag=9ptest "
+fi
+if test -n "$VIRTFS_SCRATCH_PATH"; then
+    VIRTFS+=" -fsdev local,id=p9scratch,path=$VIRTFS_SCRATCH_PATH,"
+    VIRTFS+="security_model=$VIRTFS_MODEL "
+    VIRTFS+="-device virtio-9p-pci,fsdev=p9scratch,mount_tag=9pscratch "
+fi
 
 VDH=$(mktemp /tmp/kvm-upload.XXXXXXXX)
 trap 'rm -f "$VDH"' 0
@@ -119,8 +135,7 @@ $NO_ACTION $IONICE $QEMU -boot order=c $NET \
 	-drive file=$VDG,cache=none,if=virtio,format=raw$AIO \
 	-drive file=$VDH,if=virtio,format=raw \
 	-vga none -nographic -smp $NR_CPU -m $MEM \
-	-fsdev local,id=v_tmp,path=$VIRTFS_PATH,security_model=none \
-	-device virtio-9p-pci,fsdev=v_tmp,mount_tag=v_tmp \
+	$VIRTFS \
 	$VIRTIO_RNG \
 	$CONSOLE \
 	$MONITOR \
diff --git a/kvm-xfstests/test-appliance/files/root/runtests.sh b/kvm-xfstests/test-appliance/files/root/runtests.sh
index a44f3893a6a4..0a83c70af853 100755
--- a/kvm-xfstests/test-appliance/files/root/runtests.sh
+++ b/kvm-xfstests/test-appliance/files/root/runtests.sh
@@ -282,7 +282,7 @@ do
 	    fi
 	fi
 	case "$TEST_DEV" in
-	    */ovl) ;;
+	    */ovl|9p*) ;;
 	    *:/*) ;;
 	    *)
 		if ! [ -b $TEST_DEV -o -c $TEST_DEV ]; then
diff --git a/kvm-xfstests/util/parse_cli b/kvm-xfstests/util/parse_cli
index 11b45758b31b..52f518a5064c 100644
--- a/kvm-xfstests/util/parse_cli
+++ b/kvm-xfstests/util/parse_cli
@@ -399,6 +399,18 @@ while [ "$1" != "" ]; do
 	    supported_flavors kvm
 	    VIRTFS_PATH="$1"
 	    ;;
+	--virtfs-test) shift
+	    supported_flavors kvm
+	    VIRTFS_TEST_PATH="$1"
+	    ;;
+	--virtfs-scratch) shift
+	    supported_flavors kvm
+	    VIRTFS_SCRATCH_PATH="$1"
+	    ;;
+	--virtfs-model) shift
+	    supported_flavors kvm
+	    VIRTFS_MODEL="$1"
+	    ;;
 	--archive)
 	    supported_flavors kvm
 	    DO_ARCHIVE=1
-- 
2.14.3

