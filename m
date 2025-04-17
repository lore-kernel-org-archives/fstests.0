Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFF71CAA4
	for <fstests@vger.kernel.org>; Thu, 17 Apr 2025 03:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860546; cv=none; b=kVbK68JyG3ocFCOi0Lx5Xy5GjYHYXE7sZBtQHARUwcM8Z9xTYnTtLHh1l9j1vx/6SqP7jvHoxO3EwqEz6/h2FyT4ZwnMvY3JAR8G91jZ7M8wZX9Je3UD9p/Jx2Eq5TpVIpZrCnCE5MBYP46nrcIsIaUuY3vb8X7DgmBikE6hOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860546; c=relaxed/simple;
	bh=LdYFulhWiCIKBuXS6hHfm6h1TYzTEGnR8YqKhL0qmP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJU7oOmw1MYGgmVKLUNvjFZFdW3O5Ve4fs7dBaYQoH+4JWn31Xs0sRnlGEX4hunVglN0etSGcv+EGaIJJmOgS2PvGoO4uVJ2ncVgrTyh7RZ3DNlD8Xw6nX+c5ac7qzlecTS6KhwISrdeYeS/K3wgYmBUFzLvmbOUKoEcjFNwAUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=rh0sZszq; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="rh0sZszq"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b041afe0ee1so271702a12.1
        for <fstests@vger.kernel.org>; Wed, 16 Apr 2025 20:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744860544; x=1745465344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glOFGwQFlcBV/SF/ja4fqE9k2Gj9eK8JhCN8MjeqxfU=;
        b=rh0sZszqlOFTJfVFZPVQAE5Vv9X7ZHaA4gGWNuLmPqQ+M2S14jJ9QCfKunP5Pmgdvw
         lF41Q6NMjfo0DqFSxWd0bSf+ZJ+6pEZbeE4rwKIABmP5604Q8w77RNG6IVz47cVh3k1F
         bhyH8NY+NwllEGouDv41EXjSK9Rgb4T6taaI3erY5MDix4YlPqtX7nS8ABQmZopZvVqw
         DLSMxOSKU8uKJ8Yei8bcMjBRVuVh6WSYi36RIDkrJncdt8rs2IV4Ae6aA4epsmkrl7Ta
         GbEfNs4QmBzkNmTSOmMc6DUhmvjK+xaXuWPgK/nH/puAJk8hECOrlhWYpigUELtvKTTi
         grFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744860544; x=1745465344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glOFGwQFlcBV/SF/ja4fqE9k2Gj9eK8JhCN8MjeqxfU=;
        b=X79jv8GMi1FhTBZQ1jpJGUUp5uFtpOMK7+MZduywiAj+SxS8gFpULe+ElhHRePErJl
         oWoxedMB4kWSK4igbEk4tfSCkCvBlKGhCdBGohn/A+e5tvY8szds60wqhZc9zE6EWp8i
         Yh9DUByuXK43md7YllEDpgH8NUpFfI5cZSszP//KeYoVAPFSmnlGi3LP/H4NuzsEXsjG
         pllWOjM/S8dpReJ2FhN8p6CJcMsOmUmXLN4xnYTdkW2y4+yr8bDIk4pTg2T3mUAYP/5s
         0S+RI3GGkSH56XMl/O+HCZfmUi1RdVn7JQoFpFl6BEYnqAiidVI0cJqv9bLt7ZJEQAAQ
         I4sA==
X-Gm-Message-State: AOJu0YzULnkZQu7lF3JWHH3SshpmyGKXKXxgZ7iwtJoZLvolGsX+Q3tX
	Hg09tENtAdHxdAUd5Srbd6BHwuqVtuyLgsUgi2JnWaYVAmb+7eRYg+vrrEpNIVKmI93SmGmX+qK
	o
X-Gm-Gg: ASbGncunbgwAycww8b/WjY6NbV6tqLfRkdwaFh6sLrrrQwg/NJg4PBCvhRW1YrzmnKE
	WsfSyYilhMmftNRg8jUnUG3EvFDT2EL7DtSfzvg0DPwOVF0XyETo1ERhUqKACvIyORggvCGT38g
	hr8Ud4OpYTokaKxPXmuQ5ZumPwEvYO+I09nKUKERptapCuWSqbaXTjYJzrzeqIsMW3iWPpJNMbL
	rovVn61ERBGtEG/yMaX6hTmC8mCnalzLVjvRcNcdHiLjkvOxEynKagdUvMdn/mrhujdW1ToBxJ0
	Fl3mJPYg+mqRLDKIc2JdEg7Lu12M3I+mzHSWZ2ygP2Ix2zaI1YZg0H5xhsYdMjLECUn962Bn39Q
	cTw==
X-Google-Smtp-Source: AGHT+IFxYSkGsD5xE7WpWAN4xLo6R3/rnxoeyynyXXau0kYrQ8wTnptHTsPJ6ifHiQk7LWjZAbYNmA==
X-Received: by 2002:a17:90a:d008:b0:2fe:b907:562f with SMTP id 98e67ed59e1d1-30863f1a0c4mr7154219a91.14.1744860543865;
        Wed, 16 Apr 2025 20:29:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611d6171sm2498133a91.2.2025.04.16.20.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 20:29:03 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1u5Ffe-00000009Y9Z-0C4W;
	Thu, 17 Apr 2025 13:12:10 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1u5Ffe-00000007mEF-12xr;
	Thu, 17 Apr 2025 13:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org
Subject: [PATCH 05/28] check: factor out test list building code
Date: Thu, 17 Apr 2025 13:00:46 +1000
Message-ID: <20250417031208.1852171-6-david@fromorbit.com>
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

Factor out all the test list parsing and building code to
common/test_list so that it can be used by both check and
check-parallel.

This also namespaces all the test list code to use _tl_ prefixes,
and adds wrappers to set up test list parsing parameters.

Note: there is still some future work to convert externally visible
parameters like SRC_DIR to the new namespace.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check            | 270 +++----------------------------------------
 common/report    |   2 +-
 common/test_list | 295 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 314 insertions(+), 253 deletions(-)
 create mode 100644 common/test_list

diff --git a/check b/check
index 69866b14b..900ea2ba4 100755
--- a/check
+++ b/check
@@ -15,19 +15,13 @@ notrun=()
 interrupt=true
 diff="diff -u"
 showme=false
-have_test_arg=false
-randomize=false
-exact_order=false
 export here=`pwd`
-xfile=""
-subdir_xfile=""
 brief_test_summary=false
 do_report=false
 DUMP_OUTPUT=false
 iterations=1
 istop=false
 loop_on_fail=0
-exclude_tests=()
 
 # This is a global variable used to pass test failure text to reporting gunk
 _err_msg=""
@@ -49,8 +43,9 @@ timestamp=${TIMESTAMP:=false}
 
 rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
 
-SRC_GROUPS="generic"
-export SRC_DIR="tests"
+# We need to include the test list processing first as argument parsing
+# requires test list parsing and setup.
+. ./common/test_list
 
 . ./common/exit
 
@@ -126,153 +121,12 @@ examples:
 	    exit 1
 }
 
-get_sub_group_list()
-{
-	local d=$1
-	local grp=$2
-
-	test -s "$SRC_DIR/$d/group.list" || return 1
-
-	local grpl=$(sed -n < $SRC_DIR/$d/group.list \
-		-e 's/#.*//' \
-		-e 's/$/ /' \
-		-e "s;^\($VALID_TEST_NAME\).* $grp .*;$SRC_DIR/$d/\1;p")
-	echo $grpl
-}
-
-get_group_list()
-{
-	local grp=$1
-	local grpl=""
-	local sub=$(dirname $grp)
-	local fsgroup="$FSTYP"
-
-	if [ -n "$sub" -a "$sub" != "." -a -d "$SRC_DIR/$sub" ]; then
-		# group is given as <subdir>/<group> (e.g. xfs/quick)
-		grp=$(basename $grp)
-		get_sub_group_list $sub $grp
-		return
-	fi
-
-	if [ "$FSTYP" = ext2 -o "$FSTYP" = ext3 ]; then
-	    fsgroup=ext4
-	fi
-	for d in $SRC_GROUPS $fsgroup; do
-		if ! test -d "$SRC_DIR/$d" ; then
-			continue
-		fi
-		grpl="$grpl $(get_sub_group_list $d $grp)"
-	done
-	echo $grpl
-}
-
-# Find all tests, excluding files that are test metadata such as group files.
-# It matches test names against $VALID_TEST_NAME defined in common/rc
-get_all_tests()
-{
-	touch $tmp.list
-	for d in $SRC_GROUPS $FSTYP; do
-		if ! test -d "$SRC_DIR/$d" ; then
-			continue
-		fi
-		ls $SRC_DIR/$d/* | \
-			grep -v "\..*" | \
-			grep "^$SRC_DIR/$d/$VALID_TEST_NAME"| \
-			grep -v "group\|Makefile" >> $tmp.list 2>/dev/null
-	done
-}
-
-# takes the list of tests to run in $tmp.list, and removes the tests passed to
-# the function from that list.
-trim_test_list()
-{
-	local test_list="$*"
-
-	rm -f $tmp.grep
-	local numsed=0
-	for t in $test_list
-	do
-	    if [ $numsed -gt 100 ]; then
-		grep -v -f $tmp.grep <$tmp.list >$tmp.tmp
-		mv $tmp.tmp $tmp.list
-		numsed=0
-		rm -f $tmp.grep
-	    fi
-	    echo "^$t\$" >>$tmp.grep
-	    numsed=`expr $numsed + 1`
-	done
-	grep -v -f $tmp.grep <$tmp.list >$tmp.tmp
-	mv $tmp.tmp $tmp.list
-	rm -f $tmp.grep
-}
-
 _timestamp()
 {
     local now=`date "+%T"`
     echo -n " [$now]"
 }
 
-_prepare_test_list()
-{
-	unset list
-	# Tests specified on the command line
-	if [ -s $tmp.arglist ]; then
-		cat $tmp.arglist > $tmp.list
-	else
-		touch $tmp.list
-	fi
-
-	# Specified groups to include
-	# Note that the CLI processing adds a leading space to the first group
-	# parameter, so we have to catch that here checking for "all"
-	if ! $have_test_arg && [ "$GROUP_LIST" == " all" ]; then
-		# no test numbers, do everything
-		get_all_tests
-	else
-		for group in $GROUP_LIST; do
-			list=$(get_group_list $group)
-			if [ -z "$list" ]; then
-				echo "Group \"$group\" is empty or not defined?"
-				exit 1
-			fi
-
-			for t in $list; do
-				grep -s "^$t\$" $tmp.list >/dev/null || \
-							echo "$t" >>$tmp.list
-			done
-		done
-	fi
-
-	# Specified groups to exclude
-	for xgroup in $XGROUP_LIST; do
-		list=$(get_group_list $xgroup)
-		if [ -z "$list" ]; then
-			echo "Group \"$xgroup\" is empty or not defined?"
-			continue
-		fi
-
-		trim_test_list $list
-	done
-
-	# sort the list of tests into numeric order unless we're running tests
-	# in the exact order specified
-	if ! $exact_order; then
-		if $randomize; then
-			if type shuf >& /dev/null; then
-				sorter="shuf"
-			else
-				sorter="awk -v seed=$RANDOM -f randomize.awk"
-			fi
-		else
-			sorter="cat"
-		fi
-		list=`sort -n $tmp.list | uniq | $sorter`
-	else
-		list=`cat $tmp.list`
-	fi
-	rm -f $tmp.list
-}
-
 # Process command arguments first.
 while [ $# -gt 0 ]; do
 	case "$1" in
@@ -287,48 +141,20 @@ while [ $# -gt 0 ]; do
 		export OVERLAY=true
 		;;
 
-	-g)	group=$2 ; shift ;
-		GROUP_LIST="$GROUP_LIST ${group//,/ }"
-		;;
+	-g)	_tl_setup_group $2 ; shift ;;
+	-e)	_tl_setup_exclude_tests $2 ; shift ;;
+	-E)	_tl_setup_exclude_file $2 ; shift ;;
+	-x)	_tl_setup_exclude_group $2; shift ;;
+	-X)	_tl_setup_exclude_subdir $2; shift ;;
+	-r)	_tl_setup_randomise ;;
+	--exact-order) _tl_setup_ordered ;;
 
-	-x)	xgroup=$2 ; shift ;
-		XGROUP_LIST="$XGROUP_LIST ${xgroup//,/ }"
-		;;
-
-	-X)	subdir_xfile=$2; shift ;
-		;;
-	-e)
-		xfile=$2; shift ;
-		readarray -t -O "${#exclude_tests[@]}" exclude_tests < \
-			<(echo "$xfile" | tr ', ' '\n\n')
-		;;
-
-	-E)	xfile=$2; shift ;
-		if [ -f $xfile ]; then
-			readarray -t -O ${#exclude_tests[@]} exclude_tests < \
-				<(sed "s/#.*$//" $xfile)
-		fi
-		;;
 	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
 	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
 	-l)	diff="diff" ;;
 	-udiff)	diff="$diff -u" ;;
 
 	-n)	showme=true ;;
-	-r)
-		if $exact_order; then
-			echo "Cannot specify -r and --exact-order."
-			exit 1
-		fi
-		randomize=true
-		;;
-	--exact-order)
-		if $randomize; then
-			echo "Cannnot specify --exact-order and -r."
-			exit 1
-		fi
-		exact_order=true
-		;;
 	-i)	iterations=$2; shift ;;
 	-I) 	iterations=$2; istop=true; shift ;;
 	-T)	timestamp=true ;;
@@ -346,13 +172,13 @@ while [ $# -gt 0 ]; do
 
 	-*)	usage ;;
 	*)	# not an argument, we've got tests now.
-		have_test_arg=true ;;
+		_tl_setup_cli $*
 	esac
 
 	# if we've found a test specification, the break out of the processing
 	# loop before we shift the arguments so that this is the first argument
 	# that we process in the test arg loop below.
-	if $have_test_arg; then
+	if $_tl_have_test_args; then
 		break;
 	fi
 
@@ -392,51 +218,6 @@ if [ -n "$FUZZ_REWRITE_DURATION" ]; then
 	fi
 fi
 
-if [ -n "$subdir_xfile" ]; then
-	for d in $SRC_GROUPS $FSTYP; do
-		[ -f $SRC_DIR/$d/$subdir_xfile ] || continue
-		for f in `sed "s/#.*$//" $SRC_DIR/$d/$subdir_xfile`; do
-			exclude_tests+=($d/$f)
-		done
-	done
-fi
-
-# Process tests from command line now.
-if $have_test_arg; then
-	while [ $# -gt 0 ]; do
-		case "$1" in
-		-*)	echo "Arguments before tests, please!"
-			status=1
-			exit $status
-			;;
-		*)	# Expand test pattern (e.g. xfs/???, *fs/001)
-			list=$(cd $SRC_DIR; echo $1)
-			for t in $list; do
-				t=${t#$SRC_DIR/}
-				test_dir=${t%%/*}
-				test_name=${t##*/}
-				group_file=$SRC_DIR/$test_dir/group.list
-
-				if grep -Eq "^$test_name" $group_file; then
-					# in group file ... OK
-					echo $SRC_DIR/$test_dir/$test_name \
-						>>$tmp.arglist
-				else
-					# oops
-					echo "$t - unknown test, ignored"
-				fi
-			done
-			;;
-		esac
-
-		shift
-	done
-elif [ -z "$GROUP_LIST" ]; then
-	# default group list is the auto group. If any other group or test is
-	# specified, we use that instead.
-	GROUP_LIST="auto"
-fi
-
 if [ `id -u` -ne 0 ]
 then
     echo "check: QA must be run as root"
@@ -597,21 +378,6 @@ _check_filesystems()
 	return $ret
 }
 
-_expunge_test()
-{
-	local TEST_ID="$1"
-
-	for f in "${exclude_tests[@]}"; do
-		# $f may contain traling spaces and comments
-		local id_regex="^${TEST_ID}\b"
-		if [[ "$f" =~ ${id_regex} ]]; then
-			echo "       [expunged]"
-			return 0
-		fi
-	done
-	return 1
-}
-
 # retain files which would be overwritten in subsequent reruns of the same test
 _stash_fail_loop_files() {
 	local seq_prefix="${REPORT_DIR}/${1}"
@@ -719,7 +485,7 @@ _run_seq() {
 }
 
 _detect_kmemleak
-_prepare_test_list
+_tl_prepare_test_list
 fstests_start_time="$(date +"%F %T")"
 
 if $OPTIONS_HAVE_SECTIONS; then
@@ -793,7 +559,7 @@ function run_section()
 		# common/rc again with correct FSTYP to get FSTYP specific configs,
 		# e.g. common/xfs
 		. common/rc
-		_prepare_test_list
+		_tl_prepare_test_list
 	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
 		# Unmount TEST_DEV to apply the updated mount options.
 		# It will be mounted again by init_rc(), called shortly after.
@@ -854,13 +620,13 @@ function run_section()
 
 	loop_status=()	# track rerun-on-failure state
 	local tc_status ix
-	local -a _list=( $list )
+	local -a _list=( $_tl_tests )
 	for ((ix = 0; ix < ${#_list[*]}; !${#loop_status[*]} && ix++)); do
 		seq="${_list[$ix]}"
 
 		# the filename for the test and the name output are different.
 		# we don't include the tests/ directory in the name output.
-		export seqnum=${seq#$SRC_DIR/}
+		export seqnum=$(_tl_strip_src_dir $seq)
 		group=${seqnum%%/*}
 		if $OPTIONS_HAVE_SECTIONS; then
 			REPORT_DIR="$RESULT_BASE/$section"
@@ -882,7 +648,7 @@ function run_section()
 		echo -n "$seqnum"
 
 		if $showme; then
-			if _expunge_test $seqnum; then
+			if _tl_expunge_test $seqnum; then
 				tc_status="expunge"
 			else
 				echo
@@ -908,7 +674,7 @@ function run_section()
 		rm -f $seqres.out.bad $seqres.hints
 
 		# check if we really should run it
-		if _expunge_test $seqnum; then
+		if _tl_expunge_test $seqnum; then
 			tc_status="expunge"
 			_stash_test_status "$seqnum" "$tc_status"
 			continue
diff --git a/common/report b/common/report
index 7128bbeba..5697d2540 100644
--- a/common/report
+++ b/common/report
@@ -196,7 +196,7 @@ _xunit_make_testcase_report()
 		echo -e "\t\t<skipped/>" >> $report
 		;;
 	"fail")
-		local out_src="${SRC_DIR}/${test_name}.out"
+		local out_src="${_tl_src_dir}/${test_name}.out"
 		local full_file="${REPORT_DIR}/${test_name}.full"
 		local dmesg_file="${REPORT_DIR}/${test_name}.dmesg"
 		local outbad_file="${REPORT_DIR}/${test_name}.out.bad"
diff --git a/common/test_list b/common/test_list
new file mode 100644
index 000000000..2432be6f7
--- /dev/null
+++ b/common/test_list
@@ -0,0 +1,295 @@
+##/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2000-2002,2006 Silicon Graphics, Inc.  All Rights Reserved.
+# Copyright (c) 2024 Red Hat, Inc.  All Rights Reserved.
+#
+# Test list parsing and building functions
+#
+# Note: this file must stand alone and not be dependent on any other includes,
+# most especially common/rc and common/config. This is because we have to
+# include this file before option parsing, whilst the rc/config includes need to
+# be included -after- option parsing.
+#
+# Any function or variable that is public should have a "_tl_" prefix.
+
+export _tl_src_dir="tests"
+
+_SRC_GROUPS="generic"
+_GROUP_LIST=
+_XGROUP_LIST=
+_tl_exact_order=false
+_tl_randomise=false
+_tl_have_test_args=false
+_tl_file="$tmp.test_list"
+_tl_exclude_tests=()
+_tl_tests=
+
+_tl_strip_src_dir()
+{
+	local test="$1"
+
+	echo ${test#$_tl_src_dir/}
+}
+
+get_sub_group_list()
+{
+	local d=$1
+	local grp=$2
+
+	test -s "$_tl_src_dir/$d/group.list" || return 1
+
+	local grpl=$(sed -n < $_tl_src_dir/$d/group.list \
+		-e 's/#.*//' \
+		-e 's/$/ /' \
+		-e "s;^\($VALID_TEST_NAME\).* $grp .*;$_tl_src_dir/$d/\1;p")
+	echo $grpl
+}
+
+get_group_list()
+{
+	local grp=$1
+	local grpl=""
+	local sub=$(dirname $grp)
+	local fsgroup="$FSTYP"
+
+	if [ -n "$sub" -a "$sub" != "." -a -d "$_tl_src_dir/$sub" ]; then
+		# group is given as <subdir>/<group> (e.g. xfs/quick)
+		grp=$(basename $grp)
+		get_sub_group_list $sub $grp
+		return
+	fi
+
+	if [ "$FSTYP" = ext2 -o "$FSTYP" = ext3 ]; then
+	    fsgroup=ext4
+	fi
+	for d in $_SRC_GROUPS $fsgroup; do
+		if ! test -d "$_tl_src_dir/$d" ; then
+			continue
+		fi
+		grpl="$grpl $(get_sub_group_list $d $grp)"
+	done
+	echo $grpl
+}
+
+# Find all tests, excluding files that are test metadata such as group files.
+# It matches test names against $VALID_TEST_NAME defined in common/rc
+get_all_tests()
+{
+	touch $tmp.list
+	for d in $_SRC_GROUPS $FSTYP; do
+		if ! test -d "$_tl_src_dir/$d" ; then
+			continue
+		fi
+		ls $_tl_src_dir/$d/* | \
+			grep -v "\..*" | \
+			grep "^$_tl_src_dir/$d/$VALID_TEST_NAME"| \
+			grep -v "group\|Makefile" >> $tmp.list 2>/dev/null
+	done
+}
+
+# takes the list of tests to run in $tmp.list, and removes the tests passed to
+# the function from that list.
+trim_test_list()
+{
+	local test_list="$*"
+
+	rm -f $tmp.grep
+	local numsed=0
+	for t in $test_list
+	do
+	    if [ $numsed -gt 100 ]; then
+		grep -v -f $tmp.grep <$tmp.list >$tmp.tmp
+		mv $tmp.tmp $tmp.list
+		numsed=0
+		rm -f $tmp.grep
+	    fi
+	    echo "^$t\$" >>$tmp.grep
+	    numsed=`expr $numsed + 1`
+	done
+	grep -v -f $tmp.grep <$tmp.list >$tmp.tmp
+	mv $tmp.tmp $tmp.list
+	rm -f $tmp.grep
+}
+
+_tl_prepare_test_list()
+{
+	unset _tl_tests
+	# Tests specified on the command line
+	if [ -s $_tl_file ]; then
+		cat $_tl_file > $tmp.list
+	else
+		touch $tmp.list
+	fi
+
+	# Specified groups to include
+	# Note that the CLI processing adds a leading space to the first group
+	# parameter, so we have to catch that here checking for "all"
+	if ! $_tl_have_test_args && [ "$_GROUP_LIST" == " all" ]; then
+		# no test numbers, do everything
+		get_all_tests
+	else
+		for group in $_GROUP_LIST; do
+			list=$(get_group_list $group)
+			if [ -z "$list" ]; then
+				echo "Group \"$group\" is empty or not defined?"
+				exit 1
+			fi
+
+			for t in $list; do
+				grep -s "^$t\$" $tmp.list >/dev/null || \
+							echo "$t" >>$tmp.list
+			done
+		done
+	fi
+
+	# Specified groups to exclude
+	for xgroup in $_XGROUP_LIST; do
+		list=$(get_group_list $xgroup)
+		if [ -z "$list" ]; then
+			echo "Group \"$xgroup\" is empty or not defined?"
+			continue
+		fi
+
+		trim_test_list $list
+	done
+
+	# sort the list of tests into numeric order unless we're running tests
+	# in the exact order specified
+	if ! $_tl_exact_order; then
+		if $_tl_randomise; then
+			if type shuf >& /dev/null; then
+				sorter="shuf"
+			else
+				sorter="awk -v seed=$RANDOM -f randomize.awk"
+			fi
+		else
+			sorter="cat"
+		fi
+		_tl_tests=`sort -n $tmp.list | uniq | $sorter`
+	else
+		_tl_tests=`cat $tmp.list`
+	fi
+	rm -f $tmp.list
+}
+
+_tl_expunge_test()
+{
+	local TEST_ID="$1"
+
+	for f in "${_tl_exclude_tests[@]}"; do
+		# $f may contain traling spaces and comments
+		local id_regex="^${TEST_ID}\b"
+		if [[ "$f" =~ ${id_regex} ]]; then
+			echo "       [expunged]"
+			return 0
+		fi
+	done
+	return 1
+}
+
+_tl_setup_exclude_tests()
+{
+	local list="$1"
+
+	readarray -t -O "${#_tl_exclude_tests[@]}" _tl_exclude_tests < \
+		<(echo "$list" | tr ', ' '\n\n')
+}
+
+_tl_setup_exclude_file()
+{
+	local xfile="$1"
+
+	if [ -f $xfile ]; then
+		readarray -t -O ${#_tl_exclude_tests[@]} _tl_exclude_tests < \
+			<(sed "s/#.*$//" $xfile)
+	fi
+}
+
+_tl_setup_exclude_subdir()
+{
+	local xfile="$1"
+	local d
+	local f
+
+	[ -z "$xfile" ] && return
+
+	for d in $_SRC_GROUPS $FSTYP; do
+		[ -f $_tl_src_dir/$d/$xfile ] || continue
+		for f in `sed "s/#.*$//" $_tl_src_dir/$d/$xfile`; do
+			_tl_exclude_tests+=($d/$f)
+		done
+	done
+}
+
+_tl_setup_exclude_group()
+{
+	local xgroup="$1"
+
+	_XGROUP_LIST="$_XGROUP_LIST ${xgroup//,/ }"
+}
+
+_tl_setup_group()
+{
+	local group="$1"
+
+	_GROUP_LIST="$_GROUP_LIST ${group//,/ }"
+}
+
+_tl_setup_randomise()
+{
+	if $_tl_exact_order; then
+		echo "Cannot specify -r and --exact-order."
+		exit 1
+	fi
+	_tl_randomise=true
+}
+
+_tl_setup_ordered()
+{
+	if $_tl_randomise; then
+		echo "Cannnot specify --exact-order and -r."
+		exit 1
+	fi
+	_tl_exact_order=true
+}
+
+_tl_setup_cli()
+{
+	while [ $# -gt 0 ]; do
+		case "$1" in
+		-*)	echo "Arguments before tests, please!"
+			status=1
+			exit $status
+			;;
+		*)	# Expand test pattern (e.g. xfs/???, *fs/001)
+			local list=$(cd $_tl_src_dir; echo $1)
+			local t
+
+			for t in $list; do
+				t=${t#$_tl_src_dir/}
+				local test_dir=${t%%/*}
+				local test_name=${t##*/}
+				local group_file=$_tl_src_dir/$test_dir/group.list
+
+				if grep -Eq "^$test_name" $group_file; then
+					# in group file ... OK
+					echo $_tl_src_dir/$test_dir/$test_name \
+						>> $_tl_file
+					_tl_have_test_args=true
+				else
+					# oops
+					echo "$t - unknown test, ignored"
+				fi
+			done
+			;;
+		esac
+
+		shift
+	done
+
+	if ! $_tl_have_test_args && [ -z "$_GROUP_LIST" ]; then
+		# default group list is the auto group. If any other group or
+		# test is specified, we use that instead.
+		_GROUP_LIST="auto"
+	fi
+}
-- 
2.45.2

