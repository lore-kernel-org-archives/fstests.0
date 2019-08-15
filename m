Received: from mail-qt1-f196.google.com ([209.85.160.196]:44536 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbfHOS1D (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Aug 2019 14:27:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id 44so3307903qtg.11
        for <fstests@vger.kernel.org>; Thu, 15 Aug 2019 11:27:02 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] fstests: generic/500 doesn't work for btrfs
Date: Thu, 15 Aug 2019 14:26:59 -0400
Message-Id: <20190815182659.27875-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

Btrfs does COW, so when we unlink the file we need to update metadata
and write it to a new location, which we can't do because the thinp is
full.  This results in an EIO during a metadata write, which makes us
flip read only, thus making it impossible to fstrim the fs.  Just make
it so we skip this test for btrfs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/500 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/generic/500 b/tests/generic/500
index 201d8b9f..5cd7126f 100755
--- a/tests/generic/500
+++ b/tests/generic/500
@@ -49,6 +49,12 @@ _supported_os Linux
 _require_scratch_nocheck
 _require_dm_target thin-pool
 
+# The unlink below will result in new metadata blocks for btrfs because of CoW,
+# and since we've filled the thinp device it'll return EIO, which will make
+# btrfs flip read only, making it fail this test when it just won't work right
+# for us in the first place.
+test $FSTYP == "btrfs"  && _notrun "btrfs doesn't work that way lol"
+
 # Require underlying device support discard
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
-- 
2.21.0
