Received: from imap.thunk.org ([74.207.234.97]:60332 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750759AbdLKWgS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 11 Dec 2017 17:36:18 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] test-appliance: exclude generic/382 from the ext3 configuration
Date: Mon, 11 Dec 2017 17:36:14 -0500
Message-Id: <20171211223614.21052-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

The generic/382 test fails on ext3 configuration because the quota
report, which includs the number of blocks used after writing a 30 meg
file, is in the golden output.  Unfortunately this doesn't take into
account the indirect blocks which are needed when we are in ext3 mode
and the extents feature is disabled.

It's not clear whether this should be considered a test bug or not,
but at least for now, suppress this test in the ext3 configuration for
{kvm,gce,android}-xfstests.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/ext3.exclude | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/ext3.exclude b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/ext3.exclude
index f78524f..c77c75f 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/ext3.exclude
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/ext3.exclude
@@ -1,3 +1,8 @@
 # This takes a *long* time and doesn't add much value to run on all
 # configurations.  So we're going to be selective where we run it.
 generic/027
+
+# The generic/382 test fails on ext3 because the indirect blocks
+# are included in the quota report, and so the resulting quota
+# report output is different from what is expected in the 382.out file
+generic/382
-- 
2.11.0.rc0.7.gbe5a750

