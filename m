Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40681 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754498AbaI2QHP (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 29 Sep 2014 12:07:15 -0400
Message-ID: <1412006829.3471.23.camel@jtulak>
Subject: Re: Performance testing
From: Jan Tulak <jtulak@redhat.com>
Date: Mon, 29 Sep 2014 18:07:09 +0200
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

On Sat, 2014-09-27 at 10:47 +1000, Dave Chinner wrote:
> On Thu, Sep 25, 2014 at 05:03:40PM +0200, Jan Tulak wrote:
> > On Thu, 2014-09-18 at 10:36 +1000, Dave Chinner wrote:
> > > On Wed, Sep 17, 2014 at 10:48:44AM +0200, Jan Tulak wrote:
> > > ...
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

I can't argue about that. :-)

> > > > ...
> > > ...
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

One idea I thought about and didn't see big problems in existing
infrastructure would be to add another level for tests. So there could
be something like tests/something/001/001. Not specifying the last level
would mean "every test in a sub-level". 

>From what I saw, that would need some smaller changes in ./check script
and a mechanism for the sub-levels to share their environment. The
mechanism could work as follows:
In a sub-level there would be an init script, invoked by the tests and
used for setting the filesystem and other things. After first run, it
would export a variable with its own file path/group name. On subsequent
tests, the variable would already have the specified value, so no
initialization would be done again, until another sub-level.

An alternative for the mechanism would be to really check if the
filesystem is in required state, but this seems to me like a test in a
test (in a test...) :-)

> 
> > > > ...
> > > > ...
> > > 
> > > ...
> > > 
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

Yes, exactly.

Cheers,
Jan

