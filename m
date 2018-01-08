Received: from mx2.suse.de ([195.135.220.15]:41986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755907AbeAHIne (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 8 Jan 2018 03:43:34 -0500
From: Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] generic/015: Change the test filesystem size to 101mb
Date: Mon,  8 Jan 2018 10:43:30 +0200
Message-Id: <1515401010-26802-1-git-send-email-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
List-ID: <fstests@vger.kernel.org>

This test has been failing for btrfs for quite some time,
at least since 4.7. There are 2 implementation details of btrfs that
it exposes:

1. Currently btrfs filesystem under 100mb are created in Mixed block
group mode. Freespace accounting for it is not 100% accurate - I've
observed around 100-200kb discrepancy between a newly created filesystem,
then writing a file and deleting it and checking the free space. This
falls within %3 and not %1 as hardcoded in the test. 

2. BTRFS won't flush it's delayed allocation on file deletion if less
than 32mb are deleted. On such files we need to perform sync (missing
in the test) or wait until time elapses for transaction commit.

Since mixed mode is somewhat deprecated and btrfs is not really intended
to be used on really small devices let's just adjust the test to
create a 101mb fs, which doesn't use mixed mode and really test
freespace accounting.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/generic/015 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/015 b/tests/generic/015
index 78f2b13..416c4ae 100755
--- a/tests/generic/015
+++ b/tests/generic/015
@@ -53,7 +53,7 @@ _supported_os Linux
 _require_scratch
 _require_no_large_scratch_dev
 
-_scratch_mkfs_sized `expr 50 \* 1024 \* 1024` >/dev/null 2>&1 \
+_scratch_mkfs_sized `expr 101 \* 1024 \* 1024` >/dev/null 2>&1 \
     || _fail "mkfs failed"
 _scratch_mount || _fail "mount failed"
 out=$SCRATCH_MNT/fillup.$$
-- 
2.7.4

