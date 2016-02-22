Received: from imap.thunk.org ([74.207.234.97]:34166 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753072AbcBVE0U (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 21 Feb 2016 23:26:20 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/4] xfstests: remove dependency on /proc/partitions for generic/312
Date: Sun, 21 Feb 2016 23:26:08 -0500
Message-Id: <1456115171-13191-2-git-send-email-tytso@mit.edu>
In-Reply-To: <1456115171-13191-1-git-send-email-tytso@mit.edu>
References: <1456115171-13191-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

We don't need to do this test at all, since _scratch_mkfs_sized will
do this check for us.   This allows this test to work with tmpfs.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/312 | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/generic/312 b/tests/generic/312
index b570814..669e19b 100755
--- a/tests/generic/312
+++ b/tests/generic/312
@@ -51,11 +51,6 @@ _require_scratch
 
 # 5G in byte
 fssize=$((2**30 * 5))
-required_blocks=$(($fssize / 1024))
-dev_blocks=$(grep -w $(_short_dev $SCRATCH_DEV) /proc/partitions | $AWK_PROG '{print $3}')
-if [ $required_blocks -gt $dev_blocks ];then
-	_notrun "this test requires \$SCRATCH_DEV has ${fssize}B space"
-fi
 
 rm -f $seqres.full
 _scratch_mkfs_sized $fssize >>$seqres.full 2>&1
-- 
2.5.0

