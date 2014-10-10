Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:49449 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbaJIQRu (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 9 Oct 2014 12:17:50 -0400
Received: by mail-pd0-f169.google.com with SMTP id w10so44671pde.28
        for <fstests@vger.kernel.org>; Thu, 09 Oct 2014 09:17:49 -0700 (PDT)
Received: from vm01.localdomain ([221.181.146.136])
        by mx.google.com with ESMTPSA id gw1sm957956pbd.49.2014.10.09.09.17.48
        for <fstests@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 09:17:49 -0700 (PDT)
From: Wang Shilong <wangshilong1991@gmail.com>
Subject: [PATCH v3] xfstests,shared/032: fix fsck failure
Date: Thu,  9 Oct 2014 20:16:57 -0400
Message-Id: <1412900217-58174-1-git-send-email-wangshilong1991@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

while running ./check tests/shared/032, it outputs something like:

FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 vm01 3.17.0-rc5+
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /mnt/scratch

shared/032 2s ... 2s
_check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent (see /root/xfstests-dev/results//shared/032.full)
Ran: shared/032
Passed all 1 tests

This is because xfstests will run fsck after each unit test,
for tests/shared/032, we have reformated SCRATCH_DEV to other fs,
fix this problem by skipping fsck here.

Signed-off-by: Wang Shilong <wangshilong1991@gmail.com>
---
 v2->v3: fix commit message....
 v1->v2: use _require_scratch_nocheck helper to skip fsck.(pointed by Eryu Guan)
---
 tests/shared/032 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/shared/032 b/tests/shared/032
index 7835e30..a410003 100755
--- a/tests/shared/032
+++ b/tests/shared/032
@@ -40,7 +40,7 @@ rm -f $seqres.full
 _supported_fs xfs btrfs
 _supported_os Linux
 
-_require_scratch
+_require_scratch_nocheck
 _require_no_large_scratch_dev
 
 # mkfs.btrfs did not have overwrite detection at first
-- 
1.8.3.1

