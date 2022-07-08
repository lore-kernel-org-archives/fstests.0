Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF41DC43334
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Jul 2022 15:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbiGHPV3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Jul 2022 11:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbiGHPV2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Jul 2022 11:21:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAB11C108
        for <fstests@vger.kernel.org>; Fri,  8 Jul 2022 08:21:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A49EB828A9
        for <fstests@vger.kernel.org>; Fri,  8 Jul 2022 15:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF939C341C0;
        Fri,  8 Jul 2022 15:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657293684;
        bh=uzXmucdxpk0BUxLF1rYZgzaLz6kQHunpqU6A8Vhe24A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q8/hF4auaj31L6E65U3SpKulXDdwzbRnXFTeW+q2MFJ3sufl/0N6Iz06rq4F3Bkju
         FmrRMeO4jzviCtbXC7am+7gNMJ6ZLF9zdY8bUs04ON5Vc7zH4/+/90KEWik9SfsA2Q
         Eiz2Lg46RjGnxTZsGVdAdjFihgI6/UzcI9Uj3zFwSDZew2PSuKWmn2aZI5f+hO5iKp
         07EbSZNA5wPjrySW4guhDe2mQKbzOsh+EOLivKZ2QFeNqgh3e0hAE0RpsiPDQGGewY
         Mn+PWYrqRcEcO9ulO9gtzBc1uDo7MiEIPc8pPfKH16A+6btphKmTPUgJQPuWPY4j/K
         K5COPSw6TKqeQ==
Date:   Fri, 8 Jul 2022 08:21:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, tytso@mit.edu, zlang@redhat.com
Subject: Re: [PATCH v4 5/5] check: add -L <n> parameter to rerun failed tests
Message-ID: <YshLdLX9m9rkh23E@magnolia>
References: <20220708085142.20991-1-ddiss@suse.de>
 <20220708085142.20991-6-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708085142.20991-6-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jul 08, 2022 at 10:51:42AM +0200, David Disseldorp wrote:
> If check is run with -L <n>, then a failed test will be rerun <n> times
> before proceeding to the next test. Following completion of the rerun
> loop, aggregate pass/fail statistics are printed.
> 
> Rerun tests will be tracked as a single failure in overall pass/fail
> metrics (via @try and @bad), with .out.bad, .dmesg, .core, .hints,
> .notrun and .full saved using a .rerun# suffix.
> 
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Link: https://lwn.net/Articles/897061/
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Looks good!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  check | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/check b/check
> index 6dbdb2a8..5f6d86b4 100755
> --- a/check
> +++ b/check
> @@ -26,6 +26,7 @@ do_report=false
>  DUMP_OUTPUT=false
>  iterations=1
>  istop=false
> +loop_on_fail=0
>  
>  # This is a global variable used to pass test failure text to reporting gunk
>  _err_msg=""
> @@ -78,6 +79,7 @@ check options
>      --large-fs		optimise scratch device for large filesystems
>      -s section		run only specified section from config file
>      -S section		exclude the specified section from the config file
> +    -L <n>		loop tests <n> times following a failure, measuring aggregate pass/fail metrics
>  
>  testlist options
>      -g group[,group...]	include tests from these groups
> @@ -336,6 +338,9 @@ while [ $# -gt 0 ]; do
>  		;;
>  	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
>  	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
> +	-L)	[[ $2 =~ ^[0-9]+$ ]] || usage
> +		loop_on_fail=$2; shift
> +		;;
>  
>  	-*)	usage ;;
>  	*)	# not an argument, we've got tests now.
> @@ -553,6 +558,19 @@ _expunge_test()
>  	return 0
>  }
>  
> +# retain files which would be overwritten in subsequent reruns of the same test
> +_stash_fail_loop_files() {
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
>  # Retain in @bad / @notrun the result of the just-run @test_seq. @try array
>  # entries are added prior to execution.
>  _stash_test_status() {
> @@ -564,8 +582,35 @@ _stash_test_status() {
>  				      "$test_status" "$((stop - start))"
>  	fi
>  
> +	if ((${#loop_status[*]} > 0)); then
> +		# continuing or completing rerun-on-failure loop
> +		_stash_fail_loop_files "$test_seq" ".rerun${#loop_status[*]}"
> +		loop_status+=("$test_status")
> +		if ((${#loop_status[*]} > loop_on_fail)); then
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
> +			loop_status=()
> +		fi
> +		return	# only stash @bad result for initial failure in loop
> +	fi
> +
>  	case "$test_status" in
>  	fail)
> +		if ((loop_on_fail > 0)); then
> +			# initial failure, start rerun-on-failure loop
> +			_stash_fail_loop_files "$test_seq" ".rerun0"
> +			loop_status+=("$test_status")
> +		fi
>  		bad+=("$test_seq")
>  		;;
>  	list|notrun)
> @@ -758,8 +803,12 @@ function run_section()
>  	seqres="$check"
>  	_check_test_fs
>  
> -	local tc_status
> -	for seq in $list ; do
> +	loop_status=()	# track rerun-on-failure state
> +	local tc_status ix
> +	local -a _list=( $list )
> +	for ((ix = 0; ix < ${#_list[*]}; !${#loop_status[*]} && ix++)); do
> +		seq="${_list[$ix]}"
> +
>  		if [ ! -f $seq ]; then
>  			# Try to get full name in case the user supplied only
>  			# seq id and the test has a name. A bit of hassle to
> @@ -829,7 +878,9 @@ function run_section()
>  		fi
>  
>  		# record that we really tried to run this test.
> -		try+=("$seqnum")
> +		if ((!${#loop_status[*]})); then
> +			try+=("$seqnum")
> +		fi
>  
>  		awk 'BEGIN {lasttime="       "} \
>  		     $1 == "'$seqnum'" {lasttime=" " $2 "s ... "; exit} \
> -- 
> 2.35.3
> 
