Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07596C43334
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Jun 2022 05:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiFJFDN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Jun 2022 01:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiFJFDL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Jun 2022 01:03:11 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB7FE24C0B3
        for <fstests@vger.kernel.org>; Thu,  9 Jun 2022 22:03:09 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B3C515EC69F;
        Fri, 10 Jun 2022 15:03:04 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nzWnW-004pWf-8U; Fri, 10 Jun 2022 15:03:02 +1000
Date:   Fri, 10 Jun 2022 15:03:02 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/297: fix the delta time based on stat
Message-ID: <20220610050302.GX1098723@dread.disaster.area>
References: <20220610023553.24418-1-wangyugui@e16-tech.com>
 <20220610042405.z2ou4uwwgoiympxx@zlang-mailbox>
 <20220610123623.D773.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610123623.D773.409509F4@e16-tech.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62a2d08b
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=Uq0mbvy6AAAA:8 a=7-415B0cAAAA:8
        a=tKOuy-oXcDD2Z-JutqYA:9 a=CjuIK1q_8ugA:10 a=9nAYT2xhiIK_ZOnRzmc7:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 10, 2022 at 12:36:24PM +0800, Wang Yugui wrote:
> Hi,
> 
> > On Fri, Jun 10, 2022 at 10:35:53AM +0800, Wang Yugui wrote:
> > > stat -c '%Y' report seconds as int, so the delta 2.01s may result as 3s.
> > > 
> > > Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> > > ---
> > >  tests/generic/297 | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tests/generic/297 b/tests/generic/297
> > > index 6bdc3e1c..e3082202 100755
> > > --- a/tests/generic/297
> > > +++ b/tests/generic/297
> > > @@ -51,7 +51,7 @@ for i in $(seq 0 $fnr); do
> > >  	touch $TEST_DIR/after
> > >  	before=$(stat -c '%Y' $TEST_DIR/before)
> > >  	after=$(stat -c '%Y' $TEST_DIR/after)
> > > -	delta=$((after - before))
> > > +	delta=$((after - before -1)) # 2.01s may result as 3s; so -1
> > 
> > What issue is this change trying to fix? "timeout=8"s is not long enough?
> 
> for the command
> $TIMEOUT_PROG -s INT ${kill_after}s
> 
> delta=$((after - before )) may report 'kill_after+1' in some case.

Yes, that's what it is supposed to report. The process is
killed 2s after the test starts, so delta is going to be kill_after
+ the delay for the task to exit and the 'touch $TEST_DIR/after'
command to run. This can take a second or two, depending on how fast
the reflink operation is proceeding (e.g. waiting on IO).

> so no relationship to "timeout=8" or "timeout=2".

If the reflink doesn't get killed within 6s then delta will be
greater than the timeout (8) and the test fails. So if delta is 2 or
3, then it makes no difference to the test result, right?

> '$XFS_IO_PROG -f -c reflink' without '$TIMEOUT_PROG -s INT ${kill_after}s'
> may take 20s because this is a very complex reflink.

Yes, and if it takes 20s (i.e. delta=20s) then it means that the
kill signal was not delivered and acted upon correctly and so the
test should fail.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
