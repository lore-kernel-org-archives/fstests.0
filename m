Received: from mx2.suse.de ([195.135.220.15]:46995 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967755AbeE2Wec (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 May 2018 18:34:32 -0400
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0EB49AB34
        for <fstests@vger.kernel.org>; Tue, 29 May 2018 22:34:31 +0000 (UTC)
Date: Wed, 30 May 2018 00:34:30 +0200
From: Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH] generic/009: don't run for btrfs if PAGE_SIZE > 4096
Message-ID: <20180529223430.GC19860@wotan.suse.de>
Reply-To: Mark Fasheh <mfasheh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Btrfs has the same issue as XFS here in that the extent layout on
a > 4096 page size system will not match what is reflected in the
test output.

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 tests/generic/009 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/generic/009 b/tests/generic/009
index 797def5c..727d4b60 100755
--- a/tests/generic/009
+++ b/tests/generic/009
@@ -56,12 +56,12 @@ if [ "$FSTYP" = "ext4" ]; then
 	_ext4_disable_extent_zeroout
 fi
 
-# When PAGE_SIZE > 4096 xfs extent layout is different so it would not match
-# the output.
-if [ "$FSTYP" = "xfs" ]; then
+# When PAGE_SIZE > 4096 some filesystems extent layout is different so
+# it would not match the output.
+if [ "$FSTYP" = "xfs" -o "$FSTYP" = "btrfs" ]; then
 	PAGE_SIZE=`getconf PAGE_SIZE`
 	if [ $PAGE_SIZE -gt 4096 ]; then
-		_notrun "Not supported on xfs with page size > 4096"
+		_notrun "Not supported on xfs or btrfs with page size > 4096"
 	fi
 fi
 
-- 
2.15.1

