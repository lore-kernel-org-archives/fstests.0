Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED744C07E9B
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Jul 2021 00:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6CC61106
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Jul 2021 00:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhGTXdD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Jul 2021 19:33:03 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:40305 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231152AbhGTXdD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Jul 2021 19:33:03 -0400
Received: from dread.disaster.area (pa49-181-34-10.pa.nsw.optusnet.com.au [49.181.34.10])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 1C30910AF6C
        for <fstests@vger.kernel.org>; Wed, 21 Jul 2021 10:13:38 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1m5zrh-008uHQ-IO
        for fstests@vger.kernel.org; Wed, 21 Jul 2021 10:13:33 +1000
Received: from dave by discord.disaster.area with local (Exim 4.94)
        (envelope-from <david@fromorbit.com>)
        id 1m5zrh-00CaDO-AJ
        for fstests@vger.kernel.org; Wed, 21 Jul 2021 10:13:33 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] tools: add a dm-logwrites replay tool
Date:   Wed, 21 Jul 2021 10:13:33 +1000
Message-Id: <20210721001333.2999103-1-david@fromorbit.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=hdaoRb6WoHYrV466vVKEyw==:117 a=hdaoRb6WoHYrV466vVKEyw==:17
        a=e_q4qTt1xDgA:10 a=20KFwNOVAAAA:8 a=TcVBzKVZuEY3lVG4GoIA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Trying to decipher a dm-logwrites replay failure from generic/482 is
difficult. The test destroys all the dm state and devices when the
test fails, leaving nothing behind for post-mortem analysis. This
script is intended to allow replay of the dm-logwrites device one
FUA at a time similar to generic/482, and is used in conjunction
with a modifed g/482 test that does not tear down the dm volumes
or state when the test fails.

This allows the developer to replay the logwrites up to just prior
to failure to examine just the differences between the last good
state and the first failure state, greatly reducing the complexity
of analysing failures.

Instructions for use are in the tools/dm-logwrite-replay script
itself.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/dmlogwrites       |   8 +--
 tests/generic/482        |  18 +++++++
 tools/dm-logwrite-replay | 113 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 4 deletions(-)
 create mode 100755 tools/dm-logwrite-replay

diff --git a/common/dmlogwrites b/common/dmlogwrites
index 573f4b8a..66c57e2b 100644
--- a/common/dmlogwrites
+++ b/common/dmlogwrites
@@ -180,11 +180,11 @@ _log_writes_replay_log_range()
 	[ -z "$blkdev" ] && _fail \
 	"block dev must be specified for _log_writes_replay_log_range"
 
-	# To ensure we replay the last entry,
-	# we need to manually increase the end entry number to ensure
-	# it's played
+	# To ensure we replay the last entry, we need to manually increase the
+	# end entry number to ensure it's played. We also dump all the
+	# operations performed as this helps post-mortem analysis of failures.
 	echo "=== replay to $end ===" >> $seqres.full
-	$here/src/log-writes/replay-log --log $LOGWRITES_DEV \
+	$here/src/log-writes/replay-log -vv --log $LOGWRITES_DEV \
 		--replay $blkdev --limit $(($end + 1)) \
 		>> $seqres.full 2>&1
 	[ $? -ne 0 ] && _fail "replay failed"
diff --git a/tests/generic/482 b/tests/generic/482
index f26e6fc4..416b929a 100755
--- a/tests/generic/482
+++ b/tests/generic/482
@@ -12,6 +12,10 @@
 _begin_fstest auto metadata replay thin
 
 # Override the default cleanup function.
+#
+# If debugging logwrites failures using the tools/dm-logwrite-replay script,
+# switch the cleanup function to the version that is commented out below so that
+# failure leaves the corpse intact for post-mortem failure analysis.
 _cleanup()
 {
 	cd /
@@ -21,6 +25,20 @@ _cleanup()
 	rm -f $tmp.*
 }
 
+# tools/dm-logwrite-replay _cleanup version
+#_cleanup()
+#{
+#	cd /
+#	$KILLALL_PROG -KILL -q $FSSTRESS_PROG &> /dev/null
+#	if [ $status -eq 0 ]; then
+#		_log_writes_cleanup &> /dev/null
+#		_dmthin_cleanup
+#	else
+#		echo dm-thinvol-dev: $DMTHIN_VOL_DEV >> $seqres.full
+#	fi
+#	rm -f $tmp.*
+#}
+
 # Import common functions.
 . ./common/filter
 . ./common/dmthin
diff --git a/tools/dm-logwrite-replay b/tools/dm-logwrite-replay
new file mode 100755
index 00000000..56d0121c
--- /dev/null
+++ b/tools/dm-logwrite-replay
@@ -0,0 +1,113 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0 Copyright (c) 2021 Red Hat, Inc.  All Rights
+# Reserved.
+#
+# dm-logwrite-replay utility.
+#
+# This is used to replay failures that result from generic/482. Modify the
+# cleanup function in g/482 to the version that does not tear down the dm-thin
+# volume and grab the thin volume name from the the 482.full output file.  Then
+# you can replay the log writes manually with this tool so that the changes
+# between a good replay and a bad replay can be isolated. The 482.full output
+# file has all the FUA write locations recorded - these are what you pass the
+# tool as "PREV_FUA" and "END_FUA".
+#
+# The tool uses the fstests infrastructure and scripts, so it needs to be run
+# from the base fstests directory similar to the check script. RESULT_DIR is
+# pointed at the current directory, which means that debug output from the tool
+# placed in $seqres.full points ends up in ./dm-logwrite-replay.full.
+#
+# For example:
+#	- device name /dev/mapper/thin-vol
+# 	- last good replay @ write 124
+# 	- first bad replay @ write 125
+#
+# Replay from start to 124:
+#
+# cd src/fstests
+# tools/dm-logwrite-replay --dev /dev/mapper/thin-vol --end 124
+# <take image of filesystem /dev/mapper/thin-vol>
+#
+# Replay from 124 to 125:
+#
+# tools/dm-logwrite-replay --dev /dev/mapper/thin-vol --start 124 --end 125
+# <take image of filesystem from /dev/mapper/thin-vol>
+#
+# Now compare images of the filesystem to see the differences and analyse the
+# failure.
+#
+# Often with log recovery failures, you need to see the pre-recovery state of
+# the filesystem. To do this, use the --no-recovery option in conjunction with
+# the above commands.  This allows you to determine if recovery is doing the
+# wrong thing or not.
+#
+# Once finished, teardown the logwrites/thin vol with
+#
+# tools/dm-logwrite-replay --dev /dev/mapper/thin-vol --cleanup
+#
+
+DMTHIN_VOL_DEV=""
+PREV_FUA=""
+END_FUA=""
+CLEANUP=""
+DO_RECOVERY="y"
+
+while [ $# -gt 0 ]; do
+	case "$1" in
+	--dev) DMTHIN_VOL_DEV="$2" ; shift ;;
+	--start) PREV_FUA="$2" ; shift ;;
+	--end) END_FUA="$2" ; shift ;;
+	--cleanup) CLEANUP=y ;;
+	--no-recovery) DO_RECOVERY="" ;;
+	esac
+	shift
+done
+
+[ -z "$DMTHIN_VOL_DEV" ] && _fail "not dmthin vol defined"
+
+RESULT_DIR=`pwd`
+
+. ./common/preamble
+_begin_fstest replay
+
+MOUNT_OPTIONS="-o dax=never"
+
+# Import common functions.
+. ./common/filter
+. ./common/dmthin
+. ./common/dmlogwrites
+
+LOGWRITES_NAME=logwrites-test
+LOGWRITES_DMDEV=/dev/mapper/$LOGWRITES_NAME
+
+if [ -n "$CLEANUP" ]; then
+	_log_writes_cleanup &> /dev/null
+	_dmthin_cleanup
+	exit;
+fi
+
+if [ -z "$PREV_FUA" ]; then
+	prev=$(_log_writes_mark_to_entry_number mkfs)
+	[ -z "$prev" ] && _fail "failed to locate entry mark 'mkfs'"
+else
+	prev="$((PREV_FUA + 1))"
+fi
+cur=$(_log_writes_find_next_fua $prev)
+[ -z "$cur" ] && _fail "failed to locate next FUA write"
+
+while [ ! -z "$cur" ]; do
+	echo "Replay writes from $prev to $cur"
+	_log_writes_replay_log_range $cur $DMTHIN_VOL_DEV
+
+	if [ -n "$DO_RECOVERY" ]; then
+		_dmthin_mount
+		_dmthin_check_fs
+	fi
+
+	[ -n "$END_FUA" -a "$END_FUA" -eq "$cur" ] && break;
+
+	prev=$cur
+	cur=$(_log_writes_find_next_fua $(($cur + 1)))
+	[ -z "$cur" ] && break
+done
+
-- 
2.31.1

