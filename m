Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:49679 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752121AbbJSC3t (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 18 Oct 2015 22:29:49 -0400
Date: Mon, 19 Oct 2015 13:29:27 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common: introduce XFS_IO_AVOID env var
Message-ID: <20151019022927.GC27164@dastard>
References: <1445107518-32022-1-git-send-email-tytso@mit.edu>
 <20151018213745.GX27164@dastard>
 <20151018220805.GN2678@thunk.org>
 <20151018231402.GA27164@dastard>
 <20151019001058.GP2678@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151019001058.GP2678@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Oct 18, 2015 at 08:10:58PM -0400, Theodore Ts'o wrote:
> On Mon, Oct 19, 2015 at 10:14:02AM +1100, Dave Chinner wrote:
> > 
> > However, chopping out entire tests because they use a specific
> > xfs_io command is a little different - it can exclude a lot of
> > explicit correctness tests, rather than just change the pattern of
> > stress loads by excluding certain operations.
> 
> Well, if a test which is testing collapse_range, and we chop it out,
> then yes, we are excluding an explicit correctness test (for collapse
> range) --- but that's the whole point.  I guess what you're saying is
> that by excluding tests that require "collapse range", we might be
> excluding something that is testing core file system correctness
> beyond just, say, "collapse range" or "insert range".  But are there
> really tests that fall into that category?

No idea, and I don't really care, either.

> > This is exactly what the "-x group" CLI option is for: To exclude
> > specific groups of tests from running, such as:
> > 
> > # ./check -g auto -x fcollapse
> > 
> > i.e. selection/exclusion of tests is done by group classifications
> > in tests/*/group, not environment variables. Update the group files,
> > and everything will work just fine for you.
> 
> The tests already have that information encoded in the
> '_require_xfs_io_command "fcollapse"' assertion in the test file.

Yes, but that's so the "auto" group does the right thing when it
comes across the test and it's being run on a platform/fs that
doesn't support that functionality.

You want to manually control what tests you run, and we already
have generic mechanisms for that. Indeed, the external expunge file
was added precisely so you could maintain these expunge lists easily
yourself in your kvm/gce test harness:

commit 9f3515572c4939674bdb582e26ca12baa1575416
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Tue May 13 09:04:13 2014 +1000

    check: add support for an external file containing tests to exclude
    
    Currently the -X option is intended to specify a set of expunging
    files which are stored in each test/* subdirectory.  As described in
    the commit description for 0b1e8abd4, in order to exclude the test
    generic/280, the -X option is used as follows:
    
        $ cat tests/generic/3.0-stable-avoid
        280
        $ sudo ./check -X 3.0-stable-avoid generic/280
    
    However, it is sometimes useful to store the set of expunged tests in
    a single file, outside of tests/* subdirectories.  This commit enables
    the following:
    
        $ cat /root/conf/data_journal.exclude
        generic/068
        ext4/301
        $ sudo ./check -E /root/conf/data_journal.exclude -g auto
    
    Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
    Reviewed-by: Dave Chinner <dchinner@redhat.com>
    Signed-off-by: Dave Chinner <david@fromorbit.com>

We don't need mulitple mechanisms to implement the same
funtionality in slightly different contexts.

> It also means that when people create new tests, they need to know
> what groups should be included in the test's group file entry, or code
> reviewers have to manually check to make sure the group file is
> properly updated when each new test is added.  Which leads me to...

That would be your responsibility to keep up to date. i.e. you'd
need to catch group misuse as a reviewer, or send patches to fix it
up after the fact. If you need something, then you keep it working
and make sure people learn how to use it properly.

> > FWIW, any test that uses a fallocatei() based command should also be
> > in the prealloc group. Can you update the group files to ensure
> > these tests are tagged with prealloc at the same time?
> 
> Is there documentation about what all of the groups are supposed to
> mean, and what groups a new test should be part of?

It's all pretty obvious, yes?

auto = expected to work as a regression test
quick = runs fast
rw = does read/write IO operations
aio = does AIO
metadata = tests/stresses metadata operations
prealloc = does extent manipulations
enospc = exercises operation at enospc
acl = ACL tests
attr = extended attribute tests
freeze = filesystem freeze tests
....

and so on.

> For example, what is the precise meaning of the "dangerous" group?

"Test is likely to oops/hang the kernel and prevent subsequent tests
from being run and/or completing correctly."

> I've recently tried running all of the dangerous group tests against
> 3.10.89, 3.14.53, 3.18.21, 4.1.8, and 4.3-rc2, and none of the caused
> the kernels to crash when using ext4.  I was about to submit a patch
> to remove the ext4/30[1234] tests from the "dangerous" group and add
> them to the "auto" group.

So whatever bugs they were triggering have been fixed? If so, send a
patch to add them to the auto group.

> I wasn't sure what to do with generic/019, generic/068, and
> generic/280, which are in the dangerous group, and are passing for
> ext4, but may be causing other file systems to crash.  But part of
> that is I wasn't sure what the formal definition of "dangerous" is
> supposed to mean.

generic/068 and /280 are already part of the auto group, indicating
that they work fine on current kernels, but are likely to hang/crash
older kernels.

As for generic/019, it's dangerous for other filesystems, especially
XFS w/ CONFIG_XFS_DEBUG=y as it detects a in-memory corruption
caused by shutdown detection in the middle of a trnasaction that is
then aborted.  That causes an ASSERT failure and hence an oops and
the machine is brought down. So, no auto group for that test until
that problem is fixed.

> Similarly, it didn't even *occur* to me that say, a test which uses
> fpunch should be part of the prealloc group.  Yes, it's an fallocate()
> based command, but it otherwise has no connection to preallocation.

So now you know - it's been the placeholder for direct extent
manipulation tests for many, many years, whether they be allocating
extents, punching them out or even querying them
(xfs_bmap/fiemap)...

> I'm sure there's probably some very good historical, and possibly
> still relevant reason today for that definition of "prealloc"; but it
> certainly isn't obvious to me.

So write a patch to document the group names and intended categories
of tests they should contain, and another to change the name of the
prealloc group to something like "extent_ops" so it's easier to
understand.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
