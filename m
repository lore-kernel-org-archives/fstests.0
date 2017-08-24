Received: from mx2.suse.de ([195.135.220.15]:42950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751083AbdHXNRY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 24 Aug 2017 09:17:24 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA08AAB22
        for <fstests@vger.kernel.org>; Thu, 24 Aug 2017 13:17:22 +0000 (UTC)
From: David Sterba <dsterba@suse.com>
Subject: [PATCH] check: print elapsed time even for failed tests
Date: Thu, 24 Aug 2017 15:15:57 +0200
Message-Id: <20170824131557.32342-1-dsterba@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
List-ID: <fstests@vger.kernel.org>

Sometimes it's useful to see how long the test runs.  The time is
calculated the same way as in the normal case but the time is not stored
in the $tmp.time file.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index f8db3cd6dfab..f3a1b72e4b2b 100755
--- a/check
+++ b/check
@@ -755,7 +755,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			    fi
 			    echo ""
 			else
-			    echo " - output mismatch (see $seqres.out.bad)"
+			    echo " `expr $stop - $start`s - output mismatch (see $seqres.out.bad)"
 			    mv $tmp.out $seqres.out.bad
 			    $diff $seq.out $seqres.out.bad | {
 				if test "$DIFF_LENGTH" -le 0; then
-- 
2.14.0

