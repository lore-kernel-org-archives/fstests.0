Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:39390 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727362AbeKIMxj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 9 Nov 2018 07:53:39 -0500
Date: Fri, 9 Nov 2018 14:12:05 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
Message-ID: <20181109031205.GC6311@dastard>
References: <20181104163826.GH12788@desktop>
 <1B22AFA2-FAF3-45AA-9910-CDBE4AEBFB09@gmail.com>
 <20181105052217.GT6311@dastard>
 <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
 <20181106231536.GB8691@thunk.org>
 <20181106233956.GX6311@dastard>
 <CA+EzBbDwdi26MCswz0iQ8hUTcGixATUXayxMOmEw5gekYvmMuw@mail.gmail.com>
 <20181107020922.GY6311@dastard>
 <20181108094045.GB6311@dastard>
 <CAHWVdUXSCo1UjGG+TL9SBq5KXOMszVP86E2od1RXqKfcwcYXvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHWVdUXSCo1UjGG+TL9SBq5KXOMszVP86E2od1RXqKfcwcYXvA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
Cc: Jayashree Mohan <jayashree2912@gmail.com>, Theodore Tso <tytso@mit.edu>, guaneryu@gmail.com, fstests <fstests@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, fdmanana@gmail.com
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 08, 2018 at 09:35:56AM -0600, Vijaychidambaram Velayudhan Pillai wrote:
> On Thu, Nov 8, 2018 at 3:40 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Wed, Nov 07, 2018 at 01:09:22PM +1100, Dave Chinner wrote:
> > > To put it in other words, developers need tests focussed on finding
> > > bugs quickly, not regression tests that provide the core
> > > requirements of integration and release testing. The development
> > > testing phase is all about finding fast and effciently.
> >
> > To emphasis my point of having tests and tools capable of finding
> > new bugs, I noticed yesterday that fstress and fsx didn't support
> > copy_file_range, and fsx doesn't support clone/dedupe_file_range
> > either. Darrick added them overnight.
> >
> > fsx as run by generic/263 takes *32* operations to find a data
> > corruption with copy_file_range on XFS. Even changing it to do
> > buffered IO instead of direct IO, it only takes ~600 operations to
> > fail with a different data corruption.
> >
> > That's *at least* two previously unknown bugs exposed in under a
> > second of runtime.
> >
> > That's the sort of tooling we need - we don't need hundreds of tests
> > that are scripted reproducers of fixed problems, we need tools that
> > exercise boundary conditions and corner cases in ways that are
> > likely to expose incorrect behaviour. Tools that do these things
> > quickly and in a reproducable manner are worth their weight in
> > gold...
> >
> > IMO, Quality Engineering is not just about writing regression tests
> > to keep out known bugs - it's most important function is developing
> > and refining new testing tools to find bugs that have escaped
> > detection with existing testing methods and tools. If test engineers
> > can find new bugs, software engineers can fix them. That's really
> > the ultimate goal here - to find bugs and fix them before users are
> > exposed to them...
> 
> Dave, I think there is some confusion about what CrashMonkey does. I
> think you'll find its very close to what you want. Let me explain.

I'm pretty sure I know what crashmonkey does, and I know what is
being proposed here /isn't crashmonkey/.

> CrashMonkey does exactly the kind of systematic testing that you want.
> Given a set of system calls, it generates tests for crash consistency
> for different workloads comprising of these system calls. It does this
> by testing each system call first, then each pair of system calls, and
> so on. Both the workload (which system calls to test) and the check
> (what should the file system look like after crash recovery) are
> automatically generated, without any human effort in the loop.
> 
> CrashMonkey found 10 new bugs in btrfs and F2FS, so its not just a
> suite of regression tests.

Sure, but that was during an initial exploritory phase of the
project on two immature filesystems. Now that those initial bugs
have been fixed, I'm not seeing new bugs being reported.

So what is being proposed for fstests here? It's not an exploratory
tool like crashmonkey, or arbitrary boundary case exerciser like
fsstress and fsx. What is being proposed is a set of fixed scripts
that walk a defined set of single operations with a known, fixed set
of initial conditions and checks that each individual op they behave
as they should in that environment.

There's no variation here. The same tests with the same initial
conditions is run /every time/. When run on the same code, they will
exercise exactly the same code path. There is no variation at all,
and so if there are no bugs in the code path they exercise, they
will not find any new bugs.

That's my point: unlike crashmonkey in workload generation mode or
fsx/fsstress, the code they exercise does not vary.  Yes, when first
run on a new code base they exposed bugs, but now that those bugs
are fixed, they don't find any new bugs.  They can only detect bugs
in changes to the fixed code paths they exercise.  Ergo, they are
regression tests.

Don't get me wrong - we need both types of tests - but I care less
about a huge swath of railroad regression tests than I do about
tools that find new bugs over and over again without needing
modification.

> When we studied previous crash-consistency bugs reported and fixed in
> the kernel, we noticed most of them could be reproduced on a clean fs
> image of small size (100 MB). We found that the arguments to the
> system calls could also be constrained: we just needed to reuse a
> small set of file names or file ranges. We used this to automatically
> generate xfstests-style tests for each file system. We generated and
> tested a total of 3.3M workloads on a research cluster at UT Austin.

Which is great, especailly as you found bugs in that exploration.
But exhaustive searches like this really are not practical for day
to day development. Developers don't ahve their own personal
clusters for testing their filesystem code. They might only have a
laptop.

These sorts of massive exploratory regression testing are really the
domain of product release managers and their QE department (think of
the scale of testing that goes into a RHEL or SLES release).  It's
-their job- to find gnarly, weird regressions that are beyond the
capability of individual developers to uncover. This isn't the sort
of testing that is relevant to the day-to-day filesystem developer.

This comes back to my point about fstests being a tool for
developers as much as it is for distro QE departments. The balance
is falling too far towards the "massive regression test suite" side
and away from the "find new bugs really fast" focus we have
historically had. Adding hundreds more tests on that fall on the
"massive regression test suite" side of the ledger just makes this
imbalance worse.

That's not something that crashmonkey can solve, but it's something
we, as fstests users and developers, have to be very aware of when
considering an addition of the size being proposed.

> We found that even testing a single system call revealed three new
> bugs (which have not all been patched yet). To systematically test
> single system calls, you need about 300 tests.

That's 300 tests per system call?  I think that's underestimating
the complexity of many syscalls (like open(), read(), etc) quite
substantially. Indeed, open(O_TMPFILE) is going to make linkat()
behave very differently, and there's a whole set of crash
consistency problems when O_TMPFILE is used with linkat() that the
proposed link behaviour tests do not cover.

Maybe a better way to integrate this is to add a completely new
tests/ subdirectory and push all the crash consistency tests into
that directory. They don't get run by quick/auto, but instead by a
specific group that runs that directory. The tests don't get
intermingled with all the other generic tests, and you can set them
up to run fsck as often as you want because they don't get in the
way of existing testing.  Over time we can more of the generic crash
consistency regression tests elsewhere in fstests (e.g. all those
fsync-on-btrfs-doesn't tests) over to that same subdir.

I suspect we need to do more of this sort of "by type" breakup of
the "generic" directory, too, because it has become hard to manage
the 500-odd tests that are now in it....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
