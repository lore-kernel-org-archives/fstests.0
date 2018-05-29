Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:2615 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967441AbeE2WAW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 May 2018 18:00:22 -0400
Date: Wed, 30 May 2018 08:00:03 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] Make ./new work for non-root user
Message-ID: <20180529220003.GP10363@dastard>
References: <20180529165119.31961-1-jack@suse.cz>
 <20180529165119.31961-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529165119.31961-2-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, May 29, 2018 at 06:51:19PM +0200, Jan Kara wrote:
> Currently 'new' script sources common/config which tries to find mkfs
> and fails if not found (which is likely for non-root user). This is
> inconvenient as development usually does not happen as root. In fact the
> vast majority of setup in common/config and common/rc is not necessary
> for 'new'. Split out the necessary bits into new common/config-base and
> use it in 'new'. Cleanup common/rc and common/config now that they're
> only used from 'check' and 'setup'.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good!

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
