Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7741D1DE8A8
	for <fstests@vger.kernel.org>; Mon, 12 May 2025 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058286; cv=none; b=EC5wwt/WaHfswI2udREKQKP6eLUJ3QS+x6gbwo5eLF1RUp5gyChVUxYOCLmkJTC3JpkKD77RNz/Sxd1jqWIkmNihnGHrMROKwEQUaT/4oHWeXpaOqnK1IY2GQ94PlGyi/eh3W4vbnKbALYt80jxMj2vnzL5XQXbIV6XtygqHWQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058286; c=relaxed/simple;
	bh=n4lJVmnDt+qlYLSGhF+Ar7CxIlmfiqK3jfX1a7lFckk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=fpuGQ++wSQ6Dm9kTc7f0/ZcG+QxlbYHKb65qzKumctoaaW3eaaff4481TghVOfwYwzh5jUBO5skNnWnjGExJOMNPgU0xjcjWkn4w476NlQbW26bOGwIA/4zITbxiEvbB5KGRGWOYKSwhbpRc1Whe/vDbRPNOng1GKUlGT0lnlvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUf/y+id; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUf/y+id"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30820167b47so3661331a91.0
        for <fstests@vger.kernel.org>; Mon, 12 May 2025 06:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747058284; x=1747663084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2F5ZU+Vl4t52Uq4biyxaJdMviklehei51qDcyTjjpo=;
        b=XUf/y+idxtoHLfE3UiTHvNLuMQ6HCPFyOL5mTGNa9soxfzfwWT7nHyJDqL2ofi9SGG
         xSGFRcXuThtPKXPGgZxTzpst9PzD4n80DhFH6po8WU09Yc//GUh+OOWtuujRfSZ329Xz
         ugAbyuGm+/A9L7+FYOEQBw8+lRA5pjMFDtSa6hkiuxn5ebEe7EIl/OQA6kj/9m6CSgNp
         J5ku6XJOd/Gn7PaS7sX/KddN35QAs9uaOREzMG+l8OveBtK5JA158u3cd+sMXICqj9Gs
         5UYAr5WXfdH1aMD293qANU+8GkHhfwldJFk8wxvRtf6HpO2EocjJvKmi0WYv9wujGNDD
         pezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747058284; x=1747663084;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x2F5ZU+Vl4t52Uq4biyxaJdMviklehei51qDcyTjjpo=;
        b=PxHTG+q5bgqXe1Mh/+UkulSgfsZs8/HHb1lhvAw3YNVUS8AOVozHiM8TnBbUUxAaOo
         ZWH7Yu/FOzVb1DvIiOOd8tC9PiL/Ibb6z9ttJYv6xTwXeMKfQjBHB64rKdRFmfRpDOnc
         UTxd32kdRnifLr/FTgLLSaPOMu0Li2z/EcHJNmeRjTaKUuGkKGDSrsGlxkmV34Oy2NxQ
         622u4/s7HvKZguOHhID1fe36WPP+JE6UoW04kXOjTEB41kSlUnixVH1A/g+kDDyjiVWe
         QAHC7CfNYAn+P2KxXJ5N1fMWjfbDQynIUHEfojyXGSUy9ha2mL8djJEDqOvg4x3Htqxc
         h/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUN0Bx4jnGgxukgUjIk0i/MrwCwJVRHTRVnosU5vfRZcNTYRXjN3+e5qYBkLBAHdWtA0wIUJRhd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7T0Eedj8uHhu2Re7MsmD72gyRKRxxGiVlxqdknSEXJH1HdKp4
	M0B7/+tIcAX3PDLAAy6TveCdhrcat/tVhejGsQtjo9lndbhqsipi
X-Gm-Gg: ASbGncs3CDZ6MZuseqGMyUIit1YR1qYCzXMRXfn9Hu5g5MP5oR9jrK17OErAYKtXzLM
	oVFFTbmZlLxUXqm3/vnzUkOEDDxZH4tsaQinZnZDkLE1cN6bw8wpZuj7sYUOcPKVeZmM+eh+0Ht
	HAV/BSEchpBXP4YtPnE3BkgCTN2Hlmqwrg/C/apq0Y0b1p3vu7cX4ygHR4qt4pKtpUfFKPbrw3d
	XtWocbeETOvLUPlbmrrNGPLZm24BA0HuTSfg4UD1wsk1P4oew8/4A/6eeFIeguYR1g65xrdOC+k
	ak5HwvwwoovltCOyO9S6KPQdy2/JeJOKBIz/P8U50yWrSOBB/Uvdpmsad022KsdNDmas6V40UEy
	O/WNiOwQDoJuY/Jl+K07qxT+LkGSWXkueGQ7gUgw=
X-Google-Smtp-Source: AGHT+IG/7ac05I4PBd6qfpBNK11LYxACFo7CDyfQFKUcftAZUwRFmpmX/a7KLQPIv82cet7qJdt8Jw==
X-Received: by 2002:a17:90a:e7c8:b0:2fe:b907:5e5a with SMTP id 98e67ed59e1d1-30adbf257e7mr24143971a91.10.1747058283085;
        Mon, 12 May 2025 06:58:03 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4d2f1dasm8982461a91.17.2025.05.12.06.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 06:58:02 -0700 (PDT)
Message-ID: <5ee4c18f6b36f23e84f8e7d614637275eeb5eaf8.camel@gmail.com>
Subject: Re: [PATCH 19/28] check: factor test running
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Mon, 12 May 2025 19:27:58 +0530
In-Reply-To: <20250417031208.1852171-20-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-20-david@fromorbit.com>
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
> Rework the code that check uses to run an individual test,
> separating the executing of the test from the various pre- and post-
> test processing operations that are specific to check results
> processing.
> 
> This essentially encapsulates the test running and result tracking
> in it's own file, leaving just the section iteration and reporting
> to the caller that is running the tests. The caller needs to define
> the runseq() function that actually executes the test and some
I couldn't understand the usage of runseq() function? Can you please elaborate this a little bit
more?
> environment variables (e.g. REPORT_DIR) so that the test execution
> code will run correctly and stash results and reports in the correct
> location.
> 
> This greatly simplifies the check script as a big chunk of code
> dedicated to simply running a test and gathering the results is
> completely abstracted away. This makes it clearer what check is now
> doing at a high level in terms of iterating sections and generating
> reports.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  check            | 396 ++++++-----------------------------------------
>  common/test_exec | 352 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 398 insertions(+), 350 deletions(-)
>  create mode 100644 common/test_exec
> 
> diff --git a/check b/check
> index fea86f7b9..106de0ee6 100755
> --- a/check
> +++ b/check
> @@ -8,13 +8,9 @@ tmp=/tmp/$$
>  status=0
>  needwrap=true
>  needsum=true
> -try=()
>  sum_bad=0
> -bad=()
> -notrun=()
>  interrupt=true
>  diff="diff -u"
> -showme=false
>  export here=`pwd`
>  brief_test_summary=false
>  do_report=false
> @@ -38,14 +34,12 @@ export QA_CHECK_FS=${QA_CHECK_FS:=true}
>  # number of diff lines from a failed test, 0 for whole output
>  export DIFF_LENGTH=${DIFF_LENGTH:=10}
>  
> -# by default don't output timestamps
> -timestamp=${TIMESTAMP:=false}
> -
>  rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
>  
>  . ./common/exit
>  . ./common/test_names
>  . ./common/test_list
> +. ./common/test_exec
>  . ./common/config
>  . ./common/config-sections
>  . ./common/rc
> @@ -122,12 +116,6 @@ examples:
>  	    exit 1
>  }
>  
> -_timestamp()
> -{
> -    local now=`date "+%T"`
> -    echo -n " [$now]"
> -}
> -
>  # Process command arguments first.
>  while [ $# -gt 0 ]; do
>  	case "$1" in
> @@ -155,7 +143,7 @@ while [ $# -gt 0 ]; do
>  	-l)	diff="diff" ;;
>  	-udiff)	diff="$diff -u" ;;
>  
> -	-n)	showme=true ;;
> +	-n)	_te_dry_run="true" ;;
>  	-i)	iterations=$2; shift ;;
>  	-I) 	iterations=$2; istop=true; shift ;;
>  	-T)	timestamp=true ;;
> @@ -197,6 +185,9 @@ if [ ! -z "$REPORT_LIST" ]; then
>  	_assert_report_list
>  fi
>  
> +# by default don't output timestamps
> +_te_emit_timestamps=${TIMESTAMP:=}
> +
>  # If the test config specified a soak test duration, see if there are any
>  # unit suffixes that need converting to an integer seconds count.
>  if [ -n "$SOAK_DURATION" ]; then
> @@ -227,13 +218,6 @@ then
>      exit 1
>  fi
>  
> -_wipe_counters()
> -{
> -	try=()
> -	notrun=()
> -	bad=()
> -}
> -
>  _global_log() {
>  	echo "$1" >> $check.log
>  	if $OPTIONS_HAVE_SECTIONS; then
> @@ -252,11 +236,11 @@ _wrapup()
>  	check="$RESULT_BASE/check"
>  	$interrupt && sect_stop=`_wallclock`
>  
> -	if $showme && $needwrap; then
> +	if [ "$_te_dry_run" == "true" ] && $needwrap; then
>  		if $do_report; then
> -			# $showme = all selected tests are notrun (no tries)
> -			_make_section_report "$section" "${#notrun[*]}" "0" \
> -					     "${#notrun[*]}" \
> +			# $_te_dry_run = all selected tests are notrun (no tries)
> +			_make_section_report "$section" "${#_te_notrun[*]}" "0" \
> +					     "${#_te_notrun[*]}" \
>  					     "$((sect_stop - sect_start))"
>  		fi
>  		needwrap=false
> @@ -276,6 +260,7 @@ _wrapup()
>  				cp $check.time ${REPORT_DIR}/check.time
>  			fi
>  		fi
> +		set +x
>  
>  		_global_log ""
>  		_global_log "Kernel version: $(uname -r)"
> @@ -283,12 +268,12 @@ _wrapup()
>  
>  		echo "SECTION       -- $section" >>$tmp.summary
>  		echo "=========================" >>$tmp.summary
> -		if ((${#try[*]} > 0)); then
> +		if ((${#_te_try[*]} > 0)); then
>  			if [ $brief_test_summary == "false" ]; then
> -				echo "Ran: ${try[*]}"
> -				echo "Ran: ${try[*]}" >>$tmp.summary
> +				echo "Ran: ${_te_try[*]}"
> +				echo "Ran: ${_te_try[*]}" >>$tmp.summary
>  			fi
> -			_global_log "Ran: ${try[*]}"
> +			_global_log "Ran: ${_te_try[*]}"
>  		fi
>  
>  		$interrupt && echo "Interrupted!" | tee -a $check.log
> @@ -297,30 +282,30 @@ _wrapup()
>  				${REPORT_DIR}/check.log
>  		fi
>  
> -		if ((${#notrun[*]} > 0)); then
> +		if ((${#_te_notrun[*]} > 0)); then
>  			if [ $brief_test_summary == "false" ]; then
> -				echo "Not run: ${notrun[*]}"
> -				echo "Not run: ${notrun[*]}" >>$tmp.summary
> +				echo "Not run: ${_te_notrun[*]}"
> +				echo "Not run: ${_te_notrun[*]}" >>$tmp.summary
>  			fi
> -			_global_log "Not run: ${notrun[*]}"
> +			_global_log "Not run: ${_te_notrun[*]}"
>  		fi
>  
> -		if ((${#bad[*]} > 0)); then
> -			echo "Failures: ${bad[*]}"
> -			echo "Failed ${#bad[*]} of ${#try[*]} tests"
> -			_global_log "Failures: ${bad[*]}"
> -			_global_log "Failed ${#bad[*]} of ${#try[*]} tests"
> -			echo "Failures: ${bad[*]}" >>$tmp.summary
> -			echo "Failed ${#bad[*]} of ${#try[*]} tests" >>$tmp.summary
> +		if ((${#_te_bad[*]} > 0)); then
> +			echo "Failures: ${_te_bad[*]}"
> +			echo "Failed ${#_te_bad[*]} of ${#_te_try[*]} tests"
> +			_global_log "Failures: ${_te_bad[*]}"
> +			_global_log "Failed ${#_te_bad[*]} of ${#_te_try[*]} tests"
> +			echo "Failures: ${_te_bad[*]}" >>$tmp.summary
> +			echo "Failed ${#_te_bad[*]} of ${#_te_try[*]} tests" >>$tmp.summary
>  		else
> -			echo "Passed all ${#try[*]} tests"
> -			_global_log "Passed all ${#try[*]} tests"
> -			echo "Passed all ${#try[*]} tests" >>$tmp.summary
> +			echo "Passed all ${#_te_try[*]} tests"
> +			_global_log "Passed all ${#_te_try[*]} tests"
> +			echo "Passed all ${#_te_try[*]} tests" >>$tmp.summary
>  		fi
>  		echo "" >>$tmp.summary
>  		if $do_report; then
> -			_make_section_report "$section" "${#try[*]}" \
> -					     "${#bad[*]}" "${#notrun[*]}" \
> +			_make_section_report "$section" "${#_te_try[*]}" \
> +					     "${#_te_bad[*]}" "${#_te_notrun[*]}" \
>  					     "$((sect_stop - sect_start))"
>  		fi
>  
> @@ -338,8 +323,8 @@ _wrapup()
>  		needwrap=false
>  	fi
>  
> -	sum_bad=`expr $sum_bad + ${#bad[*]}`
> -	_wipe_counters
> +	sum_bad=`expr $sum_bad + ${#_te_bad[*]}`
> +	_te_wipe_counters
>  	if ! $OPTIONS_HAVE_SECTIONS; then
>  		rm -f $tmp.*
>  	fi
> @@ -348,7 +333,7 @@ _wrapup()
>  _summary()
>  {
>  	_wrapup
> -	if $showme; then
> +	if [ "$_te_dry_run" == "true" ]; then
>  		:
>  	elif $needsum; then
>  		count=`wc -L $tmp.summary | cut -f1 -d" "`
> @@ -358,95 +343,6 @@ _summary()
>  	rm -f $tmp.*
>  }
>  
> -_check_filesystems()
> -{
> -	local ret=0
> -
> -	if [ -f ${RESULT_DIR}/require_test ]; then
> -		if ! _check_test_fs ; then
> -			ret=1
> -			echo "Trying to repair broken TEST_DEV file system"
> -			_repair_test_fs
> -			_test_mount
> -		fi
> -		rm -f ${RESULT_DIR}/require_test*
> -	else
> -		_test_unmount 2> /dev/null
> -	fi
> -	if [ -f ${RESULT_DIR}/require_scratch ]; then
> -		_check_scratch_fs || ret=1
> -		rm -f ${RESULT_DIR}/require_scratch*
> -	fi
> -	_scratch_unmount 2> /dev/null
> -	return $ret
> -}
> -
> -# retain files which would be overwritten in subsequent reruns of the same test
> -_stash_fail_loop_files() {
> -	local seq_prefix="${REPORT_DIR}/${1}"
> -	local cp_suffix="$2"
> -
> -	for i in ".full" ".dmesg" ".out.bad" ".notrun" ".core" ".hints"; do
> -		rm -f "${seq_prefix}${i}${cp_suffix}"
> -		if [ -f "${seq_prefix}${i}" ]; then
> -			cp "${seq_prefix}${i}" "${seq_prefix}${i}${cp_suffix}"
> -		fi
> -	done
> -}
> -
> -# Retain in @bad / @notrun the result of the just-run @test_seq. @try array
> -# entries are added prior to execution.
> -_stash_test_status() {
> -	local test_seq="$1"
> -	local test_status="$2"
> -
> -	if $do_report && [[ $test_status != "expunge" ]]; then
> -		_make_testcase_report "$section" "$test_seq" \
> -				      "$test_status" "$((stop - start))"
> -	fi
> -
> -	if ((${#loop_status[*]} > 0)); then
> -		# continuing or completing rerun-on-failure loop
> -		_stash_fail_loop_files "$test_seq" ".rerun${#loop_status[*]}"
> -		loop_status+=("$test_status")
> -		if ((${#loop_status[*]} > loop_on_fail)); then
> -			printf "%s aggregate results across %d runs: " \
> -				"$test_seq" "${#loop_status[*]}"
> -			awk "BEGIN {
> -				n=split(\"${loop_status[*]}\", arr);"'
> -				for (i = 1; i <= n; i++)
> -					stats[arr[i]]++;
> -				for (x in stats)
> -					printf("%s=%d (%.1f%%)",
> -					       (i-- > n ? x : ", " x),
> -					       stats[x], 100 * stats[x] / n);
> -				}'
> -			echo
> -			loop_status=()
> -		fi
> -		return	# only stash @bad result for initial failure in loop
> -	fi
> -
> -	case "$test_status" in
> -	fail)
> -		if ((loop_on_fail > 0)); then
> -			# initial failure, start rerun-on-failure loop
> -			_stash_fail_loop_files "$test_seq" ".rerun0"
> -			loop_status+=("$test_status")
> -		fi
> -		bad+=("$test_seq")
> -		;;
> -	list|notrun)
> -		notrun+=("$test_seq")
> -		;;
> -	pass|expunge)
> -		;;
> -	*)
> -		echo "Unexpected test $test_seq status: $test_status"
> -		;;
> -	esac
> -}
> -
>  # Can we run systemd scopes?
>  HAVE_SYSTEMD_SCOPES=
>  systemctl reset-failed "fstests-check" &>/dev/null
> @@ -454,11 +350,7 @@ systemd-run --quiet --unit "fstests-check" --scope bash -c "exit 77" &> /dev/nul
>  test $? -eq 77 && HAVE_SYSTEMD_SCOPES=yes
>  
>  # Make the check script unattractive to the OOM killer...
> -OOM_SCORE_ADJ="/proc/self/oom_score_adj"
> -function _adjust_oom_score() {
> -	test -w "${OOM_SCORE_ADJ}" && echo "$1" > "${OOM_SCORE_ADJ}"
> -}
> -_adjust_oom_score -500
> +_te_adjust_oom_score -500
>  
>  # ...and make the tests themselves somewhat more attractive to it, so that if
>  # the system runs out of memory it'll be the test that gets killed and not the
> @@ -472,7 +364,7 @@ _adjust_oom_score -500
>  # when systemd tells them to terminate (e.g. programs stuck in D state when
>  # systemd sends SIGKILL), so we use reset-failed to tear down the scope.
>  _run_seq() {
> -	local cmd=(bash -c "test -w ${OOM_SCORE_ADJ} && echo 250 > ${OOM_SCORE_ADJ}; exec ./$seq")
> +	local cmd=(bash -c "test -w ${_te_oom_score_adj} && echo 250 > ${_te_oom_score_adj}; exec ./$seq")
nit: 80 chars exceeded
>  	local res
>  
>  	if [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
> @@ -617,222 +509,26 @@ function run_section()
>  	seqres="$check"
>  	_check_test_fs
>  
> -	loop_status=()	# track rerun-on-failure state
> -	local tc_status ix
> +	if $OPTIONS_HAVE_SECTIONS; then
> +		REPORT_DIR="$RESULT_BASE/$section"
> +	else
> +		REPORT_DIR="$RESULT_BASE"
> +	fi
> +
> +	local ix
>  	local -a _list=( $_tl_tests )
> -	for ((ix = 0; ix < ${#_list[*]}; !${#loop_status[*]} && ix++)); do
> +	for ((ix = 0; ix < ${#_list[*]}; !${#_te_loop_status[*]} && ix++)); do
>  		seq="${_list[$ix]}"
>  
> -		# the filename for the test and the name output are different.
> -		# we don't include the tests/ directory in the name output.
> -		export seqnum=$(_tl_strip_src_dir $seq)
> -		group=${seqnum%%/*}
> -		if $OPTIONS_HAVE_SECTIONS; then
> -			REPORT_DIR="$RESULT_BASE/$section"
> -		else
> -			REPORT_DIR="$RESULT_BASE"
> -		fi
> -		export RESULT_DIR="$REPORT_DIR/$group"
> -		seqres="$REPORT_DIR/$seqnum"
> -
>  		# Generate the entire section report with whatever test results
>  		# we have so far.  Leave the $sect_time parameter empty so that
>  		# it's a little more obvious that this test run is incomplete.
>  		if $do_report; then
> -			_make_section_report "$section" "${#try[*]}" \
> -					     "${#bad[*]}" "${#notrun[*]}" \
> +			_make_section_report "$section" "${#_te_try[*]}" \
> +					     "${#_te_bad[*]}" "${#_te_notrun[*]}" \
>  					     "" &> /dev/null
>  		fi
> -
> -		echo -n "$seqnum"
> -
> -		if $showme; then
> -			if _tl_expunge_test $seqnum; then
> -				tc_status="expunge"
> -			else
> -				echo
> -				start=0
> -				stop=0
> -				tc_status="list"
> -			fi
> -			_stash_test_status "$seqnum" "$tc_status"
> -			continue
> -		fi
> -
> -		tc_status="pass"
> -		if [ ! -f $seq ]; then
> -			echo " - no such test?"
> -			_stash_test_status "$seqnum" "$tc_status"
> -			continue
> -		fi
> -
> -		# really going to try and run this one
> -		mkdir -p $RESULT_DIR
> -		rm -f ${RESULT_DIR}/require_scratch*
> -		rm -f ${RESULT_DIR}/require_test*
> -		rm -f $seqres.out.bad $seqres.hints
> -
> -		# check if we really should run it
> -		if _tl_expunge_test $seqnum; then
> -			tc_status="expunge"
> -			_stash_test_status "$seqnum" "$tc_status"
> -			continue
> -		fi
> -
> -		# record that we really tried to run this test.
> -		if ((!${#loop_status[*]})); then
> -			try+=("$seqnum")
> -		fi
> -
> -		awk 'BEGIN {lasttime="       "} \
> -		     $1 == "'$seqnum'" {lasttime=" " $2 "s ... "; exit} \
> -		     END {printf "%s", lasttime}' "$check.time"
> -		rm -f core $seqres.notrun
> -
> -		start=`_wallclock`
> -		$timestamp && _timestamp
> -		[ ! -x $seq ] && chmod u+x $seq # ensure we can run it
> -		$LOGGER_PROG "run xfstest $seqnum"
> -		if [ -w /dev/kmsg ]; then
> -			export date_time=`date +"%F %T"`
> -			echo "run fstests $seqnum at $date_time" > /dev/kmsg
> -			# _check_dmesg depends on this log in dmesg
> -			touch ${RESULT_DIR}/check_dmesg
> -			rm -f ${RESULT_DIR}/dmesg_filter
> -		fi
> -		_try_wipe_scratch_devs > /dev/null 2>&1
> -
> -		# clear the WARN_ONCE state to allow a potential problem
> -		# to be reported for each test
> -		(echo 1 > $DEBUGFS_MNT/clear_warn_once) > /dev/null 2>&1
> -
> -		test_start_time="$(date +"%F %T")"
> -		if [ "$DUMP_OUTPUT" = true ]; then
> -			_run_seq 2>&1 | tee $tmp.out
> -			# Because $? would get tee's return code
> -			sts=${PIPESTATUS[0]}
> -		else
> -			_run_seq >$tmp.out 2>&1
> -			sts=$?
> -		fi
> -
> -		# If someone sets kernel.core_pattern or kernel.core_uses_pid,
> -		# coredumps generated by fstests might have a longer name than
> -		# just "core".  Use globbing to find the most common patterns,
> -		# assuming there are no other coredump capture packages set up.
> -		local cores=0
> -		for i in core core.*; do
> -			test -f "$i" || continue
> -			if ((cores++ == 0)); then
> -				_dump_err_cont "[dumped core]"
> -			fi
> -			(_adjust_oom_score 250; _save_coredump "$i")
> -			tc_status="fail"
> -		done
> -
> -		if [ -f $seqres.notrun ]; then
> -			$timestamp && _timestamp
> -			stop=`_wallclock`
> -			$timestamp || echo -n "[not run] "
> -			$timestamp && echo " [not run]" && \
> -				      echo -n "	$seqnum -- "
> -			cat $seqres.notrun
> -			tc_status="notrun"
> -			_stash_test_status "$seqnum" "$tc_status"
> -
> -			# Unmount the scratch fs so that we can wipe the scratch
> -			# dev state prior to the next test run.
> -			_scratch_unmount 2> /dev/null
> -			continue;
> -		fi
> -
> -		if [ $sts -ne 0 ]; then
> -			_dump_err_cont "[failed, exit status $sts]"
> -			_test_unmount 2> /dev/null
> -			_scratch_unmount 2> /dev/null
> -			rm -f ${RESULT_DIR}/require_test*
> -			rm -f ${RESULT_DIR}/require_scratch*
> -			# Even though we failed, there may be something interesting in
> -			# dmesg which can help debugging.
> -			_check_dmesg
> -			tc_status="fail"
> -		else
> -			# The test apparently passed, so check for corruption
> -			# and log messages that shouldn't be there.  Run the
> -			# checking tools from a subshell with adjusted OOM
> -			# score so that the OOM killer will target them instead
> -			# of the check script itself.
> -			(_adjust_oom_score 250; _check_filesystems) || tc_status="fail"
> -			_check_dmesg || tc_status="fail"
> -
> -			# Save any coredumps from the post-test fs checks
> -			for i in core core.*; do
> -				test -f "$i" || continue
> -				if ((cores++ == 0)); then
> -					_dump_err_cont "[dumped core]"
> -				fi
> -				(_adjust_oom_score 250; _save_coredump "$i")
> -				tc_status="fail"
> -			done
> -		fi
> -
> -		# Reload the module after each test to check for leaks or
> -		# other problems.
> -		if [ -n "${TEST_FS_MODULE_RELOAD}" ]; then
> -			_test_unmount 2> /dev/null
> -			_scratch_unmount 2> /dev/null
> -			modprobe -r fs-$FSTYP
> -			modprobe fs-$FSTYP
> -		fi
> -
> -		# Scan for memory leaks after every test so that associating
> -		# a leak to a particular test will be as accurate as possible.
> -		_check_kmemleak || tc_status="fail"
> -
> -		# test ends after all checks are done.
> -		$timestamp && _timestamp
> -		stop=`_wallclock`
> -
> -		if [ ! -f $seq.out ]; then
> -			_dump_err "no qualified output"
> -			tc_status="fail"
> -			_stash_test_status "$seqnum" "$tc_status"
> -			continue;
> -		fi
> -
> -		# coreutils 8.16+ changed quote formats in error messages
> -		# from `foo' to 'foo'. Filter old versions to match the new
> -		# version.
> -		sed -i "s/\`/\'/g" $tmp.out
> -		if diff $seq.out $tmp.out >/dev/null 2>&1 ; then
> -			if [ "$tc_status" != "fail" ]; then
> -				echo "$seqnum `expr $stop - $start`" >>$tmp.time
> -				echo -n " `expr $stop - $start`s"
> -			fi
> -			echo ""
> -		else
> -			_dump_err "- output mismatch (see $seqres.out.bad)"
> -			mv $tmp.out $seqres.out.bad
> -			$diff $seq.out $seqres.out.bad | {
> -			if test "$DIFF_LENGTH" -le 0; then
> -				cat
> -			else
> -				head -n "$DIFF_LENGTH"
> -				echo "..."
> -				echo "(Run '$diff $here/$seq.out $seqres.out.bad'" \
> -					" to see the entire diff)"
> -			fi; } | sed -e 's/^\(.\)/    \1/'
> -			tc_status="fail"
> -		fi
> -		if [ -f $seqres.hints ]; then
> -			if [ "$tc_status" == "fail" ]; then
> -				echo
> -				cat $seqres.hints
> -			else
> -				rm -f $seqres.hints
> -			fi
> -		fi
> -		_stash_test_status "$seqnum" "$tc_status"
> +		_te_run_test $seq
>  	done
>  
>  	# Reset these three variables so that unmount output doesn't get
> diff --git a/common/test_exec b/common/test_exec
> new file mode 100644
> index 000000000..63efa3d19
> --- /dev/null
> +++ b/common/test_exec
> @@ -0,0 +1,352 @@
> +##/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (c) 2000-2002,2006 Silicon Graphics, Inc.  All Rights Reserved.
> +# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
> +#
> +# Test execution functions
> +#
> +# This file contains the functions to run a test and capture the results. The
> +# caller context must source all the dependencies this code requires, as well
> +# as provide certain global variables and define certain
> +# functions to run and track the test status of the test being run.
> +#
> +# Any function or variable that is public should have a "_te_" prefix.
> +
> +# test status tracking variables. These are externally visible so that the
> +# caller can do it's own test reporting based on the tracking provided by these
> +# variables.
> +_te_try=()
> +_te_bad=()
> +_te_notrun=()
> +_te_loop_status=()
> +_te_emit_timestamps=""
> +_te_dry_run=""
> +
> +_te_wipe_counters()
> +{
> +	_te_try=()
> +	_te_notrun=()
> +	_te_bad=()
> +	_te_loop_status=()
> +}
> +
> +_te_oom_score_adj="/proc/self/oom_score_adj"
> +_te_adjust_oom_score() {
> +	test -w "${_te_oom_score_adj}" && echo "$1" > "${_te_oom_score_adj}"
> +}
> +
> +_te_timestamp()
> +{
> +	if [ "$_te_emit_timestamps" == "true" ]; then
> +		local now=`date "+%T"`
> +		echo -n " [$now]"
> +	fi
> +}
> +
> +_te_check_filesystems()
> +{
> +	local ret=0
> +
> +	if [ -f ${RESULT_DIR}/require_test ]; then
> +		if ! _check_test_fs ; then
> +			ret=1
> +			echo "Trying to repair broken TEST_DEV file system"
> +			_repair_test_fs
> +			_test_mount
> +		fi
> +		rm -f ${RESULT_DIR}/require_test*
> +	else
> +		_test_unmount 2> /dev/null
> +	fi
> +	if [ -f ${RESULT_DIR}/require_scratch ]; then
> +		_check_scratch_fs || ret=1
> +		rm -f ${RESULT_DIR}/require_scratch*
> +	fi
> +	_scratch_unmount 2> /dev/null
> +	return $ret
> +}
> +
> +# retain files which would be overwritten in subsequent reruns of the same test
> +_te_stash_fail_loop_files() {
> +	local seq_prefix="${REPORT_DIR}/${1}"
> +	local cp_suffix="$2"
> +
> +	for i in ".full" ".dmesg" ".out.bad" ".notrun" ".core" ".hints"; do
> +		rm -f "${seq_prefix}${i}${cp_suffix}"
> +		if [ -f "${seq_prefix}${i}" ]; then
> +			cp "${seq_prefix}${i}" "${seq_prefix}${i}${cp_suffix}"
> +		fi
> +	done
> +}
> +
> +# Retain in @bad / @notrun the result of the just-run @test_seq. @try array
> +# entries are added prior to execution.
> +_te_stash_test_status() {
> +	local test_seq="$1"
> +	local test_status="$2"
> +
> +	if $do_report && [[ $test_status != "expunge" ]]; then
> +		_make_testcase_report "$section" "$test_seq" \
> +				      "$test_status" "$((stop - start))"
> +	fi
> +
> +	if ((${#loop_status[*]} > 0)); then
Shouldn't the above be _te_loop_status?
> +		# continuing or completing rerun-on-failure loop
> +		_te_stash_fail_loop_files "$test_seq" ".rerun${#loop_status[*]}"
> +		_te_loop_status+=("$test_status")
> +		if ((${#_te_loop_status[*]} > loop_on_fail)); then
> +			printf "%s aggregate results across %d runs: " \
> +				"$test_seq" "${#loop_status[*]}"
> +			awk "BEGIN {
> +				n=split(\"${loop_status[*]}\", arr);"'
> +				for (i = 1; i <= n; i++)
> +					stats[arr[i]]++;
> +				for (x in stats)
> +					printf("%s=%d (%.1f%%)",
> +					       (i-- > n ? x : ", " x),
> +					       stats[x], 100 * stats[x] / n);
> +				}'
> +			echo
> +			_te_loop_status=()
> +		fi
> +		return	# only stash @bad result for initial failure in loop
> +	fi
> +
> +	case "$test_status" in
> +	fail)
> +		if ((loop_on_fail > 0)); then
> +			# initial failure, start rerun-on-failure loop
> +			_te_stash_fail_loop_files "$test_seq" ".rerun0"
> +			loop_status+=("$test_status")
Same: Shouldn't the above be _te_loop_status? We should only use _te_loop_status, isn't it?
> +		fi
> +		_te_bad+=("$test_seq")
> +		;;
> +	list|notrun)
> +		_te_notrun+=("$test_seq")
> +		;;
> +	pass|expunge)
> +		;;
> +	*)
> +		echo "Unexpected test $test_seq status: $test_status"
> +		;;
> +	esac
> +}
> +
> +# Run a test.
> +#
> +# This currently relies on the caller defining global variables for test
> +# reporting and status tracking:
> +#
> +# REPORT_DIR
> +# tmp
> +#
> +# The caller also needs to define the functions _run_seq and _kill_seq
> +# for executing and killing specific test binaries.
I couldn't understand this part. _run_seq() is already defined, isn't it? 
--NR
> +# 
> +_te_run_test()
> +{
> +	local seq="$1"
> +	local tc_status="pass"
> +	local start
> +	local stop
> +	local sts
> +
> +	# the filename for the test and the name output are different.
> +	# we don't include the tests/ directory in the name output.
> +	export seqnum=$(_tl_strip_src_dir $seq)
> +	group=${seqnum%%/*}
> +	export RESULT_DIR="$REPORT_DIR/$group"
> +	seqres="$REPORT_DIR/$seqnum"
> +
> +	echo -n "$seqnum"
> +
> +	if [ "$_te_dry_run" == "true" ]; then
> +		if _tl_expunge_test $seqnum; then
> +			tc_status="expunge"
> +		else
> +			echo
> +			start=0
> +			stop=0
> +			tc_status="list"
> +		fi
> +		_te_stash_test_status "$seqnum" "$tc_status"
> +		return
> +	fi
> +
> +	if [ ! -f $seq ]; then
> +		echo " - no such test?"
> +		_te_stash_test_status "$seqnum" "$tc_status"
> +		return
> +	fi
> +
> +	# really going to try and run this one
> +	mkdir -p $RESULT_DIR
> +	rm -f ${RESULT_DIR}/require_scratch*
> +	rm -f ${RESULT_DIR}/require_test*
> +	rm -f $seqres.out.bad $seqres.hints
> +
> +	# check if we really should run it
> +	if _tl_expunge_test $seqnum; then
> +		tc_status="expunge"
> +		_te_stash_test_status "$seqnum" "$tc_status"
> +		return
> +	fi
> +
> +	# record that we really tried to run this test.
> +	if ((!${#loop_status[*]})); then
> +		_te_try+=("$seqnum")
> +	fi
> +
> +	awk 'BEGIN {lasttime="       "} \
> +	     $1 == "'$seqnum'" {lasttime=" " $2 "s ... "; exit} \
> +	     END {printf "%s", lasttime}' "$check.time"
> +	rm -f core $seqres.notrun
> +
> +	start=`_wallclock`
> +	_te_timestamp
> +	[ ! -x $seq ] && chmod u+x $seq # ensure we can run it
> +	$LOGGER_PROG "run xfstest $seqnum"
> +	if [ -w /dev/kmsg ]; then
> +		export date_time=`date +"%F %T"`
> +		echo "run fstests $seqnum at $date_time" > /dev/kmsg
> +		# _check_dmesg depends on this log in dmesg
> +		touch ${RESULT_DIR}/check_dmesg
> +		rm -f ${RESULT_DIR}/dmesg_filter
> +	fi
> +	_try_wipe_scratch_devs > /dev/null 2>&1
> +
> +	# clear the WARN_ONCE state to allow a potential problem
> +	# to be reported for each test
> +	(echo 1 > $DEBUGFS_MNT/clear_warn_once) > /dev/null 2>&1
> +
> +	test_start_time="$(date +"%F %T")"
> +	if [ "$DUMP_OUTPUT" = true ]; then
> +		_run_seq 2>&1 | tee $tmp.out
> +		# Because $? would get tee's return code
> +		sts=${PIPESTATUS[0]}
> +	else
> +		_run_seq >$tmp.out 2>&1
> +		sts=$?
> +	fi
> +
> +	# If someone sets kernel.core_pattern or kernel.core_uses_pid,
> +	# coredumps generated by fstests might have a longer name than
> +	# just "core".  Use globbing to find the most common patterns,
> +	# assuming there are no other coredump capture packages set up.
> +	local cores=0
> +	for i in core core.*; do
> +		test -f "$i" || continue
> +		if ((cores++ == 0)); then
> +			_dump_err_cont "[dumped core]"
> +		fi
> +		(_te_adjust_oom_score 250; _save_coredump "$i")
> +		tc_status="fail"
> +	done
> +
> +	if [ -f $seqres.notrun ]; then
> +		stop=`_wallclock`
> +		if [ "$_te_emit_timestamps" == "true" ]; then
> +			_te_timestamp
> +			echo " [not run]"
> +			echo -n " $seqnum -- "
> +		else
> +			echo -n "[not run] "
> +		fi
> +		cat $seqres.notrun
> +		tc_status="notrun"
> +		_te_stash_test_status "$seqnum" "$tc_status"
> +
> +		# Unmount the scratch fs so that we can wipe the scratch
> +		# dev state prior to the next test run.
> +		_scratch_unmount 2> /dev/null
> +		return
> +	fi
> +
> +	if [ $sts -ne 0 ]; then
> +		_dump_err_cont "[failed, exit status $sts]"
> +		_test_unmount 2> /dev/null
> +		_scratch_unmount 2> /dev/null
> +		rm -f ${RESULT_DIR}/require_test*
> +		rm -f ${RESULT_DIR}/require_scratch*
> +		# Even though we failed, there may be something interesting in
> +		# dmesg which can help debugging.
> +		_check_dmesg
> +		tc_status="fail"
> +	else
> +		# The test apparently passed, so check for corruption
> +		# and log messages that shouldn't be there.  Run the
> +		# checking tools from a subshell with adjusted OOM
> +		# score so that the OOM killer will target them instead
> +		# of the check script itself.
> +		(_te_adjust_oom_score 250; _te_check_filesystems) || tc_status="fail"
> +		_check_dmesg || tc_status="fail"
> +
> +		# Save any coredumps from the post-test fs checks
> +		for i in core core.*; do
> +			test -f "$i" || continue
> +			if ((cores++ == 0)); then
> +				_dump_err_cont "[dumped core]"
> +			fi
> +			(_te_adjust_oom_score 250; _save_coredump "$i")
> +			tc_status="fail"
> +		done
> +	fi
> +
> +	# Reload the module after each test to check for leaks or
> +	# other problems.
> +	if [ -n "${TEST_FS_MODULE_RELOAD}" ]; then
> +		_test_unmount 2> /dev/null
> +		_scratch_unmount 2> /dev/null
> +		modprobe -r fs-$FSTYP
> +		modprobe fs-$FSTYP
> +	fi
> +
> +	# Scan for memory leaks after every test so that associating
> +	# a leak to a particular test will be as accurate as possible.
> +	_check_kmemleak || tc_status="fail"
> +
> +	# test ends after all checks are done.
> +	_te_timestamp
> +	stop=`_wallclock`
> +
> +	if [ ! -f $seq.out ]; then
> +		_dump_err "no qualified output"
> +		tc_status="fail"
> +		_te_stash_test_status "$seqnum" "$tc_status"
> +		return;
> +	fi
> +
> +	# coreutils 8.16+ changed quote formats in error messages
> +	# from `foo' to 'foo'. Filter old versions to match the new
> +	# version.
> +	sed -i "s/\`/\'/g" $tmp.out
> +	if diff $seq.out $tmp.out >/dev/null 2>&1 ; then
> +		if [ "$tc_status" != "fail" ]; then
> +			echo "$seqnum `expr $stop - $start`" >>$tmp.time
> +			echo -n " `expr $stop - $start`s"
> +		fi
> +		echo ""
> +	else
> +		_dump_err "- output mismatch (see $seqres.out.bad)"
> +		mv $tmp.out $seqres.out.bad
> +		$diff $seq.out $seqres.out.bad | {
> +		if test "$DIFF_LENGTH" -le 0; then
> +			cat
> +		else
> +			head -n "$DIFF_LENGTH"
> +			echo "..."
> +			echo "(Run '$diff $here/$seq.out $seqres.out.bad'" \
> +				" to see the entire diff)"
> +		fi; } | sed -e 's/^\(.\)/    \1/'
> +		tc_status="fail"
> +	fi
> +	if [ -f $seqres.hints ]; then
> +		if [ "$tc_status" == "fail" ]; then
> +			echo
> +			cat $seqres.hints
> +		else
> +			rm -f $seqres.hints
> +		fi
> +	fi
> +	_te_stash_test_status "$seqnum" "$tc_status"
> +}

