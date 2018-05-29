Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:25394 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967497AbeE2WBl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 May 2018 18:01:41 -0400
Date: Wed, 30 May 2018 08:01:29 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 3/6] xfs/310: Cleanup
Message-ID: <20180529220129.GQ10363@dastard>
References: <20180529165601.32133-1-jack@suse.cz>
 <20180529165601.32133-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529165601.32133-4-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, May 29, 2018 at 06:55:58PM +0200, Jan Kara wrote:
> Cleanup couple of things that were objected to when creating test
> ext4/033 out of this one.
> 
> Use _require_scratch_nocheck instead of recreating scratch fs before
> exiting. Avoid needless cleanup of dmhugedev on exit - _cleanup
> takes care of that. Use _scratch_unmount where possible.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
