Received: from mx2.suse.de ([195.135.220.15]:46332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729891AbfAUQdo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 Jan 2019 11:33:44 -0500
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 818FDAFAA
        for <fstests@vger.kernel.org>; Mon, 21 Jan 2019 16:33:43 +0000 (UTC)
From: jeffm@suse.com
Subject: [PATCH 4/7] btrfs: require feature raid56 for raid56 tests
Date: Mon, 21 Jan 2019 11:33:13 -0500
Message-Id: <20190121163316.20616-4-jeffm@suse.com>
In-Reply-To: <20190121163316.20616-1-jeffm@suse.com>
References: <20190121163316.20616-1-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jeff Mahoney <jeffm@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Jeff Mahoney <jeffm@suse.com>

btrfs/125, btrfs/148, btrfs/157, and btrfs/158 test for raid56
behavior.  We shouldn't run if the kernel doesn't have support for them.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 tests/btrfs/125 | 1 +
 tests/btrfs/148 | 1 +
 tests/btrfs/157 | 1 +
 tests/btrfs/158 | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tests/btrfs/125 b/tests/btrfs/125
index 5ac68b67..847fa62a 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -51,6 +51,7 @@ _supported_os Linux
 _require_scratch_dev_pool 3
 _test_unmount
 _require_loadable_fs_module "btrfs"
+_require_btrfs_fs_feature raid56
 
 _scratch_dev_pool_get 3
 
diff --git a/tests/btrfs/148 b/tests/btrfs/148
index d0e554c2..3fd8616f 100755
--- a/tests/btrfs/148
+++ b/tests/btrfs/148
@@ -30,6 +30,7 @@ _supported_os Linux
 _require_scratch
 _require_scratch_dev_pool 4
 _require_odirect
+_require_btrfs_fs_feature raid56
 
 _scratch_dev_pool_get 4
 
diff --git a/tests/btrfs/157 b/tests/btrfs/157
index d9ea4b7b..7f75c407 100755
--- a/tests/btrfs/157
+++ b/tests/btrfs/157
@@ -49,6 +49,7 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch_dev_pool 4
 _require_btrfs_command inspect-internal dump-tree
+_require_btrfs_fs_feature raid56
 
 get_physical_stripe0()
 {
diff --git a/tests/btrfs/158 b/tests/btrfs/158
index fe2dd956..603e8bea 100755
--- a/tests/btrfs/158
+++ b/tests/btrfs/158
@@ -41,6 +41,7 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch_dev_pool 4
 _require_btrfs_command inspect-internal dump-tree
+_require_btrfs_fs_feature raid56
 
 get_physical_stripe0()
 {
-- 
2.16.4
