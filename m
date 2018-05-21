Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:14105 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751094AbeEUCge (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 20 May 2018 22:36:34 -0400
Date: Mon, 21 May 2018 12:36:31 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/132: umount scratch device after finishing test
Message-ID: <20180521023631.GN10363@dastard>
References: <1526704344-19615-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526704344-19615-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, May 19, 2018 at 12:32:24PM +0800, Xiao Yang wrote:
> xfs/132 and xfs/133 running together got the following error:
> ------------------------------------------------------------
> ...
> xfs/132 1s ... 1s
> xfs/133 1s ... [failed, exit status 1] - output mismatch (see /var/lib/xfstests/results//xfs/133.out.bad)
> ...
> QA output created by 133
> -Format and mount
> -Corrupt filesystem
> -Remount, try to append
> -Write did not succeed (ok).
> +SCRATCH_DEV=/dev/sda11 is mounted but not on SCRATCH_MNT=common/config: - aborting
> +Already mounted result:
> +/dev/sda11 /mnt/xfstests/scratch
> ...
> ------------------------------------------------------------
> 
> xfs/132 led to XFS shutdown due to the corrupted inode, but it didn't rectify XFS
> by umount scratch device.

AFAIK, we don't have to unmount the scratch device when a test
finishes - the test harness is supposed to do that and make sure
that it is in the correct state for the next test to run.

It seems that somewhere along the line this got broken. - I'm
guessing the fact that this test also says "don't check the scratch
device" the test harness is failing to unmount it because it's not
running _check_scratch_device. I'm guessing that it should at least
run _scratch_unmount....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
