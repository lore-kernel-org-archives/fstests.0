Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1FEC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 21:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349310AbiEPVf1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 17:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349364AbiEPVfZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 17:35:25 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B7674093B
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 14:35:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 5562A5345B2;
        Tue, 17 May 2022 07:35:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nqiN3-00CoVO-0P; Tue, 17 May 2022 07:35:17 +1000
Date:   Tue, 17 May 2022 07:35:17 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/4] fstests: fix group list generation for whacky test
 names
Message-ID: <20220516213516.GL2306852@dread.disaster.area>
References: <20220516085922.1306879-1-david@fromorbit.com>
 <20220516085922.1306879-2-david@fromorbit.com>
 <YoJ5yvYD9ZmNoNVi@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoJ5yvYD9ZmNoNVi@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6282c396
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=h9maRAkpTmx4mdwP3KUA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 16, 2022 at 09:20:26AM -0700, Darrick J. Wong wrote:
> On Mon, May 16, 2022 at 06:59:19PM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Darrick noticed that tests/xfs/191-input-validation didn't get
> > generated properly. Fix the regex to handle this.
> > 
> > $ grep -I -R "^_begin_fstest" tests/xfs | \
> >   sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' |grep 191
> > tests/xfs/191-input-validation:_begin_fstest auto quick mkfs realtime
> > $
> > $ grep -I -R "^_begin_fstest" tests/xfs | \
> >   sed -e 's/^.*\/\([0-9]*\).*:_begin_fstest/\1/ ' |grep 191
> > 191 auto quick mkfs realtime
> > $
> > 
> > Long term, we should rename that test to '191' and rip out all that
> > unused and unnecessary complexity for matching ascii test names
> > because we just don't use it. Numbers for tests are still working
> > just fine.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  tools/mkgroupfile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/mkgroupfile b/tools/mkgroupfile
> > index 24435898..958d4e2f 100755
> > --- a/tools/mkgroupfile
> > +++ b/tools/mkgroupfile
> > @@ -60,7 +60,7 @@ ENDL
> >  
> >  	# Aggregate the groups each test belongs to for the group file
> >  	grep -I -R "^_begin_fstest" $test_dir/ | \
> > -		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' >> $new_groups
> > +		sed -e 's/^.*\/\([0-9]*\).*:_begin_fstest/\1/' >> $new_groups
> 
> Sorry I didn't get a chance to review this patch before it went in, but
> this string parsing gets tripped up by things that the old code handled
> just fine.  Back when we'd run _begin_fstest as a real bash subroutine
> to print the group name arguments, a line like this:
> 
> _begin_fstest deprecated # log logprint quota

And I just don't care about that.

Handling these whacky corner cases is the *wrong solution* - we're
just creating more technical debt for ourselves going down that
path.

$ git grep _begin_fstest tests/ |grep "#"
tests/xfs/018:_begin_fstest deprecated # log logprint v2log
tests/xfs/081:_begin_fstest deprecated # log logprint quota
tests/xfs/082:_begin_fstest deprecated # log logprint v2log
$

There are the only 3 tests marked deprecated. *Nobody runs them* and
if they did, they all fail on a current kernel:

....
Running: MOUNT_OPTIONS= ./check -R xunit -b -s xfs xfs/018 xfs/081 xfs/082
....
Failures: xfs/018 xfs/081 xfs/082
Failed 3 of 3 tests

We don't need to support this whacky corner case - just remove
the three deprecated tests completely. If anyone needs them, they
are still in the git history. But the right thing to do is to remove
the corner case altogether, not add complexity to handle it
needlessly.

> Instead, that above output (which I harvested from xfs/081) now becomes:
> 
> 081 deprecated # log logprint quota
> 
> The first grepsed blobule should do more if it's going to
> performance-optimize bash:

We don't need to "performance-optimize bash" - we've already fixed
the problem by addressing the low hanging fruit (35s down to less
than 0.4s, and less than 0.1s with make -j8).

Beyond where we iare now is really "don't care" territory because
nobody is going to notice it going 0.1s faster now. OTOH, we are sure
as anything going to notice the complexity of the regexes in a
year's time when we have to work out what it does from first
principles again....

> grep -I -R "^_begin_fstest" -Z $test_dir/ | \
> 	sed -e 's/#.*$//g' \

This is the only bit that is needed to handle the commented out
group case, everythign else is just complexity that comes from
over-optimisation. And even handling comments is largely unnecessary
because removing deprecated tests is the right way to fix this...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
