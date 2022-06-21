Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F12CCA481
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Jun 2022 16:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353626AbiFUQDI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353628AbiFUQCp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2022 12:02:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A4F2DD77
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 09:02:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A37BC21C3A;
        Tue, 21 Jun 2022 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655827321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wm202VUpLwLstxBwUKzMir2O1PtmLNEyCooM1ghVLzI=;
        b=xF8ELxympDdNC5QFzNjhKfMF4IViosPG5NvGrHd5F7EXbCrreAiw7gyM+1FwMOPKFuiYkz
        KRrgRZxngGlVX4WHs8QML/tW6lNu0t6uD2t8RlZ2lGx+4DLnQITraYCHcWvve4P7nUaQp4
        JL/YWDbgmYwb6eXgZOvbvFRVEbRsqV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655827321;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wm202VUpLwLstxBwUKzMir2O1PtmLNEyCooM1ghVLzI=;
        b=7iQ3fRjrl4LViHYu4Uz8K2ThLTBe/SZFnPr67CSnzGfkNK4CKxb2w2/BkstFm6/xL1r0xw
        TYMVOX0utXv30yBQ==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 842022C142;
        Tue, 21 Jun 2022 16:02:01 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org, tytso@mit.edu
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH 2/2] check: add -L <n> parameter to rerun failed tests
Date:   Tue, 21 Jun 2022 18:01:53 +0200
Message-Id: <20220621160153.29591-3-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220621160153.29591-1-ddiss@suse.de>
References: <20220621160153.29591-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

If check is run with -L <n>, then a failed test will be rerun <n> times
before proceeding to the next test. Following completion of the rerun
loop, aggregate pass/fail statistics are printed.

Caveats:
- rerun tests will be tracked as a single failure in @try and @bad
  + xunit reports do not include any rerun details
- .bad files generated on failure will be overwritten by test reruns

Suggested-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lwn.net/Articles/897061/
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 check | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 11 deletions(-)

diff --git a/check b/check
index 3e8a232c..97fa50ad 100755
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
@@ -333,6 +335,7 @@ while [ $# -gt 0 ]; do
 		;;
 	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
 	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
+	-L)	loop_on_fail=$2; shift ;;
 
 	-*)	usage ;;
 	*)	# not an argument, we've got tests now.
@@ -606,6 +609,40 @@ _run_seq() {
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
+	local t="$1" && shift
+	awk "BEGIN {
+		n=split(\"$*\", arr);"'
+		for (i = 1; i <= n; i++)
+			stats[arr[i]]++;
+		printf("'"$t"' aggregate results across %d runs: ", n);
+		for (x in stats)
+			printf("%s=%d (%.1f%%)", (i-- > n ? x : ", " x),
+			       stats[x], 100 * stats[x] / n);
+		print;
+	     }'
+}
+
 _detect_kmemleak
 _prepare_test_list
 
@@ -746,13 +783,33 @@ function run_section()
 	seqres="$check"
 	_check_test_fs
 
-	local tc_status="init"
+	local tc_status="init" ix
 	prev_seq=""
-	for seq in $list ; do
-		# Run report for previous test!
-		_stash_test_status "$seqnum" "$tc_status"
-		if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
-			_make_testcase_report "$prev_seq" "$tc_status"
+	local -a _list=( $list ) loop_status=()
+	for ((ix = 0; ix < ${#_list[*]};
+	      ix += $(_ix_inc "$tc_status" "${#loop_status[*]}"))); do
+		seq="${_list[$ix]}"
+
+		if ((!loop_on_fail)); then
+			# Run report for previous test!
+			_stash_test_status "$seqnum" "$tc_status"
+			if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
+				_make_testcase_report "$prev_seq" "$tc_status"
+			fi
+		else
+			if [ "$seq" == "$prev_seq" ]; then
+				if ((!${#loop_status[*]})); then
+					_stash_test_status "$seqnum" "$tc_status"
+					if $do_report; then
+						_make_testcase_report "$prev_seq" "$tc_status"
+					fi
+				fi
+				loop_status+=("$tc_status")
+			elif ((${#loop_status[*]})); then
+				loop_status+=("$tc_status")
+				_failure_loop_dump_stats "$seqnum" "${loop_status[@]}"
+				loop_status=()
+			fi
 		fi
 
 		prev_seq="$seq"
@@ -822,7 +879,9 @@ function run_section()
 		fi
 
 		# record that we really tried to run this test.
-		try+=("$seqnum")
+		if ((!${#loop_status[*]})); then
+			try+=("$seqnum")
+		fi
 
 		awk 'BEGIN {lasttime="       "} \
 		     $1 == "'$seqnum'" {lasttime=" " $2 "s ... "; exit} \
@@ -949,10 +1008,15 @@ function run_section()
 		fi
 	done
 
-	# make sure we record the status of the last test we ran.
-	_stash_test_status "$seqnum" "$tc_status"
-	if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
-		_make_testcase_report "$prev_seq" "$tc_status"
+	if ((${#loop_status[*]})); then
+		loop_status+=("$tc_status")
+		_failure_loop_dump_stats "$seqnum" "${loop_status[@]}"
+	else
+		# make sure we record the status of the last test we ran.
+		_stash_test_status "$seqnum" "$tc_status"
+		if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
+			_make_testcase_report "$prev_seq" "$tc_status"
+		fi
 	fi
 
 	sect_stop=`_wallclock`
-- 
2.35.3

