Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35593C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Dec 2021 03:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhLODyW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Dec 2021 22:54:22 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52997 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229453AbhLODyV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Dec 2021 22:54:21 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BF3sH4h003303
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 22:54:18 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4EBF515C00C8; Tue, 14 Dec 2021 22:54:17 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4/033: remove a portion of the test assuming resize2fs would fail
Date:   Tue, 14 Dec 2021 22:54:09 -0500
Message-Id: <20211215035409.244674-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The ext4/033 test tries to test if resize2fs would fail when resizing
a file system to a size that the number of inodes exceeds the maximum
allowed inode size, 2**32-1.  This no longer takes place as of
e2fsprogs commit 623985ed7dd5 ("resize2fs: attempt to keep the # of
inodes valid by removing the last bg") which will allow resizing a
file system to 64TB by reducing the last block group so that file
system will be 64TB - 128MB, which is close enough for government
work.

Reported-by: Eric Whitney <enwlinux@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/033     | 8 --------
 tests/ext4/033.out | 1 -
 2 files changed, 9 deletions(-)

diff --git a/tests/ext4/033 b/tests/ext4/033
index 1bc14c03..0fd0ec90 100755
--- a/tests/ext4/033
+++ b/tests/ext4/033
@@ -66,14 +66,6 @@ _mount $DMHUGEDISK_DEV $SCRATCH_MNT
 echo "Initial fs dump" >> $seqres.full
 $DUMPE2FS_PROG -h $DMHUGEDISK_DEV >> $seqres.full 2>&1
 
-# This should fail, s_inodes_count would just overflow!
-echo "Resizing to inode limit + 1..."
-$RESIZE2FS_PROG $DMHUGEDISK_DEV $((limit_groups*group_blocks)) >> $seqres.full 2>&1
-if [ $? -eq 0 ]; then
-	echo "Resizing succeeded but it should fail!"
-	exit
-fi
-
 # This should succeed, we are maxing out inodes
 echo "Resizing to max group count..."
 $RESIZE2FS_PROG $DMHUGEDISK_DEV $(((limit_groups-1)*group_blocks)) >> $seqres.full 2>&1
diff --git a/tests/ext4/033.out b/tests/ext4/033.out
index 24c251cb..183a7492 100644
--- a/tests/ext4/033.out
+++ b/tests/ext4/033.out
@@ -1,6 +1,5 @@
 QA output created by 033
 Figure out block size
 Format huge device
-Resizing to inode limit + 1...
 Resizing to max group count...
 Resizing to device size...
-- 
2.31.0

