Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:17744 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751002AbcFUXrb (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2016 19:47:31 -0400
Date: Wed, 22 Jun 2016 09:47:16 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs/186: run test on expected XFS configuration
Message-ID: <20160621234716.GC27480@dastard>
References: <1466510507-17548-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1466510507-17548-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 21, 2016 at 08:01:47PM +0800, Eryu Guan wrote:
> Usually xfs/186 _notrun on crc enabled XFS because of
> _require_attr_v1, since v2 attr format is always enabled on v5 XFS.
> 
> But when testing on 512B block size XFS, i.e. MKFS_OPTIONS="-m crc=0
> -b size=512", test fails. This is because crc enalbed XFS was

*enabled

> created in the end, not 512B block size XFS with crc disabled, and
> that's not what we want to test.
> 
> The reason why _scratch_mkfs_xfs creates a different XFS than
> expected is that, it may ignore $MKFS_OPTIONS if mkfs fails due to
> conflicts between $MKFS_OPTIONS and the provided mkfs options.
> 
> In the case of xfs/186, "-b size=512" conflicts with "-i size=512",
> and the first mkfs fails, then it ends up with a 4k block size XFS
> with crc enabled (the default config).
> 
> Fix it by checking crc enablement status and attr version in the
> test, to make sure it's testing on expected XFS.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
