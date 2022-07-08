Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34A2C43334
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Jul 2022 22:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbiGHWcb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Jul 2022 18:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240030AbiGHWc2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Jul 2022 18:32:28 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBEB13B458
        for <fstests@vger.kernel.org>; Fri,  8 Jul 2022 15:32:27 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 268MWNpr020157
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Jul 2022 18:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657319544; bh=7gqdWGLg0SQgErngxKl7ZJvTW28R8aWXqyX4rPSeDw8=;
        h=From:To:Cc:Subject:Date;
        b=SjSH84HBQEzsmoswoChabirtV+z6NcwzD6eEZSJeWXuC3fF64D5/WwoaUDAnT0kZS
         XxopzsrNsC2kITQZPHguIeOzlTbYNtrrbXR9jFrIWAfniF6/7f4F7ZiyQ91m/OKWmK
         g6mMcm0YeTdDZ3rgWc/aIiN0FuVWNXdLI1JfxRVgjl0NlObkJHoh8P8vjkZJx2Zdck
         mPd/HJJUeDNcV9Hmzw0yYEl1/w9ysLfkBuhyFrCUo8sPhi1/bLjwmdCd8tOcPtfSZz
         RueC9hcFzEVU7H0Yy9K+wd7+rwBpZe9qh11gh0UBA8lNt6Z3y2vBx4vi6UiCIxu95E
         aSn2ur63lAOXg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4EBD115C4331; Fri,  8 Jul 2022 18:32:23 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] report: add support for the xunit-quiet format
Date:   Fri,  8 Jul 2022 18:32:19 -0400
Message-Id: <20220708223219.1872812-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The xunit-quiet format exludes the NNN.{full,dmesg,bad} files in
<system-out> and <system-err> nodes.

For test runners that save the enttire results directory to preserve
all of the test artifacts, capturing the NNN.{full,dmesg,bad} in the
results.xml file is redundant.  In addition, if the NNN.bad is too
large, it can cause the junitparser python library to refuse to parse
the XML file to prevent potential denial of service attacks[1].  A
simple way to avoid this problem is to simply to have xfstests to omit
the <system-out> and <system-err> nodes.

[1] https://gitlab.com/gitlab-org/gitlab/-/issues/268035

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

Note: this patch depends on David Disseldorp's "add option to rerun
failed tests"  series.

 check         |  2 +-
 common/report | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/check b/check
index 27ebb0c2..d4d436c0 100755
--- a/check
+++ b/check
@@ -75,7 +75,7 @@ check options
     -I <n>		iterate the test list <n> times, but stops iterating further in case of any test failure
     -d			dump test output to stdout
     -b			brief test summary
-    -R fmt[,fmt]	generate report in formats specified. Supported format: [xunit]
+    -R fmt[,fmt]	generate report in formats specified. Supported formats: xunit, xunit-quiet
     --large-fs		optimise scratch device for large filesystems
     -s section		run only specified section from config file
     -S section		exclude the specified section from the config file
diff --git a/common/report b/common/report
index 5ca41bc4..cdf36b3e 100644
--- a/common/report
+++ b/common/report
@@ -71,6 +71,12 @@ _xunit_make_testcase_report()
 	local test_name="$2"
 	local test_status="$3"
 	local test_time="$4"
+	local report_format="$5"
+	local quiet
+
+	if [ "$report_format" = xunit-quiet ]; then
+	    quiet=yes
+	fi
 
 	# TODO: other places may also win if no-section mode will be named like 'default/global'
 	if [ $sect_name == '-no-sections-' ]; then
@@ -104,14 +110,16 @@ _xunit_make_testcase_report()
 			_err_msg="Test $test_name failed, reason unknown"
 		fi
 		echo -e "\t\t<failure message=\"$_err_msg\" type=\"TestFail\" />" >> $report
-		if [ -s "$full_file" ]; then
+		if [ -z "$quiet" -a -s "$full_file" ]; then
 			echo -e "\t\t<system-out>" >> $report
 			printf	'<![CDATA[\n' >>$report
 			cat "$full_file" | tr -dc '[:print:][:space:]' | encode_xml >>$report
 			printf ']]>\n'	>>$report
 			echo -e "\t\t</system-out>" >> $report
 		fi
-		if [ -f "$dmesg_file" ]; then
+		if [ -n "$quiet" ]; then
+		   :
+		elif [ -f "$dmesg_file" ]; then
 			echo -e "\t\t<system-err>" >> $report
 			printf	'<![CDATA[\n' >>$report
 			cat "$dmesg_file" | tr -dc '[:print:][:space:]' | encode_xml >>$report
@@ -144,7 +152,7 @@ _make_section_report()
 	local sect_time="$5"
 	for report in $REPORT_LIST; do
 		case "$report" in
-		"xunit")
+		"xunit"|"xunit-quiet")
 			_xunit_make_section_report "$sect_name" "$tests_count" \
 						   "$bad_count" "$notrun_count" \
 						   "$sect_time"
@@ -164,9 +172,9 @@ _make_testcase_report()
 	local test_time="$4"
 	for report in $REPORT_LIST; do
 		case "$report" in
-		"xunit")
+		"xunit"|"xunit-quiet")
 			_xunit_make_testcase_report "$sect_name" "$test_seq" \
-						    "$test_status" "$test_time"
+						    "$test_status" "$test_time" "$report"
 			;;
 		*)
 			_dump_err "report format '$report' is not supported"
@@ -178,7 +186,7 @@ _make_testcase_report()
 _assert_report_list() {
 	for report in $REPORT_LIST; do
 		case "$report" in
-		"xunit")
+		"xunit"|"xunit-quiet")
 			;;
 		*)
 			_fatal "report format '$report' is not supported"
-- 
2.31.0

