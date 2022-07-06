Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65625CCA47C
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Jul 2022 11:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiGFLXk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 Jul 2022 07:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiGFLXh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Jul 2022 07:23:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB61415739
        for <fstests@vger.kernel.org>; Wed,  6 Jul 2022 04:23:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4C5A31FD9A;
        Wed,  6 Jul 2022 11:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657106609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBcBsPD5OdWTh855JNDJoJt6HAP8HIk29jxAiPnN28Y=;
        b=zgLT89vuYPoZa9s7RcJwy8Rf4if/AeqnOKILn2Zdoc+rBp4VMRN6oVcUx5sd0CM5QVTWBr
        0xVPwFgm/F1FrbdISu9guvWel1CYzLDNIsU1w11Xn41f6M+PPwv7M+tPkmqj/bZx7d9dAo
        oWjhC6snHnCsYaoKZSlQyCQtbjdhsWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657106609;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBcBsPD5OdWTh855JNDJoJt6HAP8HIk29jxAiPnN28Y=;
        b=jiX2cAb9IgCZx4ujbyf/SkqDrJt6Vnt5Xfpjbzu/kHLGhc3S3l+C/QjCWsSa0aY+AkqLKH
        ov6MLdizdzzCQtCg==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2C9882C142;
        Wed,  6 Jul 2022 11:23:29 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org, tytso@mit.edu
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 5/5] check: add -L <n> parameter to rerun failed tests
Date:   Wed,  6 Jul 2022 13:23:12 +0200
Message-Id: <20220706112312.4349-6-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220706112312.4349-1-ddiss@suse.de>
References: <20220706112312.4349-1-ddiss@suse.de>
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
 check | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/check b/check
index 6dbdb2a8..46fca6e6 100755
--- a/check
+++ b/check
@@ -26,6 +26,7 @@ do_report=false
 DUMP_OUTPUT=false
 iterations=1
 istop=false
+loop_on_fail=0
 
 # This is a global variable used to pass test failure text to reporting gunk
 _err_msg=""
@@ -78,6 +79,7 @@ check options
     --large-fs		optimise scratch device for large filesystems
     -s section		run only specified section from config file
     -S section		exclude the specified section from the config file
+    -L <n>		loop tests <n> times following a failure, measuring aggregate pass/fail metrics
 
 testlist options
     -g group[,group...]	include tests from these groups
@@ -336,6 +338,9 @@ while [ $# -gt 0 ]; do
 		;;
 	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
 	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
+	-L)	[[ $2 =~ ^[0-9]+$ ]] || usage
+		loop_on_fail=$2; shift
+		;;
 
 	-*)	usage ;;
 	*)	# not an argument, we've got tests now.
@@ -553,6 +558,18 @@ _expunge_test()
 	return 0
 }
 
+# retain files which would be overwritten in subsequent reruns of the same test
+_stash_fail_loop_files() {
+	local test_seq="$1"
+	local suffix="$2"
+
+	for i in "${REPORT_DIR}/${test_seq}.full" \
+		 "${REPORT_DIR}/${test_seq}.dmesg" \
+		 "${REPORT_DIR}/${test_seq}.out.bad"; do
+		[ -f "$i" ] && cp "$i" "${i}${suffix}"
+	done
+}
+
 # Retain in @bad / @notrun the result of the just-run @test_seq. @try array
 # entries are added prior to execution.
 _stash_test_status() {
@@ -564,8 +581,35 @@ _stash_test_status() {
 				      "$test_status" "$((stop - start))"
 	fi
 
+	if ((${#loop_status[*]} > 0)); then
+		# continuing or completing rerun-on-failure loop
+		_stash_fail_loop_files "$test_seq" ".rerun${#loop_status[*]}"
+		loop_status+=("$test_status")
+		if ((${#loop_status[*]} > loop_on_fail)); then
+			printf "%s aggregate results across %d runs: " \
+				"$test_seq" "${#loop_status[*]}"
+			awk "BEGIN {
+				n=split(\"${loop_status[*]}\", arr);"'
+				for (i = 1; i <= n; i++)
+					stats[arr[i]]++;
+				for (x in stats)
+					printf("%s=%d (%.1f%%)",
+					       (i-- > n ? x : ", " x),
+					       stats[x], 100 * stats[x] / n);
+				}'
+			echo
+			loop_status=()
+		fi
+		return	# only stash @bad result for initial failure in loop
+	fi
+
 	case "$test_status" in
 	fail)
+		if ((loop_on_fail > 0)); then
+			# initial failure, start rerun-on-failure loop
+			_stash_fail_loop_files "$test_seq" ".rerun0"
+			loop_status+=("$test_status")
+		fi
 		bad+=("$test_seq")
 		;;
 	list|notrun)
@@ -758,8 +802,12 @@ function run_section()
 	seqres="$check"
 	_check_test_fs
 
-	local tc_status
-	for seq in $list ; do
+	loop_status=()	# track rerun-on-failure state
+	local tc_status ix
+	local -a _list=( $list )
+	for ((ix = 0; ix < ${#_list[*]}; !${#loop_status[*]} && ix++)); do
+		seq="${_list[$ix]}"
+
 		if [ ! -f $seq ]; then
 			# Try to get full name in case the user supplied only
 			# seq id and the test has a name. A bit of hassle to
@@ -829,7 +877,9 @@ function run_section()
 		fi
 
 		# record that we really tried to run this test.
-		try+=("$seqnum")
+		if ((!${#loop_status[*]})); then
+			try+=("$seqnum")
+		fi
 
 		awk 'BEGIN {lasttime="       "} \
 		     $1 == "'$seqnum'" {lasttime=" " $2 "s ... "; exit} \
-- 
2.35.3

