Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:39677 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751296AbeBWE41 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Feb 2018 23:56:27 -0500
Date: Fri, 23 Feb 2018 15:56:25 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common/xfs: Initialise OPTIND for getopts calls
Message-ID: <20180223045625.GA30854@dastard>
References: <20180223035454.1406-1-david@fromorbit.com>
 <20180223042928.GV18267@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223042928.GV18267@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 23, 2018 at 12:29:28PM +0800, Eryu Guan wrote:
> On Fri, Feb 23, 2018 at 02:54:54PM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > According to the bash man page:
> > 
> > 	OPTIND is initialized to 1 each time the shell or a shell
> > 	script is invoked.
> > 
> > This doesn't appear to be true - in tests scripts with no other
> > getopts calls, I'm seeing the getopts loop in _xfs_check to fail
> > to parse input parameters correctly. Tracing shows the parameters
> > are being passed to _xfs_check correctly, but on occassion getopts
> > simply doesn't see the,
> 
> Hmm, unfinished sentence here?

Typo. "simply doesn't see them."

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
