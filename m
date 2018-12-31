Received: from mail-eopbgr740121.outbound.protection.outlook.com ([40.107.74.121]:6077
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbeLaDzR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 30 Dec 2018 22:55:17 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] report: gracefully handle XML report creation when no tests are run
Date: Sun, 30 Dec 2018 22:55:07 -0500
Message-ID: <20181231035507.10530-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

If no tests are run (because they have all been excluded) then make
sure we insert a valid timestamp into the XML file, and avoid printing
an error message when reading a non-existent test summary scratch
file.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/report | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/common/report b/common/report
index fb00b402..6cac71fc 100644
--- a/common/report
+++ b/common/report
@@ -59,6 +59,9 @@ _xunit_make_section_report()
 	local report=$tmp.report.xunit.$sect_name.xml
 	# Header
 	echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $REPORT_DIR/result.xml
+	if [ -z "$date_time" ]; then
+		date_time=$(date +"%F %T")
+	fi
 	local dtime=`echo $date_time| tr  " " 'T'`
 	local stats="failures=\"$n_bad\" skipped=\"$n_notrun\" tests=\"$n_total\" time=\"$sect_time\""
 	local hw_info="hostname=\"$HOST\" timestamp=\"$dtime\" "
@@ -70,7 +73,9 @@ _xunit_make_section_report()
 		_xunit_add_property "$p"
 	done
 	echo -e "\t</properties>" >> $REPORT_DIR/result.xml
-	cat $tmp.report.xunit.$sect_name.xml >> $REPORT_DIR/result.xml
+	if [ -f $report ]; then
+		cat $report >> $REPORT_DIR/result.xml
+	fi
 	echo "</testsuite>" >> $REPORT_DIR/result.xml
 	echo "Xunit report: $REPORT_DIR/result.xml"
 }
-- 
2.19.1
