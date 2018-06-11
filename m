Received: from mail-wm0-f49.google.com ([74.125.82.49]:40331 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754039AbeFKIP2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Jun 2018 04:15:28 -0400
Received: by mail-wm0-f49.google.com with SMTP id n5-v6so14580188wmc.5
        for <fstests@vger.kernel.org>; Mon, 11 Jun 2018 01:15:27 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] test-appliance: add noftype configs for ext2/ext4/xfs
Date: Mon, 11 Jun 2018 11:16:58 +0300
Message-Id: <1528705018-28604-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Ted,

These config files were used for testing generic/401
and other ftype related tests.

Thanks,
Amir.

 kvm-xfstests/test-appliance/files/root/fs/ext2/cfg/noftype | 4 ++++
 kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/noftype | 4 ++++
 kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/noftype  | 3 +++
 3 files changed, 11 insertions(+)
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/ext2/cfg/noftype
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/noftype
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/noftype

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext2/cfg/noftype b/kvm-xfstests/test-appliance/files/root/fs/ext2/cfg/noftype
new file mode 100644
index 0000000..31ab387
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext2/cfg/noftype
@@ -0,0 +1,4 @@
+SIZE=small
+export MKFS_OPTIONS="-O ^filetype"
+export EXT_MOUNT_OPTIONS=""
+TESTNAME="Ext2 no filetype"
diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/noftype b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/noftype
new file mode 100644
index 0000000..03cd96f
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/noftype
@@ -0,0 +1,4 @@
+SIZE=small
+export MKFS_OPTIONS="-O ^filetype"
+export EXT_MOUNT_OPTIONS=""
+TESTNAME="Ext4 no filetype"
diff --git a/kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/noftype b/kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/noftype
new file mode 100644
index 0000000..0bf0446
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/xfs/cfg/noftype
@@ -0,0 +1,3 @@
+SIZE=small
+export XFS_MKFS_OPTIONS="-m crc=0 -n ftype=0"
+TESTNAME="XFS noftype"
-- 
2.7.4

