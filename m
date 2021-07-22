Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48FEC63793
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Jul 2021 06:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44B961283
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Jul 2021 06:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhGVGGz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Jul 2021 02:06:55 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:37329 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231325AbhGVGGy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Jul 2021 02:06:54 -0400
Received: from dread.disaster.area (pa49-181-34-10.pa.nsw.optusnet.com.au [49.181.34.10])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id BA8D21044E09
        for <fstests@vger.kernel.org>; Thu, 22 Jul 2021 16:47:27 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1m6SUQ-009OCu-8u
        for fstests@vger.kernel.org; Thu, 22 Jul 2021 16:47:26 +1000
Received: from dave by discord.disaster.area with local (Exim 4.94)
        (envelope-from <david@fromorbit.com>)
        id 1m6SUP-00Cucn-Ub
        for fstests@vger.kernel.org; Thu, 22 Jul 2021 16:47:26 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] [RFC] fstests: generic test hook infrastructure
Date:   Thu, 22 Jul 2021 16:47:25 +1000
Message-Id: <20210722064725.3077558-1-david@fromorbit.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=hdaoRb6WoHYrV466vVKEyw==:117 a=hdaoRb6WoHYrV466vVKEyw==:17
        a=e_q4qTt1xDgA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
        a=dVLDxgSidpLH0of_3jIA:9 a=AjGcO6oz07-iQ99wixmX:22
        a=WzC6qhA0u3u7Ye7llzcV:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

For discussion. This embodies the infrastructure I was suggesting
here:

https://lore.kernel.org/fstests/342381aa-9e1f-f81c-f0e4-a72f70f8ac48@suse.com/T/#m8ff385bb5b8eab9ea5ed5fb45f253fda8b087fcf

Essentially:

hooks/start/generic-001.0

will be run when generic/001 is set up but before the test starts.

hooks/end/generic-001.0

will be run when generic/001 _cleanup() is called but before any
cleanup is done. i.e. we know if the test had a hard failure, but
not whether there was a goldem image mismatch. Global hooks are
named "global.N". The integer suffix is to allow multiple hooks to
be stacked and ordered so we can combins simple hook scripts into
much more complex monitoring setups without having to write a custom
hook for every use case. e.g. a common trace-cmd hook to turn on
trace_printk recording...

In general, hooks/ is intended to contain symlinks to generic hooks
scripts held elsewhere in the git tree. That way we can have common
hooks for doing things like turning tracing on and off, but only
execute them for the tests we want to trace. The current curated
hook scripts can be found in tests/Hooks. It is named with "H"
because then the Makefile automatically skips it when generating
group lists.

The hook scripts run in the full test environment, so can _not_run
and _fail tests. I've stopped them from outputting to stdout so they
don't perturb golden image matches, but they can use $seqres.full
easily enough. Indeed, the trace-cmd hooks I'm currenlty using write
traces to $seqres.trace.dat and $seqres.trace.

Yes, I'm actually using these hooks for trying to get a trace from a
failure that is now occuring 1 in several hundred iterations of
generic/482, and so I need the "-i <n>" based test iterations to
restart the tracing at the start of every test. IOWs, a reason I
was asking for Qu Wenro's basic infrastructure to be made more
functional and usable.

What else do people need these hooks to do?

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 .gitignore                          |   2 +
 common/preamble                     | 104 +++++++++++++++++++++++++++-
 tests/Hooks/trace-cmd-failure-stop  |  18 +++++
 tests/Hooks/trace-cmd-start-xfs     |  11 +++
 tests/Hooks/trace-cmd-start-xfs-log |  11 +++
 tests/Hooks/trace-cmd-stop          |  14 ++++
 tests/generic/482                   |  34 ++++-----
 7 files changed, 177 insertions(+), 17 deletions(-)
 create mode 100644 tests/Hooks/trace-cmd-failure-stop
 create mode 100644 tests/Hooks/trace-cmd-start-xfs
 create mode 100644 tests/Hooks/trace-cmd-start-xfs-log
 create mode 100644 tests/Hooks/trace-cmd-stop

diff --git a/.gitignore b/.gitignore
index 2d72b064..c06cd6d8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -10,6 +10,7 @@ tags
 
 /local.config
 /results
+/hooks
 
 # autogenerated group files
 /tests/*/group.list
@@ -45,6 +46,7 @@ tags
 # custom config files
 /configs/*.config
 
+
 # ltp/ binaries
 /ltp/aio-stress
 /ltp/doio
diff --git a/common/preamble b/common/preamble
index 66b0ed05..7ef7d5b1 100644
--- a/common/preamble
+++ b/common/preamble
@@ -1,13 +1,114 @@
 #!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-1.0
 # Copyright (c) 2021 Oracle.  All Rights Reserved.
+# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
 
 # Boilerplate fstests functionality
 
+# Hooks are scripts that are run at defined events within a test execution.
+# The run in the test environment, so can interact with tests in interesting
+# ways.
+#
+# Start hooks are run once the test environment has been set up but before
+# the test execution starts.
+#
+# End hooks run from the cleanup function of the test but before any cleanup
+# action has been performed. Hence they have access to the entire state of the
+# test at exit and know whether the test has failed or not. Cleanup actions will
+# be run after the hook has completed.
+#
+# Hooks are implemented via a hook_execute() function in the hook script. A hook
+# without such a function will do nothing.
+#
+# The vector that executes the hook can be accessed from the hook script via the
+# $_hook varible. Tests never see this variable, or know that hooks exist.
+#
+# Output from the hook script ends up in the test output file, so hooks need to
+# be silent on stdout otherwise they will cause test failures. Information that
+# hooks want to output should be directed to $seqres.full or there own
+# $seqres.<type> output files. e.g. tracing output could be directed to
+# $seqres.trace, raw trace files to $seqres.trace.dat, etc.
+#
+# Hooks can use _notrun and _fail to prevent a test from running or triggering a
+# hard failure.
+#
+_HOOKS_START="$here/hooks/start"
+_HOOKS_END="$here/hooks/end"
+_HOOKS_SRC="$here/tests/hooks"
+
+_run_hook()
+{
+	local _hook="$1"
+
+	. $_hook
+	hook_execute >> $seqres.full 2>&1
+}
+
+# For start hooks, we run global hooks first, per-test hooks last
+#
+# Per-test hooks are named "<type>-<name>" to reflect the structure of
+# tests/<type>/<name>. e.g. xfs-001 is the hooks for the test in tests/xfs/001
+_run_start_hooks()
+{
+	local n
+	local name_arr
+	local name
+
+	[ -d $_HOOKS_START ] || return
+
+	n=0
+	while [ -e  $_HOOKS_START/global.$n ]; do
+		_run_hook $_HOOKS_START/global.$n
+		n=$((n + 1))
+	done
+
+	# Convert the test name into a hook name. This converts the path name
+	# to a space delimited array, and then uses reverse order indexing to
+	# grab the last two elements of the array as the hook name. Hence
+	# we end up with a name like xfs-001 from ..../tests/xfs/001
+	name_arr=(${0//\//" "})
+	name="${name_arr[-2]}-${name_arr[-1]}"
+
+	n=0
+	while [ -e $_HOOKS_START/$name.$n ]; do
+		_run_hook $_HOOKS_START/$name.$n
+		n=$((n + 1))
+	done
+}
+
+# For end hooks, we run per-test hooks first, global hooks last
+#
+# Per-test hooks are named "<type>-<name>" to reflect the structure of
+# tests/<type>/<name>. e.g. xfs-001 is the hooks for the test in tests/xfs/001
+_run_end_hooks()
+{
+	local n
+	local name_arr
+	local name
+
+	[ -d $_HOOKS_END ] || return
+
+	name_arr=(${0//\//" "})
+	name="${name_arr[-2]}-${name_arr[-1]}"
+	n=0
+	while [ -e $_HOOKS_END/$name.$n ]; do
+		_run_hook $_HOOKS_END/$name.$n
+		n=$((n + 1))
+	done
+
+	n=0
+	while [ -e $_HOOKS_END/global.$n ]; do
+		_run_hook $_HOOKS_END/global.$n
+		n=$((n + 1))
+	done
+}
+
+
 # Standard cleanup function.  Individual tests can override this.
 _cleanup()
 {
 	cd /
+	_run_end_hooks
 	rm -r -f $tmp.*
 }
 
@@ -60,4 +161,5 @@ _begin_fstest()
 	# remove previous $seqres.full before test
 	rm -f $seqres.full
 
+	_run_start_hooks
 }
diff --git a/tests/Hooks/trace-cmd-failure-stop b/tests/Hooks/trace-cmd-failure-stop
new file mode 100644
index 00000000..cf5fae05
--- /dev/null
+++ b/tests/Hooks/trace-cmd-failure-stop
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
+#
+# Basic trace-cmd stop hook to extract traces only on test failure. This will
+# not generate a trace if a golden image match fails, only if the test exits
+# with a non-zero failure code.
+#
+# This will extract the current traces to $seqres.trace.dat, then stop the
+# tracer. It will run a report on the trace data and drop it in $seqres/trace
+hook_execute()
+{
+	echo Running hook $_hook
+	if [ $status -ne 0 ]; then
+		trace-cmd extract -o $seqres.trace.dat
+		trace-cmd report -i $seqres.trace.dat > $seqres.trace
+	fi
+	trace-cmd reset
+}
diff --git a/tests/Hooks/trace-cmd-start-xfs b/tests/Hooks/trace-cmd-start-xfs
new file mode 100644
index 00000000..90e484b1
--- /dev/null
+++ b/tests/Hooks/trace-cmd-start-xfs
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
+#
+# trace-cmd start hook for tracing all XFS
+#
+# This is a memory hog - it reserves 250MB of RAM per CPU for the ring buffer.
+hook_execute()
+{
+	echo Running hook $_hook
+	trace-cmd start -b 250000 -e xfs\* -e xlog\*
+}
diff --git a/tests/Hooks/trace-cmd-start-xfs-log b/tests/Hooks/trace-cmd-start-xfs-log
new file mode 100644
index 00000000..886b707a
--- /dev/null
+++ b/tests/Hooks/trace-cmd-start-xfs-log
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
+#
+# trace-cmd start hook for tracing XFS log events
+#
+# This is a memory hog - it reserves 250MB of RAM per CPU for the ring buffer.
+hook_execute()
+{
+	echo Running hook $_hook
+	trace-cmd start -b 250000 -e xfs_log\* -e xlog\*
+}
diff --git a/tests/Hooks/trace-cmd-stop b/tests/Hooks/trace-cmd-stop
new file mode 100644
index 00000000..402f40ff
--- /dev/null
+++ b/tests/Hooks/trace-cmd-stop
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
+#
+# Basic trace-cmd stop hook
+#
+# This will extract the current traces to $seqres.trace.dat, then stop the
+# tracer. It will run a report on the trace data and drop it in $seqres/trace
+hook_execute()
+{
+	echo Running hook $_hook
+	trace-cmd extract -o $seqres.trace.dat
+	trace-cmd reset
+	trace-cmd report -i $seqres.trace.dat > $seqres.trace
+}
diff --git a/tests/generic/482 b/tests/generic/482
index 416b929a..9db464ba 100755
--- a/tests/generic/482
+++ b/tests/generic/482
@@ -16,29 +16,31 @@ _begin_fstest auto metadata replay thin
 # If debugging logwrites failures using the tools/dm-logwrite-replay script,
 # switch the cleanup function to the version that is commented out below so that
 # failure leaves the corpse intact for post-mortem failure analysis.
-_cleanup()
-{
-	cd /
-	$KILLALL_PROG -KILL -q $FSSTRESS_PROG &> /dev/null
-	_log_writes_cleanup &> /dev/null
-	_dmthin_cleanup
-	rm -f $tmp.*
-}
-
-# tools/dm-logwrite-replay _cleanup version
 #_cleanup()
 #{
 #	cd /
+#	_run_end_hooks
 #	$KILLALL_PROG -KILL -q $FSSTRESS_PROG &> /dev/null
-#	if [ $status -eq 0 ]; then
-#		_log_writes_cleanup &> /dev/null
-#		_dmthin_cleanup
-#	else
-#		echo dm-thinvol-dev: $DMTHIN_VOL_DEV >> $seqres.full
-#	fi
+#	_log_writes_cleanup &> /dev/null
+#	_dmthin_cleanup
 #	rm -f $tmp.*
 #}
 
+# tools/dm-logwrite-replay _cleanup version
+_cleanup()
+{
+	cd /
+	_run_end_hooks
+	$KILLALL_PROG -KILL -q $FSSTRESS_PROG &> /dev/null
+	if [ $status -eq 0 ]; then
+		_log_writes_cleanup &> /dev/null
+		_dmthin_cleanup
+	else
+		echo dm-thinvol-dev: $DMTHIN_VOL_DEV >> $seqres.full
+	fi
+	rm -f $tmp.*
+}
+
 # Import common functions.
 . ./common/filter
 . ./common/dmthin
-- 
2.31.1

