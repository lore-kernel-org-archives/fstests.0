Received: from ipmail02.adl2.internode.on.net ([150.101.137.139]:32166 "EHLO
        ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725884AbeJVKWK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Oct 2018 06:22:10 -0400
Date: Mon, 22 Oct 2018 13:05:39 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Submitting patches to xfstests based on OSDI '18 paper
 (CrashMonkey)
Message-ID: <20181022020539.GR6311@dastard>
References: <CA+EzBbDZ5QZPqbgicY6Ar=uroM9a0-7b8PyUBdwYGMwXgBEanw@mail.gmail.com>
 <20181021104525.GS17817@desktop>
 <CA+EzBbCd2zZ9sNW-dgyPyR5FH-HK5LArG6y+bPOCJ3Wqyp5=Ug@mail.gmail.com>
 <20181021222111.GH1617@thunk.org>
 <CA+EzBbB7GA8PZ1xHag0fTWst5cYMUngTmsjUeWemvKOvJ5B8yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EzBbB7GA8PZ1xHag0fTWst5cYMUngTmsjUeWemvKOvJ5B8yQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Eryu Guan <guaneryu@gmail.com>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Oct 21, 2018 at 05:52:21PM -0500, Jayashree Mohan wrote:
> > How long does each test case take to run?
> All the tests would touch 4 files at most or write 32-64KB of data to
> a file, starting from a empty file system image (hence very minimal
> running time). We are not going to bring CrashMonkey in the loop - we
> will port the generated tests to xfstest using dm-flakey (like
> generic/498 [1], which was submitted in response to a bug found by
> CrashMonkey in btrfs). Hence, each test should take the same time as
> that of current crash-consistency tests in the xfstest suite (for
> example, similar to generic/034 which takes about a second to run).
> 
> > And note, by the way, that
> > by default we automatically run fsck on the test device after each
> > test.  So number one, if you use the test device, you don't need to
> > worry about running fsck explicitly; the xfstests check script will do
> > that, and fail the test if the file system is corrupted --- and number
> > two, this will influence whether which groups each test should be
> > assigned.
> 
> Noted. Since we will be writing the out-file (checker) manually, will
> ensure that checks only the content/metadata.
> 
> > See the file xfstests-dev/tests/generic/group to see how groups get
> > assigned to tests.  I suppose all of the crashmonkey tests should be
> > assigned to a new group, say, "crashmonkey".  Whether or not they
> > should get assigned to the "auto" or "quick" group is a different
> > question.  Note that if running these tests will signicantly increase
> > the test run time of smoke tests and even the full "automatic"
> > regression tests, there may be some resistence in adding all of these
> > tests to the "auto" or "quick" groups.  Or even if you do, many file
> > system developers may choose to exclude all tests from the
> > "crashmonkey" group because if a 15 minute smoke test suddenly gets
> > extended to take 6 hours, developers are wont to get.... cranky.  :-)
> 
> It makes sense to add it to a new group as you suggest, and
> considering a second to run each test, it should take around 5 minutes
> to run this batch of CrashMonkey tests. Once the tests cases are
> ready, we can give you a better estimate of total time spent on the
> newly added tests.

Add the time between tests - fsck checks, scrub, etc, and that can
easily add another 10s per test.

Hence I'd strongly encourage you to batch similar tests into a
single xfstest test so that we're not needlessly adding 300x15s to
every test run because of the per-test external overhead.....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
