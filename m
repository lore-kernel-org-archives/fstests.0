Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAAEC43334
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Jul 2022 11:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiGFLXj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 Jul 2022 07:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbiGFLXc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Jul 2022 07:23:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284C01570A
        for <fstests@vger.kernel.org>; Wed,  6 Jul 2022 04:23:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C53B31FD51;
        Wed,  6 Jul 2022 11:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657106608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMqChZaE6/7jkdCdOmPysyseqK04lpb5vwnq+37Wy6I=;
        b=VkU8osncoW7yWhxvwXxjRz6UonmyH+xx94/jJPS3+Zd7kivOi/Msrn8hol8rSi3tKCwaH/
        b66Wchlum9SzQ7gpQ3hO6TlpfH04Xx67fdAkVzX6M18Pr6sPc84ovZ9dYhizsjcMqIbhHU
        nqQg7riub5PSDx0xQGC85Ova6K87JUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657106608;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMqChZaE6/7jkdCdOmPysyseqK04lpb5vwnq+37Wy6I=;
        b=5PIjNNhZR4hbuOEHlresaQHEaCYT/mPCk3zXnFOYRtWSY+EKblIgifGXuAasry3cmnN1VH
        jeVgQOpDjWLB4qCw==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A00EF2C142;
        Wed,  6 Jul 2022 11:23:28 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org, tytso@mit.edu
Cc:     David Disseldorp <ddiss@suse.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 2/5] report: pass through most details as function parameters
Date:   Wed,  6 Jul 2022 13:23:09 +0200
Message-Id: <20220706112312.4349-3-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220706112312.4349-1-ddiss@suse.de>
References: <20220706112312.4349-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Report generation currently involves reaching into a whole bunch of
globals for things like section name and start/end times. Pass these
through as explicit function parameters to avoid unintentional breakage.

One minor fix included is the default xunit error message, which used
$sequm instead of $seqnum.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 check         | 14 +++++++----
 common/report | 64 +++++++++++++++++++++++++++++----------------------
 2 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/check b/check
index 4b0ebad6..dbad6dde 100755
--- a/check
+++ b/check
@@ -432,7 +432,9 @@ _wrapup()
 	if $showme && $needwrap; then
 		if $do_report; then
 			# $showme = all selected tests are notrun (no tries)
-			_make_section_report "${#notrun[*]}" "0" "${#notrun[*]}"
+			_make_section_report "$section" "${#notrun[*]}" "0" \
+					     "${#notrun[*]}" \
+					     "$((sect_stop - sect_start))"
 		fi
 		needwrap=false
 	elif $needwrap; then
@@ -493,7 +495,9 @@ _wrapup()
 		fi
 		echo "" >>$tmp.summary
 		if $do_report; then
-			_make_section_report "${#try[*]}" "${#bad[*]}" "${#notrun[*]}"
+			_make_section_report "$section" "${#try[*]}" \
+					     "${#bad[*]}" "${#notrun[*]}" \
+					     "$((sect_stop - sect_start))"
 		fi
 		needwrap=false
 	fi
@@ -736,7 +740,8 @@ function run_section()
 			bad+=("$seqnum")
 		fi
 		if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
-			_make_testcase_report "$prev_seq" "$tc_status"
+			_make_testcase_report "$section" "$seqnum" \
+					      "$tc_status" "$((stop - start))"
 		fi
 
 		prev_seq="$seq"
@@ -940,7 +945,8 @@ function run_section()
 		bad+=("$seqnum")
 	fi
 	if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
-		_make_testcase_report "$prev_seq" "$tc_status"
+		_make_testcase_report "$section" "$seqnum" "$tc_status" \
+				      "$((stop - start))"
 	fi
 
 	sect_stop=`_wallclock`
diff --git a/common/report b/common/report
index 2b8285d8..5ca41bc4 100644
--- a/common/report
+++ b/common/report
@@ -33,11 +33,11 @@ _xunit_add_property()
 _xunit_make_section_report()
 {
 	# xfstest:section ==> xunit:testsuite
-	local tests_count="$1"
-	local bad_count="$2"
-	local notrun_count="$3"
-	local sect_name=$section
-	local sect_time=`expr $sect_stop - $sect_start`
+	local sect_name="$1"
+	local tests_count="$2"
+	local bad_count="$3"
+	local notrun_count="$4"
+	local sect_time="$5"
 
 	if [ $sect_name == '-no-sections-' ]; then
 		sect_name='global'
@@ -67,12 +67,10 @@ _xunit_make_section_report()
 
 _xunit_make_testcase_report()
 {
-	local test_seq="$1"
-	local test_status="$2"
-	local test_time=`expr $stop - $start`
-	local strip="$SRC_DIR/"
-	local test_name=${test_seq#$strip}
-	local sect_name=$section
+	local sect_name="$1"
+	local test_name="$2"
+	local test_status="$3"
+	local test_time="$4"
 
 	# TODO: other places may also win if no-section mode will be named like 'default/global'
 	if [ $sect_name == '-no-sections-' ]; then
@@ -86,8 +84,9 @@ _xunit_make_testcase_report()
 	"pass")
 		;;
 	"notrun")
-		if [ -f $seqres.notrun ]; then
-			local msg=`cat $seqres.notrun | encode_xml`
+		local notrun_file="${REPORT_DIR}/${test_name}.notrun"
+		if [ -f "$notrun_file" ]; then
+			local msg=`cat "$notrun_file" | encode_xml`
 			echo -e "\t\t<skipped message=\"$msg\" />" >> $report
 		else
 			echo -e "\t\t<skipped/>" >> $report
@@ -97,27 +96,31 @@ _xunit_make_testcase_report()
 		echo -e "\t\t<skipped/>" >> $report
 		;;
 	"fail")
+		local out_src="${SRC_DIR}/${test_name}.out"
+		local full_file="${REPORT_DIR}/${test_name}.full"
+		local dmesg_file="${REPORT_DIR}/${test_name}.dmesg"
+		local outbad_file="${REPORT_DIR}/${test_name}.out.bad"
 		if [ -z "$_err_msg" ]; then
-			_err_msg="Test $sequm failed, reason unknown"
+			_err_msg="Test $test_name failed, reason unknown"
 		fi
 		echo -e "\t\t<failure message=\"$_err_msg\" type=\"TestFail\" />" >> $report
-		if [ -s $seqres.full ]; then
+		if [ -s "$full_file" ]; then
 			echo -e "\t\t<system-out>" >> $report
 			printf	'<![CDATA[\n' >>$report
-			cat $seqres.full | tr -dc '[:print:][:space:]' | encode_xml >>$report
+			cat "$full_file" | tr -dc '[:print:][:space:]' | encode_xml >>$report
 			printf ']]>\n'	>>$report
 			echo -e "\t\t</system-out>" >> $report
 		fi
-		if [ -f $seqres.dmesg ]; then
+		if [ -f "$dmesg_file" ]; then
 			echo -e "\t\t<system-err>" >> $report
 			printf	'<![CDATA[\n' >>$report
-			cat $seqres.dmesg | tr -dc '[:print:][:space:]' | encode_xml >>$report
+			cat "$dmesg_file" | tr -dc '[:print:][:space:]' | encode_xml >>$report
 			printf ']]>\n'	>>$report
 			echo -e "\t\t</system-err>" >> $report
-		elif [ -s $seqres.out.bad ]; then
+		elif [ -s "$outbad_file" ]; then
 			echo -e "\t\t<system-err>" >> $report
 			printf	'<![CDATA[\n' >>$report
-			$diff $test_seq.out $seqres.out.bad | encode_xml >>$report
+			$diff "$out_src" "$outbad_file" | encode_xml >>$report
 			printf ']]>\n'	>>$report
 			echo -e "\t\t</system-err>" >> $report
 		fi
@@ -134,13 +137,17 @@ _xunit_make_testcase_report()
 #  Common report generator entry points
 _make_section_report()
 {
-	local tests_count="$1"
-	local bad_count="$2"
-	local notrun_count="$3"
+	local sect_name="$1"
+	local tests_count="$2"
+	local bad_count="$3"
+	local notrun_count="$4"
+	local sect_time="$5"
 	for report in $REPORT_LIST; do
 		case "$report" in
 		"xunit")
-			_xunit_make_section_report "$tests_count" "$bad_count" "$notrun_count"
+			_xunit_make_section_report "$sect_name" "$tests_count" \
+						   "$bad_count" "$notrun_count" \
+						   "$sect_time"
 			;;
 		*)
 			_dump_err "format '$report' is not supported"
@@ -151,12 +158,15 @@ _make_section_report()
 
 _make_testcase_report()
 {
-	local test_seq="$1"
-	local test_status="$2"
+	local sect_name="$1"
+	local test_seq="$2"
+	local test_status="$3"
+	local test_time="$4"
 	for report in $REPORT_LIST; do
 		case "$report" in
 		"xunit")
-			_xunit_make_testcase_report "$test_seq" "$test_status"
+			_xunit_make_testcase_report "$sect_name" "$test_seq" \
+						    "$test_status" "$test_time"
 			;;
 		*)
 			_dump_err "report format '$report' is not supported"
-- 
2.35.3

