Received: from mx2.suse.de ([195.135.220.15]:59160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754413AbeAKJRy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 11 Jan 2018 04:17:54 -0500
From: Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] generic/015: Change the test filesystem size to 101mb
Date: Thu, 11 Jan 2018 11:17:47 +0200
Message-Id: <1515662267-21518-1-git-send-email-nborisov@suse.com>
In-Reply-To: <1515401010-26802-1-git-send-email-nborisov@suse.com>
References: <1515401010-26802-1-git-send-email-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
List-ID: <fstests@vger.kernel.org>

This test has been failing for btrfs for quite some time,
at least since 4.7. There are 2 implementation details of btrfs that
it exposes:

1. Currently btrfs filesystem under 100mb are created in Mixed block
group mode. Freespace accounting for it is not 100% accurate - I've
observed consistent 1mb discrepancy between a newly created filesystem,
then writing a file and deleting it and checking the free space.

2. BTRFS won't flush it's delayed allocation on file deletion if less
than 32mb are deleted. On such files we need to perform sync (missing
in the test) or wait until time elapses for transaction commit.

In order to avoid both of the aforementioned idiosyncrasies of the fs make
the test filesystem 101mb. With this we achieve 2 things: 

1. Since the filesystem is larger we can create a file larger than 32mb, so 
it's going to be flushed upon deletion and numbers acquired from df will be 
accurate 
2. We don't create the filesystem in mixed mode and also since the 1mb is less 
than %1 of 101mb we will fall within the tolerance of 1%

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/generic/015 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/generic/015 b/tests/generic/015
index 78f2b13..9dcdde9 100755
--- a/tests/generic/015
+++ b/tests/generic/015
@@ -53,7 +53,11 @@ _supported_os Linux
 _require_scratch
 _require_no_large_scratch_dev
 
-_scratch_mkfs_sized `expr 50 \* 1024 \* 1024` >/dev/null 2>&1 \
+# With filesystems less than 100mb btrfs is created in mixed mode
+# which can lead to slight accounting errors of 1mb. Having the
+# fs be at least 101 mb ensures those errors are within the error
+# tolerance of 1%
+_scratch_mkfs_sized `expr 101 \* 1024 \* 1024` >/dev/null 2>&1 \
     || _fail "mkfs failed"
 _scratch_mount || _fail "mount failed"
 out=$SCRATCH_MNT/fillup.$$
-- 
2.7.4

