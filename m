Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:28027 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932593AbdJKINc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Oct 2017 04:13:32 -0400
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1e2C8w-0005yA-4r
        for fstests@vger.kernel.org; Wed, 11 Oct 2017 19:13:30 +1100
Date: Wed, 11 Oct 2017 19:13:30 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [whacky issue] xfs/277 endlessly looping in
 _require_xfs_io_command
Message-ID: <20171011081330.GF15067@dastard>
References: <20171011080047.GE15067@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171011080047.GE15067@dastard>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 11, 2017 at 07:00:47PM +1100, Dave Chinner wrote:
> HI folks,
> 
> I was wondering if anyone else had seen this problem, because it's
> got me absolutely stumped. One of my test VMs is having a really
> weird livelock in xfs/277. It's getting stuck in an endless loop
> burning the entire CPU in a the 277 process (i.e. running bash).
> What it is stuck on makes no sense to me, nor does the looping
> behaviour, and I can only reproduce it on this one machine.

FWIW, the trigger for this was enabling rmap+reflink on the test
device on this machine for the first time. Hence this is the first
time the test has been run on that machine...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
