Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:64210 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751575AbeEVIA4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 May 2018 04:00:56 -0400
Date: Tue, 22 May 2018 18:00:36 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] check: fail tests if check/dmesg are not clean
Message-ID: <20180522080035.GU10363@dastard>
References: <20180506224634.1425-1-david@fromorbit.com>
 <20180512125108.GS8373@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180512125108.GS8373@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, May 12, 2018 at 08:51:08PM +0800, Eryu Guan wrote:
> On Mon, May 07, 2018 at 08:46:34AM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Currently a test passes even if it leaves a corrupt filesystem
> > behind, or a splat in the system logs that should not be there.
> 
> It seems that test does fail when post-test fsck fails or dmesg check
> reports failure, but just after the test runtime being recorded &
> reported, which makes the test looks like a PASS.

Yup, that's exactly what I said - the test fails, but the reporting
indicates the test passed before it reports failure.

And because these failures match the "test pass" signature, my results
post-processing script was saying these tests passed, not had a
"post-test failure". The post-test failure messages don't mention
the test directly, either, so it's a bit of a wart when it comes to
processing the output for regression test comparisons...

Hence I thought I'd fix it so they didn't look like a test pass.

> But the test summary
> does report it as a failure, e.g. (I added "echo BUG: > /dev/kmsg" to
> generic/444 manually)

Right, but I don't look at those for comparing run-to-run regression
test results - having a timestamp that is wildly different is a
regression that needs investigation, too, even though we are only
looking at correctness in the test harness...

> generic/443 0s ... 0s
> generic/444 0s ... 0s
> _check_dmesg: something found in dmesg (see /root/workspace/xfstests/results//xfs_2k_crc/generic/444.dmesg)
> generic/445 0s ... 0s
> Ran: generic/443 generic/444 generic/445
> Failures: generic/444
> Failed 1 of 3 tests
> 
> And the return value of check is also non-zero.

Yes, that is also true, but it is also not useful to tell me what
test out of the 700+ I've just run failed.

> But the whole rework looks good! Just need to reword the patch summary
> and description?

Ok.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
