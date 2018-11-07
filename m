Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:34077 "EHLO
 ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S2388677AbeKGLho (ORCPT <rfc822;fstests@vger.kernel.org>); Wed,
 7 Nov 2018 06:37:44 -0500
MIME-Version: 1.0
Message-ID: <20181107020922.GY6311@dastard>
Date: Tue, 6 Nov 2018 18:09:22 -0800 (PST)
From: Dave Chinner <david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
References: <CA+EzBbB5t5bSZ0hB6Y1jkxTgOLOv809Jbbcx7w5eK_XS_FPG7w@mail.gmail.com>
 <20181104163826.GH12788@desktop>
 <1B22AFA2-FAF3-45AA-9910-CDBE4AEBFB09@gmail.com>
 <20181105052217.GT6311@dastard>
 <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
 <20181106231536.GB8691@thunk.org> <20181106233956.GX6311@dastard>
 <CA+EzBbDwdi26MCswz0iQ8hUTcGixATUXayxMOmEw5gekYvmMuw@mail.gmail.com>
In-Reply-To: <CA+EzBbDwdi26MCswz0iQ8hUTcGixATUXayxMOmEw5gekYvmMuw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 06, 2018 at 05:50:28PM -0600, Jayashree Mohan wrote:
> On Tue, Nov 6, 2018 at 5:40 PM Dave Chinner <david@fromorbit.com> wrote:
> 
> > On Tue, Nov 06, 2018 at 06:15:36PM -0500, Theodore Y. Ts'o wrote:
> > > On Mon, Nov 05, 2018 at 02:16:57PM -0600, Jayashree Mohan wrote:
> > > >
> > > > I believe that to _scratch_mkfs, I must first _cleanup dm_flakey. If I
> > replace the above snippet by
> > > > _cleanup
> > > > _scratch_mkfs
> > > > _init_flakey
> > > >
> > > > The time taken for the test goes up by around 10 seconds (due to mkfs
> > maybe). So I thought it was sufficient to remove the working directory.
> > >
> > > Can you try adding _check_scratch_fs after each test case?  Yes, it
> >
> > _check_scratch_fs now runs xfs_scrub on XFS as well as xfs_repair,
> > so it's actually quite expensive.
> >
> > The whole point of aggregating all these tests into one fstest is to
> > avoid the overhead of running _check_scratch_fs after every single
> > test that are /extremely unlikely/ to fail on existing filesystems.
> >
> 
> Filipe and Eryu suggest that we run _check_scratch_fs after each subtest.
> Quoting Filipe,

These tests are highly unlikely to fail on existing filesystems.
If they do fail, then the developer can narrow it down by modifying
the test to the single test that fails and add _check_scratch_fs
where necessary.

Run time matters. Expensive, finegrained testing is only
useful if there's a high probability of the test finding ongoing
bugs. These tests have found bugs when they were first written, but
the ongoing probability of finding more bugs is extremely low.
Adding a huge amount of testing overhead for what appear to be very
marginal returns is not a good tradeoff.

> > Plus this test creates a very small fs, it's not like fsck will take a
> > significant time to run.
> > So for all these reasons I would unmount and fsck after each test.
> 
> For this reason, we currently _check_scratch_fs after each subtest in the
> _check_consistency method in my patch.
> +       _unmount_flakey
> +       _check_scratch_fs $FLAKEY_DEV
> +       [ $? -ne 0 ] && _fatal "fsck failed"
> 
> Running on a 200MB partition, addition of this check added only around 3-4
> seconds of delay in total for this patch consisting of 37 tests. Currently
> this patch takes about 12-15 seconds to run to completion on my 200MB
> partition.

What filesystem, and what about 20GB scratch partitions (which are
common)?  i.e. Checking cost is different on different filesystems,
different capacity devices and even different userspace versions of
the same filesystem utilities. It is most definitely not free, and
in some cases can be prohibitively expensive.

----

I suspect we've lost sight of the fact that fstests was /primarily/
a filesystem developer test suite, not a distro regression test
suite. If the test suite becomes too cumbersome and slow for
developers to use effectively, then it will get used less during
development and that's a *really, really bad outcome*.

e.g. I don't use the auto group in my development workflow any more
- it's too slow to get decent coverage of changes these days. I only
use the auto group for integration testing now. A few years ago it
would take about an hour to run the auto group on a couple of
spindles. These days it takes closer to 5 hours on the same setup.
Even on my really fast pmem setup it take a couple of hours to run
the entire auto group. As I have 15 different configurations I
need to run through integration testing and limited resources,
runtime certainly matters.

It even takes half an hour to run the quick group on my fast
machine, which really isn't very quick anymore because of the sheer
number of tests in the quick group.  Half an hour is too slow for
effective change feed back - feedback within 5 minutes is
necessary, otherwise the developer will context switch to something
else while waiting and lose all focus on what they were doing. This
leads to highly inefficient developers.

The quick group is now full of short, fine grained, targetted
regression tests. These are useful for distro release-to-release
testing, but the chances that they find new bugs are extremely low.
They really aren't that useful for developers who "fix the bug and
move on" and will never see that test fail ever again. If one of
these tests has a huge overhead or the sheer number of those tests
creates substantial overhead, then that is not a particularly good
use of the developer's time and resources.

IOWs, there's a cost to run each test that the really important use
case for fstests (i.e. the developers' test/dev cycle) cannot really
afford to pay that cost. i.e. developers need wide test coverage /at
speed/, not need deep, fine-grained, time consuming test coverage.

To put it in other words, developers need tests focussed on finding
bugs quickly, not regression tests that provide the core
requirements of integration and release testing. The development
testing phase is all about finding fast and effciently.

There's been little done in recent times to make fstests faster and
more efficient at finding new bugs for developers - the vast
majority of new tests has been for specific bugs that have already
been fixed.  Even these crashmonkey tests are not "find new bugs"
tests. The bugs they uncovered have been found and fixed, and so
they fall into this same finegrained integration regression test
category.

The only tests that I've seen discover new bugs recently are those
that run fsx, fstress or some other semi-randomised workloads that
are combined with some other operation. These tests find the bugs
that fine-grained, targetted regression tests will never uncover,
and so in many cases running most of these integration/regression
tests doesn't provide any value to the developer.

The faster the tests find the bugs, the faster the developer fixes
them. Then more dev/test cycles a developer can do in a day, the
more bugs they find and fix. So we want fstests to remain useful to
developers, then we have to pay more attention to runtime and how
efficient the tests are at fiding new bugs. More is not better.

Perhaps we need to recategorise the tests into new groups.

Perhaps we need to start working on reducing the huge amount
of technical debt we now have in fstests.

Perhaps we need to scale the fstests infrastructure to support
thousands of tests efficiently.

Perhaps we need to focus on tests that uncover new bugs (looking
forwards) rather than regression tests (looking backwards)

But, really, if we don't stop and think about what we are doing here
fstests will slowly drop out of the day-to-day developer workflow
because it is becoming less useful for finding new filesystem bugs
quickly...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
