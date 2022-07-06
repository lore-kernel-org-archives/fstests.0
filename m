Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DCFC43334
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Jul 2022 21:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiGFVy5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 Jul 2022 17:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiGFVy4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Jul 2022 17:54:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E068D275E6
        for <fstests@vger.kernel.org>; Wed,  6 Jul 2022 14:54:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0CF1F21D41;
        Wed,  6 Jul 2022 21:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657144494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pLC/Moe5rQl1vuy9xEX43Pr9T7Gv3WjznWWknnytn80=;
        b=BGX+Olvctw6AOVM8Q7VGiUNJ7qiDU1KWq2xWk2hacJkvvs7N4JaAcQanDtVyUEuiQcw8Oo
        kCkb9NQ7Z+ON4d3eNxRKm38M6fvqLavUi5FnWQVaZQDQy3civoji425wiMzedsw205jf3Y
        QxSNzLymPeP5+vjOJ2OYEbKbHluiOvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657144494;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pLC/Moe5rQl1vuy9xEX43Pr9T7Gv3WjznWWknnytn80=;
        b=qgvQbPaINhYMsjbpn0y+e1963ZWUGWLeiwLGDITmdMAgEJ1fazqPP+9aJZRLwZ63/0zo0X
        +oVJazIa6sGFfLDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC5DE134CF;
        Wed,  6 Jul 2022 21:54:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pRg+NK0ExmKBHgAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 06 Jul 2022 21:54:53 +0000
Date:   Wed, 6 Jul 2022 23:54:52 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH v3 5/5] check: add -L <n> parameter to rerun failed
 tests
Message-ID: <20220706235452.694341f0@suse.de>
In-Reply-To: <YsXbt85xBNJIOwZu@magnolia>
References: <20220706112312.4349-1-ddiss@suse.de>
        <20220706112312.4349-6-ddiss@suse.de>
        <YsXbt85xBNJIOwZu@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Thanks for the follow-up feedback, Darrick...

On Wed, 6 Jul 2022 12:00:07 -0700, Darrick J. Wong wrote:

> On Wed, Jul 06, 2022 at 01:23:12PM +0200, David Disseldorp wrote:
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
> >  check | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 53 insertions(+), 3 deletions(-)
> > 
> > diff --git a/check b/check
> > index 6dbdb2a8..46fca6e6 100755
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
> > @@ -78,6 +79,7 @@ check options
> >      --large-fs		optimise scratch device for large filesystems
> >      -s section		run only specified section from config file
> >      -S section		exclude the specified section from the config file
> > +    -L <n>		loop tests <n> times following a failure, measuring aggregate pass/fail metrics
> >  
> >  testlist options
> >      -g group[,group...]	include tests from these groups
> > @@ -336,6 +338,9 @@ while [ $# -gt 0 ]; do
> >  		;;
> >  	--large-fs) export LARGE_SCRATCH_DEV=yes ;;
> >  	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
> > +	-L)	[[ $2 =~ ^[0-9]+$ ]] || usage
> > +		loop_on_fail=$2; shift
> > +		;;
> >  
> >  	-*)	usage ;;
> >  	*)	# not an argument, we've got tests now.
> > @@ -553,6 +558,18 @@ _expunge_test()
> >  	return 0
> >  }
> >  
> > +# retain files which would be overwritten in subsequent reruns of the same test
> > +_stash_fail_loop_files() {
> > +	local test_seq="$1"
> > +	local suffix="$2"
> > +
> > +	for i in "${REPORT_DIR}/${test_seq}.full" \
> > +		 "${REPORT_DIR}/${test_seq}.dmesg" \
> > +		 "${REPORT_DIR}/${test_seq}.out.bad"; do
> > +		[ -f "$i" ] && cp "$i" "${i}${suffix}"  
> 
> I wonder, is there any particular reason to copy the output file and let
> it get overwritten instead of simply mv'ing it?

The copy is left over from an earlier version I had where xunit report
generation was done after the copy. Looking closer:
- .full is removed in _begin_fstest()
- _check_dmesg() overwrites .dmesg and retains on failure or KEEP_DMESG
- out.bad is removed in the main check loop prior to seq invocation
- .notrun, .core and .hints are also removed in the check loop at
  various places before seq (.hints again in _begin_fstest())

One concern I have in changing this to a move is that external scripts
may check for presence / parse these files after check invocation. I'd
considered moving and then copying / symlinking back the .rerun0 files
on rerun-on-failure loop completion but that's also pretty ugly. IMO
leaving this as a copy, with the non-suffix file state left to reflect
the results of the last rerun-on-failure loop, would make the most
sense for now.

> > +	done
> > +}
> > +
> >  # Retain in @bad / @notrun the result of the just-run @test_seq. @try array
> >  # entries are added prior to execution.
> >  _stash_test_status() {
> > @@ -564,8 +581,35 @@ _stash_test_status() {
> >  				      "$test_status" "$((stop - start))"
> >  	fi
> >  
> > +	if ((${#loop_status[*]} > 0)); then
> > +		# continuing or completing rerun-on-failure loop
> > +		_stash_fail_loop_files "$test_seq" ".rerun${#loop_status[*]}"
> > +		loop_status+=("$test_status")
> > +		if ((${#loop_status[*]} > loop_on_fail)); then
> > +			printf "%s aggregate results across %d runs: " \
> > +				"$test_seq" "${#loop_status[*]}"
> > +			awk "BEGIN {
> > +				n=split(\"${loop_status[*]}\", arr);"'
> > +				for (i = 1; i <= n; i++)
> > +					stats[arr[i]]++;
> > +				for (x in stats)
> > +					printf("%s=%d (%.1f%%)",  
> 
> Hmm, if I parse this correctly, do you end up with something like:
> 
> "xfs/555 aggregate results across 15 runs: pass=5 (33.3%) fail=10 (66.7%)" ?

Yes, with a comma in between "... (33.3%), fail=10 ...".

> > +					       (i-- > n ? x : ", " x),
> > +					       stats[x], 100 * stats[x] / n);
> > +				}'
> > +			echo
> > +			loop_status=()
> > +		fi
> > +		return	# only stash @bad result for initial failure in loop
> > +	fi
> > +
> >  	case "$test_status" in
> >  	fail)
> > +		if ((loop_on_fail > 0)); then
> > +			# initial failure, start rerun-on-failure loop
> > +			_stash_fail_loop_files "$test_seq" ".rerun0"
> > +			loop_status+=("$test_status")  
> 
> So if I'm reading this right, the length of the $loop_status array is
> what gates us moving on or retrying, right?  If the length is zero, then
> we move on to the next test; otherwise, that loopy logic in
> _stash_test_result above will keep the same test running until the
> length exceeds loop_on_fail, at which point we print the aggregation
> report, empty out $loop_status, and then ix increments and we move on to
> the next test?

Yes, exactly.

Cheers, David
