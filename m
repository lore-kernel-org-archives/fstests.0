Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38597 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619AbaJYS44 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 25 Oct 2014 14:56:56 -0400
Message-ID: <1414257004.4531.68.camel@jtulak>
Subject: Re: Performance testing
From: Jan Tulak <jtulak@redhat.com>
Date: Sat, 25 Oct 2014 19:10:04 +0200
In-Reply-To: <20140927004711.GJ4758@dastard>
References: <1410943724.31777.31.camel@jtulak>
	 <20140918003628.GX4322@dastard> <1411657420.26791.48.camel@jtulak>
	 <20140927004711.GJ4758@dastard>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi,

I have done some work on the pre-conditions for tests to share some
setup recently (like making the FS almost full... I'm using word
"environment" as name for it). It is not yet fully implemented, but I
have found some things where I'm uncertain what solution to use.

So at first how it works:
There is a new file "environment" on the same level as a "group" file in
tests directory. This file has the same syntax as "group". For setting
up the environment for a test, there is also a file named
"environment-NAME", where NAME is the name of the setup from the first
file - something like a group name.

Tests are sorted by the environment name, so if they do not need to
reset the environment pre-conditions, the setup script is run just one.

Here is the unsure part: Currently I have the environments on same level
as groups, but that means that it can't be shared between (for example)
general/001 and xfs/001 tests. I can move it somewhere else, so either
full environments settings, or just the setup scripts can be shared
between the categories. Is there a strong reasoning why to choose one or
the other option? If not, I think I will keep the "environment" file on
same level as "group", but will share the setup scripts.

Also, because one test can be in multiple environments, the test can be
run multiple times. Because of this, I wonder if all the functionality
should be enabled explicitly, as a flag to ./check script. (No
environment preparations until requested). It is not changing anything
if the test is not explicitly placed into the "environment" file.

Thanks.

Cheers,
Jan

On Sat, 2014-09-27 at 10:47 +1000, Dave Chinner wrote:
> On Thu, Sep 25, 2014 at 05:03:40PM +0200, Jan Tulak wrote:
> > On Thu, 2014-09-18 at 10:36 +1000, Dave Chinner wrote:
> > > On Wed, Sep 17, 2014 at 10:48:44AM +0200, Jan Tulak wrote:
> > > > Hi,
> > > > 
> > > > I have began to work on some set of performance tests. I think it would
> > > > be useful to have some standard set, because as far as I know, there is
> > > > just little of performance testing and every of the few tests someone
> > > > does is unique. I want to propose my ideas before I start to really
> > > > write it, to fix possible complications.
> > > 
> > > Great idea, but I'm missing some context about your ultimate goal
> > > here: how is this performance testing going to be used?
> > > 
> > > My focus for xfstests is mainly for it to be useful to filesystem
> > > developers who are developing new features and fixing bugs, so my
> > > comments come from the point of view of "will it make my life as a
> > > filesystem developer easier?" rather than a "we have need a
> > > performance test suites" perspective.
> > 
> > I think there is a place for two kinds of these tests. One is a quick
> > suite that should not run for more than few minutes and can be used
> > whenever sending a patch (or on daily basis...) for a quick check, to
> > catch bad things as soon as possible. 
> > 
> > The other set would be for deeper and more complex and used rather
> > between versions than single patches. This one maybe could be
> > independent, but for consistency, I think it is better to keep both sets
> > together.
> 
> I'm not yet convinced, but keep talking ;)
> 
> > > > From the beginning there would be some basic test cases, like sync/async
> > > > read and write. Hopefully more natural cases, like a database server
> > > > would be added later.
> > > 
> > > IMO, if we do add performance tests to xfstests, then the focus
> > > would definitely need to be on performance regression tests, not
> > > "performance benchmark" (aka benchmarketing) tests. If you want
> > > "performance benchmarks" then openbenchmarking.org is probably a
> > > better place to start as that is what it is designed for and
> > > already has everything you've mentioned.
> > > 
> > > So I'll focus on performance regression testing. Performance
> > > regression testing involves a lot more than just "run benchmark,
> > > save and compare results". It's once the "compare results" phase
> > > says "regression found" that the functionality of the test really
> > > matters to the filesystem develper. i.e. the tests need to be useful
> > > for *analysis of the regression*.
> > > 
> > > Hence things like "database server benchmark" don't really belong in
> > > a performance regression test suite because they can't be used to
> > > isolate regressions. Further, they tend to be susceptible to changes
> > > in performance being caused by changes outside filesystem and
> > > storage layers. Hence they lead to wild goose chases more often than
> > > they point to a real filesystem or IO regression.
> > > 
> > This is not needed in the quick suite, but just testing simple
> > read/write will not find regression appearing during some more
> > complicated situations. If the only thing changed is the filesystem,
> > any big difference in results can be attributed to the filesystem
> > change. Right? 
> 
> No. A change in a filesystem can causing things like more context
> switches to occur due to additional serialisation on a sleeping
> lock. A change of context switch behaviour can expose issuing in
> other subsystems, like the scheduler or even bugs in the locking
> code. This happens more frequently than you think...
> 
> > I do not expect everyone will run this test suite all
> > day, but it could notice us about regressions between versions of a
> > filesystem.
> 
> It's rare that developers run tests directly comparing released
> versions of the kernel. We'll compare "unpatched vs patched" in
> back-to-back tests, so the tests we do run need to be cover a good
> portion of the performance matrix in a useful fashion....
> 
> > > > For the IO testing, I want to use FIO for the
> > > > specific workflow and eventually iozone for the basic synthetic tests.
> > > 
> > > I think that the initial focus for performance regression tests
> > > would need to be more on simple micro-benchmarks (e.g. read, write,
> > > create, remove, etc).  I'd much prefer to see simple, targeted
> > > benchmarks that are easily understood jus tby looking at the
> > > xfstests code. e.g.  a patchset made unlink go fast, but slowed down
> > > file create. Or that we sped up single threaded creates, but
> > > destroyed multithreaded create scalability. Or that we sped up small
> > > directories at the expense of large directories.  These things
> > > can all be measured individually (and quickly) and because they
> > > tend to measure a single aspect of filesystem performance they
> > > can be used directly for regression analysis.
> > > 
> > > Many of these sorts of tests can be written into the existing
> > > xfstests infrastructure without needing significant external
> > > dependencies - fio and fsmark cover most of the microbenchmarks that
> > > would be necessary. I already have quite a few scripts that I use to
> > > run fsmark tests that could easily be wrapped with xfstests
> > > templates....
> > 
> > The initial focus should really aim at this, I agree. Creating this
> > quick and small suite should not take a long time. If you have
> > something, that could be useful once I will create some kind of template
> > for performance tests.
> 
> I've attached an example script I use to run a file creation
> micro-benchmark.
> 
> What is important here is that once the files are created, I then
> run several more performance tests on the filesystem - xfs_repair
> performance, bulkstat performance, find and ls -R performance, and
> finally unlink performance.
> 
> So it's really 5 or 6 tests in one. We are going to need to be able
> to support such "sub-test" categories so that we don't waste lots of
> time having to create filesystem pre-conditions for various
> micro-benchmarks. Any ideas on how we could group tests like this
> so they are run sequentially as a group, but also can be run
> individually and correctly invking the setup test if the filesystem
> is not in the correct state?
> 
> > > > What I'm not sure is how a comparison between different versions could
> > > > be done, because I don't see any infrastructure within fstests for
> > > > cross-version comparison. (What would it do with regression tests
> > > > anyway...) So I wonder if it should be done in this set at all. So the
> > > > set would only print the measured values. Some other tool (which can be
> > > > also included, but is not directly part of the performance tests set)
> > > > could then be used to compare and/or plot graphs.
> > > 
> > > I don't think that storing results long term or comparing results is
> > > something xfstests should directly care about. It is architected to
> > > defer that to some external tool for post processing.  i.e. xfstests
> > > is used to run the tests and generate results, not do long term
> > > storage or analysis of those results.
> > > 
> > > I see no issues with including scripts to do result processing
> > > across multiple RESULT_DIRs within xfstests itself, but the
> > > infrastructure still has to be architected so it can be externally
> > > controllable and usable by external test infrastructure.
> > 
> > I expected something like this, so it shouldn't be a big trouble. What I
> > see as a good way: at first to create some small tests. Then, once they
> > works as intended, I can work on the external tool for managing the
> > results, rather than at first creating the tool. That will also give me
> > more time to find some good solution. (What I see, there is already some
> > work with autotest running xfstest, so maybe it will needs just a little
> > work to add the new tests.)
> 
> Yes, that seems like the sensible approach to take.
> 
> FWIW, I'm pretty sure most developers run xfstests directly, so I'd
> concentrate on making reporting work well for this case first, then
> concentrate on what extra functionality external harnesses like
> autotest require....
> 
> Cheers,
> 
> Dave.


