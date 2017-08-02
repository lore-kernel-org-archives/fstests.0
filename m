Received: from mx1.redhat.com ([209.132.183.28]:36054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752443AbdHBOkE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 2 Aug 2017 10:40:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF0BF4DD7C
        for <fstests@vger.kernel.org>; Wed,  2 Aug 2017 14:40:03 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 2/2] check: source common/rc again if TEST_DEV was recreated
Date: Wed,  2 Aug 2017 22:39:15 +0800
Message-Id: <20170802143915.19585-2-eguan@redhat.com>
In-Reply-To: <20170802143915.19585-1-eguan@redhat.com>
References: <20170802143915.19585-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

If TEST_DEV is recreated by check, FSTYP derived from TEST_DEV
previously could be changed too and might not reflect the reality.
So source common/rc again with correct FSTYP to get fs-specific
configs, e.g. common/xfs.

For example, using this config-section config file, and run section
ext4 first then xfs, you can see:

our local _scratch_mkfs routine ...
./common/rc: line 825: _scratch_mkfs_xfs: command not found
check: failed to mkfs $SCRATCH_DEV using specified options

local.config:
[default]
RECREATE_TEST_DEV=true
TEST_DEV=/dev/sda5
SCRATCH_DEV=/dev/sda6
TEST_DIR=/mnt/test
SCRATCH_MNT=/mnt/scratch

[ext4]
MKFS_OPTIONS="-b 4096"
FSTYP=ext4

[xfs]
FSTYP=xfs
MKFS_OPTIONS="-f -b size=4k"

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 check | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/check b/check
index f8db3cd6dfab..07586ce463c4 100755
--- a/check
+++ b/check
@@ -555,6 +555,10 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			status=1
 			exit
 		fi
+		# TEST_DEV has been recreated, previous FSTYP derived from
+		# TEST_DEV could be changed, source common/rc again with
+		# correct FSTYP to get FSTYP specific configs, e.g. common/xfs
+		. common/rc
 		_prepare_test_list
 	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
 		_test_unmount 2> /dev/null
-- 
2.13.3

