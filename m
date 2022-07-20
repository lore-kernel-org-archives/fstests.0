Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4989CCA482
	for <linux-fstests@archiver.kernel.org>; Wed, 20 Jul 2022 16:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiGTQoR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiGTQoH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2022 12:44:07 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6F566AE1
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 09:44:06 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26KGi1sA023369
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 12:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658335442; bh=YGUTV65UfHjpOyg+ZFMAj1kz+xJRBw2bMpjFRnZYBmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FVISuY2Oxm61lVG0jQzUHAzVlhmRMbHY9ZaXag0dp//86509a2AyhMfDKHXRXUjFy
         +a96nMCHC5Gg6eVEs+pRlKV8tKLdiamy8H4gZ9LE1UX2ERYz8v6lUYQWTs4N3qqPEw
         NI21NGgIP8arqsv5r5fruQtYYaRD/EDzXdlVnRt+sd5UP/n31lin27I6lPx90Uw5MN
         OYxLUKyYeqmhDmv9HehkeYrG+vKSZLMB3YSFIgy/VenjW59stiNOua7ZrIcZijy39d
         RuMk1GsCUcc3qwwrsQKeXcmABcoiMrg5GUuo2baOqjEBHDnhpllEnPC6Zk7kuyCyH3
         eKq/g24mP/cdw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 079E615C3EC1; Wed, 20 Jul 2022 12:44:01 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, David Disseldorp <ddiss@suse.de>
Subject: [PATCH 1/4] report: add support for the xunit-quiet format
Date:   Wed, 20 Jul 2022 12:43:53 -0400
Message-Id: <20220720164356.4078789-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220720164356.4078789-1-tytso@mit.edu>
References: <20220720164356.4078789-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The xunit-quiet format excludes the NNN.{full,dmesg,bad} files in
<system-out> and <system-err> nodes which are included in the xunit
report format.

For test runners that save the entire results directory to preserve
all of the test artifacts, capturing the NNN.{full,dmesg,bad} in the
results.xml file is redundant.  In addition, if the NNN.bad is too
large, it can cause the junitparser python library to refuse to parse
the XML file to prevent potential denial of service attacks[1].  A
simple way to avoid this problem is to simply to omit the <system-out>
and <system-err> nodes in the results.xml file.

[1] https://gitlab.com/gitlab-org/gitlab/-/issues/268035

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: David Disseldorp <ddiss@suse.de>
---
 check         |  2 +-
 common/report | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/check b/check
index 5f6d86b4..0b2f10ed 100755
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
index 5ca41bc4..64f9c866 100644
--- a/common/report
+++ b/common/report
@@ -71,11 +71,16 @@ _xunit_make_testcase_report()
 	local test_name="$2"
 	local test_status="$3"
 	local test_time="$4"
+	local report_format="$5"
+	local quiet
+
+	if [ "$report_format" = xunit-quiet ]; then
+		quiet=yes
+	fi
 
 	# TODO: other places may also win if no-section mode will be named like 'default/global'
 	if [ $sect_name == '-no-sections-' ]; then
 		sect_name='global'
-
 	fi
 	local report=$tmp.report.xunit.$sect_name.xml
 
@@ -104,14 +109,16 @@ _xunit_make_testcase_report()
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
@@ -144,7 +151,7 @@ _make_section_report()
 	local sect_time="$5"
 	for report in $REPORT_LIST; do
 		case "$report" in
-		"xunit")
+		"xunit"|"xunit-quiet")
 			_xunit_make_section_report "$sect_name" "$tests_count" \
 						   "$bad_count" "$notrun_count" \
 						   "$sect_time"
@@ -164,9 +171,9 @@ _make_testcase_report()
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
@@ -178,7 +185,7 @@ _make_testcase_report()
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

