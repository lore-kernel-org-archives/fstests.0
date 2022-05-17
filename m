Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB4EC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 17 May 2022 04:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiEQEgM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 May 2022 00:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiEQEgL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 May 2022 00:36:11 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3A95659B
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 21:36:08 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 2EB0E10E6A47;
        Tue, 17 May 2022 14:36:05 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nqowF-00Cvdb-No; Tue, 17 May 2022 14:36:03 +1000
Date:   Tue, 17 May 2022 14:36:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/4] fstests: fix group list generation for whacky test
 names
Message-ID: <20220517043603.GN2306852@dread.disaster.area>
References: <20220516085922.1306879-1-david@fromorbit.com>
 <20220516085922.1306879-2-david@fromorbit.com>
 <YoJ5yvYD9ZmNoNVi@magnolia>
 <20220516213516.GL2306852@dread.disaster.area>
 <YoLPfAi8sZH99FuV@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoLPfAi8sZH99FuV@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62832636
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=2fWaknoIRDdbkgn1UhsA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 16, 2022 at 03:26:04PM -0700, Darrick J. Wong wrote:
> On Tue, May 17, 2022 at 07:35:17AM +1000, Dave Chinner wrote:
> > On Mon, May 16, 2022 at 09:20:26AM -0700, Darrick J. Wong wrote:
> > > On Mon, May 16, 2022 at 06:59:19PM +1000, Dave Chinner wrote:
> > > > From: Dave Chinner <dchinner@redhat.com>
> > > > 
> > > > Darrick noticed that tests/xfs/191-input-validation didn't get
> > > > generated properly. Fix the regex to handle this.
> > > > 
> > > > $ grep -I -R "^_begin_fstest" tests/xfs | \
> > > >   sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' |grep 191
> > > > tests/xfs/191-input-validation:_begin_fstest auto quick mkfs realtime
> > > > $
> > > > $ grep -I -R "^_begin_fstest" tests/xfs | \
> > > >   sed -e 's/^.*\/\([0-9]*\).*:_begin_fstest/\1/ ' |grep 191
> > > > 191 auto quick mkfs realtime
> > > > $
> > > > 
> > > > Long term, we should rename that test to '191' and rip out all that
> > > > unused and unnecessary complexity for matching ascii test names
> > > > because we just don't use it. Numbers for tests are still working
> > > > just fine.
> > > > 
> > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > ---
> > > >  tools/mkgroupfile | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/mkgroupfile b/tools/mkgroupfile
> > > > index 24435898..958d4e2f 100755
> > > > --- a/tools/mkgroupfile
> > > > +++ b/tools/mkgroupfile
> > > > @@ -60,7 +60,7 @@ ENDL
> > > >  
> > > >  	# Aggregate the groups each test belongs to for the group file
> > > >  	grep -I -R "^_begin_fstest" $test_dir/ | \
> > > > -		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' >> $new_groups
> > > > +		sed -e 's/^.*\/\([0-9]*\).*:_begin_fstest/\1/' >> $new_groups
> > > 
> > > Sorry I didn't get a chance to review this patch before it went in, but
> > > this string parsing gets tripped up by things that the old code handled
> > > just fine.  Back when we'd run _begin_fstest as a real bash subroutine
> > > to print the group name arguments, a line like this:
> > > 
> > > _begin_fstest deprecated # log logprint quota
> > 
> > And I just don't care about that.
> 
> I *do*, because my entire testing dashboard turned red overnight because
> these changes broke the group list file generation and pulled in tests
> that normally get excluded from my nightly test runs.

How did that happen? I missed xfs/191-..., but that won't cause it
to run.  The others should only been seen by check as belonging to
the deprecated group, so I'm not sure how they got run, either.

check is supposed to be stripping the commented out regions of the
group file (e.g. the header) with this code:

get_sub_group_list()

        local d=$1
        local grp=$2

        test -s "$SRC_DIR/$d/group.list" || return 1

        local grpl=$(sed -n < $SRC_DIR/$d/group.list \
>>>>>>>         -e 's/#.*//' \
                -e 's/$/ /' \
                -e "s;^\($VALID_TEST_NAME\).* $grp .*;$SRC_DIR/$d/\1;p")
        echo $grpl
}

If the comments not being stripped correctly, then the three
deprecated tests:

> > $ git grep _begin_fstest tests/ |grep "#"
> > tests/xfs/018:_begin_fstest deprecated # log logprint v2log
> > tests/xfs/081:_begin_fstest deprecated # log logprint quota
> > tests/xfs/082:_begin_fstest deprecated # log logprint v2log
> > $

should all be listed as members of the log group. So let's list the
tests that the log group will run:

# MOUNT_OPTIONS= ./check -b -s xfs -n -g log
SECTION       -- xfs
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 test2 5.18.0-rc7-dgc+ #1245 SMP PREEMPT_DYNAMIC Mon May 16 11:51:16 AEST 2022
MKFS_OPTIONS  -- -f -m rmapbt=1 /dev/vdb
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/vdb /mnt/scratch

generic/034
generic/039
generic/040
generic/041
generic/043
generic/044
generic/045
generic/046
generic/051
generic/052
generic/054
generic/055
generic/056
generic/057
generic/059
generic/065
generic/066
generic/073
generic/090
generic/101
generic/104
generic/106
generic/107
generic/177
generic/311
generic/321
generic/322
generic/325
generic/335
generic/336
generic/341
generic/342
generic/343
generic/376
generic/388
generic/417
generic/455
generic/457
generic/475
generic/479
generic/480
generic/481
generic/483
generic/489
generic/498
generic/501
generic/502
generic/509
generic/510
generic/512
generic/520
generic/526
generic/527
generic/534
generic/535
generic/546
generic/547
generic/552
generic/557
generic/588
generic/640
generic/648
generic/677
generic/690
shared/002
xfs/011
xfs/029
xfs/051
xfs/057
xfs/079
xfs/095
xfs/119
xfs/121
xfs/141
xfs/181
xfs/216
xfs/217
xfs/439

$

They aren't there.

And to check that they are actually getting parsed correctly:

# MOUNT_OPTIONS= ./check -b -s xfs -n -g deprecated
SECTION       -- xfs
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 test2 5.18.0-rc7-dgc+ #1245 SMP PREEMPT_DYNAMIC Mon May 16 11:51:16 AEST 2022
MKFS_OPTIONS  -- -f -m rmapbt=1 /dev/vdb
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/vdb /mnt/scratch

xfs/018
xfs/081
xfs/082

$

Yup, there they are in the deprecated group.

AFAICT, nothing except for the handling of xfs/191-... is broken.
Comments in group lists are being stripped just fine, and so I have
no idea what is going wrong in your test environment to cause these
tests to run and/or be marked as failing.

> Did _anyone_ actually compare the group.list output before and after
> applying the patch?

Yup. I did a visual inspection, ran group listings like above, ran
it for a couple of weeks on all my machines before sending it out
for review.  No extra tests ran, no tests that should have run
didn't run, no unexpected errors occur.

Yes, I missed that 191-...  was missing in my inspection, but we 
all make mistakes from time to time. I noticed when pointing out
the comment stripping in get_sub_group_list() that we have
$VALID_TEST_NAME for regex matching test names. I should change the
regex to use that - if I had remembered this existed, I wouldn't
have written my own and got it wrong....

> > Handling these whacky corner cases is the *wrong solution* - we're
> > just creating more technical debt for ourselves going down that
> > path.
> 
> Frankly, I think this whole change *introduces* technical debt.
> 
> Test files used to be bash scripts that have /all/ the standard
> behaviors of bash scripts -- commands can have comments at the end of
> the line, continuations are supported, etc.  Test authors merely have to
> ensure that the script parses correctly, and that the groups for each
> test are specified as options to _begin_fstest.

Only 3 tests out of 1700 make any use of these features, and check
handles those 3 tests just fine. The list generation change has made
no practical difference to anything inside fstests, and the group
files do not form a stable ABI that will never change.

I use comments in group lists occasionally, I made sure that works.
We don't have anything that uses any of that other functionality in
then ~1700 tests we already have, so there's no current need for
the special case requirements being described.

"Make the requirements less dumb."
	- Elon Musk's 1st rule for engineering success.

> Now you've effectively made it so that there's this one weird line that
> looks like any other piece of shell script, but it isn't.  You can't
> have comments, you can't use line continuations, and if you
> accidentally drop something like a colon in the line, there's a risk
> that a regular expression will do the wrong thing and explode.

<shrug>

All we need is a list of the {test number, {groups}} sets. We do not
need to execute 1700 tests and several grep/sed invocations per test
to build these lists - all we need to do is parse the single line in
the existing test files that defines the groups.

It is trivial to document that single line requirement for future
reference, and given that every test already conforms to that
requirement it has zero impact on anyone or any existing test.

We don't need to over-engineer this again.

> In other words, test scripts aren't purely bash scripts anymore even
> though they sure look like pure bash.  Every author must now be aware
> that there's a behavioral quirk pertaining to exactly one required line
> in every test script.

<shrug>

We have had restrictions on the format of the test file that aren't
"bash" for a long, long time. lsqa.pl expects the test comment
headers to be in a specific format so it can parse tests as
text files to extract the test titles and descriptions.

Nothing is perfect. The old code wasn't perfect. The new code isn't
perfect, either, but it's simpler and faster and I'm fixing
problems as they are reported.

I didn't intend to break anything. I make mistakes and miss things
and I expect that everyone else does, too. I try to fix mistakes as
fast as I can and I expect everyone else to do the same.

> > $ git grep _begin_fstest tests/ |grep "#"
> > tests/xfs/018:_begin_fstest deprecated # log logprint v2log
> > tests/xfs/081:_begin_fstest deprecated # log logprint quota
> > tests/xfs/082:_begin_fstest deprecated # log logprint v2log
> > $
> > 
> > There are the only 3 tests marked deprecated. *Nobody runs them* and
> > if they did, they all fail on a current kernel:
> > 
> > ....
> > Running: MOUNT_OPTIONS= ./check -R xunit -b -s xfs xfs/018 xfs/081 xfs/082
> > ....
> > Failures: xfs/018 xfs/081 xfs/082
> > Failed 3 of 3 tests
> > 
> > We don't need to support this whacky corner case - just remove
> > the three deprecated tests completely. If anyone needs them, they
> > are still in the git history. But the right thing to do is to remove
> > the corner case altogether, not add complexity to handle it
> > needlessly.
> 
> Then why didn't you propose remove them?

I just did!

I can't propose solutions before I know about them being a problem;
of the many things I can do, "violating causality" is not on that
list.

> > > Instead, that above output (which I harvested from xfs/081) now
> > > becomes:
> > > 
> > > 081 deprecated # log logprint quota
> > > 
> > > The first grepsed blobule should do more if it's going to
> > > performance-optimize bash:
> > 
> > We don't need to "performance-optimize bash" - we've already fixed
> > the problem by addressing the low hanging fruit (35s down to less
> > than 0.4s, and less than 0.1s with make -j8).
> 
> That's nice that it's faster to build, but IMHO it's *broken*.  The
> original patch was a performance improvement that submarined in a change
> in how we have to write tests.

<deep breathe, don't shout, be calm>

Please choose your words more carefully in future, Darrick.
Submarining implies that people are acting in bad faith.

I doubt this is what you meant, but that was kind of the last straw
after implying the change wasn't tested properly, wasn't reviewed
properly, was just straight out broken and that I should have broken
the laws of physics to propose fixes before they were reported as
problems.

It has taken me half a day to calm down enough to write a reasonable
reply to address these issues.

I Am Not A Happy Camper.
-- 
Dave Chinner
david@fromorbit.com
