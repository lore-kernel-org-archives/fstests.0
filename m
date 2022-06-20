Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89730C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Jun 2022 19:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbiFTTaF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Jun 2022 15:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239371AbiFTTaD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Jun 2022 15:30:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC321C130
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 12:30:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5DE8621B2F
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 19:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655753400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7hYVIN9iHd1LTjQv7uRYMcCiGgDiiOShTjqADvxK3A=;
        b=MOe3HP2xiiHjs+XJ/jKIMih7XmBU10LZV4NyFsaosOLZnufmOFkCiJi/XJc9IBsHZkYuXj
        TGbziwRgq/gnFv7dnWn3oJBbdYUME75j2eW+wC5eL+CsKaRKRnU6Qvvnl5OSnyScUuUnbs
        3T2QSVme9wSB1m6UYWxpoILBCKBRSME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655753400;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7hYVIN9iHd1LTjQv7uRYMcCiGgDiiOShTjqADvxK3A=;
        b=/IIkTLL0dy4ZOSzkUyTab0tuo7KZ4PT5bNhFXmOrXkbNa2Jkw1i+6i3KjV+ULFPa7bXblW
        XyBMcy7wVzxgnCDw==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 429282C146;
        Mon, 20 Jun 2022 19:30:00 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH 4/6] report: fix xunit tests count
Date:   Mon, 20 Jun 2022 21:29:32 +0200
Message-Id: <20220620192934.21694-5-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220620192934.21694-1-ddiss@suse.de>
References: <20220620192934.21694-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The xunit "section report" provides a tests attribute, which according
to https://llg.cubic.org/docs/junit/ represents:
tests=""     <!-- The total number of tests in the suite, required. -->

The current value is generated as a sum of the $n_try and $n_notrun
counters. This is incorrect as the $n_try counter already includes tests
which are run but complete with _notrun.
One special case exists for $showme (check -n), where $n_try remains
zero, so $n_notrun can be used as-is.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 check         | 13 ++++++-------
 common/report | 14 +++++++++-----
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/check b/check
index 43c072d2..a5183d3a 100755
--- a/check
+++ b/check
@@ -430,13 +430,12 @@ _wrapup()
 	seq="check"
 	check="$RESULT_BASE/check"
 
-	if $showme; then
-		if $needwrap; then
-			if $do_report; then
-				_make_section_report
-			fi
-			needwrap=false
+	if $showme && $needwrap; then
+		if $do_report; then
+			# $showme = all selected tests are notrun (no tries)
+			_make_section_report "$n_notrun" "0" "$n_notrun"
 		fi
+		needwrap=false
 	elif $needwrap; then
 		if [ -f $check.time -a -f $tmp.time ]; then
 			cat $check.time $tmp.time  \
@@ -495,7 +494,7 @@ _wrapup()
 		fi
 		echo "" >>$tmp.summary
 		if $do_report; then
-			_make_section_report
+			_make_section_report "$n_try" "$n_bad" "$n_notrun"
 		fi
 		needwrap=false
 	fi
diff --git a/common/report b/common/report
index bf05afa9..84d9e0a7 100644
--- a/common/report
+++ b/common/report
@@ -49,9 +49,11 @@ _xunit_add_property()
 _xunit_make_section_report()
 {
 	# xfstest:section ==> xunit:testsuite
+	local tests_count="$1"
+	local bad_count="$2"
+	local notrun_count="$3"
 	local sect_name=$section
 	local sect_time=`expr $sect_stop - $sect_start`
-	local n_total=`expr $n_try + $n_notrun`
 
 	if [ $sect_name == '-no-sections-' ]; then
 		sect_name='global'
@@ -62,9 +64,8 @@ _xunit_make_section_report()
 	if [ -z "$date_time" ]; then
 		date_time=$(date +"%F %T")
 	fi
-	local dtime=`echo $date_time| tr  " " 'T'`
-	local stats="failures=\"$n_bad\" skipped=\"$n_notrun\" tests=\"$n_total\" time=\"$sect_time\""
-	local hw_info="hostname=\"$HOST\" timestamp=\"$dtime\" "
+	local stats="failures=\"$bad_count\" skipped=\"$notrun_count\" tests=\"$tests_count\" time=\"$sect_time\""
+	local hw_info="hostname=\"$HOST\" timestamp=\"${date_time/ /T}\" "
 	echo "<testsuite name=\"xfstests\" $stats  $hw_info >" >> $REPORT_DIR/result.xml
 
 	# Properties
@@ -149,10 +150,13 @@ _xunit_make_testcase_report()
 #  Common report generator entry points
 _make_section_report()
 {
+	local tests_count="$1"
+	local bad_count="$2"
+	local notrun_count="$3"
 	for report in $REPORT_LIST; do
 		case "$report" in
 		"xunit")
-			_xunit_make_section_report
+			_xunit_make_section_report "$tests_count" "$bad_count" "$notrun_count"
 			;;
 		*)
 			_dump_err "format '$report' is not supported"
-- 
2.35.3

