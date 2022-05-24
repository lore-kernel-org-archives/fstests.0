Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795BBC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 09:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiEXJwv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 05:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbiEXJwr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 05:52:47 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB98347550
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 02:52:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id CF2275345B6;
        Tue, 24 May 2022 19:52:45 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntRDY-00Fmk7-7Y; Tue, 24 May 2022 19:52:44 +1000
Date:   Tue, 24 May 2022 19:52:44 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 4/8] fstests: define a common _dump_cleanup function
Message-ID: <20220524095244.GG2306852@dread.disaster.area>
References: <20220524073411.1943480-1-david@fromorbit.com>
 <20220524073411.1943480-5-david@fromorbit.com>
 <CAOQ4uxiKbdMQZsr335RM6Og6XLkSTUdVw7NdsYD3djJbtPGRmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiKbdMQZsr335RM6Og6XLkSTUdVw7NdsYD3djJbtPGRmQ@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=628caaee
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=X7xJN7W7_d_qWs1udZAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 12:04:36PM +0300, Amir Goldstein wrote:
> On Tue, May 24, 2022 at 11:32 AM Dave Chinner <david@fromorbit.com> wrote:
> > diff --git a/tests/xfs/026 b/tests/xfs/026
> > index 18529003..0daa7c88 100755
> > --- a/tests/xfs/026
> > +++ b/tests/xfs/026
> > @@ -9,17 +9,8 @@
> >  . ./common/preamble
> >  _begin_fstest dump ioctl auto quick
> >
> > -status=0       # success is the default!
> > -
> 
> All those tests that you change from success is the default
> to failure is the default, that makes sense, but
> 1. Should be documented in the commit message?

I cleaned up a bunch of random stuff like this as I went along. If I
try to document every little change that gets done, I'll be spending
more time on describing the changes than actually doing them. I
don't have the time to rigourously document this stuff - I've got
the time to modify the code, write an overview of the changes and
that's about it.

What does the fstests community want: better test infrastructure or
perfect commits?

> 2. Why were those tests written this way? Do you know?

That's just the pattern that was used by the team that wrote these
dump tests 20-odd years ago. At the time nobody cared that much
about little inconsistencies like this as long as the test failed
when something went wrong. i.e. test works, merge it, move on to the
next thing. 

Now that we have ~1700 tests to maintain, little inconsistencies are
a big deal. That's why I cleaned up the simple ones as I saw them...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
