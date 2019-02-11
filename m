Received: from ipmailnode02.adl6.internode.on.net ([150.101.137.148]:3919 "EHLO
        ipmailnode02.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726101AbfBKBzn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Feb 2019 20:55:43 -0500
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gt0ou-0000wi-Gk
        for fstests@vger.kernel.org; Mon, 11 Feb 2019 12:55:40 +1100
Date: Mon, 11 Feb 2019 12:55:40 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] xfs: new EOF fragmentation tests
Message-ID: <20190211015540.GD20493@dastard>
References: <20190211013647.22580-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211013647.22580-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Feb 11, 2019 at 12:36:47PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> These tests create substantial file fragmentation as a result of
> application actions that defeat post-EOF preallocation
> optimisations. They are intended to replicate known vectors for
> these problems, and provide a check that the fragmentation levels
> have been controlled. The mitigations we make may not completely
> remove fragmentation (e.g. they may demonstrate speculative delalloc
> related extent size growth) so the checks don't assume we'll end up
> with perfect layouts and hence check for an exceptable level of
> fragmentation rather than none.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Forgot to add that these tests go along with this patch series:

https://marc.info/?l=linux-xfs&m=154951612101291&w=2

And can be used to test whatever way we decide to minimise
fragmentation through maintianing post-EOF preallocation.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
