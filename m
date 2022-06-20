Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3705ECCA47F
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Jun 2022 19:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiFTTaF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Jun 2022 15:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbiFTTaD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Jun 2022 15:30:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD211C131
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 12:30:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7E0F721B3B
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 19:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655753400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ii+cN3r95AnqiCNSdql5UBJL//K6u+Mpx4//N7ngW5c=;
        b=fVCGScMuwee+pI5PoGAz1DE0xyGaTpxA+EC28gAvQU+uwd32OsQ42OnNNukZ8T71zKYIfJ
        diSXj+DNYEYN2RPhM5dM+Su8q0P/rgowkB0ipmARTrCvFof87yTREaqpdpHkYzziNXDT9C
        1LF9DyX6w4PoUfuViCbOLQJ8wVDgXSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655753400;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ii+cN3r95AnqiCNSdql5UBJL//K6u+Mpx4//N7ngW5c=;
        b=tNnsIsuoSDzFTx7dkqNLSH85vs1/rijZ328ZcyhABkh4Mpo4mF8W3Kve9Yg8iweUCyKHgj
        an5zw65q3FYpjXBA==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6514B2C141;
        Mon, 20 Jun 2022 19:30:00 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH 5/6] check: use arrays instead of separate n_ counters
Date:   Mon, 20 Jun 2022 21:29:33 +0200
Message-Id: <20220620192934.21694-6-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220620192934.21694-1-ddiss@suse.de>
References: <20220620192934.21694-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The separate n_try, n_bad and n_notrun counters are unnecessary when
the corresponding lists are switched to bash arrays.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 check | 72 ++++++++++++++++++++++++++---------------------------------
 1 file changed, 32 insertions(+), 40 deletions(-)

diff --git a/check b/check
index a5183d3a..8423d7a1 100755
--- a/check
+++ b/check
@@ -8,13 +8,10 @@ tmp=/tmp/$$
 status=0
 needwrap=true
 needsum=true
-n_try=0
-try=""
-n_bad=0
+try=()
 sum_bad=0
-bad=""
-n_notrun=0
-notrun=""
+bad=()
+notrun=()
 interrupt=true
 diff="diff -u"
 showme=false
@@ -412,10 +409,9 @@ fi
 
 _wipe_counters()
 {
-	n_try="0"
-	n_bad="0"
-	n_notrun="0"
-	unset try notrun bad
+	try=()
+	notrun=()
+	bad=()
 }
 
 _global_log() {
@@ -433,7 +429,7 @@ _wrapup()
 	if $showme && $needwrap; then
 		if $do_report; then
 			# $showme = all selected tests are notrun (no tries)
-			_make_section_report "$n_notrun" "0" "$n_notrun"
+			_make_section_report "${#notrun[*]}" "0" "${#notrun[*]}"
 		fi
 		needwrap=false
 	elif $needwrap; then
@@ -458,12 +454,12 @@ _wrapup()
 
 		echo "SECTION       -- $section" >>$tmp.summary
 		echo "=========================" >>$tmp.summary
-		if [ ! -z "$n_try" -a $n_try != 0 ]; then
+		if ((${#try[*]} > 0)); then
 			if [ $brief_test_summary == "false" ]; then
-				echo "Ran:$try"
-				echo "Ran:$try" >>$tmp.summary
+				echo "Ran: ${try[*]}"
+				echo "Ran: ${try[*]}" >>$tmp.summary
 			fi
-			_global_log "Ran:$try"
+			_global_log "Ran: ${try[*]}"
 		fi
 
 		$interrupt && echo "Interrupted!" | tee -a $check.log
@@ -472,34 +468,34 @@ _wrapup()
 				${REPORT_DIR}/check.log
 		fi
 
-		if [ ! -z "$notrun" ]; then
+		if ((${#notrun[*]} > 0)); then
 			if [ $brief_test_summary == "false" ]; then
-				echo "Not run:$notrun"
-				echo "Not run:$notrun" >>$tmp.summary
+				echo "Not run: ${notrun[*]}"
+				echo "Not run: ${notrun[*]}" >>$tmp.summary
 			fi
-			_global_log "Not run:$notrun"
+			_global_log "Not run: ${notrun[*]}"
 		fi
 
-		if [ ! -z "$n_bad" -a $n_bad != 0 ]; then
-			echo "Failures:$bad"
-			echo "Failed $n_bad of $n_try tests"
-			_global_log "Failures:$bad"
-			_global_log "Failed $n_bad of $n_try tests"
-			echo "Failures:$bad" >>$tmp.summary
-			echo "Failed $n_bad of $n_try tests" >>$tmp.summary
+		if ((${#bad[*]} > 0)); then
+			echo "Failures: ${bad[*]}"
+			echo "Failed ${#bad[*]} of ${#try[*]} tests"
+			_global_log "Failures: ${bad[*]}"
+			_global_log "Failed ${#bad[*]} of ${#try[*]} tests"
+			echo "Failures: ${bad[*]}" >>$tmp.summary
+			echo "Failed ${#bad[*]} of ${#try[*]} tests" >>$tmp.summary
 		else
-			echo "Passed all $n_try tests"
-			_global_log "Passed all $n_try tests"
-			echo "Passed all $n_try tests" >>$tmp.summary
+			echo "Passed all ${#try[*]} tests"
+			_global_log "Passed all ${#try[*]} tests"
+			echo "Passed all ${#try[*]} tests" >>$tmp.summary
 		fi
 		echo "" >>$tmp.summary
 		if $do_report; then
-			_make_section_report "$n_try" "$n_bad" "$n_notrun"
+			_make_section_report "${#try[*]}" "${#bad[*]}" "${#notrun[*]}"
 		fi
 		needwrap=false
 	fi
 
-	sum_bad=`expr $sum_bad + $n_bad`
+	sum_bad=`expr $sum_bad + ${#bad[*]}`
 	_wipe_counters
 	rm -f /tmp/*.rawout /tmp/*.out /tmp/*.err /tmp/*.time
 	if ! $OPTIONS_HAVE_SECTIONS; then
@@ -735,8 +731,7 @@ function run_section()
 	for seq in $list ; do
 		# Run report for previous test!
 		if $err ; then
-			bad="$bad $seqnum"
-			n_bad=`expr $n_bad + 1`
+			bad+=("$seqnum")
 			tc_status="fail"
 		fi
 		if $do_report && ! $first_test ; then
@@ -794,7 +789,7 @@ function run_section()
 			start=0
 			stop=0
 			tc_status="list"
-			n_notrun=`expr $n_notrun + 1`
+			notrun+=("$seqnum")
 			continue
 		fi
 
@@ -815,8 +810,7 @@ function run_section()
 		fi
 
 		# record that we really tried to run this test.
-		try="$try $seqnum"
-		n_try=`expr $n_try + 1`
+		try+=("$seqnum")
 
 		awk 'BEGIN {lasttime="       "} \
 		     $1 == "'$seqnum'" {lasttime=" " $2 "s ... "; exit} \
@@ -861,8 +855,7 @@ function run_section()
 			$timestamp && echo " [not run]" && \
 				      echo -n "	$seqnum -- "
 			cat $seqres.notrun
-			notrun="$notrun $seqnum"
-			n_notrun=`expr $n_notrun + 1`
+			notrun+=("$seqnum")
 			tc_status="notrun"
 
 			# Unmount the scratch fs so that we can wipe the scratch
@@ -947,8 +940,7 @@ function run_section()
 
 	# make sure we record the status of the last test we ran.
 	if $err ; then
-		bad="$bad $seqnum"
-		n_bad=`expr $n_bad + 1`
+		bad+=("$seqnum")
 		tc_status="fail"
 	fi
 	if $do_report && ! $first_test ; then
-- 
2.35.3

