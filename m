Received: from mx2.suse.de ([195.135.220.15]:39097 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936972AbeE2Q4G (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 May 2018 12:56:06 -0400
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 41BDFAD2A
        for <fstests@vger.kernel.org>; Tue, 29 May 2018 16:56:05 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 4/6] ext4/032: Fix up resize2fs usage
Date: Tue, 29 May 2018 18:55:59 +0200
Message-Id: <20180529165601.32133-5-jack@suse.cz>
In-Reply-To: <20180529165601.32133-1-jack@suse.cz>
References: <20180529165601.32133-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

The test uses resize2fs(8) without proper feature test macro and also
without specifying full path to it. Fix that.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/ext4/032 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/ext4/032 b/tests/ext4/032
index 22cd533be8e8..13faa26a0f9f 100755
--- a/tests/ext4/032
+++ b/tests/ext4/032
@@ -72,7 +72,7 @@ ext4_online_resize()
 
 	echo "+++ resize fs to $final_size" | tee -a $seqres.full
 
-	resize2fs -f ${LOOP_DEVICE} $final_size >$tmp.resize2fs 2>&1
+	$RESIZE2FS_PROG -f ${LOOP_DEVICE} $final_size >$tmp.resize2fs 2>&1
 	if [ $? -ne 0 ]; then
 		if [ $check_if_supported -eq 1 ]; then
 			grep -iq "operation not supported" $tmp.resize2fs \
@@ -114,6 +114,7 @@ _require_scratch
 # We use resize_inode to make sure that block group descriptor table
 # can be extended.
 _require_scratch_ext4_feature "bigalloc,resize_inode"
+_require_command "$RESIZE2FS_PROG" resize2fs
 
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
-- 
2.13.6

