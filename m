Received: from mx2.suse.de ([195.135.220.15]:41762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751377AbeFVVip (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 22 Jun 2018 17:38:45 -0400
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B942FACFF
        for <fstests@vger.kernel.org>; Fri, 22 Jun 2018 21:38:43 +0000 (UTC)
Date: Fri, 22 Jun 2018 23:38:43 +0200
From: Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH] btrfs/149: don't run if PAGE_SIZE > 4096
Message-ID: <20180622213843.GF28053@wotan.suse.de>
Reply-To: Mark Fasheh <mfasheh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The test assumes a 4K block size and fails on larger block sizes - the
extent layout will not match and the reflink command will fail.

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 tests/btrfs/149 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/btrfs/149 b/tests/btrfs/149
index 3e955a30..64bc8ac3 100755
--- a/tests/btrfs/149
+++ b/tests/btrfs/149
@@ -37,6 +37,12 @@ _require_scratch
 _require_scratch_reflink
 _require_odirect
 
+# Test output will not match results if page size > 4096
+PAGE_SIZE=`getconf PAGE_SIZE`
+if [ $PAGE_SIZE -gt 4096 ]; then
+    _notrun "Not supported with page size > 4096"
+fi
+
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
 rm -f $seqres.full
-- 
2.15.1

