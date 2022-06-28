Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3B9C43334
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Jun 2022 15:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346485AbiF1PAI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jun 2022 11:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347050AbiF1PAG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2022 11:00:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F289D2B278
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2022 08:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FD5CB81EAF
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2022 15:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE8EC341C6;
        Tue, 28 Jun 2022 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656428402;
        bh=eWkBVjdAAxdDy6UGUom+7glUlyeZazpIsRhmbwyY9ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rnf2KF6EzzouYlIybNRak1Rue7/B+5ucy62N2Co19cV4aLJ27ybYLEdkuSJNJjNBp
         3GfgdmH8yxaz6Lnpxr4W5aFuLk4WcehKvPd+ANDBchv7KkDmmgJDhPFFTrVKfFb4hv
         hO1RYGZ+dw8QHvH8rJt9Yb1ETwBYp0tnkGZu0Hdm9EYT/YYPDd2Xc3ohnY4TwWShDH
         qdq07m6wTPCmFx3PhYH1ipPQQKp3DcNfb7PbvxRaLGqbQRnh/i58S6d83HZ6cxp7CC
         bsVPEM1vmEBw/Sl7UpcYOhtdJ4NxtQx9zrZUBzHQYnc9ReRIGrgZdPR8fs6o/7NLiR
         tpy1BsbiyJ0Vw==
Date:   Tue, 28 Jun 2022 08:00:01 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, tytso@mit.edu
Subject: Re: [RFC PATCH v2 4/6] check: append bad / notrun arrays in helper
 function
Message-ID: <YrsXcVkWjOYFrqZs@magnolia>
References: <20220627222256.14175-1-ddiss@suse.de>
 <20220627222256.14175-5-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627222256.14175-5-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 28, 2022 at 12:22:54AM +0200, David Disseldorp wrote:
> Currently the @try, @bad and @notrun arrays are appended with seqnum at
> different points in the main run_section() loop:
> - @try: shortly prior to test script execution
> - @notrun: on list (check -n), or after .notrun flagged test completion
> - @bad: at the start of subsequent test loop and loop exit
> 
> For future loop-test-following-failure functionality it makes sense to
> combine some of these steps. This change moves both @notrun and @bad
> appends into a helper function.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  check | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/check b/check
> index f973dd28..aa7dac2f 100755
> --- a/check
> +++ b/check
> @@ -550,6 +550,27 @@ _expunge_test()
>  	return 0
>  }
>  
> +# Retain in @bad / @notrun the result of previously run @test_seq. @try array
> +# entries are added prior to execution.
> +_stash_test_status() {
> +	local test_seq="$1"
> +	local test_status="$2"
> +
> +	case "$test_status" in
> +	fail)
> +		bad+=("$test_seq")
> +		;;
> +	list|notrun)
> +		notrun+=("$test_seq")
> +		;;
> +	pass|expunge|init)
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
> @@ -733,9 +754,7 @@ function run_section()
>  	prev_seq=""
>  	for seq in $list ; do
>  		# Run report for previous test!
> -		if [ "$tc_status" == "fail" ]; then
> -			bad+=("$seqnum")
> -		fi
> +		_stash_test_status "$seqnum" "$tc_status"
>  		if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
>  			_make_testcase_report "$section" "$seqnum" \
>  					      "$tc_status" "$((stop - start))"
> @@ -788,7 +807,6 @@ function run_section()
>  			start=0
>  			stop=0
>  			tc_status="list"
> -			notrun+=("$seqnum")
>  			continue
>  		fi
>  
> @@ -854,7 +872,6 @@ function run_section()
>  			$timestamp && echo " [not run]" && \
>  				      echo -n "	$seqnum -- "
>  			cat $seqres.notrun
> -			notrun+=("$seqnum")

Ahh, it took me a minute to figure out that removing this line was ok
because we'll either jump back to the top of the loop or fall out below.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


>  			tc_status="notrun"
>  
>  			# Unmount the scratch fs so that we can wipe the scratch
> @@ -938,9 +955,7 @@ function run_section()
>  	done
>  
>  	# make sure we record the status of the last test we ran.
> -	if [ "$tc_status" == "fail" ]; then
> -		bad+=("$seqnum")
> -	fi
> +	_stash_test_status "$seqnum" "$tc_status"
>  	if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
>  		_make_testcase_report "$section" "$seqnum" "$tc_status" \
>  				      "$((stop - start))"
> -- 
> 2.35.3
> 
