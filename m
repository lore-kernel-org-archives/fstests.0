Received: from mx2.suse.de ([195.135.220.15]:40356 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbcFPKFT (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 16 Jun 2016 06:05:19 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 13E2CACEC
	for <fstests@vger.kernel.org>; Thu, 16 Jun 2016 10:05:17 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4/271: Fix test failure with data=<foo> mount option
Date: Thu, 16 Jun 2016 12:05:11 +0200
Message-Id: <1466071511-30069-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

The test is failing when MOUNT_OPTIONS contain 'data=<foo>' mount option
as it does not combine with 'noload' mount option the test uses. Fix it
by removing the data=<foo> mount option. Arguably we could also fix the
problem by just skipping the test when such option is set but e.g. using
'data=writeback' is common to excercise somewhat different behavior and
it is undesirable to skip the test just because of this.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/ext4/271 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/ext4/271 b/tests/ext4/271
index d68c2719024e..417a796ffac9 100755
--- a/tests/ext4/271
+++ b/tests/ext4/271
@@ -45,6 +45,10 @@ _scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
 
 # -onoload and EXT4_SYNC_FL on file is important becase result in
 # metadata sync writes inside ext4_handle_dirty_metadata()
+#
+# We have to be careful and remove data=<foo> mount options as they don't
+# combine with 'noload'.
+MOUNT_OPTIONS=$(echo $MOUNT_OPTIONS | sed -e 's/\([ ,]\)data=[a-zA-Z]*[,$]/\1/')
 _scratch_mount -onoload
 touch $SCRATCH_MNT/file
 $CHATTR_PROG +S $SCRATCH_MNT/file
-- 
2.6.6

