Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1F6C43334
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Jun 2022 16:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353596AbiFUQDH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353485AbiFUQCp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2022 12:02:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249982DD71
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 09:02:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7C30621B8B;
        Tue, 21 Jun 2022 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655827321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=joBl42SXLrT4lvb7W1s4wFzrbqyFu8tdayNn0XFcPao=;
        b=oVsYIECVHCWQikKp8h5yUlRJBC6IOcWQ2cNF5MjK7UeusXCuL8x4QVxP8N7TsIpVKZotB1
        /ILmxKqaXrO9zaXi+eR6gVHA4zkTamK4tyEsUvncBYymKLBQl7aouzb6ZbD7oahQoS77Cb
        8+Q+6uLwX88Iv/cQbYzvVCH7D00mf2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655827321;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=joBl42SXLrT4lvb7W1s4wFzrbqyFu8tdayNn0XFcPao=;
        b=9IncI15PcxGeshEhvtXsBPk4kk83WhPmo2IH3GwmNvghtRqRELM16wsRE/gDW8ilfHlTWO
        apFTNzmx9sH0UGCQ==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 24EC22C141;
        Tue, 21 Jun 2022 16:02:01 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org, tytso@mit.edu
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH 1/2] check: append bad / notrun arrays in helper function
Date:   Tue, 21 Jun 2022 18:01:52 +0200
Message-Id: <20220621160153.29591-2-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220621160153.29591-1-ddiss@suse.de>
References: <20220621160153.29591-1-ddiss@suse.de>
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
appends into a helper function.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 check | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/check b/check
index 2ea2920f..3e8a232c 100755
--- a/check
+++ b/check
@@ -546,6 +546,27 @@ _expunge_test()
 	return 0
 }
 
+# Retain in @bad / @notrun the result of previously run @test_seq. @try array
+# entries are added prior to execution.
+_stash_test_status() {
+	local test_seq="$1"
+	local test_status="$2"
+
+	case "$test_status" in
+	fail)
+		bad+=("$test_seq")
+		;;
+	list|notrun)
+		notrun+=("$test_seq")
+		;;
+	pass|expunge|init)
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
@@ -729,9 +750,7 @@ function run_section()
 	prev_seq=""
 	for seq in $list ; do
 		# Run report for previous test!
-		if [ "$tc_status" == "fail" ]; then
-			bad+=("$seqnum")
-		fi
+		_stash_test_status "$seqnum" "$tc_status"
 		if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
 			_make_testcase_report "$prev_seq" "$tc_status"
 		fi
@@ -783,7 +802,6 @@ function run_section()
 			start=0
 			stop=0
 			tc_status="list"
-			notrun+=("$seqnum")
 			continue
 		fi
 
@@ -849,7 +867,6 @@ function run_section()
 			$timestamp && echo " [not run]" && \
 				      echo -n "	$seqnum -- "
 			cat $seqres.notrun
-			notrun+=("$seqnum")
 			tc_status="notrun"
 
 			# Unmount the scratch fs so that we can wipe the scratch
@@ -933,9 +950,7 @@ function run_section()
 	done
 
 	# make sure we record the status of the last test we ran.
-	if [ "$tc_status" == "fail" ]; then
-		bad+=("$seqnum")
-	fi
+	_stash_test_status "$seqnum" "$tc_status"
 	if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
 		_make_testcase_report "$prev_seq" "$tc_status"
 	fi
-- 
2.35.3

