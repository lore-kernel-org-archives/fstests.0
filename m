Received: from newman.cs.utexas.edu ([128.83.139.110]:55453 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbeKJCUt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 9 Nov 2018 21:20:49 -0500
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com [209.85.161.46])
        (authenticated bits=0)
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id wA9GdRs2023814
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <fstests@vger.kernel.org>; Fri, 9 Nov 2018 10:39:28 -0600
Received: by mail-yw1-f46.google.com with SMTP id w135-v6so1889507ywd.2
        for <fstests@vger.kernel.org>; Fri, 09 Nov 2018 08:39:27 -0800 (PST)
MIME-Version: 1.0
References: <20181104163826.GH12788@desktop> <1B22AFA2-FAF3-45AA-9910-CDBE4AEBFB09@gmail.com>
 <20181105052217.GT6311@dastard> <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
 <20181106231536.GB8691@thunk.org> <20181106233956.GX6311@dastard>
 <CA+EzBbDwdi26MCswz0iQ8hUTcGixATUXayxMOmEw5gekYvmMuw@mail.gmail.com>
 <20181107020922.GY6311@dastard> <20181108094045.GB6311@dastard>
 <CAHWVdUXSCo1UjGG+TL9SBq5KXOMszVP86E2od1RXqKfcwcYXvA@mail.gmail.com> <20181109031205.GC6311@dastard>
In-Reply-To: <20181109031205.GC6311@dastard>
From: Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
Date: Fri, 9 Nov 2018 10:39:16 -0600
Message-ID: <CAHWVdUXUtY+e-yuTzwV-E-2kvkg0YeNqxiK01pEJOuLBnWWtAw@mail.gmail.com>
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jayashree Mohan <jayashree2912@gmail.com>, Theodore Tso <tytso@mit.edu>, Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 8, 2018 at 9:15 PM Dave Chinner <david@fromorbit.com> wrote:

> Which is great, especailly as you found bugs in that exploration.
> But exhaustive searches like this really are not practical for day
> to day development. Developers don't ahve their own personal
> clusters for testing their filesystem code. They might only have a
> laptop.
>
> These sorts of massive exploratory regression testing are really the
> domain of product release managers and their QE department (think of
> the scale of testing that goes into a RHEL or SLES release).  It's
> -their job- to find gnarly, weird regressions that are beyond the
> capability of individual developers to uncover. This isn't the sort
> of testing that is relevant to the day-to-day filesystem developer.
>
> This comes back to my point about fstests being a tool for
> developers as much as it is for distro QE departments. The balance
> is falling too far towards the "massive regression test suite" side
> and away from the "find new bugs really fast" focus we have
> historically had. Adding hundreds more tests on that fall on the
> "massive regression test suite" side of the ledger just makes this
> imbalance worse.
>
> That's not something that crashmonkey can solve, but it's something
> we, as fstests users and developers, have to be very aware of when
> considering an addition of the size being proposed.
>
> > We found that even testing a single system call revealed three new
> > bugs (which have not all been patched yet). To systematically test
> > single system calls, you need about 300 tests.
>
> That's 300 tests per system call?  I think that's underestimating
> the complexity of many syscalls (like open(), read(), etc) quite
> substantially. Indeed, open(O_TMPFILE) is going to make linkat()
> behave very differently, and there's a whole set of crash
> consistency problems when O_TMPFILE is used with linkat() that the
> proposed link behaviour tests do not cover.

We have workloads which explore the interaction between different
system calls, which would capture effects like this. But thats a
bigger set, and we are not attempting to add them to fstests at this
point.

> Maybe a better way to integrate this is to add a completely new
> tests/ subdirectory and push all the crash consistency tests into
> that directory. They don't get run by quick/auto, but instead by a
> specific group that runs that directory. The tests don't get
> intermingled with all the other generic tests, and you can set them
> up to run fsck as often as you want because they don't get in the
> way of existing testing.  Over time we can more of the generic crash
> consistency regression tests elsewhere in fstests (e.g. all those
> fsync-on-btrfs-doesn't tests) over to that same subdir.

I agree with not wanting developers to run 300 tests every time they
run fstests. Perhaps a different "crash" group is what we want to do
here? Then only developers who want to ensure crash consistency still
holds can run those, knowing it will take a bit of time to run the
set. We'll submit a patch with a new "crash" group and see what people
think -- let me know if you disagree.

I should note that although ext4 and xfs are super robust from a long
history of development and testing, many other file systems in the
Linux kernel are not, and I think the other file systems would
definitely benefit from having the CrashMonkey regression tests.

More generally, I'm not sure how to help/encourage file-system
developers to run CrashMonkey. Note that CrashMonkey can be run for
different amounts of time based on the computational budget of the
developers. It is similar to fstress in that regard. I think having
fstress in-kernel helps developers use it. Is adding the CrashMonkey
tool (user-space code) into the Linux kernel the right move here?
