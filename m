Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7366 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753207AbcCYSfz (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 25 Mar 2016 14:35:55 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u2PIYZQv016201
	for <fstests@vger.kernel.org>; Fri, 25 Mar 2016 11:35:54 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0b-00082601.pphosted.com with ESMTP id 21vva6jwft-1
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NOT)
	for <fstests@vger.kernel.org>; Fri, 25 Mar 2016 11:35:54 -0700
From: Josef Bacik <jbacik@fb.com>
Subject: [PATCH] fstests: make results/check.log match everybody else
Date: Fri, 25 Mar 2016 14:35:50 -0400
Message-ID: <1458930950-22356-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

results/check.log is inconsistent with what goes to stdout and $tmp.summary.  It
passes the ran and failed tests through fmt but not the "Not Run" tests for some
reason, and nobody else passes it through fmt.  So fix this to be the same
output as what goes to stdout and $tmp.summary to make for easier post parsing.
Now we'll get

Ran: <single line with all the tests>
Not run: <single line with all the not run tests>
Failures: <single line with all the failed tests>

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 check | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/check b/check
index 2986d84..5be183f 100755
--- a/check
+++ b/check
@@ -342,17 +342,18 @@ END	{ if (NR > 0) {
 
 	echo "" >>$check.log
 	date >>$check.log
-	echo $list | fmt | sed -e 's/^/    /' -e "s;$SRC_DIR/;;g" >>$check.log
-	$interrupt && echo "Interrupted!" >>$check.log
 
 	echo "SECTION       -- $section" >>$tmp.summary
 	echo "=========================" >>$tmp.summary
         if [ ! -z "$n_try" -a $n_try != 0 ]
 	then
 	    echo "Ran:$try"
+	    echo "Ran:$try" >>$check.log
 	    echo "Ran:$try" >>$tmp.summary
 	fi
 
+	$interrupt && echo "Interrupted!" >>$check.log
+
 	if [ ! -z "$notrun" ]
 	then
 	    echo "Not run:$notrun"
@@ -364,7 +365,7 @@ END	{ if (NR > 0) {
 	then
 	    echo "Failures:$bad"
 	    echo "Failed $n_bad of $n_try tests"
-	    echo "Failures:$bad" | fmt >>$check.log
+	    echo "Failures:$bad" >>$check.log
 	    echo "Failed $n_bad of $n_try tests" >>$check.log
 	    echo "Failures:$bad" >>$tmp.summary
 	    echo "Failed $n_bad of $n_try tests" >>$tmp.summary
-- 
2.8.0.rc2

