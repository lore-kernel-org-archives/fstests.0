Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:52965 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731046AbeKTIBw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Nov 2018 03:01:52 -0500
Date: Tue, 20 Nov 2018 08:36:14 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] fstest: CrashMonkey tests ported to xfstest Inbox x
Message-ID: <20181119213614.GK19305@dastard>
References: <CA+EzBbDr7rxN1ptJKd5FOLQFxLQSRnvEod6+xvR4A6pFuG07fQ@mail.gmail.com>
 <CA+EzBbDKZzW++xuzL3oefmbEAY=_65L_ux_V7a_6tYoXuMZpsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EzBbDKZzW++xuzL3oefmbEAY=_65L_ux_V7a_6tYoXuMZpsQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>, Theodore Ts'o <tytso@mit.edu>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
List-ID: <fstests@vger.kernel.org>

On Fri, Nov 16, 2018 at 01:33:02PM -0600, Jayashree Mohan wrote:
> Hi all,
> 
> This is a gentle reminder to review the patch porting the first set of
> CrashMonkey tests to xfstest. Do let me know if this patch requires
> any correction, so that I can incorporate them and send out all
> patches as soon as possible.

Sorry, I've been busy trying to get to the bottom of the data
corruption problems exposed by new fsx functionality. I've still a
fair way from the bottom, so it might be a while before I get back
to this.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
