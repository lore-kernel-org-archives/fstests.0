Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CDA22E419
	for <fstests@vger.kernel.org>; Wed, 15 Jan 2025 06:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920988; cv=none; b=e6zDSnjOjH018BFNqZJ/JG/EOLWkdI7AUHg3HVStRhVl54iTpOKfWxSOBAzS+d66bGJNnU9zs+nRJzFelCwYB7x0nHVtvbT7ZMHfVCIlLicAnj0afmaU7Cp+pa0SimqaIQhdFaoWooZGiRyFIlbxRH0wUt5WEP6BOJkho8akpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920988; c=relaxed/simple;
	bh=qK0xXXy6mlcIhjTu+n2GKINd1vjba9DuKS7Bh1j9DLw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkpHGvTIBzzvdFisv+6S+hpOzh2DEpMiiVn1+7ImYwEmvl0KjGCifYGWXRLrZ4XWdJdrD/84DCX4tc53ps5r+6ac64iX4trGjQJggWsln75RWzM8XeGOYXHinLb1h9MP8fcxc2pwjvj+bLqo7o/1wnQAP1iFx1lHpq/QBKuvNGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=bhoLyPT6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="bhoLyPT6"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2166651f752so142562645ad.3
        for <fstests@vger.kernel.org>; Tue, 14 Jan 2025 22:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1736920985; x=1737525785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFk1FWouxMjeQQYaCjTdkGov0cv5f8Ey4Cb2GqdivKo=;
        b=bhoLyPT6d3NQVINIv37Ie8K7eysF0QbPaR5wbw60BvLL901e0mcEvqfDc/ehnSZ7Va
         nuQf0eH6CE2VASoH+WJ7ya2DEtM15wKlQc7IYdsu0BqmeUDNsriAueyqDt7wb+TWtNkj
         hB+UBTUF1TKS6R5MvvKXnFmZip+3QJt6gryP7nJ6WH9EOAB2YbNVpIQKCUTMM4iDuSZA
         x9YaKohxAuYNkZKgrmlyUoPcpSSzyPsyNgXWuAMYrO9KaXYnErpftzKfNkuuZX3MMc6k
         cA0v75fsVJQmH+W6im6aO2zwaAF0t5LxodkIhs50U66TG9xcS57yDOB2oeVpqlQmyFXG
         qkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920985; x=1737525785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFk1FWouxMjeQQYaCjTdkGov0cv5f8Ey4Cb2GqdivKo=;
        b=GisXcSHY/b7b2HDhNpcLdX5kZLQgqoVOU6z2+QHG0itoWBpqVAHBgUHmVB/bWkUQQB
         mctMATeiR78Qc2tMv94rLtTkeJ7fYfMsKmN7jql14lInkG5W5zhrd9waQRbDvu0mYJCB
         C8MFiBM2DJRyV4sdE+JBNc7ImXE63Jr0IbWTSAPiFrdMeuTLZGFnnAk/Mgh/IXJNZ0OQ
         njcSLzfdFCp2TgLs7lpDmQgKzgxCyBXYo8uN6xna6TEZTu1sxT0m04pXJIxy5YKR6yKW
         lKnjigFDrVRFuGbKoinNWSlE8vLaEMJJYcsmSy5y/I6aswYS0HFjAGPEhZKwtRI5GCQY
         M45w==
X-Gm-Message-State: AOJu0YyFEjxckb3SkgUKjVTb/BD5ZAq25iTABFp89bFdLdgFJt7fo3w7
	GRPEUZsCRTE8Q/Aye99mthWKMiYQuyXiEv3cXRM0DAC3NQ58yKY01ZdPWZwy71M7l6+f4YWkOhP
	q
X-Gm-Gg: ASbGncs4MS4IhCGdA7fyKe/Ufmyp+8trJItBmV7yh4LiDJNgE4P1+ApTXi8xfh6pmY/
	Xco1ijXDs8DDVNSDwReKL/6JUZx6/w1R7LcjpUalvUyn0YwhmCVVfV+aSuxGqeUzBRmSrErkR9a
	ppngwX9GxVvG6BE3fRqpRFoBT0sBNF3Ovre4np52gLQxVP5PAsI4HQ5ojO8tEgBZSlwvNLEYVkU
	Y5CPf0yKLa1s4QYcGTJX3ZyY8ZoFzrc6gOyzcXN4CwztOmcXpgTRrIP9Bfn57lmIy7Yw8tZvS6M
	2K8JeR09TJ4zyIEDfGaM8bz5Cvi3R0g=
X-Google-Smtp-Source: AGHT+IEeJ6FbPThuSNvTvCkzCH9j0TuoKc6RZuow/bI8KaxgGRUo18olOKaDpDE/HOpQVYM1MSSGiQ==
X-Received: by 2002:a17:902:f681:b0:215:385e:921c with SMTP id d9443c01a7336-21a8400b31amr355588425ad.51.1736920984873;
        Tue, 14 Jan 2025 22:03:04 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10e0cfsm74886195ad.43.2025.01.14.22.03.03
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 22:03:03 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tXwUW-0000000641Y-1fRS
	for fstests@vger.kernel.org;
	Wed, 15 Jan 2025 17:03:00 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tXwUW-0000000GabO-2Ycm
	for fstests@vger.kernel.org;
	Wed, 15 Jan 2025 17:03:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 2/5] check: factor out test list building code
Date: Wed, 15 Jan 2025 16:51:13 +1100
Message-ID: <20250115060258.3951185-3-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115060258.3951185-1-david@fromorbit.com>
References: <20250115060258.3951185-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

factor out all the test list parsing and building code to
common/test_list so that it can be used by both check and
check-parallel.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check            | 270 +++----------------------------------------
 common/report    |   2 +-
 common/test_list | 295 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 314 insertions(+), 253 deletions(-)
 create mode 100644 common/test_list

diff --git a/check b/check
index 607d2456e..4dc266dcf 100755
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
 
 usage()
 {
@@ -124,153 +119,12 @@ examples:
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
@@ -285,48 +139,20 @@ while [ $# -gt 0 ]; do
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
@@ -344,13 +170,13 @@ while [ $# -gt 0 ]; do
 
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
 
@@ -388,51 +214,6 @@ if [ -n "$FUZZ_REWRITE_DURATION" ]; then
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
@@ -593,21 +374,6 @@ _check_filesystems()
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
@@ -714,7 +480,7 @@ _run_seq() {
 }
 
 _detect_kmemleak
-_prepare_test_list
+_tl_prepare_test_list
 fstests_start_time="$(date +"%F %T")"
 
 if $OPTIONS_HAVE_SECTIONS; then
@@ -794,7 +560,7 @@ function run_section()
 		# TEST_DEV could be changed, source common/rc again with
 		# correct FSTYP to get FSTYP specific configs, e.g. common/xfs
 		. common/rc
-		_prepare_test_list
+		_tl_prepare_test_list
 	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
 		_test_unmount 2> /dev/null
 		if ! _test_mount
@@ -859,7 +625,7 @@ function run_section()
 
 	loop_status=()	# track rerun-on-failure state
 	local tc_status ix
-	local -a _list=( $list )
+	local -a _list=( $_tl_tests )
 	for ((ix = 0; ix < ${#_list[*]}; !${#loop_status[*]} && ix++)); do
 		seq="${_list[$ix]}"
 
@@ -880,7 +646,7 @@ function run_section()
 
 		# the filename for the test and the name output are different.
 		# we don't include the tests/ directory in the name output.
-		export seqnum=${seq#$SRC_DIR/}
+		export seqnum=$(_tl_strip_src_dir $seq)
 		group=${seqnum%%/*}
 		if $OPTIONS_HAVE_SECTIONS; then
 			REPORT_DIR="$RESULT_BASE/$section"
@@ -902,7 +668,7 @@ function run_section()
 		echo -n "$seqnum"
 
 		if $showme; then
-			if _expunge_test $seqnum; then
+			if _tl_expunge_test $seqnum; then
 				tc_status="expunge"
 			else
 				echo
@@ -928,7 +694,7 @@ function run_section()
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

