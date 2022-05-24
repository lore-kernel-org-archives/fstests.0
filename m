Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02203C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 12:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbiEXM1I (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 08:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiEXM1I (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 08:27:08 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEB109346F
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 05:27:06 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 694B65345AF;
        Tue, 24 May 2022 22:27:05 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntTct-00FpVL-Tc; Tue, 24 May 2022 22:27:03 +1000
Date:   Tue, 24 May 2022 22:27:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 3/8] xfs/*: clean up _cleanup override
Message-ID: <20220524122703.GL2306852@dread.disaster.area>
References: <20220524073411.1943480-1-david@fromorbit.com>
 <20220524073411.1943480-4-david@fromorbit.com>
 <CAOQ4uxgZwngHevX_FXytAi68k=aqp_N-8Buk50rrJKD0UoK+2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgZwngHevX_FXytAi68k=aqp_N-8Buk50rrJKD0UoK+2g@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=628ccf1a
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8 a=20KFwNOVAAAA:8
        a=VwQbUJbxAAAA:8 a=TyGuxyW6N0P06ufJ008A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22 a=AjGcO6oz07-iQ99wixmX:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 01:42:15PM +0300, Amir Goldstein wrote:
> On Tue, May 24, 2022 at 12:41 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > Use a local cleanup function and _register_cleanup properly.
> >
> > Remove local cleanups that just do what the standard _cleanup and
> > test exist does.
> >
> > Remove local cleanups that just remove test files and then do
> > standard _cleanup functionality.
> 
> As I mentioned in response to the cover letter, the call to _cleanup()
> can and I think should be chained implicitly, but I am still waiting
> for your response regarding the tests where generic _cleanup is not
> desired.

Please go an look at the lore archive if vger is having problems
delivering to you - the whole thread is there, as are all my
responses.

[PATCH 6/8] fstests: consolidate no cleanup test setup

https://lore.kernel.org/fstests/20220524073411.1943480-7-david@fromorbit.com/T/#u


> > diff --git a/tests/xfs/006 b/tests/xfs/006
> > index cecceaa3..fd8d8071 100755
> > --- a/tests/xfs/006
> > +++ b/tests/xfs/006
> > @@ -11,11 +11,10 @@
> >  _begin_fstest auto quick mount eio
> >
> >  # Override the default cleanup function.
> > -_cleanup()
> > +_dmerror_cleanup()
> >  {
> > -       cd /
> > -       rm -f $tmp.*
> >         _dmerror_cleanup
> 
> That looks recursive.
> Again, if the call to _cleanup is implicitly chained then
> the local function is not needed and trap can call
> the global _dmerror_cleanup().

Yes, the local name should have been _dm_error_cleanup(), like I
used elsewhere.

> > diff --git a/tests/xfs/008 b/tests/xfs/008
> > index a53f6c92..5bef44bb 100755
> > --- a/tests/xfs/008
> > +++ b/tests/xfs/008
> > @@ -12,13 +12,6 @@ _begin_fstest rw ioctl auto quick
> >  status=0       # success is the default!
> >  pgsize=`$here/src/feature -s`
> >
> > -# Override the default cleanup function.
> > -_cleanup()
> > -{
> > -    rm -f $tmp.*
> > -    rm -rf $TEST_DIR/randholes.$$.*
> 
> It's fine to keep the test files behind, but maybe
> make that change more clear in commit message
> because it was not clear to me that there was a change of
> behavior when I read the commit message.
> 
> Sorry to drop this extra burden on you, but this seems
> important to me and I cannot add this information after the fact.

The  point of TEST_DIR is it gathers cruft from tests so exercises
filesystem aging. If the file is tiny, there's no point in removing
it - all we have to do is ensure it is removed in the test setup so
we have known initial state. So If that's the case, I removed the
cleanup of it altogether.

Like I said, I have time to do a single classification pass across
all these tests, but if I have to document every single little
change I make in doing these cleanups, I'm not going to bother
trying because it's too hard and takes too long.

Do you want perfect commits or do you want better infrastructure?

> Also, it was very hard to see in this review if the test files
> that are not cleaned in cleanup() are cleaned in the beginning
> of the test or if it is not important to clean them because they
> are overwritten.

All tests are required to control their initial state on the test
device as many tests use the same file names and locations and there
is no guarantee that the test device is clean. Hence tests must
clean up during startup to ensure they have a known initial state
to begin the test from.

> I did my best to try and I think there is a missing cleanup of
> ${OUTPUT_DIR} in the beginning of xfs/253.
> Although that may already be considered a test bug, removing
> the cleanup of ${OUTPUT_DIR} from cleanup() will expose this bug.

OUTPUT_DIR="${SCRATCH_MNT}/test_${seq}"

No cleanup is needed for tests that use the scratch device.

> > diff --git a/tests/xfs/051 b/tests/xfs/051
> > index ea70cb50..4718099d 100755
> > --- a/tests/xfs/051
> > +++ b/tests/xfs/051
> > @@ -11,14 +11,13 @@
> >  . ./common/preamble
> >  _begin_fstest shutdown auto log metadata
> >
> > -# Override the default cleanup function.
> > -_cleanup()
> > +_fsstress_cleanup()
> >  {
> > -       cd /
> > -       rm -f $tmp.*
> >         $KILLALL_PROG -9 $FSSTRESS_PROG > /dev/null 2>&1
> > -       _scratch_unmount > /dev/null 2>&1
> > +       wait
> 
> All right. I see that cleanup helpers are not consistent
> in calling wait after kill and in using SIGKILL.
> I guess we could go either way. So be it.

That's the whole point of these cleanups - they will be collapsed
down to a single helper and then we can apply the same behaviour
consistently across them all.

> > diff --git a/tests/xfs/310 b/tests/xfs/310
> > index 3214e04b..c635b39a 100755
> > --- a/tests/xfs/310
> > +++ b/tests/xfs/310
> > @@ -9,14 +9,12 @@
> >  . ./common/preamble
> >  _begin_fstest auto clone rmap
> >
> > -# Override the default cleanup function.
> > -_cleanup()
> > +_dmhuge_cleanup()
> >  {
> > -       cd /
> > -       umount $SCRATCH_MNT > /dev/null 2>&1
> >         _dmhugedisk_cleanup
> > -       rm -rf $tmp.*
> > +       _cleanup
> >  }
> > +_register_cleanup _dmhuge_cleanup
> 
> Maybe it's just me, but if the intention is to maybe make this
> function global someday then the difference with the name
> _dmhugedisk_cleanup() is confusing.

The names I used here are for classification, so I can grep over
the _register_cleanup line and easily determine all the tests use
loop devices, dmflakey, dmerror, etc and then consolidate them all
into a single cleanup function that works for them all. This is just
the first step in that process.

> I'd rather keep the local function name local_cleanup
> in unclear cases like this one.

And that defeats the entire purpose of giving them a descriptive
name at this point in time.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
