Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:13645 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751842AbbIAVTc (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 1 Sep 2015 17:19:32 -0400
Date: Wed, 2 Sep 2015 07:19:17 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: xfstests run to run variability
Message-ID: <20150901211917.GL26895@dastard>
References: <x4937yyrzh1.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x4937yyrzh1.fsf@segfault.boston.devel.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 01, 2015 at 10:22:34AM -0400, Jeff Moyer wrote:
> Hi,
> 
> I typically use ./check -g auto to test for regressions in my patches.
> However, I've noticed that there is some run-to-run variability in the
> results, even for a single kernel.  Here are the tests that fail, either
> reliably, or worse, intermittently:

What kernel, what xfsprogs version, xfs_info $TEST_DIR, etc.

> 
> reproducible failures: generic/042 generic/311 xfs/032 xfs/053 xfs/070 xfs/071

generic/042 will fail for XFS - the test needs fixing IIRC. You can
ignore it.

generic/311 has been failing intermittently for me on XFS since
4.2-rc1, and I can't reproduce it reliably enough to triage it.
Failure mode is a hash mismatch:

    --- tests/generic/311.out   2014-01-20 16:57:33.000000000 +1100
    +++ /home/dave/src/xfstests-dev/results//generic/311.out.bad        2015-08-28 16:29:29.000000000 +1000
    @@ -166,7 +166,7 @@
     Running test 11 direct, normal suspend
     Random seed is 11
     1144c9b3147873328cf4e81d066cd3da
    -1144c9b3147873328cf4e81d066cd3da
    +95cbe2ba4a2ace65edc71ab9165ceed2
     Running test 11 buffered, nolockfs
     Random seed is 11
    ...
    (Run 'diff -u tests/generic/311.out /home/dave/src/xfstests-dev/results//generic/311.out.bad'  to see the entire diff)

I suspect either another sync regression in the memcg-aware
writeback patches that landed in 4.2-rc1, but as yet I'm unable to
reproduce it reliably.

xfs/053 requires a TOT xfsprogs (i.e. 4.2.0-rcX and a 4.2 kernel to
pass (recently found problem, new test, new fixes)

xfs/032, xfs/070 and xfs/071 haven't failed for me for a long, long
time, so without more info I can't really say anything about it.

> intermittent failures: generic/192 generic/247 generic/232 xfs/167

generic/192 should not fail - it's just an atime test. I don't
recall ever seeing it fail.

generic/247 throws warnings on XFS because it's exercising mmap vs
direct IO to the same file and we explicitly make XFS to tell us
when an application is doing this and we hit a potential data
corruption event (e.g. invalidation fails during direct IO due to
racing page fault in the invalidation range). It's a race condition,
so it occurs intermittently. The test fails when this happens since
the test harness grew generic dmesg warning detection. You can
ignore it.

generic/232 is a fstress vs quota reporting test. The space usage
can vary slightly as fsstress does random operations, and when
there's unexpected extra metadata on disk (e.g. a directory btree
was split in an unusual way) the quota counts can be slightly higher
than expected and the test reports a failure. No big deal, happened
a lot more with older kernels than it does now, I haven't seen it
fail for months, you can ignore it.

xfs/167 is doing the same to me as generic/311. It's worked for a
long time, but since 4.2.-rc1 its failed a couple of times, but not
enough to be able to debug the failures.

> In case it's interesting, I run my tests on a Micron P320h PCIe SSD as
> the test device, and a regular sata disk as the scratch device.

Shouldn't make any difference - I test on all sorts of different
speed block devices, from ram disks to local sata to iscsi.  Results
are pretty consistent for me, regardless of the backing store.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
