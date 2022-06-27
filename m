Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5705C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Jun 2022 22:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242574AbiF0WX3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Jun 2022 18:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241392AbiF0WX0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Jun 2022 18:23:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5018111A29
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 15:23:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E88A021D51;
        Mon, 27 Jun 2022 22:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656368598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBj1hFkJ/ZPr0qXvVacP4cMzok9nzGgUB+EYsiMreMI=;
        b=TIXvN872y3psfo2/lG+bdLF4Yjio7rbDdldFlv5cLdt7pAS733vCgu7M3GOGWTFHf4YDgx
        U9H9/Oyhgx2Il8j1aELbk/2IMK72wpv69yh/hR1V0KSOaBd5SjChV8sHvj/7piCKJUXB1S
        0TCsLhUuc6TFHg/frfLJ83d6QTEg+EE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656368598;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBj1hFkJ/ZPr0qXvVacP4cMzok9nzGgUB+EYsiMreMI=;
        b=QyfNGf5fWkH8AEkMPaZq36hV880xoM4g6icGQ7e19pOt5mrtUgypBiDy5F5fCfzev8XnBt
        e+Bup23J4zQMQECw==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C86C42C142;
        Mon, 27 Jun 2022 22:23:18 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org, tytso@mit.edu
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH v2 5/6] check: add -L <n> parameter to rerun failed tests
Date:   Tue, 28 Jun 2022 00:22:55 +0200
Message-Id: <20220627222256.14175-6-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220627222256.14175-1-ddiss@suse.de>
References: <20220627222256.14175-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

If check is run with -L <n>, then a failed test will be rerun <n> times
before proceeding to the next test. Following completion of the rerun
loop, aggregate pass/fail statistics are printed.

Rerun tests will be tracked as a single failure in overall pass/fail
metrics (via @try and @bad), with .out.bad, .dmesg and .full saved using
a .rerun# suffix.

Suggested-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lwn.net/Articles/897061/
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 check         | 94 ++++++++++++++++++++++++++++++++++++++++++++-------
 common/report |  8 +++--
 2 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/check b/check
index aa7dac2f..726c83d9 100755
--- a/check
+++ b/check
@@ -26,6 +26,7 @@ do_report=false
 DUMP_OUTPUT=false
 iterations=1
 istop=false
+loop_on_fail=0
 
 # This is a global variable used to pass test failure text to reporting gunk
 _err_msg=""
@@ -75,6 +76,7 @@ check options
     --large-fs		optimise scratch device for large filesystems
     -s section		run only specified section from config file
     -S section		exclude the specified section from the config file
+    -L <n>		loop tests <n> times following a failure, measuring aggregate pass/fail metrics
 
 testlist options
     -g group[,group...]	include tests from these groups
@@ -333,6 +335,9 @@ while [ $# -gt 0 ]; do
 		;;
 	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
 	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
+	-L)	[[ $2 =~ ^[0-9]+$ ]] || usage
+		loop_on_fail=$2; shift
+		;;
 
 	-*)	usage ;;
 	*)	# not an argument, we've got tests now.
@@ -555,6 +560,18 @@ _expunge_test()
 _stash_test_status() {
 	local test_seq="$1"
 	local test_status="$2"
+	local test_time="$3"
+	local loop_num="$4"
+	local report_msg="$5"
+
+	if $do_report && [[ ! $test_status =~ ^(init|expunge)$ ]]; then
+		_make_testcase_report "$section" "$test_seq" \
+				      "$test_status" "$test_time" \
+				      "$report_msg"
+	fi
+
+	# only stash result for first failure (triggering loop)
+	((loop_num > 1)) && return
 
 	case "$test_status" in
 	fail)
@@ -610,6 +627,38 @@ _run_seq() {
 	fi
 }
 
+# Check whether the last test should be rerun according to loop-on-error state
+# and return "0" if so, otherwise return "1".
+_ix_inc() {
+	local test_status="$1"
+	local loop_len="$2"
+
+	if ((!loop_on_fail)); then
+		echo 1
+		return
+	fi
+
+	if [ "$test_status" == "fail" ] && ((!loop_len)); then
+		echo 0	# initial failure of this test, start loop-on-fail
+	elif ((loop_len > 0)) && ((loop_len < loop_on_fail)); then
+		echo 0	# continue loop following initial failure
+	else
+		echo 1	# completed or not currently in a failure loop
+	fi
+}
+
+_failure_loop_dump_stats() {
+	awk "BEGIN {
+		n=split(\"$*\", arr);"'
+		for (i = 1; i <= n; i++)
+			stats[arr[i]]++;
+		printf("aggregate results across %d runs: ", n);
+		for (x in stats)
+			printf("%s=%d (%.1f%%)", (i-- > n ? x : ", " x),
+			       stats[x], 100 * stats[x] / n);
+	     }'
+}
+
 _detect_kmemleak
 _prepare_test_list
 
@@ -750,14 +799,29 @@ function run_section()
 	seqres="$check"
 	_check_test_fs
 
-	local tc_status="init"
+	local tc_status="init" ix agg_msg
 	prev_seq=""
-	for seq in $list ; do
+	local -a _list=( $list ) loop_status=()
+	for ((ix = 0; ix < ${#_list[*]};
+	      ix += $(_ix_inc "$tc_status" "${#loop_status[*]}"))); do
+		seq="${_list[$ix]}"
+
+		if [ "$seq" == "$prev_seq" ]; then
+			loop_status+=("$tc_status")
+		elif ((${#loop_status[*]})); then
+			# leaving rerun-on-failure loop
+			loop_status+=("$tc_status")
+			agg_msg=$(_failure_loop_dump_stats "${loop_status[@]}")
+			echo "$seqnum $agg_msg"
+		fi
+
 		# Run report for previous test!
-		_stash_test_status "$seqnum" "$tc_status"
-		if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
-			_make_testcase_report "$section" "$seqnum" \
-					      "$tc_status" "$((stop - start))"
+		_stash_test_status "$seqnum" "$tc_status" "$((stop - start))" \
+				   "${#loop_status[*]}" "$agg_msg"
+
+		if [ -n "$agg_msg" ]; then
+			loop_status=()
+			agg_msg=""
 		fi
 
 		prev_seq="$seq"
@@ -827,7 +891,9 @@ function run_section()
 		fi
 
 		# record that we really tried to run this test.
-		try+=("$seqnum")
+		if ((!${#loop_status[*]})); then
+			try+=("$seqnum")
+		fi
 
 		awk 'BEGIN {lasttime="       "} \
 		     $1 == "'$seqnum'" {lasttime=" " $2 "s ... "; exit} \
@@ -954,13 +1020,17 @@ function run_section()
 		fi
 	done
 
-	# make sure we record the status of the last test we ran.
-	_stash_test_status "$seqnum" "$tc_status"
-	if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
-		_make_testcase_report "$section" "$seqnum" "$tc_status" \
-				      "$((stop - start))"
+	if ((${#loop_status[*]})); then
+		# leaving rerun-on-failure loop
+		loop_status+=("$tc_status")
+		agg_msg=$(_failure_loop_dump_stats "${loop_status[@]}")
+		echo "$seqnum $agg_msg"
 	fi
 
+	# Run report for previous test!
+	_stash_test_status "$seqnum" "$tc_status" "$((stop - start))" \
+			   "${#loop_status[*]}" "$agg_msg"
+
 	sect_stop=`_wallclock`
 	interrupt=false
 	_wrapup
diff --git a/common/report b/common/report
index 5ca41bc4..cede4987 100644
--- a/common/report
+++ b/common/report
@@ -71,6 +71,7 @@ _xunit_make_testcase_report()
 	local test_name="$2"
 	local test_status="$3"
 	local test_time="$4"
+	local test_md="$5"
 
 	# TODO: other places may also win if no-section mode will be named like 'default/global'
 	if [ $sect_name == '-no-sections-' ]; then
@@ -79,7 +80,8 @@ _xunit_make_testcase_report()
 	fi
 	local report=$tmp.report.xunit.$sect_name.xml
 
-	echo -e "\t<testcase classname=\"xfstests.$sect_name\" name=\"$test_name\" time=\"$test_time\">" >> $report
+	[ -n "$test_md" ] && test_md=" status=\"$(echo "$test_md"|encode_xml)\""
+	echo -e "\t<testcase classname=\"xfstests.$sect_name\" name=\"$test_name\" time=\"$test_time\"${test_md}>" >> $report
 	case $test_status in
 	"pass")
 		;;
@@ -162,11 +164,13 @@ _make_testcase_report()
 	local test_seq="$2"
 	local test_status="$3"
 	local test_time="$4"
+	local test_md="$5"
 	for report in $REPORT_LIST; do
 		case "$report" in
 		"xunit")
 			_xunit_make_testcase_report "$sect_name" "$test_seq" \
-						    "$test_status" "$test_time"
+						    "$test_status" \
+						    "$test_time" "$test_md"
 			;;
 		*)
 			_dump_err "report format '$report' is not supported"
-- 
2.35.3

