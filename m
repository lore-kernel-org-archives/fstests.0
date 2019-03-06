Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:38324 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725267AbfCFFAz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Mar 2019 00:00:55 -0500
Date: Wed, 6 Mar 2019 16:00:49 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] generic: test i_mode recovery after power failure
Message-ID: <20190306050049.GA23020@dastard>
References: <20190305114744.129633-1-yuchao0@huawei.com>
 <20190305205344.GC26298@dastard>
 <0f1af38b-5dbf-a56a-c0c1-72cf9fafb515@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f1af38b-5dbf-a56a-c0c1-72cf9fafb515@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: fstests@vger.kernel.org, guaneryu@gmail.com, linux-f2fs-devel@lists.sourceforge.net, fdmanana@gmail.com
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 06, 2019 at 10:29:10AM +0800, Chao Yu wrote:
> On 2019/3/6 4:53, Dave Chinner wrote:
> > On Tue, Mar 05, 2019 at 07:47:44PM +0800, Chao Yu wrote:
> >> After fsync, filesystem should guarantee inode metadata including
> >> permission info being persisted, so even after sudden power-cut,
> >> during mount, we should recover i_mode fields correctly, in order
> >> to not loss those meta info.
> >>
> >> So adding this testcase to check whether generic filesystem can
> >> guarantee that.
> > 
> > Can I make a suggestion here?
> > 
> > I've noticed that we are getting a lot of these one-off, random
> > "fsync persists one specific piece of metadata in one specific case"
> > tests, mainly in response to some fsync bug that was found in btrfs.
> > This is reactive, and does not find new bugs in this area.
> > 
> > We are also beyond the point where the number of tests is
> > maintainable (e.g. to be able to make infrastructure changes), so we
> > really should be looking to consolidate largely similar tests into
> > single tests where possible.
> > 
> > I'd strongly suggest that a robust fsync tester should be written
> > for all the cases that are currently being addressed in an ad hoc
> > fashion. Then they can be consolidated into a single test run, and
> > we can get rid of all the one-off "fsync failed on this <specific
> > thing>" tests from the harness.
> 
> Thanks for the suggestion, and that makes sense.
> 
> > 
> > Oh, wait, we *already have that infrastructure*: src/fsync-tester.c
> > and generic/311.
> > 
> > Can we please consider rolling all of these "do something, fsync,
> > drop-writes, remount check" into fsync-tester.c and do the same for
> > all future one-off "did fsync persist X" tests?
> 
> Let me add this testcase into fsync-tester.c, still we need add new
> testcase in generic/ directory instead of changing generic/311 directly,
> right? since as I remember that Eryu mentioned that:
> 
> "Usually we don't add new sub-tests to existing tests, so new failures
> introduced by the new sub-tests won't be treated as false regressions.
> Please add a new test instead."

Yeah, sure, but there's no point in adding a new fstest for every
case we move/add to fsync-tester.c - that's no better than what we have
now. i.e the whole point of using fsync-tester.c is to aggregate
lots of individual tests full of copy-n-paste dm-flakey
infrastructure into a single test. Copy-n-paste of fsync tester
boiler plate is not an improvement.

There are other 'aggregation' style tests in fstests, and we do
extend them from time to time. Some that come to mind are the
falloc/fpunch/fzero corner case tests, and we add new functionality
to fsstress and fsx all the time which affects every test that
runs them, etc.


> https://patchwork.kernel.org/patch/10042149/
> 
> Or to avoid redundant copied code from generic/311 in each fsync related
> patch, do I need just add my case into fsync_tester.c? and before
> announcement of fstests master branch, we can add one testcase into
> generic/ directory, in that testcase we gather/test all new added cases in
> fsync_tester.c recently.

Gathering them all into fsync-tester is what I'm suggesting should
be done....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
