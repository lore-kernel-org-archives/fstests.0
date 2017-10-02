Received: from imap.thunk.org ([74.207.234.97]:51342 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750943AbdJBDjm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 1 Oct 2017 23:39:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] report: fix summary statistics in xUnit header
Date: Sun,  1 Oct 2017 23:39:32 -0400
Message-Id: <20171002033932.12419-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

The xUnit XML DTD distinguishes between test failures and test errors,
where a test failure indicate that the test has explicitly indicated
that the code under test has behaved in an unexpected fashion, whereas
a test error indicates the test code itself has thrown an error or
there has been some other test implementation error.

Xfstest failures are correctly marked as xUnit failures, but in the
attributes of the testsuite XML element, the number of test failures
was incorrectly reported as the number of errors.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
---
 common/report | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/report b/common/report
index bb689836..058c0bba 100644
--- a/common/report
+++ b/common/report
@@ -59,7 +59,7 @@ _xunit_make_section_report()
 	# Header
 	echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $REPORT_DIR/result.xml
 	local dtime=`echo $date_time| tr  " " 'T'`
-	local stats="errors=\"$n_bad\" skipped=\"$n_notrun\" tests=\"$n_total\" time=\"$sect_time\""
+	local stats="failures=\"$n_bad\" skipped=\"$n_notrun\" tests=\"$n_total\" time=\"$sect_time\""
 	local hw_info="hostname=\"$HOST\" timestamp=\"$dtime\" "
 	echo "<testsuite name=\"xfstests\" $stats  $hw_info >" >> $REPORT_DIR/result.xml
 
-- 
2.11.0.rc0.7.gbe5a750

