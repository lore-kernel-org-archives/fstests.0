Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11914C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 18 Apr 2022 00:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiDRAEs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 17 Apr 2022 20:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbiDRAEs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Apr 2022 20:04:48 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9B8717061
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 17:02:09 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-115-138.pa.nsw.optusnet.com.au [49.181.115.138])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E681110E5AD2;
        Mon, 18 Apr 2022 10:02:07 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ngEqE-001O3m-9n; Mon, 18 Apr 2022 10:02:06 +1000
Date:   Mon, 18 Apr 2022 10:02:06 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     David Disseldorp <ddiss@suse.de>, fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/019: kill background processes on interrupt
Message-ID: <20220418000206.GO1609613@dread.disaster.area>
References: <20220411054833.2157779-1-david@fromorbit.com>
 <20220412145942.0a268875@suse.de>
 <20220412142500.ubkbw2fvbxowzo5p@zlang-mailbox>
 <20220413002656.GL1609613@dread.disaster.area>
 <CAOQ4uxi_YY2fBTAoQz4W_jOFvySUWGG0UFhtKjptgiiM1jg7Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi_YY2fBTAoQz4W_jOFvySUWGG0UFhtKjptgiiM1jg7Bg@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=625caa80
        a=/kVtbFzwtM2bJgxRVb+eeA==:117 a=/kVtbFzwtM2bJgxRVb+eeA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8 a=20KFwNOVAAAA:8
        a=CTRjChovUeMN2YvAFXMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 13, 2022 at 10:13:35AM +0300, Amir Goldstein wrote:
> On Wed, Apr 13, 2022 at 4:53 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Tue, Apr 12, 2022 at 10:25:00PM +0800, Zorro Lang wrote:
> > > On Tue, Apr 12, 2022 at 02:59:42PM +0200, David Disseldorp wrote:
> > > > On Mon, 11 Apr 2022 15:48:33 +1000, Dave Chinner wrote:
> > > >
> > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > >
> > > > > If you ctrl-c generic/019, it leaves fsstress processes running.
> > > > > Kill them in the cleanup function so that they don't have to be
> > > > > manually killed after interrupting the test.
> > > > >
> > > > > While touching the _cleanup() function, make it do everything that
> > > > > the generic _cleanup function it overrides does and fix the
> > > > > indenting.
> > > > >
> > > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > > ---
> > > > >  tests/generic/019 | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/tests/generic/019 b/tests/generic/019
> > > > > index db56dac1..cda107f4 100755
> > > > > --- a/tests/generic/019
> > > > > +++ b/tests/generic/019
> > > > > @@ -53,8 +53,10 @@ stop_fail_scratch_dev()
> > > > >  # Override the default cleanup function.
> > > > >  _cleanup()
> > > > >  {
> > > > > -    disallow_fail_make_request
> > > > > -    rm -f $tmp.*
> > > > > + kill $fs_pid $fio_pid &> /dev/null
> > > > > + disallow_fail_make_request
> > > > > + cd /
> > > > > + rm -r -f $tmp.*
> > > > >  }
> > > > >
> > > > >  RUN_TIME=$((20+10*$TIME_FACTOR))
> > > >
> > > > Might be worth unset'ing the "fs_pid" and "fio_pid" variables after the
> > > > wait, but should be fine as-is:
> > >
> > > I agree. Better to avoid killing other system processes. Or how about this place
> > > does (avoid killing system useful processes):
> > > $KILLALL_PROG -q $FSSTRESS_PROG
> > > $KILLALL_PROG -q $FIO_PROG

In general I dislike the use of killall because because it is a
barrier to being able to run multiple tests in parallel on the same
machine. One of the things I'd really like to be able to do is run
tests in parallel and widespread use of killall is one of the
primary reasons we can't do that.

So, yeah, what one person sees as a "better method" another person
will see as having significant drawbacks and problems.

> > > Another picky question is, do we need to use a while loop checking, until the
> > > processes really get killed? :)
> >
> > Do we really need to paint the bikeshed over how best to kill a
> > process? I don't have time to do that, this is just a drive-by fix
> > that works for me....
> 
> This is not a kind response to reviewers.
> Does a "drive-by fix" get exempt from the review process?

No. But suggesting that the fix has to take into account unnecessary
and increasingly esoteric edge cases is not "review" - that's called
"moving the goal posts".

IOWs, my comment is based on the observation that a simple fix to a
problem that has been encountered during some other work gets turned
into a "fix the world" discussion that implies the original patch
author needs to fix the world rather than the single problem they
encountered and sent a patch for.

We talk about "drive by contributions" repeatedly in terms of how to
review/accept them without placing undue burdens on the people
sending such patches.  That fix might not be a 100% perfect fix but
it is still an improvement and it addresses that person's immediate
problem. That's largely all that matters to the person sending the
patch.

> The review comments are legit even if they could be dismissed
> on technical grounds, because the risk of pid wraparound is quite low.
>
> I don't think this is about "bikeshed over how best to kill a process"
> I think this is about how to have better test cleanup practices.
> It would have been nice to have better isolation by having fstests
> run a test without a control group and cleanup the control group
> processes after the test if someone wants to take on this task.

And now your are demonstrating my point - you've gone off into
bikeshedding over how to change the cleanup processes. This is
exactly what I pushed back against in the first place.

Review is not about turning a simple fix into a huge chunk of work
that the original patch author neither cares about nor has time or
resources to perform. It doesn't encourage them to send other simple
5 minute fixup patches as they encounter them, either.

Requiring patches to be perfect rather than just an *improvement* is
the problem here.  Turning a simple fix into a bikeshed session that
ends up going nowhere is in no-ones best interests.  Taking the fix
as it stands and then noting that there's a wider problem that needs
to be addressed (as Darrick has already described) is a much better
way forward. Address that bigger problem in it's own thread that
starts with patches that demonstrate solutions to that problem,
don't morph the "review" process into a discussion that implies that
the person who sent a simple fix is now on the hook to do a major
piece of cleanup work....

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
