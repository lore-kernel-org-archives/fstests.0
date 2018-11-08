Received: from newman.cs.utexas.edu ([128.83.139.110]:50501 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeKIBSV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Nov 2018 20:18:21 -0500
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com [209.85.161.42])
        (authenticated bits=0)
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id wA8Fa8f8037746
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 8 Nov 2018 09:36:08 -0600
Received: by mail-yw1-f42.google.com with SMTP id j75-v6so8143575ywj.10
        for <fstests@vger.kernel.org>; Thu, 08 Nov 2018 07:36:08 -0800 (PST)
MIME-Version: 1.0
References: <CA+EzBbB5t5bSZ0hB6Y1jkxTgOLOv809Jbbcx7w5eK_XS_FPG7w@mail.gmail.com>
 <20181104163826.GH12788@desktop> <1B22AFA2-FAF3-45AA-9910-CDBE4AEBFB09@gmail.com>
 <20181105052217.GT6311@dastard> <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
 <20181106231536.GB8691@thunk.org> <20181106233956.GX6311@dastard>
 <CA+EzBbDwdi26MCswz0iQ8hUTcGixATUXayxMOmEw5gekYvmMuw@mail.gmail.com>
 <20181107020922.GY6311@dastard> <20181108094045.GB6311@dastard>
In-Reply-To: <20181108094045.GB6311@dastard>
From: Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
Date: Thu, 8 Nov 2018 09:35:56 -0600
Message-ID: <CAHWVdUXSCo1UjGG+TL9SBq5KXOMszVP86E2od1RXqKfcwcYXvA@mail.gmail.com>
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jayashree Mohan <jayashree2912@gmail.com>, Theodore Tso <tytso@mit.edu>, guaneryu@gmail.com, fstests <fstests@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, fdmanana@gmail.com
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 8, 2018 at 3:40 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Nov 07, 2018 at 01:09:22PM +1100, Dave Chinner wrote:
> > To put it in other words, developers need tests focussed on finding
> > bugs quickly, not regression tests that provide the core
> > requirements of integration and release testing. The development
> > testing phase is all about finding fast and effciently.
>
> To emphasis my point of having tests and tools capable of finding
> new bugs, I noticed yesterday that fstress and fsx didn't support
> copy_file_range, and fsx doesn't support clone/dedupe_file_range
> either. Darrick added them overnight.
>
> fsx as run by generic/263 takes *32* operations to find a data
> corruption with copy_file_range on XFS. Even changing it to do
> buffered IO instead of direct IO, it only takes ~600 operations to
> fail with a different data corruption.
>
> That's *at least* two previously unknown bugs exposed in under a
> second of runtime.
>
> That's the sort of tooling we need - we don't need hundreds of tests
> that are scripted reproducers of fixed problems, we need tools that
> exercise boundary conditions and corner cases in ways that are
> likely to expose incorrect behaviour. Tools that do these things
> quickly and in a reproducable manner are worth their weight in
> gold...
>
> IMO, Quality Engineering is not just about writing regression tests
> to keep out known bugs - it's most important function is developing
> and refining new testing tools to find bugs that have escaped
> detection with existing testing methods and tools. If test engineers
> can find new bugs, software engineers can fix them. That's really
> the ultimate goal here - to find bugs and fix them before users are
> exposed to them...

Dave, I think there is some confusion about what CrashMonkey does. I
think you'll find its very close to what you want. Let me explain.

CrashMonkey does exactly the kind of systematic testing that you want.
Given a set of system calls, it generates tests for crash consistency
for different workloads comprising of these system calls. It does this
by testing each system call first, then each pair of system calls, and
so on. Both the workload (which system calls to test) and the check
(what should the file system look like after crash recovery) are
automatically generated, without any human effort in the loop.

CrashMonkey found 10 new bugs in btrfs and F2FS, so its not just a
suite of regression tests.

When we studied previous crash-consistency bugs reported and fixed in
the kernel, we noticed most of them could be reproduced on a clean fs
image of small size (100 MB). We found that the arguments to the
system calls could also be constrained: we just needed to reuse a
small set of file names or file ranges. We used this to automatically
generate xfstests-style tests for each file system. We generated and
tested a total of 3.3M workloads on a research cluster at UT Austin.

We found that even testing a single system call revealed three new
bugs (which have not all been patched yet). To systematically test
single system calls, you need about 300 tests. This is what Jayashree
is trying to add to fstests. Since there are very few
crash-consistency tests currently in fstests, it might be good to add
more coverage with these tests.

The CrashMonkey github repo is available here:
https://github.com/utsaslab/crashmonkey
The link to the paper: https://www.cs.utexas.edu/~jaya/pdf/osdi18-B3.pdf
Talk slides: https://www.cs.utexas.edu/~jaya/slides/osdi18-B3-slides.pdf
