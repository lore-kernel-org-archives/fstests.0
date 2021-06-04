Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BC4C47082
	for <linux-fstests@archiver.kernel.org>; Fri,  4 Jun 2021 02:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B826140A
	for <linux-fstests@archiver.kernel.org>; Fri,  4 Jun 2021 02:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFDChf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Jun 2021 22:37:35 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:43982 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229769AbhFDChf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Jun 2021 22:37:35 -0400
Received: from dread.disaster.area (pa49-179-138-183.pa.nsw.optusnet.com.au [49.179.138.183])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 68F5A1AF97D;
        Fri,  4 Jun 2021 12:35:48 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lozgZ-008hvR-Be; Fri, 04 Jun 2021 12:35:47 +1000
Date:   Fri, 4 Jun 2021 12:35:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: add basic ftrace support
Message-ID: <20210604023547.GA2068689@dread.disaster.area>
References: <20210603062113.133326-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603062113.133326-1-wqu@suse.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=MnllW2CieawZLw/OcHE/Ng==:117 a=MnllW2CieawZLw/OcHE/Ng==:17
        a=kj9zAlcOel0A:10 a=r6YtysWOX24A:10 a=iox4zFpeAAAA:8 a=7-415B0cAAAA:8
        a=9PEk-gOpZFGhZMhgGrsA:9 a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 03, 2021 at 02:21:13PM +0800, Qu Wenruo wrote:
> Sometimes developers want trace dump for certain test cases.
> 
> Normally I just add "trace-cmd" calls in "check", but it would be much
> better to let fstests to support ftrace dumping.
> 
> This patchset will add basic ftrace dumping support by:
> 
> - Clear all buffers before running each test
> - Start tracing before running each test
> - End tracing after test finished
> - Copy the trace to "$seqres.trace" if needed
>   The condition is either:
>   * $KEEP_TRACE environment is set to "yes"
>   * The test case failed
> 
> Currently we only support the main ftrace buffer, but all supporting
> functions have support for ftrace instances, for later expansion.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add explanation in "common/config" for how to use it
> - Make variables local
> - Don't create the instance when clearing buffers
> ---
>  check         | 12 +++++++-
>  common/config |  8 +++++
>  common/ftrace | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  common/rc     |  1 +
>  4 files changed, 103 insertions(+), 1 deletion(-)
>  create mode 100644 common/ftrace
> 
> diff --git a/check b/check
> index ba192042..0a09dcf9 100755
> --- a/check
> +++ b/check
> @@ -801,7 +801,7 @@ function run_section()
>  		fi
>  
>  		# really going to try and run this one
> -		rm -f $seqres.out.bad
> +		rm -f $seqres.out.bad $seqres.trace
>  
>  		# check if we really should run it
>  		_expunge_test $seqnum
> @@ -839,6 +839,10 @@ function run_section()
>  		# to be reported for each test
>  		(echo 1 > $DEBUGFS_MNT/clear_warn_once) > /dev/null 2>&1
>  
> +		# Clear previous trace and start new trace
> +		_clear_trace_buffers
> +		_start_trace

So how does one enable all 500+ xfs tracepoints for this? Or just
some subset? i.e. how do we pass it a list of events like we do
trace-cmd?  IOWs, for this to be actually useful as a replacement
for trace-cmd, it has to be able to replace invocations like this:

# trace-cmd record -e xfs_i*lock* -e xfs_buf* -e printk -e iomap* ....

which is how I use trace-cmd 99.9% of the time I'm debugging fstests
using tracepoints.

Next: some tests will generate gigabytes of trace data on XFS. I'm
not joking here - I regularly am looking for single traces in an
output file that contains tens of millions of events in it. Having
fstests run with tracing enabled is going to rapidly cause ENOSPC
problems on test machines, and that's going to cause test harness
issues...

Hence I don't think that unilaterally turning on tracing is a good
idea. I think it should only run if we set a value in the config
section for the test run. This allows a user to define two identical
test sections except one has "ENABLE_TRACE=true" in it and the other
doesn't. Hence they can run:

# check -s xfs -g auto

to get a normal, non-traced run done. Then, for all the failures
reported, run:

# check -s xfs_trace <trace specification> <failed tests>

and get those tests run with tracing enabled instead of running

# trace-cmd record <trace specification> check -s xfs <failed tests>

Finally, I also don't want fstests perturbing whatever tracing I'm
doing externally to fstests, so being having it enable tracing only
when I want it to enable tracing is somewhat important...

> +#                   NOTE: to dump ftrace buffer one needs to enable ftrace
> +#                   events or add custom trace_printk() into the fs code.
> +#                   And since fstest will clear buffer before running one
> +#                   test case, existing trace-cmd can be interrupted.

trace_printk is only a small part of the tracing I use with
trace-cmd. If we can't configure trace event output through this
interface, then it's really not a replacement for using trace-cmd...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
