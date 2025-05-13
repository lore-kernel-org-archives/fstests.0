Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850A1A23B7
	for <fstests@vger.kernel.org>; Tue, 13 May 2025 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147730; cv=none; b=OyzlOdNBMU4OyWBaWH7J8FDYcgHMJi9rnxTdfo8vLTfu30cb9lXwglkgzWT/ZRCiUUQ5zFPT982jiXz/yLLHuPynlf19ifZ9i4Z04DAJ9mj0EUhIZbQhwKfk3PV7q9mOaOUWwtoiajF3pST9/IgWHiLDo8pB8EFHVv364sJ6mcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147730; c=relaxed/simple;
	bh=LhDbPMjqPGun3EOlbOT51uGnh7nwnYxPVcPudSjAdb0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=MK8XlqH7zvBd3ecsJkeFFnpcbgZmB0YB6ljTUeFeY2FVq2eeOgnvlqjMzT3y8tXSwpGTe+gMhVnPqApuzJwx9H6LR4UUhjNISpUxq0WaScQdVlrkTr3p1jS4QA+kOarSwAKOvt/becIUwLeYbG6SEzqCnRXSQeewjh6c7jzSg3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHcn1wWI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHcn1wWI"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22c33e4fdb8so48893735ad.2
        for <fstests@vger.kernel.org>; Tue, 13 May 2025 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747147726; x=1747752526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6VNRg/yA90EL/HRrCgDQCcZhWesygUkxehcANxTB04=;
        b=iHcn1wWI0p3nSA1CntnsKyC4GWej9X2LQCqP+hNiUTXwDOcKVUUa+PZIKwlXoML3qn
         m9AR0E8PwwTHRrZZjhd/1JW1GDL8cshBmoZCFraMOg4i4b68R8hv3+w7GHtwHgHCo2/i
         1pamzTAx2s6pg6dzqMDIkyTUyEr20Yhuaz04r7ANn/nhuSPcA/SROGDuRRmyvmf0DWF7
         sZPdDAZDLObtOESuYvWmH8LImWMwJYf9DAB4Iqpan8LI9h7uNU+C5C3lVCd29qeVlzV/
         N+8k2DXoVVNygzraVJ2ptngJSmTjbS0+HBzhXYcO3WyaoDwW5KadvvabefbU5L4EwcUk
         0+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747147726; x=1747752526;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t6VNRg/yA90EL/HRrCgDQCcZhWesygUkxehcANxTB04=;
        b=ZTwIEMdojICOqQYY3awXVdj4sXYY3JJChtyYoJ7wy4As5XNWheNaxajkfJeWqk0tcQ
         1QD520z/szEy9JZBqbLq4nZdKdQDW7PKy+nUgaKXhWW4tSJo+G+kDPVGlua81dlqpmpm
         6ql0DoxOtXBe4Tnk3rbfmfoWZSCxkgUOZH567Eo0IB/KHUU+gernn3OTU1zT21SSjQrp
         zNc1JLX0Oe4UhuF7XCbPT3ZtH7PI/g0kULRy40T5QzkR4fktrPA66re6WW6TnkJWf/uC
         BGcIIgtmF+Vl0NR4YIsuD9xIYujqD4c6wuQyTbM3kilSHuDnbAP2jrNXq4HCkXNIeinr
         sktA==
X-Forwarded-Encrypted: i=1; AJvYcCXd1mcyhRqMsIa3KjJFh5Z44Z+NNN3rrBCvh8JH3US19xa080HRn+HM/LSU1fwalNLXSxDOnHEs@vger.kernel.org
X-Gm-Message-State: AOJu0YxZrmYpD5nBVyxzetErZSD8MeEbjBQybGkJf+G/uL+iOMRriAHG
	I9bT3CmckuVEYaQYIyifooUE0SGx1YmqPTHTFhQPTlPkUuN45toX
X-Gm-Gg: ASbGncvD7nn1iiA8tuewk9wX3QIbk00z+YsnCHhFDaTI//6hWEbFShQzFEfqUfSD6DR
	8Ui2JoZoN0j8GWnsE5BLAoYM50k1cvFcjwSLT77gSi8RSm6iFGPJNwkgxx1qben8UfAx3GAYsHB
	Pdo0F5vXBKulzr2wXS/ibO3nGVu72c7BSf/a3vDUR9Ne2ugiC7EFFh0f/ukjT+x5AaI9O/4WYm9
	4yGMnil3oH03a8tO0eL2e3iI+f/DZDeGYHBZAPviljTLLk0cxw+xmDCus7ocPSE08en6fkxpM/+
	BGwfgCP1YxO2ZAVbXPkO2zNr4Qm+GKr1yCFgNBrI7Jqr+8PQCyJct6mDyl/rFeqLsuGtV037uPm
	fleE7dHCEhya4cGLK99MG1o2qrigw
X-Google-Smtp-Source: AGHT+IGY350l9ExttI2snMu7IhDvory0e8Xa3lyELY9/Ez9z0cPQjWo4AZzpTsNTPNiWkqFdUBOOfg==
X-Received: by 2002:a17:902:f68e:b0:224:826:279e with SMTP id d9443c01a7336-22fc91c1d12mr226739155ad.50.1747147725891;
        Tue, 13 May 2025 07:48:45 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7544d86sm82232265ad.47.2025.05.13.07.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 07:48:45 -0700 (PDT)
Message-ID: <1fca5a3bb70431290ab0c9e62b3b7681ba4f1126.camel@gmail.com>
Subject: Re: [PATCH 20/28] [RFC] check-parallel: run tests directly without
 using check
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Tue, 13 May 2025 20:18:41 +0530
In-Reply-To: <20250417031208.1852171-21-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-21-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-04-17 at 13:01 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Now that we've factored the code that runs individual tests out of
> check, we can start using it in check-parallel instead of calling
> check to do so.
> 
> I originally thought that:
> 
> 	We can do this by implementing a _run_seq() callback that runs the
> 	individual test in it's own private namespace, using the generic
> 	test execution and status tracking to record what happens with each
> 	test that is run by a given runner.
> 
> 	This allows the runner to destage a test at a time from the global
> 	list and execute it in a batched setup, all without requiring us
> 	to run check for each test.
> 
> But, no, no we can't do that. We have to mount the test filesystem
> inside the new private mount namespace context, otherwise all the
> other runner contexts see it and we reintroduce shared mount
> namespace problems...
And earlier before this patch, we were using tools/run_privatens to direcly invoke check in a
private namespace and then let check do the rest of the work. Now, since check-parallel is moving
away from check, it is the responsibility of the check-parallel to setup a private namespace, then
setup the devices in the private namespace, then run the test and finally get the results. Am I
correct?
> 
> Hence we need a helper script that sets up the test device and does
> all that admin stuff before it starts grabbing tests from the test
> list. This means that multiple tests will run inside the runner's
> private namespace; the helper is really now a very minimal version
> of check....
> 
> This requires that check-parallel also sets up the required
> environment for all tests to run in. We can do this now simply by
> sourcing common/config as this now sets up and exports the entire
> environment that tests rely on.
> 
> Note: this change is mainly for RFC purposes right now - it still
> needs more cleanup and probably some splitting up before it is ready
> to go. I'm including it more as a informational "this is why various
> factoring and rearrangement has been done" patch than a full review
> request...
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  check             |  29 ++----------
>  check-parallel    |  75 ++++++++++++------------------
>  common/config     |   6 +++
>  common/rc         |   2 +
>  common/test_exec  |  29 +++++++++++-
>  common/test_list  |   6 +++
>  tests/xfs/271     |   2 -
>  tools/run_test.sh | 116 ++++++++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 191 insertions(+), 74 deletions(-)
>  create mode 100755 tools/run_test.sh
> 
> diff --git a/check b/check
> index 106de0ee6..f032f9c48 100755
> --- a/check
> +++ b/check
> @@ -25,15 +25,6 @@ _err_msg=""
>  # start the initialisation work now
>  iam=check.$$
>  
> -# mkfs.xfs uses the presence of both of these variables to enable formerly
> -# supported tiny filesystem configurations that fstests use for fuzz testing
> -# in a controlled environment
> -export MSGVERB="text:action"
> -export QA_CHECK_FS=${QA_CHECK_FS:=true}
> -
> -# number of diff lines from a failed test, 0 for whole output
> -export DIFF_LENGTH=${DIFF_LENGTH:=10}
> -
>  rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
>  
>  . ./common/exit
> @@ -188,6 +179,10 @@ fi
>  # by default don't output timestamps
>  _te_emit_timestamps=${TIMESTAMP:=}
>  
> +# number of diff lines from a failed test, 0 for whole output
> +_te_diff_length=${DIFF_LENGTH:=10}
> +
> +
>  # If the test config specified a soak test duration, see if there are any
>  # unit suffixes that need converting to an integer seconds count.
>  if [ -n "$SOAK_DURATION" ]; then
> @@ -245,21 +240,7 @@ _wrapup()
>  		fi
>  		needwrap=false
>  	elif $needwrap; then
> -		if [ -f $check.time -a -f $tmp.time ]; then
> -			cat $check.time $tmp.time  \
> -				| $AWK_PROG '
> -				{ t[$1] = $2 }
> -				END {
> -					if (NR > 0) {
> -						for (i in t) print i " " t[i]
> -					}
> -				}' \
> -				| sort -n >$tmp.out
> -			mv $tmp.out $check.time
> -			if $OPTIONS_HAVE_SECTIONS; then
> -				cp $check.time ${REPORT_DIR}/check.time
> -			fi
> -		fi
> +		_te_time_report
>  		set +x
>  
>  		_global_log ""
> diff --git a/check-parallel b/check-parallel
> index 1b67709a2..be3dfd346 100755
> --- a/check-parallel
> +++ b/check-parallel
> @@ -18,13 +18,13 @@ run_section=""
>  exclude_section=""
>  iam="check-parallel"
>  
> -tmp=/tmp/check-parallel.$$
> -test_list="$tmp.test_list"
> +export here=`pwd`
>  
>  . ./common/exit
>  . ./common/test_names
>  . ./common/test_list
>  . ./common/config-sections
> +. ./common/config
>  
>  usage()
>  {
> @@ -155,6 +155,18 @@ elif [ -d "$basedir/runner-0/" ]; then
>  	prev_results=`ls -tr $basedir/runner-0/ | grep results | tail -1`
>  fi
>  
> +# We keep the test list in the base directory because it needs to be common
> +# across all test runners and their private namespaces. Because runners execute
> +# in private /tmp/ instances, we can't keep it there, so use the shared
> +# $basedir that hosts all the runners as the location of the test list.
> +test_list="$basedir/test_list"
> +
> +# Similarly, set our tmp dir to be under the shared basedir so that all the
> +# temp files that stuff like test execution use for expunge lists work
> +# appropriately.
> +export tmp="$basedir/tmp/check-parallel.$$"
> +mkdir -p $basedir/tmp
> +
>  # grab all previously run tests and order them from highest runtime to lowest
>  # We are going to try to run the longer tests first, hopefully so we can avoid
>  # massive thundering herds trying to run lots of really short tests in parallel
> @@ -219,22 +231,6 @@ setup_test_list()
>  	echo $_tl_tests |sed -e 's/ /\n/g' | tac > $test_list
>  }
>  
> -# Grab the next test to be run from the tail of the file.
> -# Returns an empty string if there is no tests remaining to run.
> -# File operations are run under flock so concurrent gets are serialised against
> -# each other.
> -get_next_test()
> -{
> -	local test_file="$test_list.$1"
> -	local test=
> -
> -	flock 99
> -	test=$(tail -1 $test_file)
> -	sed -i "\,$test,d" $test_file
> -	flock -u 99
> -	echo $test
> -}
> -
>  
>  _create_loop_device()
>  {
> @@ -260,32 +256,6 @@ _destroy_loop_device()
>          losetup -d $dev || _fail "Cannot destroy loop device $dev"
>  }
>  
> -run_tests()
> -{
> -	local section="$1"
> -	local logfile="$2"
> -
> -	exec 99<>$tmp.test_list_lock
> -
> -	local test_to_run=$(get_next_test $section)
> -
> -	# Run the tests in it's own mount namespace, as per the comment below
> -	# that precedes making the basedir a private mount.
> -	#
> -	# Similarly, we need to run check in it's own PID namespace so that
> -	# operations like pkill only affect the runner instance, not globally
> -	# kill processes from other check instances.
> -	while [ -n "$test_to_run" ]; do
> -		echo -n " $test_to_run "
> -		unset FSTESTS_ISOL
> -		if ! _tl_expunge_test $test_to_run; then
> -			tools/run_privatens ./check -s $section $test_to_run >> $logfile 2>&1
> -		fi
> -
> -		test_to_run=$(get_next_test $section)
> -	done
> -}
> -
>  runner_go()
>  {
>  
> @@ -301,6 +271,8 @@ runner_go()
>  	local _results=$me/results-$2
>  	local section=$3
>  
> +	export tmp=/tmp/check-parallel-runner-$id
> +
>  	mkdir -p $me
>  
>  	xfs_io -f -c "truncate $TEST_DEV_SIZE" $_test
> @@ -323,6 +295,7 @@ runner_go()
>  
>  	export LOGWRITES_DEV=$(_create_loop_device $_logwrites)
>  	export RESULT_BASE=$_results
> +	export REPORT_DIR="$RESULT_BASE/$section"
>  
>  	mkdir -p $TEST_DIR
>  	mkdir -p $SCRATCH_MNT
> @@ -338,7 +311,7 @@ runner_go()
>  
>  #	export DUMP_CORRUPT_FS=1
>  
> -	run_tests $section $_results/log
> +	tools/run_test.sh $basedir $test_list.$section >> $_results/log 2>&1
>  
>  	wait
>  	sleep 1
> @@ -351,6 +324,7 @@ runner_go()
>  	_destroy_loop_device $SCRATCH_RTDEV
>  	_destroy_loop_device $SCRATCH_LOGDEV
>  	_destroy_loop_device $LOGWRITES_DEV
> +	rm -f $tmp.*
>  
>  	grep -q Failures: $_results/log
>  	if [ $? -eq 0 ]; then
> @@ -366,6 +340,7 @@ run_section()
>  	local now="$2"
>  	local results="$basedir/*/results-$now"
>  	local i
> +	local threads=$runners
>  
>  	echo $run_section |grep -qw $section || return
>  	echo $exclude_section |grep -qw $section && return
> @@ -391,7 +366,15 @@ run_section()
>  	fi
>  	cp $test_list $test_list.$section
>  
> -	for ((i = 0; i < $runners; i++)); do
> +	# only run as many runners are there are tests to run
> +	i=$(cat $test_list.$section | wc -l)
> +	if [ "$i" -lt "$runners" ]; then
> +		threads=$i
> +	fi
> +
> +	echo Test list $test_list.$section contains $i tests
> +	echo Running $threads tests concurrently
> +	for ((i = 0; i < $threads; i++)); do
>  		runner_go $i $now $section &
>  	done
>  	wait
> diff --git a/common/config b/common/config
> index b93a6c0d3..149ef99c7 100644
> --- a/common/config
> +++ b/common/config
> @@ -70,6 +70,12 @@ export LOAD_FACTOR=${LOAD_FACTOR:=1}
>  export SOAK_DURATION=${SOAK_DURATION:=}
>  export DEBUGFS_MNT=${DEBUGFS_MNT:="/sys/kernel/debug"}
>  
> +# mkfs.xfs uses the presence of both of these variables to enable formerly
> +# supported tiny filesystem configurations that fstests use for fuzz testing
> +# in a controlled environment
> +export MSGVERB="text:action"
> +export QA_CHECK_FS=${QA_CHECK_FS:=true}
> +
>  # some constants for overlayfs setup
>  export OVL_UPPER="ovl-upper"
>  export OVL_LOWER="ovl-lower"
> diff --git a/common/rc b/common/rc
> index be6cd92c4..5b7d2faf8 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2936,6 +2936,8 @@ _require_xfs_io_command()
>  			_notrun "O_TMPFILE is not supported"
>  		;;
>  	"fsmap")
> +		df -h >> $seqres.full 2>&1
> +		df -i >> $seqres.full 2>&1
>  		testio=`$XFS_IO_PROG -f -c "fsmap" $testfile 2>&1`
>  		echo $testio | grep -q "Inappropriate ioctl" && \
>  			_notrun "xfs_io $command support is missing"
> diff --git a/common/test_exec b/common/test_exec
> index 63efa3d19..e9c80bd59 100644
> --- a/common/test_exec
> +++ b/common/test_exec
> @@ -21,6 +21,12 @@ _te_notrun=()
>  _te_loop_status=()
>  _te_emit_timestamps=""
>  _te_dry_run=""
> +_te_diff_length=10
> +
> +# This is needed because callers don't always source common/report and
> +# if $do_report is undefined or true we'll try to call _make_testcase_report()
> +# without it being defined.
> +do_report=false
>  
>  _te_wipe_counters()
>  {
> @@ -43,6 +49,25 @@ _te_timestamp()
>  	fi
>  }
>  
> +_te_time_report()
> +{
> +	if [ -f $check.time -a -f $tmp.time ]; then
> +		cat $check.time $tmp.time  \
> +			| $AWK_PROG '
> +			{ t[$1] = $2 }
> +			END {
> +				if (NR > 0) {
> +					for (i in t) print i " " t[i]
> +				}
> +			}' \
> +			| sort -n >$tmp.out
> +		mv $tmp.out $check.time
> +		if $OPTIONS_HAVE_SECTIONS; then
> +			cp $check.time ${REPORT_DIR}/check.time
> +		fi
> +	fi
> +}
> +
>  _te_check_filesystems()
>  {
>  	local ret=0
> @@ -330,10 +355,10 @@ _te_run_test()
>  		_dump_err "- output mismatch (see $seqres.out.bad)"
>  		mv $tmp.out $seqres.out.bad
>  		$diff $seq.out $seqres.out.bad | {
> -		if test "$DIFF_LENGTH" -le 0; then
> +		if test "$_te_diff_length" -le 0; then
>  			cat
>  		else
> -			head -n "$DIFF_LENGTH"
> +			head -n "$_te_diff_length"
>  			echo "..."
>  			echo "(Run '$diff $here/$seq.out $seqres.out.bad'" \
>  				" to see the entire diff)"
> diff --git a/common/test_list b/common/test_list
> index 092b3ed17..4beb08b22 100644
> --- a/common/test_list
> +++ b/common/test_list
> @@ -160,6 +160,11 @@ _tl_prepare_test_list()
>  		trim_test_list $list
>  	done
>  
> +	# Remove expunged tests
> +	for f in "${_tl_exclude_tests[@]}"; do
> +		trim_test_list tests/$f
> +	done
> +
>  	# sort the list of tests into numeric order unless we're running tests
>  	# in the exact order specified
>  	if ! $_tl_exact_order; then
> @@ -194,6 +199,7 @@ _tl_expunge_test()
>  	return 1
>  }
>  
> +
>  _tl_setup_exclude_tests()
>  {
>  	local list="$1"
> diff --git a/tests/xfs/271 b/tests/xfs/271
> index 8a71746d6..ae4599282 100755
> --- a/tests/xfs/271
> +++ b/tests/xfs/271
> @@ -22,8 +22,6 @@ _cleanup()
>  _require_xfs_scratch_rmapbt
>  _require_xfs_io_command "fsmap"
>  
> -rm -f "$seqres.full"
> -
>  echo "Format and mount"
>  _scratch_mkfs > "$seqres.full" 2>&1
>  _scratch_mount
> diff --git a/tools/run_test.sh b/tools/run_test.sh
> new file mode 100755
> index 000000000..75f7a7dcd
> --- /dev/null
> +++ b/tools/run_test.sh
> @@ -0,0 +1,116 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
> +#
> +# Test run helper for check-parallel
> +#
> +# check-parallel sets up all the devices and environments needs to run tests,
> +# but we can't set up for a test until we are executing in a private pid/mount
> +# namespace.
> +#
> +# This means we cannot simply run the test itself in a private name space; they
> +# require things like the test device to already be mounted, and we require a
> +# private mount namespace before we start mounting devices.
> +#
> +# Hence we need a helper that first creates a private namespace, then
> +# does all the setup work for tests to run, then iterates tests until there
> +# are no more tests to run.
> +#
> +# The tests to run are held in a shared file in $basedir so that we set up
> +# a private /tmp for the namespace and no lose access to the test list.
> +
> +# re-execute in a private namespace as a first step
> +if [ -z "${FSTESTS_ISOL}" ]; then
> +	if [ -z "$1" ] || [ "$1" = "--help" ]; then
> +		echo "Usage: $0 basedir test_list "
> +		exit 1
> +	fi
> +
> +	if [ ! -d "$1" ]; then
> +		echo "invalid basedir ($1) specified"
> +		exit 1
> +	fi
> +
> +	FSTESTS_ISOL=privatens exec "$(dirname "$0")/../src/nsexec" -z -m -p "$0" "$@"
> +	exit $?
So when the first time tools/run_test.sh gets invoked for a particular runner, it sets FSTESTS_ISOL,
then does an exec with $0 i.e, the current script name. So tools/run_test.sh again gets invoked (as
a part of exec) but this time FSTESTS_ISOL is set, so this if condition isn't executed and hence we
move to the rest of the script. Simarly from second time, FSTESTS_ISOL is still set, so we don't
enter the if condition and move to the rest of the script. This is repeated for all the runners. Is
that correct?
> +fi
> +
> +# Everything past this point runs in a private namespace.
> +#
> +# We set up private mounts for /proc and /tmp so they aren't visible outside
> +# this mount namespace and it's children.
> +for path in /proc /tmp; do
> +	mountpoint "$path" >/dev/null && \
> +		mount --make-private "$path"
> +done
> +mount -t proc proc /proc
> +mount -t tmpfs tmpfs /tmp
> +
> +echo $PWD $FSTYP
> +
> +. ./common/exit
> +. ./common/test_names
> +. ./common/test_list
> +. ./common/test_exec
> +. ./common/rc
> +
> +basedir="$1"
> +test_file="$2"
> +_te_diff_length=${DIFF_LENGTH:=10}
> +export tmp=/tmp/run-helper.$$
> +
> +# XXX: should be a _te_diff variable
> +diff='diff -u'
> +
> +# Grab the next test to be run from the tail of the file.
> +# Returns an empty string if there is no tests remaining to run.
> +# File operations are run under flock so concurrent gets are serialised against
> +# each other.
> +get_next_test()
> +{
> +	local test=
> +
> +	flock 99
> +	test=$(tail -1 $test_file)
> +	sed -i "\,$test,d" $test_file
> +	flock -u 99
> +	echo $test
> +}
> +
> +_run_seq()
> +{
> +	./$seq
> +	return $?
> +}
Why can't we use the _run_seq() defined in "check"?
--NR
> +
> +exec 99<>$test_file.lock
> +
> +# XXX - refactor this back to a test_exec variable
> +check="$RESULT_BASE/check"
> +touch $check.time
> +
> +init_rc
> +
> +test_to_run=$(get_next_test)
> +while [ -n "$test_to_run" ]; do
> +	_te_run_test "tests/$test_to_run"
> +
> +	test_to_run=$(get_next_test)
> +done
> +
> +_te_time_report
> +
> +if ((${#_te_try[*]} > 0)); then
> +	echo "Ran: ${_te_try[*]}"
> +fi
> +
> +if ((${#_te_notrun[*]} > 0)); then
> +	echo "Not run: ${_te_notrun[*]}"
> +fi
> +
> +if ((${#_te_bad[*]} > 0)); then
> +	echo "Failures: ${_te_bad[*]}"
> +	echo "Failed ${#_te_bad[*]} of ${#_te_try[*]} tests"
> +else
> +	echo "Passed all ${#_te_try[*]} tests"
> +fi

