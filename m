Received: from mx2.suse.de ([195.135.220.15]:46350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730516AbfAUQdq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 Jan 2019 11:33:46 -0500
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93B13AFBF
        for <fstests@vger.kernel.org>; Mon, 21 Jan 2019 16:33:44 +0000 (UTC)
From: jeffm@suse.com
Subject: [PATCH 6/7] btrfs/131: require support for free-space-tree
Date: Mon, 21 Jan 2019 11:33:15 -0500
Message-Id: <20190121163316.20616-6-jeffm@suse.com>
In-Reply-To: <20190121163316.20616-1-jeffm@suse.com>
References: <20190121163316.20616-1-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jeff Mahoney <jeffm@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Jeff Mahoney <jeffm@suse.com>

btrfs/131 tests the free space tree, which older kernels won't have.  We
shouldn't run there.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 tests/btrfs/131 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/btrfs/131 b/tests/btrfs/131
index 0da1e7be..3de7eef8 100755
--- a/tests/btrfs/131
+++ b/tests/btrfs/131
@@ -34,6 +34,7 @@ _supported_fs btrfs
 _supported_os Linux
 _require_scratch
 _require_btrfs_command inspect-internal dump-super
+_require_btrfs_fs_feature free_space_tree
 
 mkfs_v1()
 {
-- 
2.16.4
