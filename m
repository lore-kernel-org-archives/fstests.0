Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:21061 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752298AbeEJWTC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 10 May 2018 18:19:02 -0400
Date: Fri, 11 May 2018 08:18:59 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs: limit xfs_growfs size if test with --large-fs
Message-ID: <20180510221859.GS10363@dastard>
References: <20180427082254.25524-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427082254.25524-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 27, 2018 at 04:22:54PM +0800, Zorro Lang wrote:
> When test on large SCRATCH_DEV, grow a small XFS to huge size is a
> horrible thing (e.g grow 128m to 500T). So add a helper named
> _scratch_xfs_growfs_limited() to do below things:
> 
> 1) If --large-fs is used, limit growfs size.
> 2) If a limit size parameter is specified, make sure growfs won't
> beyond this size.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

I think I originally just didn't run growfs tests like this on large
filesystems. i.e. require_no_largefs....

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
