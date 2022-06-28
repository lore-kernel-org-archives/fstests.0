Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDD2C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Jun 2022 22:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiF1Weg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jun 2022 18:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiF1Weg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2022 18:34:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94323A198
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2022 15:34:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D40E21BF9;
        Tue, 28 Jun 2022 22:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656455673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G1QRdkgBA+Mgb+Q4anZGa2e8xwYhxyY00LIjJtOJSFA=;
        b=vggXH92em5NttuSWsEa7V7L0YDSZSqJ5wB35B0/a4+C+TxfscLzdvI1FCbTXa06mq4HUO+
        Bb4DbCMauLtICMJAqm7IC+J0/3/h3tBpNOUSBVtzC0fNv0VXiQXSeqfTjre/Caggl4s5RN
        ngiUib25d1SJ78ypF8NLhKf2i/a757I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656455673;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G1QRdkgBA+Mgb+Q4anZGa2e8xwYhxyY00LIjJtOJSFA=;
        b=yDMDNisQGV6B6RoFFqAGxsBK7+1pYmxjOVNZ/klzxAbYfUKLnQjUs43Kqa5Nmb7VJY8LWO
        2JtVuG8mSrNZnuCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49BBE13ACA;
        Tue, 28 Jun 2022 22:34:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XXx8EPmBu2IaGQAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 28 Jun 2022 22:34:33 +0000
Date:   Wed, 29 Jun 2022 00:34:32 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, tytso@mit.edu
Subject: Re: [RFC PATCH v2 5/6] check: add -L <n> parameter to rerun failed
 tests
Message-ID: <20220629003432.665c9872@suse.de>
In-Reply-To: <Yrsa+wO6vLcsvcJ3@magnolia>
References: <20220627222256.14175-1-ddiss@suse.de>
        <20220627222256.14175-6-ddiss@suse.de>
        <Yrsa+wO6vLcsvcJ3@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Thanks for the review, Darrick...

On Tue, 28 Jun 2022 08:15:07 -0700, Darrick J. Wong wrote:

> On Tue, Jun 28, 2022 at 12:22:55AM +0200, David Disseldorp wrote:
> > If check is run with -L <n>, then a failed test will be rerun <n> times
> > before proceeding to the next test. Following completion of the rerun
> > loop, aggregate pass/fail statistics are printed.
> > 
> > Rerun tests will be tracked as a single failure in overall pass/fail
> > metrics (via @try and @bad), with .out.bad, .dmesg and .full saved using
> > a .rerun# suffix.
> > 
> > Suggested-by: Theodore Ts'o <tytso@mit.edu>
> > Link: https://lwn.net/Articles/897061/
> > Signed-off-by: David Disseldorp <ddiss@suse.de>
> > ---
> >  check         | 94 ++++++++++++++++++++++++++++++++++++++++++++-------
> >  common/report |  8 +++--
> >  2 files changed, 88 insertions(+), 14 deletions(-)
> > 
> > diff --git a/check b/check
> > index aa7dac2f..726c83d9 100755
> > --- a/check
> > +++ b/check
> > @@ -26,6 +26,7 @@ do_report=false
> >  DUMP_OUTPUT=false
> >  iterations=1
> >  istop=false
> > +loop_on_fail=0
> >  
> >  # This is a global variable used to pass test failure text to reporting gunk
> >  _err_msg=""
> > @@ -75,6 +76,7 @@ check options
> >      --large-fs		optimise scratch device for large filesystems
> >      -s section		run only specified section from config file
> >      -S section		exclude the specified section from the config file
> > +    -L <n>		loop tests <n> times following a failure, measuring aggregate pass/fail metrics
> >  
> >  testlist options
> >      -g group[,group...]	include tests from these groups
> > @@ -333,6 +335,9 @@ while [ $# -gt 0 ]; do
> >  		;;
> >  	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
> >  	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
> > +	-L)	[[ $2 =~ ^[0-9]+$ ]] || usage
> > +		loop_on_fail=$2; shift
> > +		;;
> >  
> >  	-*)	usage ;;
> >  	*)	# not an argument, we've got tests now.
> > @@ -555,6 +560,18 @@ _expunge_test()
> >  _stash_test_status() {
> >  	local test_seq="$1"
> >  	local test_status="$2"
> > +	local test_time="$3"
> > +	local loop_num="$4"
> > +	local report_msg="$5"
> > +
> > +	if $do_report && [[ ! $test_status =~ ^(init|expunge)$ ]]; then
> > +		_make_testcase_report "$section" "$test_seq" \
> > +				      "$test_status" "$test_time" \
> > +				      "$report_msg"
> > +	fi
> > +
> > +	# only stash result for first failure (triggering loop)
> > +	((loop_num > 1)) && return
> >  
> >  	case "$test_status" in
> >  	fail)
> > @@ -610,6 +627,38 @@ _run_seq() {
> >  	fi
> >  }
> >  
> > +# Check whether the last test should be rerun according to loop-on-error state
> > +# and return "0" if so, otherwise return "1".  
> 
> Er... this echoes 0 and 1, and the return value of the function is
> neither checked nor set to anything other than zero, right?

Right. run_section() test list iteration uses this helper to
conditionally increment the test index, depending on whether or not a
rerun (following test failure) is required.

> I'm also not sure what 'ix' stands for?

Index... I figured 'i' would get stomped on and didn't come up with a
better name at the time :)

> > +_ix_inc() {
> > +	local test_status="$1"
> > +	local loop_len="$2"
> > +
> > +	if ((!loop_on_fail)); then
> > +		echo 1
> > +		return
> > +	fi
> > +
> > +	if [ "$test_status" == "fail" ] && ((!loop_len)); then
> > +		echo 0	# initial failure of this test, start loop-on-fail
> > +	elif ((loop_len > 0)) && ((loop_len < loop_on_fail)); then
> > +		echo 0	# continue loop following initial failure
> > +	else
> > +		echo 1	# completed or not currently in a failure loop
> > +	fi
> > +}
> > +
> > +_failure_loop_dump_stats() {
> > +	awk "BEGIN {
> > +		n=split(\"$*\", arr);"'
> > +		for (i = 1; i <= n; i++)
> > +			stats[arr[i]]++;
> > +		printf("aggregate results across %d runs: ", n);
> > +		for (x in stats)
> > +			printf("%s=%d (%.1f%%)", (i-- > n ? x : ", " x),
> > +			       stats[x], 100 * stats[x] / n);
> > +	     }'
> > +}
> > +
> >  _detect_kmemleak
> >  _prepare_test_list
> >  
> > @@ -750,14 +799,29 @@ function run_section()
> >  	seqres="$check"
> >  	_check_test_fs
> >  
> > -	local tc_status="init"
> > +	local tc_status="init" ix agg_msg
> >  	prev_seq=""
> > -	for seq in $list ; do
> > +	local -a _list=( $list ) loop_status=()
> > +	for ((ix = 0; ix < ${#_list[*]};
> > +	      ix += $(_ix_inc "$tc_status" "${#loop_status[*]}"))); do

Here is the _ix_inc caller ^^. It's a bit convoluted so I could probably
turn it into a while loop and put the increment logic here. Not sure how
much simpler it'd be though.

> > +		seq="${_list[$ix]}"
> > +
> > +		if [ "$seq" == "$prev_seq" ]; then
> > +			loop_status+=("$tc_status")
> > +		elif ((${#loop_status[*]})); then
> > +			# leaving rerun-on-failure loop
> > +			loop_status+=("$tc_status")
> > +			agg_msg=$(_failure_loop_dump_stats "${loop_status[@]}")
> > +			echo "$seqnum $agg_msg"
> > +		fi
> > +
> >  		# Run report for previous test!
> > -		_stash_test_status "$seqnum" "$tc_status"
> > -		if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
> > -			_make_testcase_report "$section" "$seqnum" \
> > -					      "$tc_status" "$((stop - start))"
> > +		_stash_test_status "$seqnum" "$tc_status" "$((stop - start))" \
> > +				   "${#loop_status[*]}" "$agg_msg"
> > +
> > +		if [ -n "$agg_msg" ]; then
> > +			loop_status=()
> > +			agg_msg=""
> >  		fi
> >  
> >  		prev_seq="$seq"
> > @@ -827,7 +891,9 @@ function run_section()
> >  		fi
> >  
> >  		# record that we really tried to run this test.
> > -		try+=("$seqnum")
> > +		if ((!${#loop_status[*]})); then
> > +			try+=("$seqnum")
> > +		fi
> >  
> >  		awk 'BEGIN {lasttime="       "} \
> >  		     $1 == "'$seqnum'" {lasttime=" " $2 "s ... "; exit} \
> > @@ -954,13 +1020,17 @@ function run_section()
> >  		fi
> >  	done
> >  
> > -	# make sure we record the status of the last test we ran.
> > -	_stash_test_status "$seqnum" "$tc_status"
> > -	if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
> > -		_make_testcase_report "$section" "$seqnum" "$tc_status" \
> > -				      "$((stop - start))"
> > +	if ((${#loop_status[*]})); then
> > +		# leaving rerun-on-failure loop
> > +		loop_status+=("$tc_status")
> > +		agg_msg=$(_failure_loop_dump_stats "${loop_status[@]}")
> > +		echo "$seqnum $agg_msg"
> >  	fi
> >  
> > +	# Run report for previous test!
> > +	_stash_test_status "$seqnum" "$tc_status" "$((stop - start))" \
> > +			   "${#loop_status[*]}" "$agg_msg"
> > +
> >  	sect_stop=`_wallclock`
> >  	interrupt=false
> >  	_wrapup
> > diff --git a/common/report b/common/report
> > index 5ca41bc4..cede4987 100644
> > --- a/common/report
> > +++ b/common/report
> > @@ -71,6 +71,7 @@ _xunit_make_testcase_report()
> >  	local test_name="$2"
> >  	local test_status="$3"
> >  	local test_time="$4"
> > +	local test_md="$5"  
> 
> ...or what "md" here means.

Test (result) metadata.

> >  	# TODO: other places may also win if no-section mode will be named like 'default/global'
> >  	if [ $sect_name == '-no-sections-' ]; then
> > @@ -79,7 +80,8 @@ _xunit_make_testcase_report()
> >  	fi
> >  	local report=$tmp.report.xunit.$sect_name.xml
> >  
> > -	echo -e "\t<testcase classname=\"xfstests.$sect_name\" name=\"$test_name\" time=\"$test_time\">" >> $report
> > +	[ -n "$test_md" ] && test_md=" status=\"$(echo "$test_md"|encode_xml)\""  
> 
> AFAICT the junit xml schema defines a @status attribute for <testcase>.
> 
> https://raw.githubusercontent.com/windyroad/JUnit-Schema/master/JUnit.xsd

^ hmm, I don't see a @status attribute under your link. I was using a
different reference...

> And yes, it's confusing that fstests namespaced all this code with
> 'xunit', since there's a separate xunit test reporting schema too!

It is absolutely confusing. I've been using
https://llg.cubic.org/docs/junit/ but only came across that by searching
for specific attribute names.

> That said -- I'm not sure what's supposed to end up in this attribute?
> It looks like it's supposed to capture the aggregation report?

Correct, it's just the aggregation report for now.

> But then I wonder, why not stick to adding a separate <testcase> element
> for each test run, even the repeated ones?  And let the xml consumer
> compute aggregation statistics from the elements?

This v2 patchset does add a <testcase> element for each rerun, with the
aggregation stats attached to the last rerun . The
aggregation stats are already calculated for non-xunit output, and
passing it through for xunit only costs a few lines of code. However, if
the @status attribute isn't an option then I suppose I could drop it -
Ted also mentioned that it's unnecessary.

Cheers, David
