Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49771 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751893AbeC3CKw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Mar 2018 22:10:52 -0400
From: Eryu Guan <eguan@linux.alibaba.com>
Subject: [PATCH 2/2] test-appliance: add virtfs/9p test configs
Date: Fri, 30 Mar 2018 10:10:40 +0800
Message-Id: <20180330021040.23748-2-eguan@linux.alibaba.com>
In-Reply-To: <20180330021040.23748-1-eguan@linux.alibaba.com>
References: <20180330021040.23748-1-eguan@linux.alibaba.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eryu Guan <eguan@linux.alibaba.com>
List-ID: <fstests@vger.kernel.org>

Currently virtfs/9p has only one default config file, with tests in
clone group excluded.

Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
---
 .../test-appliance/files/root/fs/9p/cfg/all.list   |  1 +
 .../test-appliance/files/root/fs/9p/cfg/default    |  7 +++
 .../test-appliance/files/root/fs/9p/config         | 50 ++++++++++++++++++++++
 .../test-appliance/files/root/fs/9p/exclude-opt    |  1 +
 4 files changed, 59 insertions(+)
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/9p/cfg/all.list
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/9p/cfg/default
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/9p/config
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/9p/exclude-opt

diff --git a/kvm-xfstests/test-appliance/files/root/fs/9p/cfg/all.list b/kvm-xfstests/test-appliance/files/root/fs/9p/cfg/all.list
new file mode 100644
index 000000000000..4ad96d51599f
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/9p/cfg/all.list
@@ -0,0 +1 @@
+default
diff --git a/kvm-xfstests/test-appliance/files/root/fs/9p/cfg/default b/kvm-xfstests/test-appliance/files/root/fs/9p/cfg/default
new file mode 100644
index 000000000000..b7d1801b6b04
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/9p/cfg/default
@@ -0,0 +1,7 @@
+export TEST_DEV=9ptest
+export TEST_DIR=/mnt/test
+export SCRATCH_DEV=9pscratch
+export SCRATCH_MNT=/mnt/scratch
+export PLAN9_MOUNT_OPTIONS="-o trans=virtio,version=9p2000.L,posixacl"
+TESTNAME="9pfs"
+mkdir -p /mnt/test /mnt/scratch
diff --git a/kvm-xfstests/test-appliance/files/root/fs/9p/config b/kvm-xfstests/test-appliance/files/root/fs/9p/config
new file mode 100644
index 000000000000..ebd0d349be63
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/9p/config
@@ -0,0 +1,50 @@
+#
+# Configuration file for 9pfs
+#
+
+DEFAULT_MKFS_OPTIONS=""
+
+function check_filesystem()
+{
+	return 0
+}
+
+function format_filesystem()
+{
+	return 0
+}
+
+function setup_mount_opts()
+{
+	if test -z "$PLAN9_MOUNT_OPTIONS" ; then
+		export PLAN9_MOUNT_OPTIONS="-o trans=virtio,version=9p2000.L,posixacl"
+	fi
+	if test -n "$MNTOPTS" ; then
+		export PLAN9_MOUNT_OPTIONS="$PLAN9_MOUNT_OPTIONS,$MNTOPTS"
+	fi
+}
+
+function get_mkfs_opts()
+{
+	return 0
+}
+
+function show_mkfs_opts()
+{
+	return 0
+}
+
+function show_mount_opts()
+{
+	echo PLAN9_MOUNT_OPTIONS: "$PLAN9_MOUNT_OPTIONS"
+}
+
+function test_name_alias()
+{
+	echo "$1"
+}
+
+function reset_vars()
+{
+	unset PLAN9_MOUNT_OPTIONS
+}
diff --git a/kvm-xfstests/test-appliance/files/root/fs/9p/exclude-opt b/kvm-xfstests/test-appliance/files/root/fs/9p/exclude-opt
new file mode 100644
index 000000000000..b29665746f8c
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/9p/exclude-opt
@@ -0,0 +1 @@
+-x clone
-- 
2.14.3

