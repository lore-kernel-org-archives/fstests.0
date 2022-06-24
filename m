Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA168C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jun 2022 08:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiFXIcs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 04:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiFXIcr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 04:32:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B809B77FC6
        for <fstests@vger.kernel.org>; Fri, 24 Jun 2022 01:32:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70F6E21AE0;
        Fri, 24 Jun 2022 08:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656059564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NjFRkGnVAl8u2AEnmt8bcRZBqxmu9/pg+3Gt9rPZfH8=;
        b=XVzgKQlVmdUyRt9m8YN+dDMbqH5SIYqrpige+XWTZFARiZKh/2XqNdjv374KT+/SgmuGP4
        WyD0Lzr96sRkfboabJQs+ekYD/rYJHuQ3IcMSytyTqBWpjMhIzAjyo/a1oazN3mLUsBNNQ
        ZtUNIeyCck+/YyoZejJ9jn9/WxbvT9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656059564;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NjFRkGnVAl8u2AEnmt8bcRZBqxmu9/pg+3Gt9rPZfH8=;
        b=XXN942/4bGp2+9IlB4uI5j0NmrwQ1fu1Z32ROzAKVEPinBx7dDElFOJz0k33tH4ahEgl9e
        KONtqbrTzri89iBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4878F13480;
        Fri, 24 Jun 2022 08:32:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pfk1EKx2tWLdbAAAMHmgww
        (envelope-from <ddiss@suse.de>); Fri, 24 Jun 2022 08:32:44 +0000
Date:   Fri, 24 Jun 2022 10:32:43 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] add option to rerun failed tests
Message-ID: <20220624103243.10188970@suse.de>
In-Reply-To: <YrVAm6dzTUh3ufb6@mit.edu>
References: <20220621160153.29591-1-ddiss@suse.de>
        <YrVAm6dzTUh3ufb6@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Thanks for the feedback, Ted...

On Fri, 24 Jun 2022 00:42:03 -0400, Theodore Ts'o wrote:

> On Tue, Jun 21, 2022 at 06:01:51PM +0200, David Disseldorp wrote:
> > This RFC patchset adds support to loop on failed tests, as proposed by
> > Ted Ts'o in https://lwn.net/Articles/897061/:
> >   add a mode that will immediately rerun a failed test 25 or 100 times
> >   to establish a failure percentage.
> > 
> > There are a couple of things which I'd like to resolve before dropping
> > the RFC flag, but would appreciate early feedback on the approach here.  
> 
> This is really exciting!  I was hoping to try it out, but the first
> patch doesn't apply to origin/master on xfstests-dev.
> 
> For example this patch hunk:
> 
> @@ -729,9 +750,7 @@ function run_section()
>  	prev_seq=""
>  	for seq in $list ; do
>  		# Run report for previous test!
> -		if [ "$tc_status" == "fail" ]; then
> -			bad+=("$seqnum")
> -		fi
> +		_stash_test_status "$seqnum" "$tc_status"
>  		if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
>  			_make_testcase_report "$prev_seq" "$tc_status"
>  		fi
> 
> The relevant section of check looks like this:
> 
> 		# Run report for previous test!
> 		if $err ; then
> 			bad="$bad $seqnum"
> 			n_bad=`expr $n_bad + 1`
> 			tc_status="fail"
> 		fi
> 
> And "git blame" shows that this part of check hasn't changed since
> 2018, and I'm on the latest version upstream version of xfstests:
> 
> commit 568ac9fffeb6afec03e5d6c9936617232fd7fc6d (HEAD, tag: v2022.06.05, origin/master, origin/HEAD, kernel/master)
> Author: Dave Chinner <dchinner@redhat.com>
> Date:   Fri Jun 3 11:54:13 2022 +1000
> 
>     xfs/189: systemd monitoring of /etc/fstab sucks
> 
> 
> Was your patch based xfstests with some out-of-tree patches?

Yes, I forgot to mention that, sorry. As Zorro indicated, these were
done atop the v2022.06.12 tag with the following series applied:
https://lore.kernel.org/fstests/20220620192934.21694-1-ddiss@suse.de/

> > The caveats are:
> > - rerun tests will be tracked as a single failure in @try and @bad
> >   + xunit reports do not include any rerun details
> > - .bad files generated on failure will be overwritten by test reruns
> > 
> > For xunit reports, I think it'll make sense to stash the aggregates in a
> > separate <test>.agg-results file or something. Similarly for .bad file
> > overwrites, I could add a .<rerun #> suffix for capturing all failure
> > data.  
> 
> For xunit results fie, was assuming that simply we would just have
> multiple repeated testcase entries stored in the single results.xml
> file.  For example:
> 
> <testcase classname="xfstests.global" name="generic/476" time="354">
> 		<failure message="Test  failed, reason unknown" type="TestFail" />
> 		<system-out>
> 		...
> 	</testcase>
> <testcase classname="xfstests.global" name="generic/476" time="343">
> 	</testcase>
> <testcase classname="xfstests.global" name="generic/476" time="353">
> 	</testcase>
> 	...

That seems sensible, I'll add this functionality.

> I don't know that we need a separate file for the rerun tests, since
> it's not that hard to create a python script which parses the results
> and calculates the pass/fail percentages for any test which is run
> mutiple times.

It's just a string, so doesn't need to be in a file. I'll add an extra
parameter to _make_testcase_report so that it can be stashed somewhere
like <testcase ... status="$aggregate_stats"> on the last rerun.

> As far as haivng the .bad and .full files, I agree that some kind of
> .rerun-NN suffix would make a lot of sense.

I had a bit of a play with this and it does get a bit ugly if we want to
prefix things like .dmesg as well. The xunit rerun entries will already
capture everything, but I suppose it's still needed for those not using
xunit reports.

Cheers, David
