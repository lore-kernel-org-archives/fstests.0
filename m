Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D3D1CAA4
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860579; cv=none; b=NEr6kJQFsLvK328rK38Q2oGv1uHHKGudQXQ/brwweNGVRSbzvTijX4X9PjRQufhNZBSmRJJ7gVTkuYOVmYibBQmh6fqWxismjEYK5EEmLb/H/WZ0UeluA3mTeKB0XyUL3mcLXBAOkSOSNlTc8zuZfjgFFPUPzU5f6gcYltC3qFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860579; c=relaxed/simple;
	bh=vNZYwXeB3gvjNMKZShCQqxncxqLNnrxKjhC+iaA4pRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpThvseaFS3h7gr7C7SIBvQO6HXlSjBvmbTzbrZsuoL2/uBCVXYr8XXK8/JtR7N4xcuNe1508CaXEKlIbthZaUVWYHdjtGUjR/3PKJUlQezd/wEnlibHHJhIXcQRrgd0318lN6WyQPs22Rc6m+9MKU860YHMWlBvXfb6TLOdrkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=kNGFnyUy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="kNGFnyUy"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7376e311086so353870b3a.3
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744860576; x=1745465376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqO7F8O8UdvgOyGbqyLyB+BYhunQS2J/ZdU0ImlcQ1A=;
        b=kNGFnyUy4yRDAWTf/xICJ8wcUi8YqD2AgEb2uIE0/gpk7N+OFYIBGYTULS1C3yeOcC
         e60m/gsS9S1ASPr4XptQ7AiOANeEhhNxJ5BXZJyGcv13U85rQIp4sYf9Co0M1OKAah0j
         CmLZLd/tw53tV0rB/GAWUFaEeYXdFSHPDepwGN4Zb/tsX/OenaG7i2eGuq2V93GQD2m5
         aElnGxHZE5xsbdw2WSlapTWOz1TeRMy77hDihzX/xTM37WhZJ5vaIv9f2g/bt1W84s0c
         4Mf5zPWaXd2CIP24uAIkekUsvnlpcwcfqKRTKy0KNzoDK2w9OQIym1ZqRel2tsFWrqOa
         CEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744860576; x=1745465376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqO7F8O8UdvgOyGbqyLyB+BYhunQS2J/ZdU0ImlcQ1A=;
        b=ka+MB+0/7tNpeeVIzeErNtTce6XsVmxb7bsXJIPms9ferfbk4OVMeLCazfjHLUSJmL
         qjoBEHwpUt+zb43wf8qVXE6xqNvaGHYomCy9IH8TxVouLAkEIhTQczVlbWLC7DPUhBhY
         YDj4AVwoGOh3n/ZZgoRRkuGpk0Ql3RXBewVZWrYgJx3THbxOZdMGjXdvPzU4aI1Yj9BI
         8jZviqJgdXfUBrmrtBr/NInv10kphPImOtfYJvwyb4SrpekliPYbMyZQ5AN1BM6A0HGM
         RjkC1Cw+clSzIVOlOL4BoYhTEs2/SFmdQuXAKd6KrZrOJ53RkbMdkblgniifB+m12txv
         +jcQ==
X-Gm-Message-State: AOJu0YxXeCvCeHGrN2OtqyvVfVF2CBZnGkOTGEzy4bl/6R6w4kHW4hnN
	X6XHun9v08kD2ZBpZofdhcdZBf1i5Xa7t9iiSZgcyknKP2Z3y47CVPaHjf2mtbjvA/Y5ZGLIn7d
	p
X-Gm-Gg: ASbGnctLnvhh/EURHz3uCeAmFRoHM0iIm3HJy0kEBklbgx1chcRL2GHu4jA/y4H4yDw
	ibEKD+E38WOGIARjJZ39sqULFdXXW+ULcyMAT+nYABJ+TK1POCtpecB2AnSuIHtJ2IA/XBHb4+t
	YeraIqF6WuNtvotVOd+sd41YSsdpYVcst3N3DJgo2WRDWF3lxYy7UKwBPf9VS4njyvLQqhS7zRQ
	lMG6JVX9bXqUp5vrfc1io1jUHRsNs3YjhOMIzWjo6HjQmmLQQwWddWhVqkLNu9MKOyCHP7Y53lb
	zkLqyEJgPmegdwRB6Ae85mE3PaNwZOQgk6pFEnHRdgEdl3qicXgHIcceAAPVQPlha5mx1xvEU0F
	yjA==
X-Google-Smtp-Source: AGHT+IFmzeKCVwAd8+bKegM4l5O5vlKYgAHI1ktrh7iA0WJrvGtpj9y7BZehnhLUSkjtu/iyMKpADQ==
X-Received: by 2002:a05:6a20:c6ca:b0:1fa:9819:c0a5 with SMTP id adf61e73a8af0-203b3e8fb33mr5765671637.11.1744860576483;
        Wed, 16 Apr 2025 20:29:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e4d4sm11263468b3a.153.2025.04.16.20.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:29:35 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009YAc-2Le4;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mFT-3ARg;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 20/28] [RFC] check-parallel: run tests directly without using check
Date: Thu, 17 Apr 2025 13:01:01 +1000
Message-ID: <20250417031208.1852171-21-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250417031208.1852171-1-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Now that we've factored the code that runs individual tests out of
check, we can start using it in check-parallel instead of calling
check to do so.

I originally thought that:

	We can do this by implementing a _run_seq() callback that runs the
	individual test in it's own private namespace, using the generic
	test execution and status tracking to record what happens with each
	test that is run by a given runner.

	This allows the runner to destage a test at a time from the global
	list and execute it in a batched setup, all without requiring us
	to run check for each test.

But, no, no we can't do that. We have to mount the test filesystem
inside the new private mount namespace context, otherwise all the
other runner contexts see it and we reintroduce shared mount
namespace problems...

Hence we need a helper script that sets up the test device and does
all that admin stuff before it starts grabbing tests from the test
list. This means that multiple tests will run inside the runner's
private namespace; the helper is really now a very minimal version
of check....

This requires that check-parallel also sets up the required
environment for all tests to run in. We can do this now simply by
sourcing common/config as this now sets up and exports the entire
environment that tests rely on.

Note: this change is mainly for RFC purposes right now - it still
needs more cleanup and probably some splitting up before it is ready
to go. I'm including it more as a informational "this is why various
factoring and rearrangement has been done" patch than a full review
request...

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check             |  29 ++----------
 check-parallel    |  75 ++++++++++++------------------
 common/config     |   6 +++
 common/rc         |   2 +
 common/test_exec  |  29 +++++++++++-
 common/test_list  |   6 +++
 tests/xfs/271     |   2 -
 tools/run_test.sh | 116 ++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 191 insertions(+), 74 deletions(-)
 create mode 100755 tools/run_test.sh

diff --git a/check b/check
index 106de0ee6..f032f9c48 100755
--- a/check
+++ b/check
@@ -25,15 +25,6 @@ _err_msg=""
 # start the initialisation work now
 iam=check.$$
 
-# mkfs.xfs uses the presence of both of these variables to enable formerly
-# supported tiny filesystem configurations that fstests use for fuzz testing
-# in a controlled environment
-export MSGVERB="text:action"
-export QA_CHECK_FS=${QA_CHECK_FS:=true}
-
-# number of diff lines from a failed test, 0 for whole output
-export DIFF_LENGTH=${DIFF_LENGTH:=10}
-
 rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
 
 . ./common/exit
@@ -188,6 +179,10 @@ fi
 # by default don't output timestamps
 _te_emit_timestamps=${TIMESTAMP:=}
 
+# number of diff lines from a failed test, 0 for whole output
+_te_diff_length=${DIFF_LENGTH:=10}
+
+
 # If the test config specified a soak test duration, see if there are any
 # unit suffixes that need converting to an integer seconds count.
 if [ -n "$SOAK_DURATION" ]; then
@@ -245,21 +240,7 @@ _wrapup()
 		fi
 		needwrap=false
 	elif $needwrap; then
-		if [ -f $check.time -a -f $tmp.time ]; then
-			cat $check.time $tmp.time  \
-				| $AWK_PROG '
-				{ t[$1] = $2 }
-				END {
-					if (NR > 0) {
-						for (i in t) print i " " t[i]
-					}
-				}' \
-				| sort -n >$tmp.out
-			mv $tmp.out $check.time
-			if $OPTIONS_HAVE_SECTIONS; then
-				cp $check.time ${REPORT_DIR}/check.time
-			fi
-		fi
+		_te_time_report
 		set +x
 
 		_global_log ""
diff --git a/check-parallel b/check-parallel
index 1b67709a2..be3dfd346 100755
--- a/check-parallel
+++ b/check-parallel
@@ -18,13 +18,13 @@ run_section=""
 exclude_section=""
 iam="check-parallel"
 
-tmp=/tmp/check-parallel.$$
-test_list="$tmp.test_list"
+export here=`pwd`
 
 . ./common/exit
 . ./common/test_names
 . ./common/test_list
 . ./common/config-sections
+. ./common/config
 
 usage()
 {
@@ -155,6 +155,18 @@ elif [ -d "$basedir/runner-0/" ]; then
 	prev_results=`ls -tr $basedir/runner-0/ | grep results | tail -1`
 fi
 
+# We keep the test list in the base directory because it needs to be common
+# across all test runners and their private namespaces. Because runners execute
+# in private /tmp/ instances, we can't keep it there, so use the shared
+# $basedir that hosts all the runners as the location of the test list.
+test_list="$basedir/test_list"
+
+# Similarly, set our tmp dir to be under the shared basedir so that all the
+# temp files that stuff like test execution use for expunge lists work
+# appropriately.
+export tmp="$basedir/tmp/check-parallel.$$"
+mkdir -p $basedir/tmp
+
 # grab all previously run tests and order them from highest runtime to lowest
 # We are going to try to run the longer tests first, hopefully so we can avoid
 # massive thundering herds trying to run lots of really short tests in parallel
@@ -219,22 +231,6 @@ setup_test_list()
 	echo $_tl_tests |sed -e 's/ /\n/g' | tac > $test_list
 }
 
-# Grab the next test to be run from the tail of the file.
-# Returns an empty string if there is no tests remaining to run.
-# File operations are run under flock so concurrent gets are serialised against
-# each other.
-get_next_test()
-{
-	local test_file="$test_list.$1"
-	local test=
-
-	flock 99
-	test=$(tail -1 $test_file)
-	sed -i "\,$test,d" $test_file
-	flock -u 99
-	echo $test
-}
-
 
 _create_loop_device()
 {
@@ -260,32 +256,6 @@ _destroy_loop_device()
         losetup -d $dev || _fail "Cannot destroy loop device $dev"
 }
 
-run_tests()
-{
-	local section="$1"
-	local logfile="$2"
-
-	exec 99<>$tmp.test_list_lock
-
-	local test_to_run=$(get_next_test $section)
-
-	# Run the tests in it's own mount namespace, as per the comment below
-	# that precedes making the basedir a private mount.
-	#
-	# Similarly, we need to run check in it's own PID namespace so that
-	# operations like pkill only affect the runner instance, not globally
-	# kill processes from other check instances.
-	while [ -n "$test_to_run" ]; do
-		echo -n " $test_to_run "
-		unset FSTESTS_ISOL
-		if ! _tl_expunge_test $test_to_run; then
-			tools/run_privatens ./check -s $section $test_to_run >> $logfile 2>&1
-		fi
-
-		test_to_run=$(get_next_test $section)
-	done
-}
-
 runner_go()
 {
 
@@ -301,6 +271,8 @@ runner_go()
 	local _results=$me/results-$2
 	local section=$3
 
+	export tmp=/tmp/check-parallel-runner-$id
+
 	mkdir -p $me
 
 	xfs_io -f -c "truncate $TEST_DEV_SIZE" $_test
@@ -323,6 +295,7 @@ runner_go()
 
 	export LOGWRITES_DEV=$(_create_loop_device $_logwrites)
 	export RESULT_BASE=$_results
+	export REPORT_DIR="$RESULT_BASE/$section"
 
 	mkdir -p $TEST_DIR
 	mkdir -p $SCRATCH_MNT
@@ -338,7 +311,7 @@ runner_go()
 
 #	export DUMP_CORRUPT_FS=1
 
-	run_tests $section $_results/log
+	tools/run_test.sh $basedir $test_list.$section >> $_results/log 2>&1
 
 	wait
 	sleep 1
@@ -351,6 +324,7 @@ runner_go()
 	_destroy_loop_device $SCRATCH_RTDEV
 	_destroy_loop_device $SCRATCH_LOGDEV
 	_destroy_loop_device $LOGWRITES_DEV
+	rm -f $tmp.*
 
 	grep -q Failures: $_results/log
 	if [ $? -eq 0 ]; then
@@ -366,6 +340,7 @@ run_section()
 	local now="$2"
 	local results="$basedir/*/results-$now"
 	local i
+	local threads=$runners
 
 	echo $run_section |grep -qw $section || return
 	echo $exclude_section |grep -qw $section && return
@@ -391,7 +366,15 @@ run_section()
 	fi
 	cp $test_list $test_list.$section
 
-	for ((i = 0; i < $runners; i++)); do
+	# only run as many runners are there are tests to run
+	i=$(cat $test_list.$section | wc -l)
+	if [ "$i" -lt "$runners" ]; then
+		threads=$i
+	fi
+
+	echo Test list $test_list.$section contains $i tests
+	echo Running $threads tests concurrently
+	for ((i = 0; i < $threads; i++)); do
 		runner_go $i $now $section &
 	done
 	wait
diff --git a/common/config b/common/config
index b93a6c0d3..149ef99c7 100644
--- a/common/config
+++ b/common/config
@@ -70,6 +70,12 @@ export LOAD_FACTOR=${LOAD_FACTOR:=1}
 export SOAK_DURATION=${SOAK_DURATION:=}
 export DEBUGFS_MNT=${DEBUGFS_MNT:="/sys/kernel/debug"}
 
+# mkfs.xfs uses the presence of both of these variables to enable formerly
+# supported tiny filesystem configurations that fstests use for fuzz testing
+# in a controlled environment
+export MSGVERB="text:action"
+export QA_CHECK_FS=${QA_CHECK_FS:=true}
+
 # some constants for overlayfs setup
 export OVL_UPPER="ovl-upper"
 export OVL_LOWER="ovl-lower"
diff --git a/common/rc b/common/rc
index be6cd92c4..5b7d2faf8 100644
--- a/common/rc
+++ b/common/rc
@@ -2936,6 +2936,8 @@ _require_xfs_io_command()
 			_notrun "O_TMPFILE is not supported"
 		;;
 	"fsmap")
+		df -h >> $seqres.full 2>&1
+		df -i >> $seqres.full 2>&1
 		testio=`$XFS_IO_PROG -f -c "fsmap" $testfile 2>&1`
 		echo $testio | grep -q "Inappropriate ioctl" && \
 			_notrun "xfs_io $command support is missing"
diff --git a/common/test_exec b/common/test_exec
index 63efa3d19..e9c80bd59 100644
--- a/common/test_exec
+++ b/common/test_exec
@@ -21,6 +21,12 @@ _te_notrun=()
 _te_loop_status=()
 _te_emit_timestamps=""
 _te_dry_run=""
+_te_diff_length=10
+
+# This is needed because callers don't always source common/report and
+# if $do_report is undefined or true we'll try to call _make_testcase_report()
+# without it being defined.
+do_report=false
 
 _te_wipe_counters()
 {
@@ -43,6 +49,25 @@ _te_timestamp()
 	fi
 }
 
+_te_time_report()
+{
+	if [ -f $check.time -a -f $tmp.time ]; then
+		cat $check.time $tmp.time  \
+			| $AWK_PROG '
+			{ t[$1] = $2 }
+			END {
+				if (NR > 0) {
+					for (i in t) print i " " t[i]
+				}
+			}' \
+			| sort -n >$tmp.out
+		mv $tmp.out $check.time
+		if $OPTIONS_HAVE_SECTIONS; then
+			cp $check.time ${REPORT_DIR}/check.time
+		fi
+	fi
+}
+
 _te_check_filesystems()
 {
 	local ret=0
@@ -330,10 +355,10 @@ _te_run_test()
 		_dump_err "- output mismatch (see $seqres.out.bad)"
 		mv $tmp.out $seqres.out.bad
 		$diff $seq.out $seqres.out.bad | {
-		if test "$DIFF_LENGTH" -le 0; then
+		if test "$_te_diff_length" -le 0; then
 			cat
 		else
-			head -n "$DIFF_LENGTH"
+			head -n "$_te_diff_length"
 			echo "..."
 			echo "(Run '$diff $here/$seq.out $seqres.out.bad'" \
 				" to see the entire diff)"
diff --git a/common/test_list b/common/test_list
index 092b3ed17..4beb08b22 100644
--- a/common/test_list
+++ b/common/test_list
@@ -160,6 +160,11 @@ _tl_prepare_test_list()
 		trim_test_list $list
 	done
 
+	# Remove expunged tests
+	for f in "${_tl_exclude_tests[@]}"; do
+		trim_test_list tests/$f
+	done
+
 	# sort the list of tests into numeric order unless we're running tests
 	# in the exact order specified
 	if ! $_tl_exact_order; then
@@ -194,6 +199,7 @@ _tl_expunge_test()
 	return 1
 }
 
+
 _tl_setup_exclude_tests()
 {
 	local list="$1"
diff --git a/tests/xfs/271 b/tests/xfs/271
index 8a71746d6..ae4599282 100755
--- a/tests/xfs/271
+++ b/tests/xfs/271
@@ -22,8 +22,6 @@ _cleanup()
 _require_xfs_scratch_rmapbt
 _require_xfs_io_command "fsmap"
 
-rm -f "$seqres.full"
-
 echo "Format and mount"
 _scratch_mkfs > "$seqres.full" 2>&1
 _scratch_mount
diff --git a/tools/run_test.sh b/tools/run_test.sh
new file mode 100755
index 000000000..75f7a7dcd
--- /dev/null
+++ b/tools/run_test.sh
@@ -0,0 +1,116 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
+#
+# Test run helper for check-parallel
+#
+# check-parallel sets up all the devices and environments needs to run tests,
+# but we can't set up for a test until we are executing in a private pid/mount
+# namespace.
+#
+# This means we cannot simply run the test itself in a private name space; they
+# require things like the test device to already be mounted, and we require a
+# private mount namespace before we start mounting devices.
+#
+# Hence we need a helper that first creates a private namespace, then
+# does all the setup work for tests to run, then iterates tests until there
+# are no more tests to run.
+#
+# The tests to run are held in a shared file in $basedir so that we set up
+# a private /tmp for the namespace and no lose access to the test list.
+
+# re-execute in a private namespace as a first step
+if [ -z "${FSTESTS_ISOL}" ]; then
+	if [ -z "$1" ] || [ "$1" = "--help" ]; then
+		echo "Usage: $0 basedir test_list "
+		exit 1
+	fi
+
+	if [ ! -d "$1" ]; then
+		echo "invalid basedir ($1) specified"
+		exit 1
+	fi
+
+	FSTESTS_ISOL=privatens exec "$(dirname "$0")/../src/nsexec" -z -m -p "$0" "$@"
+	exit $?
+fi
+
+# Everything past this point runs in a private namespace.
+#
+# We set up private mounts for /proc and /tmp so they aren't visible outside
+# this mount namespace and it's children.
+for path in /proc /tmp; do
+	mountpoint "$path" >/dev/null && \
+		mount --make-private "$path"
+done
+mount -t proc proc /proc
+mount -t tmpfs tmpfs /tmp
+
+echo $PWD $FSTYP
+
+. ./common/exit
+. ./common/test_names
+. ./common/test_list
+. ./common/test_exec
+. ./common/rc
+
+basedir="$1"
+test_file="$2"
+_te_diff_length=${DIFF_LENGTH:=10}
+export tmp=/tmp/run-helper.$$
+
+# XXX: should be a _te_diff variable
+diff='diff -u'
+
+# Grab the next test to be run from the tail of the file.
+# Returns an empty string if there is no tests remaining to run.
+# File operations are run under flock so concurrent gets are serialised against
+# each other.
+get_next_test()
+{
+	local test=
+
+	flock 99
+	test=$(tail -1 $test_file)
+	sed -i "\,$test,d" $test_file
+	flock -u 99
+	echo $test
+}
+
+_run_seq()
+{
+	./$seq
+	return $?
+}
+
+exec 99<>$test_file.lock
+
+# XXX - refactor this back to a test_exec variable
+check="$RESULT_BASE/check"
+touch $check.time
+
+init_rc
+
+test_to_run=$(get_next_test)
+while [ -n "$test_to_run" ]; do
+	_te_run_test "tests/$test_to_run"
+
+	test_to_run=$(get_next_test)
+done
+
+_te_time_report
+
+if ((${#_te_try[*]} > 0)); then
+	echo "Ran: ${_te_try[*]}"
+fi
+
+if ((${#_te_notrun[*]} > 0)); then
+	echo "Not run: ${_te_notrun[*]}"
+fi
+
+if ((${#_te_bad[*]} > 0)); then
+	echo "Failures: ${_te_bad[*]}"
+	echo "Failed ${#_te_bad[*]} of ${#_te_try[*]} tests"
+else
+	echo "Passed all ${#_te_try[*]} tests"
+fi
-- 
2.45.2

