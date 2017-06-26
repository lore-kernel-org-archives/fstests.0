Received: from mx2.suse.de ([195.135.220.15]:41879 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751653AbdFZNkr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Jun 2017 09:40:47 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F9FDAAF2
        for <fstests@vger.kernel.org>; Mon, 26 Jun 2017 13:40:46 +0000 (UTC)
From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH 1/2] README: remove incorrect check -udf usage
Date: Mon, 26 Jun 2017 15:40:16 +0200
Message-Id: <20170626134017.2741-1-ddiss@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
List-ID: <fstests@vger.kernel.org>

The -udf parameter for check does not exist. UDF can still be tested via
the configuration parameter FSTYP=udf.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 README | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/README b/README
index fd491e4a..11bf6a94 100644
--- a/README
+++ b/README
@@ -120,12 +120,10 @@ Running tests:
     - Groups of tests maybe ran by: ./check -g [group(s)]
       See the 'group' file for details on groups
     - To randomize test order: ./check -r [test(s)]
-    - You can explicitly specify NFS/CIFS/UDF/OVERLAY, otherwise
+    - You can explicitly specify NFS/CIFS/OVERLAY, otherwise
       the filesystem type will be autodetected from $TEST_DEV:
         - for running nfs tests: ./check -nfs [test(s)]
         - for running cifs/smb3 tests: ./check -cifs [test(s)]
-        - for udf tests: ./check -udf [test(s)]
-          Running all the udf tests: ./check -udf -g udf
         - for overlay tests: ./check -overlay [test(s)]
           The TEST and SCRATCH partitions should be pre-formatted
           with another base fs, where the overlay dirs will be created
-- 
2.12.3

