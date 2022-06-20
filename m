Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BEECCA483
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Jun 2022 19:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbiFTTaG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Jun 2022 15:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238335AbiFTTaC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Jun 2022 15:30:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C3D1C134
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 12:30:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A00611FA1A
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 19:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655753400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dv8X83/H0/AqoMEIkHyrixu+09qrTAZ1+e/mze2fh0M=;
        b=EDAcHfrwTR3jN4hTQAGM+pn8UF2Oj85U2rurPyv1ZirQBoMt9dQRT+N5ctQ07Vo4uqYU+m
        MW340JRNuyOGko2d9QLJYOr1kr/Ei1sShqYgo5kfAq6bDWooE/w34p7AyV53/aljVihhXI
        WdwJ8xqS0++kQDhUz1d9yeub+EjAp7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655753400;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dv8X83/H0/AqoMEIkHyrixu+09qrTAZ1+e/mze2fh0M=;
        b=Lp7FO+BlYKjx4NvY2xr/wp/w4X+ENlwEtnlqtf1OcYAE/b64ldCDHTn0LadrohNgw3+0se
        JXMpNC3sCEf/atDw==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8644B2C143;
        Mon, 20 Jun 2022 19:30:00 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH 6/6] check: remove err and first_test variables
Date:   Mon, 20 Jun 2022 21:29:34 +0200
Message-Id: <20220620192934.21694-7-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220620192934.21694-1-ddiss@suse.de>
References: <20220620192934.21694-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

tc_status can be used for both of these.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 check | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/check b/check
index 8423d7a1..2ea2920f 100755
--- a/check
+++ b/check
@@ -725,23 +725,17 @@ function run_section()
 	seqres="$check"
 	_check_test_fs
 
-	err=false
-	first_test=true
+	local tc_status="init"
 	prev_seq=""
 	for seq in $list ; do
 		# Run report for previous test!
-		if $err ; then
+		if [ "$tc_status" == "fail" ]; then
 			bad+=("$seqnum")
-			tc_status="fail"
 		fi
-		if $do_report && ! $first_test ; then
-			if [ $tc_status != "expunge" ] ; then
-				_make_testcase_report "$prev_seq" "$tc_status"
-			fi
+		if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
+			_make_testcase_report "$prev_seq" "$tc_status"
 		fi
-		first_test=false
 
-		err=false
 		prev_seq="$seq"
 		if [ ! -f $seq ]; then
 			# Try to get full name in case the user supplied only
@@ -845,7 +839,7 @@ function run_section()
 		if [ -f core ]; then
 			_dump_err_cont "[dumped core]"
 			mv core $RESULT_BASE/$seqnum.core
-			err=true
+			tc_status="fail"
 		fi
 
 		if [ -f $seqres.notrun ]; then
@@ -870,15 +864,15 @@ function run_section()
 			_scratch_unmount 2> /dev/null
 			rm -f ${RESULT_DIR}/require_test*
 			rm -f ${RESULT_DIR}/require_scratch*
-			err=true
+			tc_status="fail"
 		else
 			# The test apparently passed, so check for corruption
 			# and log messages that shouldn't be there.  Run the
 			# checking tools from a subshell with adjusted OOM
 			# score so that the OOM killer will target them instead
 			# of the check script itself.
-			(_adjust_oom_score 250; _check_filesystems) || err=true
-			_check_dmesg || err=true
+			(_adjust_oom_score 250; _check_filesystems) || tc_status="fail"
+			_check_dmesg || tc_status="fail"
 		fi
 
 		# Reload the module after each test to check for leaks or
@@ -892,7 +886,7 @@ function run_section()
 
 		# Scan for memory leaks after every test so that associating
 		# a leak to a particular test will be as accurate as possible.
-		_check_kmemleak || err=true
+		_check_kmemleak || tc_status="fail"
 
 		# test ends after all checks are done.
 		$timestamp && _timestamp
@@ -900,7 +894,7 @@ function run_section()
 
 		if [ ! -f $seq.out ]; then
 			_dump_err "no qualified output"
-			err=true
+			tc_status="fail"
 			continue;
 		fi
 
@@ -909,7 +903,7 @@ function run_section()
 		# version.
 		sed -i "s/\`/\'/g" $tmp.out
 		if diff $seq.out $tmp.out >/dev/null 2>&1 ; then
-			if ! $err ; then
+			if [ "$tc_status" != "fail" ]; then
 				echo "$seqnum `expr $stop - $start`" >>$tmp.time
 				echo -n " `expr $stop - $start`s"
 			fi
@@ -926,10 +920,10 @@ function run_section()
 				echo "(Run '$diff $here/$seq.out $seqres.out.bad'" \
 					" to see the entire diff)"
 			fi; } | sed -e 's/^\(.\)/    \1/'
-			err=true
+			tc_status="fail"
 		fi
 		if [ -f $seqres.hints ]; then
-			if $err; then
+			if [ "$tc_status" == "fail" ]; then
 				echo
 				cat $seqres.hints
 			else
@@ -939,14 +933,11 @@ function run_section()
 	done
 
 	# make sure we record the status of the last test we ran.
-	if $err ; then
+	if [ "$tc_status" == "fail" ]; then
 		bad+=("$seqnum")
-		tc_status="fail"
 	fi
-	if $do_report && ! $first_test ; then
-		if [ $tc_status != "expunge" ] ; then
-			_make_testcase_report "$prev_seq" "$tc_status"
-		fi
+	if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
+		_make_testcase_report "$prev_seq" "$tc_status"
 	fi
 
 	sect_stop=`_wallclock`
-- 
2.35.3

