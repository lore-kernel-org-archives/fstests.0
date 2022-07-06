Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390E6C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Jul 2022 18:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiGFSeC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 Jul 2022 14:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGFSd7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Jul 2022 14:33:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B024E186F1
        for <fstests@vger.kernel.org>; Wed,  6 Jul 2022 11:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4913262022
        for <fstests@vger.kernel.org>; Wed,  6 Jul 2022 18:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CC9C3411C;
        Wed,  6 Jul 2022 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657132437;
        bh=AwylTYziF5KzudfIxCb5pd0N9MUT2OI8hdHwatAwdA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ddEZpXYGWxGX2E4gRN/JiGUrAaAEUJ8USPNV/JTMuHdH/Eh4/9qPNZWQIHbHAgGZy
         PdIQvzeAJ6LmvKSd40PLGHUGApkYVXhmvUsQqBVZqsHbklXwf5WDjXqUeS+MgAb0SC
         cUMa6riGyjyr7kyo5gS8/9mRxMQcEq1+sebw1R19rj1O8WcEkNYBUFE9TkcroECFPA
         CzXkqR1TWqLIdDk4VJKwwMpr5B9+wNAP0RLaYpI5sxOGw2fZr/wUL7pOeFunkEf1yP
         RbYIeWxvBPyj5nQB9XLmatTdeSFsRlI3kF7Qixd5A+4ag6NwST1hw8bO0Y4zKuxHlr
         +udFxyarjJ9CA==
Date:   Wed, 6 Jul 2022 11:33:57 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH v3 4/5] check: append bad / notrun arrays in helper
 function
Message-ID: <YsXVlYiVPTkioL1N@magnolia>
References: <20220706112312.4349-1-ddiss@suse.de>
 <20220706112312.4349-5-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706112312.4349-5-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 06, 2022 at 01:23:11PM +0200, David Disseldorp wrote:
> Currently the @try, @bad and @notrun arrays are appended with seqnum at
> different points in the main run_section() loop:
> - @try: shortly prior to test script execution
> - @notrun: on list (check -n), or after .notrun flagged test completion
> - @bad: at the start of subsequent test loop and loop exit
> 
> For future loop-test-following-failure functionality it makes sense to
> combine some of these steps. This change moves both @notrun and @bad
> appends into a helper function which is called at the end of each loop
> iteration.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>

I like this better, since this reduces the distance between setting
tc_status and feeding it to _stash_test_status.

Another cleanup would be to eliminate $tc_status entirely, but that's
for another day. ;)

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  check | 68 ++++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 39 insertions(+), 29 deletions(-)
> 
> diff --git a/check b/check
> index 08857f7e..6dbdb2a8 100755
> --- a/check
> +++ b/check
> @@ -553,6 +553,32 @@ _expunge_test()
>  	return 0
>  }
>  
> +# Retain in @bad / @notrun the result of the just-run @test_seq. @try array
> +# entries are added prior to execution.
> +_stash_test_status() {
> +	local test_seq="$1"
> +	local test_status="$2"
> +
> +	if $do_report && [[ $test_status != "expunge" ]]; then
> +		_make_testcase_report "$section" "$test_seq" \
> +				      "$test_status" "$((stop - start))"
> +	fi
> +
> +	case "$test_status" in
> +	fail)
> +		bad+=("$test_seq")
> +		;;
> +	list|notrun)
> +		notrun+=("$test_seq")
> +		;;
> +	pass|expunge)
> +		;;
> +	*)
> +		echo "Unexpected test $test_seq status: $test_status"
> +		;;
> +	esac
> +}
> +
>  # Can we run systemd scopes?
>  HAVE_SYSTEMD_SCOPES=
>  systemctl reset-failed "fstests-check" &>/dev/null
> @@ -732,19 +758,8 @@ function run_section()
>  	seqres="$check"
>  	_check_test_fs
>  
> -	local tc_status="init"
> -	prev_seq=""
> +	local tc_status
>  	for seq in $list ; do
> -		# Run report for previous test!
> -		if [ "$tc_status" == "fail" ]; then
> -			bad+=("$seqnum")
> -		fi
> -		if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
> -			_make_testcase_report "$section" "$seqnum" \
> -					      "$tc_status" "$((stop - start))"
> -		fi
> -
> -		prev_seq="$seq"
>  		if [ ! -f $seq ]; then
>  			# Try to get full name in case the user supplied only
>  			# seq id and the test has a name. A bit of hassle to
> @@ -784,20 +799,21 @@ function run_section()
>  		if $showme; then
>  			_expunge_test $seqnum
>  			if [ $? -eq 1 ]; then
> -			    tc_status="expunge"
> -			    continue
> +				tc_status="expunge"
> +			else
> +				echo
> +				start=0
> +				stop=0
> +				tc_status="list"
>  			fi
> -			echo
> -			start=0
> -			stop=0
> -			tc_status="list"
> -			notrun+=("$seqnum")
> +			_stash_test_status "$seqnum" "$tc_status"
>  			continue
>  		fi
>  
>  		tc_status="pass"
>  		if [ ! -f $seq ]; then
>  			echo " - no such test?"
> +			_stash_test_status "$seqnum" "$tc_status"
>  			continue
>  		fi
>  
> @@ -808,6 +824,7 @@ function run_section()
>  		_expunge_test $seqnum
>  		if [ $? -eq 1 ]; then
>  			tc_status="expunge"
> +			_stash_test_status "$seqnum" "$tc_status"
>  			continue
>  		fi
>  
> @@ -857,8 +874,8 @@ function run_section()
>  			$timestamp && echo " [not run]" && \
>  				      echo -n "	$seqnum -- "
>  			cat $seqres.notrun
> -			notrun+=("$seqnum")
>  			tc_status="notrun"
> +			_stash_test_status "$seqnum" "$tc_status"
>  
>  			# Unmount the scratch fs so that we can wipe the scratch
>  			# dev state prior to the next test run.
> @@ -903,6 +920,7 @@ function run_section()
>  		if [ ! -f $seq.out ]; then
>  			_dump_err "no qualified output"
>  			tc_status="fail"
> +			_stash_test_status "$seqnum" "$tc_status"
>  			continue;
>  		fi
>  
> @@ -938,17 +956,9 @@ function run_section()
>  				rm -f $seqres.hints
>  			fi
>  		fi
> +		_stash_test_status "$seqnum" "$tc_status"
>  	done
>  
> -	# make sure we record the status of the last test we ran.
> -	if [ "$tc_status" == "fail" ]; then
> -		bad+=("$seqnum")
> -	fi
> -	if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
> -		_make_testcase_report "$section" "$seqnum" "$tc_status" \
> -				      "$((stop - start))"
> -	fi
> -
>  	sect_stop=`_wallclock`
>  	interrupt=false
>  	_wrapup
> -- 
> 2.35.3
> 
