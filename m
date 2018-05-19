Received: from imap.thunk.org ([74.207.234.97]:55136 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752451AbeESRnQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 19 May 2018 13:43:16 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] report: make sure control charcters are encoded in xUnit report
Date: Sat, 19 May 2018 13:43:10 -0400
Message-Id: <20180519174310.3511-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Control characters (such as backspace, used in progress reports by
mkfs.ext4, for example) can make Python's XML parsers choke, claiming
that it is an invalid XML document.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/report | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/common/report b/common/report
index ffa23719..a62d343e 100644
--- a/common/report
+++ b/common/report
@@ -27,11 +27,12 @@ REPORT_ENV_LIST="$REPORT_ENV_LIST OVL_WORK"
 
 encode_xml()
 {
-    sed -e 's/&/\&amp;/g' \
-	-e 's/>/\&gt;/g' \
-	-e 's/</\&lt;/g' \
-	-e "s/'/\&apos;/g" \
-	-e 's/"/\&quot;/g'
+	cat -v | \
+	    sed -e 's/&/\&amp;/g' \
+		-e 's/>/\&gt;/g' \
+		-e 's/</\&lt;/g' \
+		-e "s/'/\&apos;/g" \
+		-e 's/"/\&quot;/g'
 }
 
 #
-- 
2.16.1.72.g5be1f00a9a

