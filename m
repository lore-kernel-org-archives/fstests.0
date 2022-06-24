Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3AEC43334
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jun 2022 04:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiFXEmM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 00:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiFXEmK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 00:42:10 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCAB680AA
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 21:42:09 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25O4g4xX007086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 00:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656045725; bh=LA69DI+gXKlJehPYLEpnzvpak9m1zQ3/ZzHaLtnXk08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=m7UvezJ2KjxS9QMq9Rxf1XAzfOjTPbmmbLE3xTRwxjvNxdA7lJkAGc1knfn9fhWmb
         tuHwzxJLeL4tgHMR5X1nxIg8/eJBsxosWxRcovV45sH5R3s2JRAozghE7Y/005K92Z
         eSAF5eVnglZkyNS1SLmJhfpi61b/nb2cYP0aEcvnvMw1Zi0bvCsrMiA5q1+OlZkJga
         oLXx7YqKS6lZp+rgBltdyXD7dGhvXzwpFbWZkCcf4b9M49Y8xtOIfY5YKTdB6j80Zp
         xfhmVtGcuWvC1lGFIroCQMIFt3hcMYbMaSibYlUwxoHw0uMlEEzNK4dlWJyyaBPELO
         zGXWY5bdSk/tg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 00F3315C42F6; Fri, 24 Jun 2022 00:42:03 -0400 (EDT)
Date:   Fri, 24 Jun 2022 00:42:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] add option to rerun failed tests
Message-ID: <YrVAm6dzTUh3ufb6@mit.edu>
References: <20220621160153.29591-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621160153.29591-1-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 21, 2022 at 06:01:51PM +0200, David Disseldorp wrote:
> This RFC patchset adds support to loop on failed tests, as proposed by
> Ted Ts'o in https://lwn.net/Articles/897061/:
>   add a mode that will immediately rerun a failed test 25 or 100 times
>   to establish a failure percentage.
> 
> There are a couple of things which I'd like to resolve before dropping
> the RFC flag, but would appreciate early feedback on the approach here.

This is really exciting!  I was hoping to try it out, but the first
patch doesn't apply to origin/master on xfstests-dev.

For example this patch hunk:

@@ -729,9 +750,7 @@ function run_section()
 	prev_seq=""
 	for seq in $list ; do
 		# Run report for previous test!
-		if [ "$tc_status" == "fail" ]; then
-			bad+=("$seqnum")
-		fi
+		_stash_test_status "$seqnum" "$tc_status"
 		if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
 			_make_testcase_report "$prev_seq" "$tc_status"
 		fi

The relevant section of check looks like this:

		# Run report for previous test!
		if $err ; then
			bad="$bad $seqnum"
			n_bad=`expr $n_bad + 1`
			tc_status="fail"
		fi

And "git blame" shows that this part of check hasn't changed since
2018, and I'm on the latest version upstream version of xfstests:

commit 568ac9fffeb6afec03e5d6c9936617232fd7fc6d (HEAD, tag: v2022.06.05, origin/master, origin/HEAD, kernel/master)
Author: Dave Chinner <dchinner@redhat.com>
Date:   Fri Jun 3 11:54:13 2022 +1000

    xfs/189: systemd monitoring of /etc/fstab sucks


Was your patch based xfstests with some out-of-tree patches?

> The caveats are:
> - rerun tests will be tracked as a single failure in @try and @bad
>   + xunit reports do not include any rerun details
> - .bad files generated on failure will be overwritten by test reruns
> 
> For xunit reports, I think it'll make sense to stash the aggregates in a
> separate <test>.agg-results file or something. Similarly for .bad file
> overwrites, I could add a .<rerun #> suffix for capturing all failure
> data.

For xunit results fie, was assuming that simply we would just have
multiple repeated testcase entries stored in the single results.xml
file.  For example:

<testcase classname="xfstests.global" name="generic/476" time="354">
		<failure message="Test  failed, reason unknown" type="TestFail" />
		<system-out>
		...
	</testcase>
<testcase classname="xfstests.global" name="generic/476" time="343">
	</testcase>
<testcase classname="xfstests.global" name="generic/476" time="353">
	</testcase>
	...

I don't know that we need a separate file for the rerun tests, since
it's not that hard to create a python script which parses the results
and calculates the pass/fail percentages for any test which is run
mutiple times.


As far as haivng the .bad and .full files, I agree that some kind of
.rerun-NN suffix would make a lot of sense.

Cheers,

						- Ted
