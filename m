Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:21027 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727592AbeLEWXh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 5 Dec 2018 17:23:37 -0500
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gUfZu-0007Vo-Db
        for fstests@vger.kernel.org; Thu, 06 Dec 2018 09:23:34 +1100
Date: Thu, 6 Dec 2018 09:23:34 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/3] generic/43[014]: copy_range beyond source EOF should
 fail
Message-ID: <20181205222334.GY19305@dastard>
References: <20181203064256.26768-1-david@fromorbit.com>
 <20181203064256.26768-3-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203064256.26768-3-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 03, 2018 at 05:42:55PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> As per the copy_file_range() man page:
> 
> EINVAL
> 	Requested range extends beyond the end of the source file;
> .....
> 
> These tests actually attempt to copy beyond the end of the source
> file and so should fail with EINVAL. The kernel does not check this
> and so needs fixing. These operations should fail, so fix the tests.
> 
> Also move the tests to the copy_range group so they are distinct
> from the copy group which refers to xfs_copy tests.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Self NACK on this - the behaviour for this corner case we've decided
on is going to be different to what the man page says, so this patch
is going to have to be reworked.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
