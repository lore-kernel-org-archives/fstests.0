Received: from mx2.suse.de ([195.135.220.15]:51825 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754397AbdFNHT1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 14 Jun 2017 03:19:27 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2697AC39
        for <fstests@vger.kernel.org>; Wed, 14 Jun 2017 07:19:25 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] generic/360: Create symlink with valid path
Date: Wed, 14 Jun 2017 09:19:20 +0200
Message-Id: <20170614071921.6741-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

A test is creating symlink with a path containing name 1023 characters
long. Such file name is invalid for most filesystems (the limit on file
name lenght is mostly 255 characters) and UDF actually complains about
this and so the test fails. Since the point of this test is to verify
storage of the symlink, change the test to use a valid path where each
component name has only 254 characters.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/360     | 4 +++-
 tests/generic/360.out | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/generic/360 b/tests/generic/360
index 86e554bb5fec..cc5623f552e0 100755
--- a/tests/generic/360
+++ b/tests/generic/360
@@ -50,9 +50,11 @@ _require_test
 linkfile=$TEST_DIR/$seq.symlink
 rm -f $linkfile
 
+FNAME=$(perl -e 'print "a"x254')
+
 # Create a symlink points to a very long path, so that the path could not be
 # hold in inode
-ln -s `perl -e 'print "a"x1023'` $linkfile
+ln -s $FNAME/$FNAME/$FNAME/$FNAME $linkfile
 
 # Check symlink contains the correct path.
 # 1023 chars are a bit long for golden image output, compute the md5 checksum
diff --git a/tests/generic/360.out b/tests/generic/360.out
index 1f0459bbcb5d..a076d99bb091 100644
--- a/tests/generic/360.out
+++ b/tests/generic/360.out
@@ -1,2 +1,2 @@
 QA output created by 360
-cd3b0a56bc304075e28a20a4edd57068  -
+36c1641ab5d82b582cd2baa1ace16277  -
-- 
2.12.3

