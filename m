Received: from imap.thunk.org ([74.207.234.97]:41588 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750808AbdBCQZn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 3 Feb 2017 11:25:43 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] generic: update errors to be returned when doing cross renames w/o keys
Date: Fri,  3 Feb 2017 11:25:37 -0500
Message-Id: <20170203162537.872-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Eric Biggers <ebiggers3@gmail.com>
List-ID: <fstests@vger.kernel.org>

The bug fix that ultimately landed in the fscrypt tree will return
ENOKEY instead of EPERM when doing a cross rename involving a
directory where the key is not available.  So fix up the golden output
for generic/398 accordingly.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Eric Biggers <ebiggers3@gmail.com>
---
 tests/generic/398.out | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/398.out b/tests/generic/398.out
index f9274878..8e08270d 100644
--- a/tests/generic/398.out
+++ b/tests/generic/398.out
@@ -39,7 +39,7 @@ Operation not permitted
 
 
 *** Exchange encrypted <=> encrypted without key ***
-Operation not permitted
+Required key not available
 
 *** Exchange encrypted <=> unencrypted without key ***
-Operation not permitted
+Required key not available
-- 
2.11.0.rc0.7.gbe5a750

