Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9893FCCA473
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Jul 2022 11:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiGFLXj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 Jul 2022 07:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiGFLXc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Jul 2022 07:23:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5FF1570E
        for <fstests@vger.kernel.org>; Wed,  6 Jul 2022 04:23:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 249B022594;
        Wed,  6 Jul 2022 11:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657106609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Jyt5C8qOBlEHNjgXc1yZscV7YB6U1jNHML5+EW97pY=;
        b=MZm/issgR4cycysgdB+0TPebShmqu7rg6cw9PJDD1gy7jqPD4mgQRe6QM02LPi+iAlvKta
        9ve4EdQEJfYfFD2sV7TERQMl08msJi2sIj9MG0UO0mumjMLtyNEm0csODENzhIgrNo0juJ
        SsVlVrar5Pj1GB7BYVZLbKSgtyIM1/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657106609;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Jyt5C8qOBlEHNjgXc1yZscV7YB6U1jNHML5+EW97pY=;
        b=xyr7+i/ClbYxDAMEQ34uz8c2sKCx2ggkHoWcsi/c4+1mYZWBlRUKoYCCjL9avV9X8SwvSO
        G3AfkF6l3ulLMxBg==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 057C42C141;
        Wed,  6 Jul 2022 11:23:29 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org, tytso@mit.edu
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 4/5] check: append bad / notrun arrays in helper function
Date:   Wed,  6 Jul 2022 13:23:11 +0200
Message-Id: <20220706112312.4349-5-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220706112312.4349-1-ddiss@suse.de>
References: <20220706112312.4349-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Currently the @try, @bad and @notrun arrays are appended with seqnum at
different points in the main run_section() loop:
- @try: shortly prior to test script execution
- @notrun: on list (check -n), or after .notrun flagged test completion
- @bad: at the start of subsequent test loop and loop exit

For future loop-test-following-failure functionality it makes sense to
combine some of these steps. This change moves both @notrun and @bad
appends into a helper function which is called at the end of each loop
iteration.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 check | 68 ++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/check b/check
index 08857f7e..6dbdb2a8 100755
--- a/check
+++ b/check
@@ -553,6 +553,32 @@ _expunge_test()
 	return 0
 }
 
+# Retain in @bad / @notrun the result of the just-run @test_seq. @try array
+# entries are added prior to execution.
+_stash_test_status() {
+	local test_seq="$1"
+	local test_status="$2"
+
+	if $do_report && [[ $test_status != "expunge" ]]; then
+		_make_testcase_report "$section" "$test_seq" \
+				      "$test_status" "$((stop - start))"
+	fi
+
+	case "$test_status" in
+	fail)
+		bad+=("$test_seq")
+		;;
+	list|notrun)
+		notrun+=("$test_seq")
+		;;
+	pass|expunge)
+		;;
+	*)
+		echo "Unexpected test $test_seq status: $test_status"
+		;;
+	esac
+}
+
 # Can we run systemd scopes?
 HAVE_SYSTEMD_SCOPES=
 systemctl reset-failed "fstests-check" &>/dev/null
@@ -732,19 +758,8 @@ function run_section()
 	seqres="$check"
 	_check_test_fs
 
-	local tc_status="init"
-	prev_seq=""
+	local tc_status
 	for seq in $list ; do
-		# Run report for previous test!
-		if [ "$tc_status" == "fail" ]; then
-			bad+=("$seqnum")
-		fi
-		if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
-			_make_testcase_report "$section" "$seqnum" \
-					      "$tc_status" "$((stop - start))"
-		fi
-
-		prev_seq="$seq"
 		if [ ! -f $seq ]; then
 			# Try to get full name in case the user supplied only
 			# seq id and the test has a name. A bit of hassle to
@@ -784,20 +799,21 @@ function run_section()
 		if $showme; then
 			_expunge_test $seqnum
 			if [ $? -eq 1 ]; then
-			    tc_status="expunge"
-			    continue
+				tc_status="expunge"
+			else
+				echo
+				start=0
+				stop=0
+				tc_status="list"
 			fi
-			echo
-			start=0
-			stop=0
-			tc_status="list"
-			notrun+=("$seqnum")
+			_stash_test_status "$seqnum" "$tc_status"
 			continue
 		fi
 
 		tc_status="pass"
 		if [ ! -f $seq ]; then
 			echo " - no such test?"
+			_stash_test_status "$seqnum" "$tc_status"
 			continue
 		fi
 
@@ -808,6 +824,7 @@ function run_section()
 		_expunge_test $seqnum
 		if [ $? -eq 1 ]; then
 			tc_status="expunge"
+			_stash_test_status "$seqnum" "$tc_status"
 			continue
 		fi
 
@@ -857,8 +874,8 @@ function run_section()
 			$timestamp && echo " [not run]" && \
 				      echo -n "	$seqnum -- "
 			cat $seqres.notrun
-			notrun+=("$seqnum")
 			tc_status="notrun"
+			_stash_test_status "$seqnum" "$tc_status"
 
 			# Unmount the scratch fs so that we can wipe the scratch
 			# dev state prior to the next test run.
@@ -903,6 +920,7 @@ function run_section()
 		if [ ! -f $seq.out ]; then
 			_dump_err "no qualified output"
 			tc_status="fail"
+			_stash_test_status "$seqnum" "$tc_status"
 			continue;
 		fi
 
@@ -938,17 +956,9 @@ function run_section()
 				rm -f $seqres.hints
 			fi
 		fi
+		_stash_test_status "$seqnum" "$tc_status"
 	done
 
-	# make sure we record the status of the last test we ran.
-	if [ "$tc_status" == "fail" ]; then
-		bad+=("$seqnum")
-	fi
-	if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
-		_make_testcase_report "$section" "$seqnum" "$tc_status" \
-				      "$((stop - start))"
-	fi
-
 	sect_stop=`_wallclock`
 	interrupt=false
 	_wrapup
-- 
2.35.3

