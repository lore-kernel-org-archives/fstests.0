Received: from mail-yb1-f195.google.com ([209.85.219.195]:41674 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJVMER (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Oct 2018 08:04:17 -0400
Received: by mail-yb1-f195.google.com with SMTP id e16-v6so15590511ybk.8
        for <fstests@vger.kernel.org>; Sun, 21 Oct 2018 20:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+EzBbDZ5QZPqbgicY6Ar=uroM9a0-7b8PyUBdwYGMwXgBEanw@mail.gmail.com>
 <20181021104525.GS17817@desktop> <CA+EzBbCd2zZ9sNW-dgyPyR5FH-HK5LArG6y+bPOCJ3Wqyp5=Ug@mail.gmail.com>
 <20181021222111.GH1617@thunk.org> <CA+EzBbB7GA8PZ1xHag0fTWst5cYMUngTmsjUeWemvKOvJ5B8yQ@mail.gmail.com>
 <20181022020539.GR6311@dastard> <CAOQ4uxhxgY0Kpk87zxWdfqUcH=ZBiajzBmnrCCb1M_+V2NPcuQ@mail.gmail.com>
 <CA+EzBbDGcryv+eiChoYEhCGKS87DBFMxiUvZGy8-VD-80YCetQ@mail.gmail.com>
In-Reply-To: <CA+EzBbDGcryv+eiChoYEhCGKS87DBFMxiUvZGy8-VD-80YCetQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 22 Oct 2018 06:47:22 +0300
Message-ID: <CAOQ4uxgJ-7Br_G5ZUMaK0v9ieDSLZZX-k9h69YNcGZv8SOXoMg@mail.gmail.com>
Subject: Re: Submitting patches to xfstests based on OSDI '18 paper (CrashMonkey)
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: Theodore Tso <tytso@mit.edu>, Eryu Guan <guaneryu@gmail.com>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, fstests <fstests@vger.kernel.org>, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 22, 2018 at 6:09 AM Jayashree Mohan <jayashree2912@gmail.com> wrote:
>
> On Sun, Oct 21, 2018 at 9:44 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > >
> > > > > See the file xfstests-dev/tests/generic/group to see how groups get
> > > > > assigned to tests.  I suppose all of the crashmonkey tests should be
> > > > > assigned to a new group, say, "crashmonkey".
> >
> > Wait, let me get it straight. Did crashmonkey produce 300 test cases or
> > did it find 300 bugs? Are all those test cases passing on all filesystems?
> > Some test cases failing on some filesystems?
>
> CrashMonkey generates 300 workloads, out of which 3 tests result in
> bugs in two file systems (btrfs and F2FS).

So I suppose those 3 tests should be separate and mention the fix
commit (if there is one?).

> Others passed clean for
> ext4, xfs, btrfs and F2FS. Given that xfstest is a regression test
> suite, we thought it would be beneficial to add all 300 workloads to
> the generic test - it is possible that a future kernel version has a
> bug that could be triggered by one of these 300 workloads. We say so
> because, these workloads test the file-system in a systematic manner
> using common file-system operations. Given that crash-consistency
> tests are sparse, checking a file system against these 300 workloads
> will at least ensure that the file system is free from simple
> crash-consistency bugs (in addition to testing for bugs that were
> reported in earlier kernel versions).
>

Well, assuming your tests are quick, IMO
auto quick fuzzer crash

Is descriptive enough. Let's see what other people think.

> > I suppose you don't HAVE to run all test cases on a fresh created fs??
> > so clean would be just rm -rf or even each test case could use its own
> > subdir?
>
> You are right. A simple cleanup will work. We can club multiple of our
> workloads into one test and create something like 1 test case per
> file-system operation.
>

If that results in a "few" more "quick" tests, then I think its a good
way to go.

Thanks,
Amir.
