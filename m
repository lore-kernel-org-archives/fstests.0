Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:58493 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965152AbeEYBah (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 May 2018 21:30:37 -0400
Date: Fri, 25 May 2018 11:30:34 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] Make ./new work for non-root user
Message-ID: <20180525013034.GD10363@dastard>
References: <20180524183055.16031-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524183055.16031-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 24, 2018 at 08:30:55PM +0200, Jan Kara wrote:
> Currently 'new' script sources common/config which tries to find mkfs
> and fails if not found (which is likely for non-root user). This is
> inconvenient as development usually does not happen as root. In fact the
> vast majority of setup in common/config and common/rc is not necessary
> for 'new'. Split out the necessary bits into new common/config-base and
> use it in 'new'. Cleanup common/rc and common/config now that it's only
> used from 'check'.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
....
> --- a/common/rc
> +++ b/common/rc
> @@ -20,18 +20,9 @@
>  #  Mountain View, CA 94043, USA, or: http://www.sgi.com
>  #-----------------------------------------------------------------------
>  
> -BC=$(which bc 2> /dev/null) || BC=
> +. common/config

Doesn't this means we now include common/config in every test setup
routine, even though the environment it sets up is inherited from
the check function.

If so, that's going to add significantly to the individual test
startup time (which already takes a significant fraction of a
second) and this happens hundreds of times over an auto run instead
of only once when we start the test run. It seems wrong to be doing
this over and over again unecessarily....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
