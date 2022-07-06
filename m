Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A151C43334
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Jul 2022 19:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbiGFTAL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 Jul 2022 15:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiGFTAK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Jul 2022 15:00:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8046F28719
        for <fstests@vger.kernel.org>; Wed,  6 Jul 2022 12:00:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19A566206C
        for <fstests@vger.kernel.org>; Wed,  6 Jul 2022 19:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70768C3411C;
        Wed,  6 Jul 2022 19:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657134008;
        bh=BsRDh9a3pycdp+xiTYsLsGDoHmOJo80pCb7oiAJLM8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IeCj9W1CSYvDO2+O9QvRgfgbl0EIrf6tKjOn2vs2/UYlmxfXE49Gwk+qkAkGI/Cb6
         WhvYYUcNRr9jzi65fdWG+WbtInsmpxLdxMElJQNPlewpkZdQ4yPwfM+BqdMJLEaL1e
         Y1YzyEzQTNQGIQdY/uZUYNtTIQFCbT1rjbEYMu0N3pwTBKtH6RlM4tN4mu8UFb+fh2
         DmIOcxjp50dPaOZvjbOFwL9kyd7LmQQiuekMGlsZ6biJ+BsUgPUPk0mtOaIStWtPNx
         S+ooFuY0uthrFjIhXJXYr3hgPsRKE0uuAcf1BSPmTTdqrKiAQS0ndxwSlV+SBQMcrZ
         c/Tytztca6FyA==
Date:   Wed, 6 Jul 2022 12:00:07 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH v3 5/5] check: add -L <n> parameter to rerun failed tests
Message-ID: <YsXbt85xBNJIOwZu@magnolia>
References: <20220706112312.4349-1-ddiss@suse.de>
 <20220706112312.4349-6-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706112312.4349-6-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 06, 2022 at 01:23:12PM +0200, David Disseldorp wrote:
> If check is run with -L <n>, then a failed test will be rerun <n> times
> before proceeding to the next test. Following completion of the rerun
> loop, aggregate pass/fail statistics are printed.
> 
> Rerun tests will be tracked as a single failure in overall pass/fail
> metrics (via @try and @bad), with .out.bad, .dmesg and .full saved using
> a .rerun# suffix.
> 
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Link: https://lwn.net/Articles/897061/
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  check | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/check b/check
> index 6dbdb2a8..46fca6e6 100755
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
> @@ -553,6 +558,18 @@ _expunge_test()
>  	return 0
>  }
>  
> +# retain files which would be overwritten in subsequent reruns of the same test
> +_stash_fail_loop_files() {
> +	local test_seq="$1"
> +	local suffix="$2"
> +
> +	for i in "${REPORT_DIR}/${test_seq}.full" \
> +		 "${REPORT_DIR}/${test_seq}.dmesg" \
> +		 "${REPORT_DIR}/${test_seq}.out.bad"; do
> +		[ -f "$i" ] && cp "$i" "${i}${suffix}"

I wonder, is there any particular reason to copy the output file and let
it get overwritten instead of simply mv'ing it?

> +	done
> +}
> +
>  # Retain in @bad / @notrun the result of the just-run @test_seq. @try array
>  # entries are added prior to execution.
>  _stash_test_status() {
> @@ -564,8 +581,35 @@ _stash_test_status() {
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

Hmm, if I parse this correctly, do you end up with something like:

"xfs/555 aggregate results across 15 runs: pass=5 (33.3%) fail=10 (66.7%)" ?

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

So if I'm reading this right, the length of the $loop_status array is
what gates us moving on or retrying, right?  If the length is zero, then
we move on to the next test; otherwise, that loopy logic in
_stash_test_result above will keep the same test running until the
length exceeds loop_on_fail, at which point we print the aggregation
report, empty out $loop_status, and then ix increments and we move on to
the next test?

If the answers to the last two questions are both "yes", then I think
this looks ok.

--D

> +		fi
>  		bad+=("$test_seq")
>  		;;
>  	list|notrun)
> @@ -758,8 +802,12 @@ function run_section()
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
> @@ -829,7 +877,9 @@ function run_section()
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
