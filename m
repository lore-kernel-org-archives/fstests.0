Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:17232 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756415AbcIVW3c (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2016 18:29:32 -0400
Date: Fri, 23 Sep 2016 08:29:23 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: require scratch dev in tests using dm targets
Message-ID: <20160922222923.GF10454@dastard>
References: <1474535153-15183-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1474535153-15183-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 22, 2016 at 05:05:53PM +0800, Eryu Guan wrote:
> We build dm device on top of scratch dev so we require $SCRATCH_DEV
> to be a valid block device in _require_dm_target(). And we need to
> _require_scratch before _require_dm_target, otherwise test fails if
> there's no SCRATCH_DEV defined, where it should _notrun.
> 
>   +Usage: _require_block_device <dev>
> 
> So add _require_scratch_nocheck to generic/347 (we do the fs check
> on thinp device), move _require_scratch before _require_dm_target in
> xfs/006 and xfs/264.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
