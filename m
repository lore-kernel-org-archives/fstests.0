Received: from mail-wr1-f53.google.com ([209.85.221.53]:44457 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeJVLZx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Oct 2018 07:25:53 -0400
Received: by mail-wr1-f53.google.com with SMTP id q6-v6so6850028wrw.11
        for <fstests@vger.kernel.org>; Sun, 21 Oct 2018 20:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <CA+EzBbDZ5QZPqbgicY6Ar=uroM9a0-7b8PyUBdwYGMwXgBEanw@mail.gmail.com>
 <20181021104525.GS17817@desktop> <CA+EzBbCd2zZ9sNW-dgyPyR5FH-HK5LArG6y+bPOCJ3Wqyp5=Ug@mail.gmail.com>
 <20181021222111.GH1617@thunk.org> <CA+EzBbB7GA8PZ1xHag0fTWst5cYMUngTmsjUeWemvKOvJ5B8yQ@mail.gmail.com>
 <20181022020539.GR6311@dastard> <CAOQ4uxhxgY0Kpk87zxWdfqUcH=ZBiajzBmnrCCb1M_+V2NPcuQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhxgY0Kpk87zxWdfqUcH=ZBiajzBmnrCCb1M_+V2NPcuQ@mail.gmail.com>
From: Jayashree Mohan <jayashree2912@gmail.com>
Date: Sun, 21 Oct 2018 22:09:01 -0500
Message-ID: <CA+EzBbDGcryv+eiChoYEhCGKS87DBFMxiUvZGy8-VD-80YCetQ@mail.gmail.com>
Subject: Re: Submitting patches to xfstests based on OSDI '18 paper (CrashMonkey)
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Eryu Guan <guaneryu@gmail.com>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, fstests <fstests@vger.kernel.org>, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Sun, Oct 21, 2018 at 9:44 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > >
> > > > See the file xfstests-dev/tests/generic/group to see how groups get
> > > > assigned to tests.  I suppose all of the crashmonkey tests should be
> > > > assigned to a new group, say, "crashmonkey".
>
> Wait, let me get it straight. Did crashmonkey produce 300 test cases or
> did it find 300 bugs? Are all those test cases passing on all filesystems?
> Some test cases failing on some filesystems?

CrashMonkey generates 300 workloads, out of which 3 tests result in
bugs in two file systems (btrfs and F2FS). Others passed clean for
ext4, xfs, btrfs and F2FS. Given that xfstest is a regression test
suite, we thought it would be beneficial to add all 300 workloads to
the generic test - it is possible that a future kernel version has a
bug that could be triggered by one of these 300 workloads. We say so
because, these workloads test the file-system in a systematic manner
using common file-system operations. Given that crash-consistency
tests are sparse, checking a file system against these 300 workloads
will at least ensure that the file system is free from simple
crash-consistency bugs (in addition to testing for bugs that were
reported in earlier kernel versions).

> In any case, I would add tests to group "crash" or "flakey", as there are
> other crash consistent tests that could fit in that group in current tests.
> If there is something differentiating the new tests from existing crash
> tests they could be added to yet another group.
>
> If it is not 300 bugs, but 300 generated sequences and crashmonkey
> OSDI paper 2019 is going to result in 26000 generated sequences,
> then the test group would be better characterized as -g generic/fuzzers.
>
> > > > Note that if running these tests will signicantly increase
> > > > the test run time of smoke tests and even the full "automatic"
> > > > regression tests, there may be some resistence in adding all of these
> > > > tests to the "auto" or "quick" groups.  Or even if you do, many file
> > > > system developers may choose to exclude all tests from the
> > > > "crashmonkey" group because if a 15 minute smoke test suddenly gets
> > > > extended to take 6 hours, developers are wont to get.... cranky.  :-)
> > >
> > > It makes sense to add it to a new group as you suggest, and
> > > considering a second to run each test, it should take around 5 minutes
> > > to run this batch of CrashMonkey tests. Once the tests cases are
> > > ready, we can give you a better estimate of total time spent on the
> > > newly added tests.
> >
> > Add the time between tests - fsck checks, scrub, etc, and that can
> > easily add another 10s per test.
> >
>
> Jayashree,
>
> Please note that the time between test highly depends on the scratch
> partition size and media, so you may not be seeing the full effects of
> running 300 "quick" tests on your system.

Got it.


> > Hence I'd strongly encourage you to batch similar tests into a
> > single xfstest test so that we're not needlessly adding 300x15s to
> > every test run because of the per-test external overhead.....
> >
>
> And that should be easy to do as:
>
> test case #1: do
> _flakey_drop_and_remount
> test case #1: check
> test case #1: clean
>
> test case #2: do
> _flakey_drop_and_remount
> test case #2: check
> test case #2: clean
>
> I suppose you don't HAVE to run all test cases on a fresh created fs??
> so clean would be just rm -rf or even each test case could use its own
> subdir?

You are right. A simple cleanup will work. We can club multiple of our
workloads into one test and create something like 1 test case per
file-system operation.

Thanks,
Jayashree.
