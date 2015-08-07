Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:48591 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946334AbbHGXXA (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 7 Aug 2015 19:23:00 -0400
Date: Sat, 8 Aug 2015 09:22:55 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/038: speed up file creation
Message-ID: <20150807232255.GG16638@dastard>
References: <1438820848-13325-1-git-send-email-david@fromorbit.com>
 <20150806141722.GF17933@dhcp-13-216.nay.redhat.com>
 <20150806222127.GE3902@dastard>
 <CAL3q7H686=7U8wx0kPEmc0TBO7ovhR56Zibu0e0NGLMvaMi1Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H686=7U8wx0kPEmc0TBO7ovhR56Zibu0e0NGLMvaMi1Eg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Filipe David Manana <fdmanana@gmail.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 07, 2015 at 09:09:43AM +0100, Filipe David Manana wrote:
> On Thu, Aug 6, 2015 at 11:21 PM, Dave Chinner <david@fromorbit.com> wrote:
> > On Thu, Aug 06, 2015 at 10:17:22PM +0800, Eryu Guan wrote:
> >> On Thu, Aug 06, 2015 at 10:27:28AM +1000, Dave Chinner wrote:
> >> > From: Dave Chinner <dchinner@redhat.com>
> >> >
> >> > Now that generic/038 is running on my test machine, I notice how
> >> > slow it is:
> >> >
> >> > generic/038      692s
> >> >
> >> > 11-12 minutes for a single test is way too long.
> >> > The test is creating
> >> > 400,000 single block files, which can be easily parallelised and
> >> > hence run much faster than the test is currently doing.
> >> >
> >> > Split the file creation up into 4 threads that create 100,000 files
> >> > each. 4 is chosen because XFS defaults to 4AGs, ext4 still has decent
> >> > speedups at 4 concurrent creates, and other filesystems aren't hurt
> >> > by excessive concurrency. The result:
> >> >
> >> > generic/038      237s
> >> >
> >> > on the same machine, which is roughly 3x faster and so it (just)
> >> > fast enough to to be considered acceptible.
> >>
> >> I got a speedup from 5663s to 639s, and confirmed the test could
> >
> > Oh, wow. You should consider any test that takes longer than 5
> > minutes in the auto group as taking too long. An hour for a test in
> > the auto group is not acceptible. I expect the auto group to
> > complete within 1-2 hours for an xfs run, depending on storage in
> > use.
> >
> > On my slowest test vm, the slowest tests are:
> >
> > $ cat results/check.time | sort -nr -k 2 |head -10
> > generic/127 1060
> > generic/038 537
> > xfs/042 426
> > generic/231 273
> > xfs/227 267
> > generic/208 200
> > generic/027 156
> > shared/005 153
> > generic/133 125
> > xfs/217 123
> > $
> >
> > As you can see, generic/038 is the second worst offender here (it's
> > a single CPU machine, so parallelism doesn't help a great deal).
> > generic/127 and xfs/042 are the other two tests that really need
> > looking at, and only generic/231 and xfs/227 are in the
> > "borderline-too-slow" category.
> >
> > generic/038 was a simple on to speed up. I've looked at generic/127,
> > and it's limited by the pair of synchronous IO fsx runs of 100,000
> > ops, which means there's probably 40,000 synchronous writes in the
> > test. Of course, this is meaningless on a ramdisk - generic/127
> > takes only 24s on my fastest test vm....
> >
> >> fail the test on unpatched btrfs (btrfsck failed, not every time).
> >
> > Seeing as you can reproduce the problem, I encourage you to work out
> > what the minimum number of files need to reproduce the problem is,
> > and update the test to use that so that it runs even faster...
> 
> There are actually several (easily over a dozen or so) problems this
> test triggered on btrfs (with some more found after the test was
> checked in), and they were all races leading to fs corruption,
> crashes, memory leaks, etc. Some were very hard to hit, and I remember
> the higher the number of files the easier it was to hit the races (or
> better say, the less hard it was to hit them) and less than 400k made
> it really really hard to hit them on my test machines (locally I often
> use this test with over 1 million files to verify specific patches).

I use fsmark for this sort of large scale directory testing. Itis
much faster than using shell script loops to create files, and it's
much more flexible in terms of file layout, too. xfstests is not
really the best vehicle for testing problems that require lots of
time to create data sets. Jan Tulak's environment work is a step
towards being able to do that (i.e. define an environment
that persists over multiple tests which may take some time and
complexity to set up), but we need to get that sorted and merged
first...

Cheers,

-- 
Dave Chinner
david@fromorbit.com
