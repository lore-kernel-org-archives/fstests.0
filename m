Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:60441 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbaJIOzl (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 9 Oct 2014 10:55:41 -0400
Received: by mail-ig0-f174.google.com with SMTP id a13so7544607igq.1
        for <fstests@vger.kernel.org>; Thu, 09 Oct 2014 07:55:40 -0700 (PDT)
Received: from vm01.localdomain ([221.181.146.136])
        by mx.google.com with ESMTPSA id lp6sm15328333igb.16.2014.10.09.07.55.38
        for <fstests@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 07:55:39 -0700 (PDT)
From: Wang Shilong <wangshilong1991@gmail.com>
Subject: [PATCH] xfstests,shared/032: fix fsck failure
Date: Thu,  9 Oct 2014 18:54:45 -0400
Message-Id: <1412895285-10544-1-git-send-email-wangshilong1991@gmail.com>
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
so to make fsck happy later, let's fomrat fs here.

Signed-off-by: Wang Shilong <wangshilong1991@gmail.com>
---
 tests/shared/032 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/shared/032 b/tests/shared/032
index 7835e30..7a1a242 100755
--- a/tests/shared/032
+++ b/tests/shared/032
@@ -91,6 +91,9 @@ do
 	fi
 done
 
+# make fsck happy later.
+_scratch_mkfs > /dev/null 2>&1
+
 # success, all done
 status=0
 exit
-- 
1.8.3.1

