Received: from mail-wm0-f67.google.com ([74.125.82.67]:36798 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdESGu4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 19 May 2017 02:50:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id k15so14837922wmh.3
        for <fstests@vger.kernel.org>; Thu, 18 May 2017 23:50:55 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] test-appliance: use new overlay xfstest config
Date: Fri, 19 May 2017 09:51:03 +0300
Message-Id: <1495176663-2226-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eryu Guan <eguan@redhat.com>, Eric Biggers <ebiggers@google.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

requires xfstests commit 33e4199
("overlay: use OVL_BASE_SCRATCH_MNT instead of SCRATCH_DEV")

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/large | 8 ++++----
 kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/small | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

Ted,

Forgot to post this one in addition to the github PR:
https://github.com/tytso/xfstests-bld/pull/4

Using the new overlay xfstest config is helping catch reference leak
bugs all the time, because it mount cycle the underlying base fs on
every test and within tests that do cycle_mount.

Please pull.

Thanks,
Amir.

diff --git a/kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/large b/kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/large
index ec1adf0..ab9a2bb 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/large
+++ b/kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/large
@@ -9,10 +9,10 @@ function format_filesystem()
 }
 
 SIZE=large
-export TEST_DEV=$LG_TST_MNT/ovl
-export TEST_DIR=$LG_TST_MNT/testarea
-export SCRATCH_DEV=$LG_SCR_MNT/ovl
-export SCRATCH_MNT=$LG_SCR_MNT/testarea
+export TEST_DEV=$LG_TST_DEV
+export TEST_DIR=$LG_TST_MNT
+export SCRATCH_DEV=$LG_SCR_DEV
+export SCRATCH_MNT=$LG_SCR_MNT
 export EXT_MOUNT_OPTIONS=""
 TESTNAME="overlayfs large"
 mkdir -p /test/tmp /test/scratch
diff --git a/kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/small b/kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/small
index a28a191..552e302 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/small
+++ b/kvm-xfstests/test-appliance/files/root/fs/overlay/cfg/small
@@ -9,10 +9,10 @@ function format_filesystem()
 }
 
 SIZE=small
-export TEST_DEV=$SM_TST_MNT/ovl
-export TEST_DIR=$SM_TST_MNT/testarea
-export SCRATCH_DEV=$SM_SCR_MNT/ovl
-export SCRATCH_MNT=$SM_SCR_MNT/testarea
+export TEST_DEV=$SM_TST_DEV
+export TEST_DIR=$SM_TST_MNT
+export SCRATCH_DEV=$SM_SCR_DEV
+export SCRATCH_MNT=$SM_SCR_MNT
 export EXT_MOUNT_OPTIONS=""
 TESTNAME="overlayfs small"
 mkdir -p /test/tmp /test/scratch
-- 
2.7.4

