Received: from imap.thunk.org ([74.207.234.97]:57974 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485AbbJSALB (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 18 Oct 2015 20:11:01 -0400
Date: Sun, 18 Oct 2015 20:10:58 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] common: introduce XFS_IO_AVOID env var
Message-ID: <20151019001058.GP2678@thunk.org>
References: <1445107518-32022-1-git-send-email-tytso@mit.edu>
 <20151018213745.GX27164@dastard>
 <20151018220805.GN2678@thunk.org>
 <20151018231402.GA27164@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151018231402.GA27164@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 19, 2015 at 10:14:02AM +1100, Dave Chinner wrote:
> 
> However, chopping out entire tests because they use a specific
> xfs_io command is a little different - it can exclude a lot of
> explicit correctness tests, rather than just change the pattern of
> stress loads by excluding certain operations.

Well, if a test which is testing collapse_range, and we chop it out,
then yes, we are excluding an explicit correctness test (for collapse
range) --- but that's the whole point.  I guess what you're saying is
that by excluding tests that require "collapse range", we might be
excluding something that is testing core file system correctness
beyond just, say, "collapse range" or "insert range".  But are there
really tests that fall into that category?

> This is exactly what the "-x group" CLI option is for: To exclude
> specific groups of tests from running, such as:
> 
> # ./check -g auto -x fcollapse
> 
> i.e. selection/exclusion of tests is done by group classifications
> in tests/*/group, not environment variables. Update the group files,
> and everything will work just fine for you.

The tests already have that information encoded in the
'_require_xfs_io_command "fcollapse"' assertion in the test file.  We
could update the group files, but that's a manual way of solving a
database synchronization problem.  This is why I liked the
XFS_AIO_AVOID solution, since the information of which tests use
fcollapse or finsert is already realiably available in one place ---
in the test script.

It also means that when people create new tests, they need to know
what groups should be included in the test's group file entry, or code
reviewers have to manually check to make sure the group file is
properly updated when each new test is added.  Which leads me to...

> FWIW, any test that uses a fallocatei() based command should also be
> in the prealloc group. Can you update the group files to ensure
> these tests are tagged with prealloc at the same time?

Is there documentation about what all of the groups are supposed to
mean, and what groups a new test should be part of?

For example, what is the precise meaning of the "dangerous" group?
I've recently tried running all of the dangerous group tests against
3.10.89, 3.14.53, 3.18.21, 4.1.8, and 4.3-rc2, and none of the caused
the kernels to crash when using ext4.  I was about to submit a patch
to remove the ext4/30[1234] tests from the "dangerous" group and add
them to the "auto" group.

I wasn't sure what to do with generic/019, generic/068, and
generic/280, which are in the dangerous group, and are passing for
ext4, but may be causing other file systems to crash.  But part of
that is I wasn't sure what the formal definition of "dangerous" is
supposed to mean.

Similarly, it didn't even *occur* to me that say, a test which uses
fpunch should be part of the prealloc group.  Yes, it's an fallocate()
based command, but it otherwise has no connection to preallocation.
I'm sure there's probably some very good historical, and possibly
still relevant reason today for that definition of "prealloc"; but it
certainly isn't obvious to me.

Cheers,

						- Ted

P.S.  More questions --- what is the meaning of the "ioctl" group
supposed to be, and what is its intended use?  And is there a reason
why we don't have a "defrag" group?  More generally, what's the
criteria used to evaluate the appropriateness of a new proposed group?
