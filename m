Received: from imap.thunk.org ([74.207.234.97]:47604 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752592AbdI3Dq2 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 29 Sep 2017 23:46:28 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] report: encode XML Character Entities in xUnit report
Date: Fri, 29 Sep 2017 23:46:21 -0400
Message-Id: <20170930034621.3036-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

Since the xUnit report is an XML document, special XML characters such
as '<', '>', '&', etc. have to be encoded as "&lt;", "&gt;", etc.
Otherwise programs parsing something like this:

	<testcase classname="xfstests.global" name="generic/450" time="0">
		<skipped message="Only test on sector size < half of block size" />
	</testcase>

Will get choke the unescaped '<' character in the skipped message.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
---
 common/report | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/common/report b/common/report
index 15a63db8..bb689836 100644
--- a/common/report
+++ b/common/report
@@ -25,6 +25,15 @@ REPORT_ENV_LIST="$REPORT_ENV_LIST OVL_UPPER"
 REPORT_ENV_LIST="$REPORT_ENV_LIST OVL_LOWER"
 REPORT_ENV_LIST="$REPORT_ENV_LIST OVL_WORK"
 
+encode_xml()
+{
+    sed -e 's/&/\&amp;/g' \
+	-e 's/>/\&gt;/g' \
+	-e 's/</\&lt;/g' \
+	-e "s/'/\&apos;/g" \
+	-e 's/"/\&quot;/g'
+}
+
 #
 # Xunit format report functions
 _xunit_add_property()
@@ -86,7 +95,7 @@ _xunit_make_testcase_report()
 		;;
 	"notrun")
 		if [ -f $seqres.notrun ]; then
-			local msg=`cat $seqres.notrun`
+			local msg=`cat $seqres.notrun | encode_xml`
 			echo -e "\t\t<skipped message=\"$msg\" />" >> $report
 		else
 			echo -e "\t\t<skipped/>" >> $report
@@ -103,20 +112,20 @@ _xunit_make_testcase_report()
 		if [ -s $seqres.full ]; then
 			echo -e "\t\t<system-out>" >> $report
 			printf	'<![CDATA[\n' >>$report
-			cat $seqres.full | tr -dc '[:print:][:space:]' >>$report
+			cat $seqres.full | tr -dc '[:print:][:space:]' | encode_xml >>$report
 			printf ']]>\n'	>>$report
 			echo -e "\t\t</system-out>" >> $report
 		fi
 		if [ -f $seqres.dmesg ]; then
 			echo -e "\t\t<system-err>" >> $report
 			printf	'<![CDATA[\n' >>$report
-			cat $seqres.dmesg | tr -dc '[:print:][:space:]' >>$report
+			cat $seqres.dmesg | tr -dc '[:print:][:space:]' | encode_xml >>$report
 			printf ']]>\n'	>>$report
 			echo -e "\t\t</system-err>" >> $report
 		elif [ -s $seqres.out.bad ]; then
 			echo -e "\t\t<system-err>" >> $report
 			printf	'<![CDATA[\n' >>$report
-			$diff $seq.out $seqres.out.bad >>$report
+			$diff $seq.out $seqres.out.bad | encode_xml >>$report
 			printf ']]>\n'	>>$report
 			echo -e "\t\t</system-err>" >> $report
 		fi
-- 
2.11.0.rc0.7.gbe5a750

