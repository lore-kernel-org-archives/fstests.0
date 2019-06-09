Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39486 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727697AbfFIVEn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Jun 2019 17:04:43 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH RESEND] report: gracefully handle XML report creation when no tests are run
Date: Sun,  9 Jun 2019 17:04:31 -0400
Message-Id: <20190609210431.26373-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

I sent this a while back, and didn't get any comments, so I'm resending.  PTAL.

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
2.22.0
