Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEA7C6377A
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Jul 2021 21:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA44F6120C
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Jul 2021 21:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhGUVR2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Jul 2021 17:17:28 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:50197 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229459AbhGUVR1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Jul 2021 17:17:27 -0400
Received: from dread.disaster.area (pa49-181-34-10.pa.nsw.optusnet.com.au [49.181.34.10])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 1F9C01B0F55;
        Thu, 22 Jul 2021 07:58:01 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1m6KE4-009Fgj-3F; Thu, 22 Jul 2021 07:58:00 +1000
Date:   Thu, 22 Jul 2021 07:58:00 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] tools: add a dm-logwrites replay tool
Message-ID: <20210721215800.GB2112234@dread.disaster.area>
References: <20210721001333.2999103-1-david@fromorbit.com>
 <CAOQ4uxh-rE4Tf7zsdCkaKxTvj47sE8N8g9MyHj1A49H_YMJ3kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh-rE4Tf7zsdCkaKxTvj47sE8N8g9MyHj1A49H_YMJ3kg@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=hdaoRb6WoHYrV466vVKEyw==:117 a=hdaoRb6WoHYrV466vVKEyw==:17
        a=kj9zAlcOel0A:10 a=e_q4qTt1xDgA:10 a=7-415B0cAAAA:8 a=20KFwNOVAAAA:8
        a=YwOMOOLzT6LR4LnHHJsA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 21, 2021 at 09:04:29AM +0300, Amir Goldstein wrote:
> On Wed, Jul 21, 2021 at 3:14 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > Trying to decipher a dm-logwrites replay failure from generic/482 is
> > difficult. The test destroys all the dm state and devices when the
> > test fails, leaving nothing behind for post-mortem analysis. This
> > script is intended to allow replay of the dm-logwrites device one
> > FUA at a time similar to generic/482, and is used in conjunction
> > with a modifed g/482 test that does not tear down the dm volumes
> > or state when the test fails.
> >
> > This allows the developer to replay the logwrites up to just prior
> > to failure to examine just the differences between the last good
> > state and the first failure state, greatly reducing the complexity
> > of analysing failures.
> >
> > Instructions for use are in the tools/dm-logwrite-replay script
> > itself.
> >
> 
> This looks very useful!
> Thanks for sharing :)
> 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  common/dmlogwrites       |   8 +--
> >  tests/generic/482        |  18 +++++++
> >  tools/dm-logwrite-replay | 113 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 135 insertions(+), 4 deletions(-)
> >  create mode 100755 tools/dm-logwrite-replay
> >
> > diff --git a/common/dmlogwrites b/common/dmlogwrites
> > index 573f4b8a..66c57e2b 100644
> > --- a/common/dmlogwrites
> > +++ b/common/dmlogwrites
> > @@ -180,11 +180,11 @@ _log_writes_replay_log_range()
> >         [ -z "$blkdev" ] && _fail \
> >         "block dev must be specified for _log_writes_replay_log_range"
> >
> > -       # To ensure we replay the last entry,
> > -       # we need to manually increase the end entry number to ensure
> > -       # it's played
> > +       # To ensure we replay the last entry, we need to manually increase the
> > +       # end entry number to ensure it's played. We also dump all the
> > +       # operations performed as this helps post-mortem analysis of failures.
> >         echo "=== replay to $end ===" >> $seqres.full
> > -       $here/src/log-writes/replay-log --log $LOGWRITES_DEV \
> > +       $here/src/log-writes/replay-log -vv --log $LOGWRITES_DEV \
> >                 --replay $blkdev --limit $(($end + 1)) \
> >                 >> $seqres.full 2>&1
> >         [ $? -ne 0 ] && _fail "replay failed"
> > diff --git a/tests/generic/482 b/tests/generic/482
> > index f26e6fc4..416b929a 100755
> > --- a/tests/generic/482
> > +++ b/tests/generic/482
> > @@ -12,6 +12,10 @@
> >  _begin_fstest auto metadata replay thin
> >
> >  # Override the default cleanup function.
> > +#
> > +# If debugging logwrites failures using the tools/dm-logwrite-replay script,
> > +# switch the cleanup function to the version that is commented out below so that
> > +# failure leaves the corpse intact for post-mortem failure analysis.
> 
> Please let's use KEEP_LOGWRITES=yes envvar for this.

Where would that be set? And how would one use it?

FWIW, I won't remember about this or use it - my work-flow is based
on patches that modify test behaviour in an unchanging test
environment, rather changing the test environment to modify test
behaviour. Hence it's much easier for me to select the
debug-482-switch-cleanup patch from my local library of debug hacks,
push it onto my fstests stack and then run the test and have it
behave as I want...

> >  _cleanup()
> >  {
> >         cd /
> > @@ -21,6 +25,20 @@ _cleanup()
> >         rm -f $tmp.*
> >  }
> >
> > +# tools/dm-logwrite-replay _cleanup version
> > +#_cleanup()
> > +#{
> > +#      cd /
> > +#      $KILLALL_PROG -KILL -q $FSSTRESS_PROG &> /dev/null
> > +#      if [ $status -eq 0 ]; then
> > +#              _log_writes_cleanup &> /dev/null
> > +#              _dmthin_cleanup
> > +#      else
> > +#              echo dm-thinvol-dev: $DMTHIN_VOL_DEV >> $seqres.full
> 
> In this case, let's print a message to stdout, with a hint to use
> dm-logwrite-replay tool and reminder to run the cleanup.

Sure, but I think the person running it this way is going to know
that this happens on failure already :/

> But also, I wonder - we can call _log_writes_cleanup;_dmthin_cleanup
> from _dmthin_init() as a service for debuggers who forgot to cleanup
> after forensics just as ./check itself will umount scratch and test leftover
> mounts.

No, we can't, because we don't even get that far trying to run
fstests when the devices have not been torn down. i.e. check
failures to access the scratch device because it's still busy and
immmediately aborts before it gets to running any tests.

Further, I'm actually using that "scratch device busy" check failure
to terminate the repeated iteration loop when a failure occurs. This
ensures that the output files from the test failure are not
overwritten by the next attempt to run the test.

Hence, even if it were possible, having the test auto-cleanup is not
a useful thing to do from a failure reproducer/debugging point of
view....

> We could do that conditional or regardless to KEEP_LOGWRITES envvar.
> 
> Does it cost us anything to do that? Any caveats?

I'm not sure what adding KEEP_LOGWRITES actually gains us other than
having just another undocumented, largely unused environment
variable that people will not remember about but we still have to
maintain.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
