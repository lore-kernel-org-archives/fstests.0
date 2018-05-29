Received: from mx2.suse.de ([195.135.220.15]:39110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937004AbeE2Q4I (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 May 2018 12:56:08 -0400
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 666BAADB0
        for <fstests@vger.kernel.org>; Tue, 29 May 2018 16:56:05 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 6/6] ext4/306: Fixup resize2fs usage
Date: Tue, 29 May 2018 18:56:01 +0200
Message-Id: <20180529165601.32133-7-jack@suse.cz>
In-Reply-To: <20180529165601.32133-1-jack@suse.cz>
References: <20180529165601.32133-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Use $RESIZE2FS_PROG instead of direct name to call program with full
path. Also add an appropriate feature test.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/ext4/306 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/ext4/306 b/tests/ext4/306
index 7d00bad6c1ce..5b3744d0597c 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -44,6 +44,7 @@ _supported_fs ext4
 _supported_os Linux
 
 _require_scratch
+_require_command "$RESIZE2FS_PROG" resize2fs
 
 rm -f $seqres.full
 
@@ -67,7 +68,7 @@ df -h $SCRATCH_MNT >> $seqres.full
 
 # Grow fs by 512m
 echo "Resize to 1g"
-resize2fs $SCRATCH_DEV 1g >> $seqres.full 2>&1 || _fail "Could not resize to 1g"
+$RESIZE2FS_PROG $SCRATCH_DEV 1g >> $seqres.full 2>&1 || _fail "Could not resize to 1g"
 df -h $SCRATCH_MNT >> $seqres.full
 
 # See if we can add more blocks to the files
-- 
2.13.6

