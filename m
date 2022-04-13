Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF69C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Apr 2022 00:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiDMA3Z (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Apr 2022 20:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiDMA3X (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Apr 2022 20:29:23 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCCED42EEB
        for <fstests@vger.kernel.org>; Tue, 12 Apr 2022 17:26:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-115-138.pa.nsw.optusnet.com.au [49.181.115.138])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 1496C53423D;
        Wed, 13 Apr 2022 10:26:57 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1neQqW-00H1X5-AI; Wed, 13 Apr 2022 10:26:56 +1000
Date:   Wed, 13 Apr 2022 10:26:56 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/019: kill background processes on interrupt
Message-ID: <20220413002656.GL1609613@dread.disaster.area>
References: <20220411054833.2157779-1-david@fromorbit.com>
 <20220412145942.0a268875@suse.de>
 <20220412142500.ubkbw2fvbxowzo5p@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412142500.ubkbw2fvbxowzo5p@zlang-mailbox>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=625618d2
        a=/kVtbFzwtM2bJgxRVb+eeA==:117 a=/kVtbFzwtM2bJgxRVb+eeA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=bigTHbYR0LDQIEDhyuMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 12, 2022 at 10:25:00PM +0800, Zorro Lang wrote:
> On Tue, Apr 12, 2022 at 02:59:42PM +0200, David Disseldorp wrote:
> > On Mon, 11 Apr 2022 15:48:33 +1000, Dave Chinner wrote:
> > 
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > If you ctrl-c generic/019, it leaves fsstress processes running.
> > > Kill them in the cleanup function so that they don't have to be
> > > manually killed after interrupting the test.
> > > 
> > > While touching the _cleanup() function, make it do everything that
> > > the generic _cleanup function it overrides does and fix the
> > > indenting.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > >  tests/generic/019 | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tests/generic/019 b/tests/generic/019
> > > index db56dac1..cda107f4 100755
> > > --- a/tests/generic/019
> > > +++ b/tests/generic/019
> > > @@ -53,8 +53,10 @@ stop_fail_scratch_dev()
> > >  # Override the default cleanup function.
> > >  _cleanup()
> > >  {
> > > -    disallow_fail_make_request
> > > -    rm -f $tmp.*
> > > +	kill $fs_pid $fio_pid &> /dev/null
> > > +	disallow_fail_make_request
> > > +	cd /
> > > +	rm -r -f $tmp.*
> > >  }
> > >  
> > >  RUN_TIME=$((20+10*$TIME_FACTOR))
> > 
> > Might be worth unset'ing the "fs_pid" and "fio_pid" variables after the
> > wait, but should be fine as-is:
> 
> I agree. Better to avoid killing other system processes. Or how about this place
> does (avoid killing system useful processes):
> $KILLALL_PROG -q $FSSTRESS_PROG
> $KILLALL_PROG -q $FIO_PROG
> 
> Another picky question is, do we need to use a while loop checking, until the
> processes really get killed? :)

Do we really need to paint the bikeshed over how best to kill a
process? I don't have time to do that, this is just a drive-by fix
that works for me....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
