Return-Path: <SRS0=zmF6=AT=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A1CC433E2
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Jul 2020 06:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92BB820786
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Jul 2020 06:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725298AbgGHGHV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:07:21 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:49272 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbgGHGHU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Jul 2020 02:07:20 -0400
X-Greylist: delayed 1919 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jul 2020 02:07:18 EDT
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id C7D0F108ECC
        for <fstests@vger.kernel.org>; Wed,  8 Jul 2020 15:35:15 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jt2ji-0003Eo-Ak
        for fstests@vger.kernel.org; Wed, 08 Jul 2020 15:35:14 +1000
Received: from dave by discord.disaster.area with local (Exim 4.93)
        (envelope-from <david@fromorbit.com>)
        id 1jt2ji-00Dg5D-0b
        for fstests@vger.kernel.org; Wed, 08 Jul 2020 15:35:14 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] check: add CLI option to repeat tests
Date:   Wed,  8 Jul 2020 15:35:13 +1000
Message-Id: <20200708053513.3259990-1-david@fromorbit.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=_RQrkK6FrEwA:10 a=20KFwNOVAAAA:8 a=2boadl56ZxmTK7JEdN0A:9
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Frequently when trying to reproduce a problem I want to run a set of
specific tests in a loop, over and over again. I run fstests from a
set of run scripts that have non-trivial overhead (e.g. patterning
block devices before the runs start), so if all I want to do is run
the same test 100x, using a shell loop over the entire run
scripts reduces the iteration rate substantially.

Hence add an option to check to allow fstests to loop a number of
times over the configured test set without stopping.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/check b/check
index 2e148e57..2676b619 100755
--- a/check
+++ b/check
@@ -26,6 +26,7 @@ subdir_xfile=""
 brief_test_summary=false
 do_report=false
 DUMP_OUTPUT=false
+iterations=1
 
 # This is a global variable used to pass test failure text to reporting gunk
 _err_msg=""
@@ -66,6 +67,7 @@ check options
     -n			show me, do not run tests
     -T			output timestamps
     -r			randomize test order
+    -i <n>		iterate the test list <n> times
     -d			dump test output to stdout
     -b			brief test summary
     -R fmt[,fmt]	generate report in formats specified. Supported format: [xunit]
@@ -297,7 +299,7 @@ while [ $# -gt 0 ]; do
 
 	-n)	showme=true ;;
         -r)	randomize=true ;;
-
+	-i)	iterations=$2; shift ;;
 	-T)	timestamp=true ;;
 	-d)	DUMP_OUTPUT=true ;;
 	-b)	brief_test_summary=true;;
@@ -525,7 +527,10 @@ else
 	trap "_wrapup; exit \$status" 0 1 2 3 15
 fi
 
-for section in $HOST_OPTIONS_SECTIONS; do
+function run_section()
+{
+	local section=$1
+
 	OLD_FSTYP=$FSTYP
 	OLD_TEST_FS_MOUNT_OPTS=$TEST_FS_MOUNT_OPTS
 	get_next_config $section
@@ -540,7 +545,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			fi
 		done
 		if $skip; then
-			continue
+			return
 		fi
 	fi
 
@@ -554,7 +559,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			fi
 		done
 		if $skip; then
-			continue
+			return
 		fi
 	fi
 
@@ -700,6 +705,8 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		seqres="$REPORT_DIR/$seqnum"
 
 		mkdir -p $RESULT_DIR
+		rm -f ${RESULT_DIR}/require_scratch*
+		rm -f ${RESULT_DIR}/require_test*
 		echo -n "$seqnum"
 
 		if $showme; then
@@ -858,6 +865,12 @@ for section in $HOST_OPTIONS_SECTIONS; do
 
 	_test_unmount 2> /dev/null
 	_scratch_unmount 2> /dev/null
+}
+
+for ((iters = 0; iters < $iterations; iters++)) do
+	for section in $HOST_OPTIONS_SECTIONS; do
+		run_section $section
+	done
 done
 
 interrupt=false
-- 
2.26.2.761.g0e0b3e54be

