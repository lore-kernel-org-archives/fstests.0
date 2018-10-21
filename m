Received: from mail-wm1-f52.google.com ([209.85.128.52]:37800 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeJVHId (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Oct 2018 03:08:33 -0400
Received: by mail-wm1-f52.google.com with SMTP id f22-v6so554900wmc.2
        for <fstests@vger.kernel.org>; Sun, 21 Oct 2018 15:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+EzBbDZ5QZPqbgicY6Ar=uroM9a0-7b8PyUBdwYGMwXgBEanw@mail.gmail.com>
 <20181021104525.GS17817@desktop> <CA+EzBbCd2zZ9sNW-dgyPyR5FH-HK5LArG6y+bPOCJ3Wqyp5=Ug@mail.gmail.com>
 <20181021222111.GH1617@thunk.org>
In-Reply-To: <20181021222111.GH1617@thunk.org>
From: Jayashree Mohan <jayashree2912@gmail.com>
Date: Sun, 21 Oct 2018 17:52:21 -0500
Message-ID: <CA+EzBbB7GA8PZ1xHag0fTWst5cYMUngTmsjUeWemvKOvJ5B8yQ@mail.gmail.com>
Subject: Re: Submitting patches to xfstests based on OSDI '18 paper (CrashMonkey)
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Eryu Guan <guaneryu@gmail.com>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

> How long does each test case take to run?
All the tests would touch 4 files at most or write 32-64KB of data to
a file, starting from a empty file system image (hence very minimal
running time). We are not going to bring CrashMonkey in the loop - we
will port the generated tests to xfstest using dm-flakey (like
generic/498 [1], which was submitted in response to a bug found by
CrashMonkey in btrfs). Hence, each test should take the same time as
that of current crash-consistency tests in the xfstest suite (for
example, similar to generic/034 which takes about a second to run).

> And note, by the way, that
> by default we automatically run fsck on the test device after each
> test.  So number one, if you use the test device, you don't need to
> worry about running fsck explicitly; the xfstests check script will do
> that, and fail the test if the file system is corrupted --- and number
> two, this will influence whether which groups each test should be
> assigned.

Noted. Since we will be writing the out-file (checker) manually, will
ensure that checks only the content/metadata.

> See the file xfstests-dev/tests/generic/group to see how groups get
> assigned to tests.  I suppose all of the crashmonkey tests should be
> assigned to a new group, say, "crashmonkey".  Whether or not they
> should get assigned to the "auto" or "quick" group is a different
> question.  Note that if running these tests will signicantly increase
> the test run time of smoke tests and even the full "automatic"
> regression tests, there may be some resistence in adding all of these
> tests to the "auto" or "quick" groups.  Or even if you do, many file
> system developers may choose to exclude all tests from the
> "crashmonkey" group because if a 15 minute smoke test suddenly gets
> extended to take 6 hours, developers are wont to get.... cranky.  :-)

It makes sense to add it to a new group as you suggest, and
considering a second to run each test, it should take around 5 minutes
to run this batch of CrashMonkey tests. Once the tests cases are
ready, we can give you a better estimate of total time spent on the
newly added tests.

[1] https://patchwork.kernel.org/patch/10458749/

Thanks,
Jayashree
