Received: from mail-pf0-f193.google.com ([209.85.192.193]:46981 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbeELMvN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 12 May 2018 08:51:13 -0400
Received: by mail-pf0-f193.google.com with SMTP id p12-v6so3937563pff.13
        for <fstests@vger.kernel.org>; Sat, 12 May 2018 05:51:13 -0700 (PDT)
Date: Sat, 12 May 2018 20:51:08 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] check: fail tests if check/dmesg are not clean
Message-ID: <20180512125108.GS8373@desktop>
References: <20180506224634.1425-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180506224634.1425-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 07, 2018 at 08:46:34AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Currently a test passes even if it leaves a corrupt filesystem
> behind, or a splat in the system logs that should not be there.

It seems that test does fail when post-test fsck fails or dmesg check
reports failure, but just after the test runtime being recorded &
reported, which makes the test looks like a PASS. But the test summary
does report it as a failure, e.g. (I added "echo BUG: > /dev/kmsg" to
generic/444 manually)

generic/443 0s ... 0s
generic/444 0s ... 0s
_check_dmesg: something found in dmesg (see /root/workspace/xfstests/results//xfs_2k_crc/generic/444.dmesg)
generic/445 0s ... 0s
Ran: generic/443 generic/444 generic/445
Failures: generic/444
Failed 1 of 3 tests

And the return value of check is also non-zero.

> Rework the check code to consider these as test failures so they can
> be accounted and tracked correctly. This also allows us to include
> the post-test filesystem checking in the test runtime - that is
> currently not accounted to the test, either, so the real runtime of
> each test is not accurately reflected in the time stats being
> reported.
> 
> This requires a complete reworking of the main test check loop. It's
> a bunch of spaghetti at the moment because it has post test
> reporting code preventing use from using continue when a test is
> done. Move that post test reporting to the start of the next loop
> iteration and clean up the code to use continues where appropriate.
> 
> Also, for cases where we haven't run the test or it's already been
> marked as failed, don't bother running the filesystem/dmesg checks
> for failure as we're already going to report the test as failed.
> 
> This touches almost all of the loop, so get rid of the remaining
> 4 space indents inside the loop while moving all this code around.
> 
> Signed-Off-By: Dave Chinner <dchinner@redhat.com>

But the whole rework looks good! Just need to reword the patch summary
and description?

Thanks,
Eryu
