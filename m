Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B531CAA4
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860564; cv=none; b=ZMECzoNgcYbiOE1Hkqry6nXpaqGnQEA3fXo1/tU2s1cBrgLhcwRgMC0VRvJrxEpMvu1BXHbomxejQtkLV5ujP+qnkdiPBt7GJ+IlzOdjgz7ySxqj1yqdRccMO0MfAWFoAlYS2aFLakF99rKS91Bn/n529+goG9dZqbYef0j8LdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860564; c=relaxed/simple;
	bh=2f0wkogR3tRNvVAv9cmWrR10xkSbgbH/p4LEyIXYyPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IL9el+nTQ1leifD2tkzUeHudYIF/G08exmndLSS0ap5WKwXUwuKRIgyyGEE5MU+ZZUgv2o1FHeBD49p2mJn0wCfUMD5wsBLSL38FPgxlQfSWNAExWdVp22tozxdNkM0/IV2EX3i73JEcH9pu0pNe0sIkLnXYmV1FrkFvEH3ZTeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=al3+rxqo; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="al3+rxqo"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso342016b3a.2
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744860562; x=1745465362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51ru1r4DBQII/qwGr9ofnJbyFKu0cP9v8CrxnzMTy7o=;
        b=al3+rxqoLW0haiaAO0PAQP/HJl2td3TXUhWoXj1UNbHmgX6yhopXa4g3u3jFqBYiHo
         KFnMQAa0RgBpUdqkHot1D0HVuUeOslYNVZYFl68UeWS7GVK+ofdIpwBDNLVefCG/zB/U
         M/EMa/fO/PrsYGoIJ8tDGqBI8qUy6EqFZB8Frl+yOIN7n5mT+m53h3/h6m2oPB/MNEHZ
         m6i+jHs3eta5+eqcQzfNCyrm8bgbeJo0pPlT3B0SYR0fNT1iOzzxOYyi1ADwLYTSgs4x
         5MLgytLY9bANo7jryoIRsfeLv0ODzq1QqClQO6TUHkwqSEdaaDr+OLLFgT9UXKyN/IMS
         Qf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744860562; x=1745465362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51ru1r4DBQII/qwGr9ofnJbyFKu0cP9v8CrxnzMTy7o=;
        b=HB/s9cvir2ZpDaxzMt/GCzxpLsc3uwK8tC2NMGsF5wVyEVX2g3+BNSSUkJcJe44PVN
         PyvfO/lUigRvxK/0cuGeidVsQ+cksD1kb7ylizGOFlvYhvlSY2BA3p6K0BUoUOu3m/uh
         zTBd1RLXOJ0/0an00+a6B76GV6a8FtLjTYV7k2w3Ukg/dZlaff14F6ToU46M2TnPu0ix
         59jZcLSb73RHM5bcVJzaKj9b6wP0eNeV3ad1Mo8mw+Ee5fZBmZu3TeUHDealkfmlZIdx
         F7Tnr0/y7EQxzoH6dtGvBE6Y4O51g0SCcdsdwyAebWyQPq9C8+LyHufxS6bMCvoNdW/Q
         F6hg==
X-Gm-Message-State: AOJu0YzR5NTIKNKyVh+LoTEZ29ijJHmE+aKVSb79Q1H8Wnxtg0qa2+OM
	SHqfaBXo+CJ3+V3zJVD2wEbhUjyyYsv3CTWV6+r8kd0kj9+BQnXqQyrr6U1yjFFlWnOm6wgyqCH
	5
X-Gm-Gg: ASbGncuv2442dN3Z3MBI9ebQnPnegRNfwz+/ZrUxGUJxxBL0QvQOUtUS9E9CLNmDlqP
	3oRUCuE0wZHUqWPeEGZ2RYqjdFk/F6bkI/PHp+XcbpudwMYFpSA8/wbW00M8O8zYVUnwPnK5f/e
	wsZGACJkcGr4vokv7Sa2SbrhjXgSZ4oaQ2wbbJxAVXyfExsOzo5Lejqypmj+ZBK3HAYcSGbzFD6
	JDmXm6LSzVy0IYKuECjVRnox6aU/HXq5D/wg+pEQXkTNQA6ltA37ZamNFkejI0NhwH05ZvB6i0r
	7QadcK4hDk/1AEKM8f5FkhSMJLFGBQErTWPf50Jlh0cK50JonqhszlsYf4KinSCyGvy+o5nzeCu
	I/g==
X-Google-Smtp-Source: AGHT+IH+mS24YYVaBoSjbNcZCgmJ939X69QtfGorpsVaCArBAaso+VgWgLeSUxBFfpMbtMDYFbQHhA==
X-Received: by 2002:a05:6a00:2d29:b0:736:43d6:f008 with SMTP id d2e1a72fcca58-73c267206aamr6008184b3a.12.1744860561872;
        Wed, 16 Apr 2025 20:29:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c20f3sm11216161b3a.39.2025.04.16.20.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:29:21 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009Y9b-0HuT;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mEL-1Bh1;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 06/28] check-parallel: use common group list parsing code
Date: Thu, 17 Apr 2025 13:00:47 +1000
Message-ID: <20250417031208.1852171-7-david@fromorbit.com>
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

Build the test list directly from command line prompts, rather
than hard coding the tests and using the check infrastructure to
filter that list.

We still pass exact test lists to check to execute the tests that
each runner needs to execute, but all other test list commands
are no longer passed to check.

As a result of this change, check-parallel no longer passes unknown
CLI parameters through to the internal check invocations. At this
point, the only non test-list related option is config file section
selection; more of the check options will be brought across as
needed in future patches.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check            |   6 +-
 check-parallel   | 156 ++++++++++++++++++++++++++++++++++++++++-------
 common/test_list |   7 +++
 3 files changed, 143 insertions(+), 26 deletions(-)

diff --git a/check b/check
index 900ea2ba4..0b489cb4b 100755
--- a/check
+++ b/check
@@ -43,11 +43,9 @@ timestamp=${TIMESTAMP:=false}
 
 rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
 
-# We need to include the test list processing first as argument parsing
-# requires test list parsing and setup.
-. ./common/test_list
-
 . ./common/exit
+. ./common/test_names
+. ./common/test_list
 
 usage()
 {
diff --git a/check-parallel b/check-parallel
index d68d76e55..cb5d6aedf 100755
--- a/check-parallel
+++ b/check-parallel
@@ -9,18 +9,114 @@
 # for them and runs the test in the background. When it completes, it tears down
 # the loop devices.
 
-export SRC_DIR="tests"
-basedir=$1
-shift
-check_args="$*"
+basedir=""
 runners=64
 runner_list=()
 runtimes=()
+show_test_list=
+run_section=""
 
+tmp=/tmp/check-parallel.$$
 
-# tests in auto group
-test_list=$(awk '/^[0-9].*auto/ { print "generic/" $1 }' tests/generic/group.list)
-test_list+=$(awk '/^[0-9].*auto/ { print "xfs/" $1 }' tests/xfs/group.list)
+export FSTYP=xfs
+
+. ./common/exit
+. ./common/test_names
+. ./common/test_list
+
+usage()
+{
+    echo "Usage: $0 [options] [testlist]"'
+
+check options
+    -D <dir>		Directory to run in
+    -n			Output test list, do not run tests
+    -r			randomize test order
+    --exact-order	run tests in the exact order specified
+    -s section		run only specified section from config file
+
+testlist options
+    -g group[,group...]	include tests from these groups
+    -x group[,group...]	exclude tests from these groups
+    -X exclude_file	exclude individual tests
+    -e testlist         exclude a specific list of tests
+    -E external_file	exclude individual tests
+    [testlist]		include tests matching names in testlist
+
+testlist argument is a list of tests in the form of <test dir>/<test name>.
+
+<test dir> is a directory under tests that contains a group file,
+with a list of the names of the tests in that directory.
+
+<test name> may be either a specific test file name (e.g. xfs/001) or
+a test file name match pattern (e.g. xfs/*).
+
+group argument is either a name of a tests group to collect from all
+the test dirs (e.g. quick) or a name of a tests group to collect from
+a specific tests dir in the form of <test dir>/<group name> (e.g. xfs/quick).
+If you want to run all the tests in the test suite, use "-g all" to specify all
+groups.
+
+exclude_file argument refers to a name of a file inside each test directory.
+for every test dir where this file is found, the listed test names are
+excluded from the list of tests to run from that test dir.
+
+external_file argument is a path to a single file containing a list of tests
+to exclude in the form of <test dir>/<test name>.
+
+examples:
+ check-parallel -D /mnt xfs/001
+ check-parallel -D /mnt -g quick
+ check-parallel -D /mnt -g xfs/quick
+ check-parallel -D /mnt -x stress xfs/*
+ check-parallel -D /mnt -X .exclude -g auto
+ check-parallel -D /mnt -E ~/.xfstests.exclude
+'
+	    exit 1
+}
+
+# Process command arguments first.
+while [ $# -gt 0 ]; do
+	case "$1" in
+	-\? | -h | --help) usage ;;
+
+	-D)	basedir=$2; shift ;;
+	-g)	_tl_setup_group $2 ; shift ;;
+	-e)	_tl_setup_exclude_tests $2 ; shift ;;
+	-E)	_tl_setup_exclude_file $2 ; shift ;;
+	-x)	_tl_setup_exclude_group $2; shift ;;
+	-X)	_tl_setup_exclude_subdir $2; shift ;;
+	-r)	_tl_setup_randomise ;;
+	--exact-order) _tl_setup_ordered ;;
+	-n)	show_test_list="yes" ;;
+
+	-s)	run_section="$run_section -s $2"; shift ;;
+
+	-*)	usage ;;
+	*)	# not an argument, we've got tests now.
+		_tl_setup_cli $*
+	esac
+
+	# if we've found a test specification, the break out of the processing
+	# loop before we shift the arguments so that this is the first argument
+	# that we process in the test arg loop below.
+	if $_tl_have_test_args; then
+		break;
+	fi
+
+	shift
+done
+
+if [ ! -d "$basedir" ]; then
+	echo "Invalid basedir specification"
+	usage
+fi
+if [ -d "$basedir/runner-0/" ]; then
+	prev_results=`ls -tr $basedir/runner-0/ | grep results | tail -1`
+fi
+
+_tl_prepare_test_list
+_tl_strip_test_list
 
 # grab all previously run tests and order them from highest runtime to lowest
 # We are going to try to run the longer tests first, hopefully so we can avoid
@@ -30,25 +126,23 @@ test_list+=$(awk '/^[0-9].*auto/ { print "xfs/" $1 }' tests/xfs/group.list)
 #
 # If we have tests in the test list that don't have runtimes recorded, then
 # append them to be run last.
-
-build_runner_list()
+time_order_test_list()
 {
 	local runtimes
 	local run_list=()
-	local prev_results=`ls -tr $basedir/runner-0/ | grep results | tail -1`
 
 	runtimes=$(cat $basedir/*/$prev_results/check.time | sort -k 2 -nr | cut -d " " -f 1)
 
 	# Iterate the timed list first. For every timed list entry that
 	# is found in the test_list, add it to the local runner list.
 	local -a _list=( $runtimes )
-	local -a _tlist=( $test_list )
+	local -a _tlist=( $_tl_tests )
 	local rx=0
 	local ix
 	local jx
 	#set -x
 	for ((ix = 0; ix < ${#_list[*]}; ix++)); do
-		echo $test_list | grep -q ${_list[$ix]}
+		echo $_tl_tests | grep -q ${_list[$ix]}
 		if [ $? == 0 ]; then
 			# add the test to the new run list and remove
 			# it from the remaining test list.
@@ -60,24 +154,27 @@ build_runner_list()
 
 	# The final test list is all the time ordered tests followed by
 	# all the tests we didn't find time records for.
-	test_list="${run_list[*]} ${_tlist[*]}"
+	_tl_tests="${run_list[*]} ${_tlist[*]}"
 }
 
-if [ -f $basedir/runner-0/results/check.time ]; then
-	build_runner_list
+if ! $_tl_randomise -a ! $_tl_exact_order; then
+	if [ -f $basedir/runner-0/$prev_results/check.time ]; then
+		time_order_test_list
+	fi
 fi
 
 # split the list amongst N runners
-
 split_runner_list()
 {
 	local ix
 	local rx
-	local -a _list=( $test_list )
+	local -a _list=( $_tl_tests )
 	for ((ix = 0; ix < ${#_list[*]}; ix++)); do
 		seq="${_list[$ix]}"
 		rx=$((ix % $runners))
-		runner_list[$rx]+="${_list[$ix]} "
+		if ! _tl_expunge_test $seq; then
+			runner_list[$rx]+="${_list[$ix]} "
+		fi
 		#echo $seq
 	done
 }
@@ -137,7 +234,7 @@ runner_go()
 
 	# Run the tests in it's own mount namespace, as per the comment below
 	# that precedes making the basedir a private mount.
-	./src/nsexec -m ./check $check_args -x unreliable_in_parallel --exact-order ${runner_list[$id]} > $me/log 2>&1
+	./src/nsexec -m ./check $run_section -x unreliable_in_parallel --exact-order ${runner_list[$id]} > $me/log 2>&1
 
 	wait
 	sleep 1
@@ -165,6 +262,13 @@ cleanup()
 
 trap "cleanup; exit" HUP INT QUIT TERM
 
+split_runner_list
+if [ -n "$show_test_list" ]; then
+	echo Time ordered test list:
+	echo $_tl_tests
+	echo
+fi
+
 
 # Each parallel test runner needs to only see it's own mount points. If we
 # leave the basedir as shared, then all tests see all mounts and then we get
@@ -178,15 +282,23 @@ trap "cleanup; exit" HUP INT QUIT TERM
 # in it's own mount namespace so that they cannot see mounts that other tests
 # are performing.
 mount --make-private $basedir
-split_runner_list
+
 now=`date +%Y-%m-%d-%H:%M:%S`
 for ((i = 0; i < $runners; i++)); do
 
-	runner_go $i $now &
+	if [ -n "$show_test_list" ]; then
+		echo "Runner $i: ${runner_list[$i]}"
+	else
+		runner_go $i $now &
+	fi
 
 done;
 wait
 
+if [ -n "$show_test_list" ]; then
+	exit 0
+fi
+
 echo -n "Tests run: "
 grep Ran $basedir/*/log | sed -e 's,^.*:,,' -e 's, ,\n,g' | sort | uniq | wc -l
 
@@ -198,7 +310,7 @@ grep Failures: $basedir/*/log | uniq | sed -e "s/^.*Failures://" -e "s,\([0-9]\)
 echo
 
 echo Ten slowest tests - runtime in seconds:
-cat $basedir/*/results/check.time | sort -k 2 -nr | head -10
+cat $basedir/*/results-$now/check.time | sort -k 2 -nr | head -10
 
 echo
 echo Cleanup on Aisle 5?
diff --git a/common/test_list b/common/test_list
index 2432be6f7..2b3ae9fbf 100644
--- a/common/test_list
+++ b/common/test_list
@@ -24,6 +24,7 @@ _tl_file="$tmp.test_list"
 _tl_exclude_tests=()
 _tl_tests=
 
+# strip 'tests\' prefix from the provided test name
 _tl_strip_src_dir()
 {
 	local test="$1"
@@ -31,6 +32,12 @@ _tl_strip_src_dir()
 	echo ${test#$_tl_src_dir/}
 }
 
+# strip 'tests\' prefix from all the tests in the test list
+_tl_strip_test_list()
+{
+	_tl_tests=$(echo $_tl_tests | sed -e "s/$_tl_src_dir\///g")
+}
+
 get_sub_group_list()
 {
 	local d=$1
-- 
2.45.2

