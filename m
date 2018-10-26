Received: from imap.thunk.org ([74.207.234.97]:60338 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbeJZUam (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 26 Oct 2018 16:30:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] generic: update group file to indicate generic/456 uses {collapse,zero}_range
Date: Fri, 26 Oct 2018 07:53:49 -0400
Message-Id: <20181026115349.4241-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/group b/tests/generic/group
index 28452732..8a21970e 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -458,7 +458,7 @@
 453 auto quick dir
 454 auto quick attr
 455 auto log replay
-456 auto quick metadata
+456 auto quick metadata collapse zero
 457 auto log replay clone
 458 auto quick clone collapse zero
 459 auto thin
-- 
2.18.0.rc0
