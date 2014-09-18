Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:4834 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752705AbaIRAih (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Sep 2014 20:38:37 -0400
Date: Thu, 18 Sep 2014 10:36:28 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Performance testing
Message-ID: <20140918003628.GX4322@dastard>
References: <1410943724.31777.31.camel@jtulak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1410943724.31777.31.camel@jtulak>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 17, 2014 at 10:48:44AM +0200, Jan Tulak wrote:
> Hi,
> 
> I have began to work on some set of performance tests. I think it would
> be useful to have some standard set, because as far as I know, there is
> just little of performance testing and every of the few tests someone
> does is unique. I want to propose my ideas before I start to really
> write it, to fix possible complications.

Great idea, but I'm missing some context about your ultimate goal
here: how is this performance testing going to be used?

My focus for xfstests is mainly for it to be useful to filesystem
developers who are developing new features and fixing bugs, so my
comments come from the point of view of "will it make my life as a
filesystem developer easier?" rather than a "we have need a
performance test suites" perspective.

> Mixing performance with regressions tests wouldn't be a good idea, so I
> thought about creating another category on the main level of tests
> (something like xfstests/tests/performance). Or it would be better to
> put it into entirely new directory, like xfstests/performance?

That depends. What infrastructure do you actually need from the
xfstests harness? How much commonality are you expecting to use
here? If there's no commonality (i.e. it's a completely separate set
of infrastructure that only shares SCRATCH_DEV/SCRATCH_MNT) then I'd
have to question whether xfstests is the right place for this
functionality.

However, if it leverages all the same test template and execution
methods, then having it as just another test subgroup (i.e. in
tests/performance) would the right way to approach this.

> From the beginning there would be some basic test cases, like sync/async
> read and write. Hopefully more natural cases, like a database server
> would be added later.

IMO, if we do add performance tests to xfstests, then the focus
would definitely need to be on performance regression tests, not
"performance benchmark" (aka benchmarketing) tests. If you want
"performance benchmarks" then openbenchmarking.org is probably a
better place to start as that is what it is designed for and
already has everything you've mentioned.

So I'll focus on performance regression testing. Performance
regression testing involves a lot more than just "run benchmark,
save and compare results". It's once the "compare results" phase
says "regression found" that the functionality of the test really
matters to the filesystem develper. i.e. the tests need to be useful
for *analysis of the regression*.

Hence things like "database server benchmark" don't really belong in
a performance regression test suite because they can't be used to
isolate regressions. Further, they tend to be susceptible to changes
in performance being caused by changes outside filesystem and
storage layers. Hence they lead to wild goose chases more often than
they point to a real filesystem or IO regression.

> For the IO testing, I want to use FIO for the
> specific workflow and eventually iozone for the basic synthetic tests.

I think that the initial focus for performance regression tests
would need to be more on simple micro-benchmarks (e.g. read, write,
create, remove, etc).  I'd much prefer to see simple, targeted
benchmarks that are easily understood jus tby looking at the
xfstests code. e.g.  a patchset made unlink go fast, but slowed down
file create. Or that we sped up single threaded creates, but
destroyed multithreaded create scalability. Or that we sped up small
directories at the expense of large directories.  These things
can all be measured individually (and quickly) and because they
tend to measure a single aspect of filesystem performance they
can be used directly for regression analysis.

Many of these sorts of tests can be written into the existing
xfstests infrastructure without needing significant external
dependencies - fio and fsmark cover most of the microbenchmarks that
would be necessary. I already have quite a few scripts that I use to
run fsmark tests that could easily be wrapped with xfstests
templates....

As for IOZone, well, I'd suggest you don't bother with IOZone(*)
because we can do far better with bash, dd and fio....

> What I'm not sure is how a comparison between different versions could
> be done, because I don't see any infrastructure within fstests for
> cross-version comparison. (What would it do with regression tests
> anyway...) So I wonder if it should be done in this set at all. So the
> set would only print the measured values. Some other tool (which can be
> also included, but is not directly part of the performance tests set)
> could then be used to compare and/or plot graphs.

I don't think that storing results long term or comparing results is
something xfstests should directly care about. It is architected to
defer that to some external tool for post processing.  i.e. xfstests
is used to run the tests and generate results, not do long term
storage or analysis of those results.

I see no issues with including scripts to do result processing
across multiple RESULT_DIRs within xfstests itself, but the
infrastructure still has to be architected so it can be externally
controllable and usable by external test infrastructure.

Cheers,

Dave.

(*) IOZone is pretty much useless for performance regression
*detection*, let alone be useful for analysis of regressions.
Run-to-run variation of +/-10% is not uncommon or unexpected - it
has a very low precision.

It requires extremely stale clocks for it's timing to be accurate,
which means you have to be very careful about the hardware you use.
This also rules out testing in VMs as the timing is simply too
variable to be useful for accurate measurement. It also means that
it's very difficult to reproduce the same results across multiple
machines.

Worse is tha fact that it is also extremely sensitive to userspace
and kernel CPU cache footprint changes. Hence a change that affects
the CPU cache residency of the IOZone data buffer will have far more
effect on the result than the actual algorithmic change to
filesystem and IO subsystem that lead to the CPU cache footprint
change. Hence the same test on two different machiens that only
differ by CPU can give very different results - one might say
"faster", the other can say "slower".

It's just not a reliable tool for IO performance measurement, which
is kinda sad because that is it's sole purpose in life.....
-- 
Dave Chinner
david@fromorbit.com
