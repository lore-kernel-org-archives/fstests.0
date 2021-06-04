Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1084C47425
	for <linux-fstests@archiver.kernel.org>; Fri,  4 Jun 2021 16:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31CB610A8
	for <linux-fstests@archiver.kernel.org>; Fri,  4 Jun 2021 16:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFDQcR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 4 Jun 2021 12:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFDQcR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 4 Jun 2021 12:32:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D377C613F4;
        Fri,  4 Jun 2021 16:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622824230;
        bh=hOkOCyImcqYnZ3mQ367D8L1lr1DrSb1NM0oEAHywkJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N3cHf+9A32jXXjB+Dfei+xhsTI/6O3jcmEYA5YGxKkRHFqPVLVhrH9HcJNtVOE12T
         PZuHUkm7nCBV+1cOyan6RMWEFYeuzykEavTPuJ40db6Mj7YbjWij7tKgrE/6b73X68
         wlTCRhWG4U54oUtgmDyrUeHfo7TpEdrMOldVUeF/nfMXTUMluXHeynPJ+Mz/uEtWrW
         zm9IEUz/bs+ao31HKvpKCa4ifhynekRTeqgGljKRIHcxjw1qC/+sodPeEtHWdAY9Ne
         D9pDr2IfZKJcLRV8daQdhw5yr50lnHLixVkqhWuDGSuSbjcR9osepIUhXSi/crm5HI
         BDmWxiZNXKDZw==
Date:   Fri, 4 Jun 2021 09:30:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: add basic ftrace support
Message-ID: <20210604163030.GD26353@locust>
References: <20210603062113.133326-1-wqu@suse.com>
 <20210604023547.GA2068689@dread.disaster.area>
 <af48b9a5-9f94-5b57-7115-e802faf50886@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af48b9a5-9f94-5b57-7115-e802faf50886@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 04, 2021 at 10:45:52AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/6/4 上午10:35, Dave Chinner wrote:
> > On Thu, Jun 03, 2021 at 02:21:13PM +0800, Qu Wenruo wrote:
> > > Sometimes developers want trace dump for certain test cases.
> > > 
> > > Normally I just add "trace-cmd" calls in "check", but it would be much
> > > better to let fstests to support ftrace dumping.
> > > 
> > > This patchset will add basic ftrace dumping support by:
> > > 
> > > - Clear all buffers before running each test
> > > - Start tracing before running each test
> > > - End tracing after test finished
> > > - Copy the trace to "$seqres.trace" if needed
> > >    The condition is either:
> > >    * $KEEP_TRACE environment is set to "yes"
> > >    * The test case failed
> > > 
> > > Currently we only support the main ftrace buffer, but all supporting
> > > functions have support for ftrace instances, for later expansion.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > > Changelog:
> > > v2:
> > > - Add explanation in "common/config" for how to use it
> > > - Make variables local
> > > - Don't create the instance when clearing buffers
> > > ---
> > >   check         | 12 +++++++-
> > >   common/config |  8 +++++
> > >   common/ftrace | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >   common/rc     |  1 +
> > >   4 files changed, 103 insertions(+), 1 deletion(-)
> > >   create mode 100644 common/ftrace
> > > 
> > > diff --git a/check b/check
> > > index ba192042..0a09dcf9 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -801,7 +801,7 @@ function run_section()
> > >   		fi
> > >   		# really going to try and run this one
> > > -		rm -f $seqres.out.bad
> > > +		rm -f $seqres.out.bad $seqres.trace
> > >   		# check if we really should run it
> > >   		_expunge_test $seqnum
> > > @@ -839,6 +839,10 @@ function run_section()
> > >   		# to be reported for each test
> > >   		(echo 1 > $DEBUGFS_MNT/clear_warn_once) > /dev/null 2>&1
> > > +		# Clear previous trace and start new trace
> > > +		_clear_trace_buffers
> > > +		_start_trace
> > 
> > So how does one enable all 500+ xfs tracepoints for this? Or just
> > some subset? i.e. how do we pass it a list of events like we do
> > trace-cmd?  IOWs, for this to be actually useful as a replacement
> > for trace-cmd, it has to be able to replace invocations like this:
> > 
> > # trace-cmd record -e xfs_i*lock* -e xfs_buf* -e printk -e iomap* ....
> 
> That's not a big problem, you can do the same thing just using tracefs
> interface, without invovling trace-cmd at all.
> 
> For your above case, you can do the same thing without trace_cmd at all:
> 
> # cat ${tracefs}/available_events | grep xfs_i*lock >> \
>   ${tracefs}/set_event
> # cat ${tracefs}/available_events | grep xfs_buf* >> \
>   ${tracefs}/set_event
> # cat ${tracefs}/available_events | grep iomap* >> \
>   ${tracefs}/set_event
> # cat ${tracefs}/available_events | grep printk >> \
>   ${tracefs}/set_event

This is **much** more work than a single trace-cmd.  Tools like
trace-cmd exist to simplify configuring complex functionality.  You can
stubbornly insist that manually fiddling around in tracefs is the end
all solution for you, but you don't get to break the entire community's
ability to use cli wrappers.

Dave and I are /not/ going to retool our entire workflows just so you
can break trace-cmd (and any other tools that use ftrace/perf
monitoring) while offering nothing even close to being a replacement.

I do not consent to disrupting well-established tracing tools.  You
rejected my earlier suggestion, so

NAK.

--D

> 
> > 
> > which is how I use trace-cmd 99.9% of the time I'm debugging fstests
> > using tracepoints.
> 
> I don't bevelive above commands can be hard to use, although it's indeed a
> little complex than trace-cmd.
> 
> > 
> > Next: some tests will generate gigabytes of trace data on XFS. I'm
> > not joking here
> 
> That's exactly why I use custom trace_printk() to filter out certain events,
> and only print what I care.
> 
> > - I regularly am looking for single traces in an
> > output file that contains tens of millions of events in it. Having
> > fstests run with tracing enabled is going to rapidly cause ENOSPC
> > problems on test machines, and that's going to cause test harness
> > issues...
> > 
> > Hence I don't think that unilaterally turning on tracing is a good
> > idea. I think it should only run if we set a value in the config
> > section for the test run. This allows a user to define two identical
> > test sections except one has "ENABLE_TRACE=true" in it and the other
> > doesn't. Hence they can run:
> > 
> > # check -s xfs -g auto
> 
> And in the expected use case, trace is only used to test certain failure,
> not to do a full test run.
> It would only make things miserably slow and make your storage explode.
> 
> But we still need to clear/start/end the events for whatever test cases that
> is going to be executed.
> 
> > 
> > to get a normal, non-traced run done. Then, for all the failures
> > reported, run:
> > 
> > # check -s xfs_trace <trace specification> <failed tests>
> > 
> > and get those tests run with tracing enabled instead of running
> > 
> > # trace-cmd record <trace specification> check -s xfs <failed tests>
> > 
> > Finally, I also don't want fstests perturbing whatever tracing I'm
> > doing externally to fstests, so being having it enable tracing only
> > when I want it to enable tracing is somewhat important...
> > 
> > > +#                   NOTE: to dump ftrace buffer one needs to enable ftrace
> > > +#                   events or add custom trace_printk() into the fs code.
> > > +#                   And since fstest will clear buffer before running one
> > > +#                   test case, existing trace-cmd can be interrupted.
> > 
> > trace_printk is only a small part of the tracing I use with
> > trace-cmd. If we can't configure trace event output through this
> > interface, then it's really not a replacement for using trace-cmd...
> 
> I mean, if you can use trace-cmd, I see now reason you can't pack your trace
> events into a small script to enable it before running the tests.
> 
> Or is trace-cmd really making us forget how to manually setup ftrace
> evetnts?
> 
> Thanks,
> Qu
> 
> > 
> > Cheers,
> > 
> > Dave.
> > 
> 
