Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:40446 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S941316AbcJaMBA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 31 Oct 2016 08:01:00 -0400
Date: Mon, 31 Oct 2016 23:00:54 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [ANNOUNCE] xfstests: master branch updated to efef020df5b2
Message-ID: <20161031120054.GS14023@dastard>
References: <20161031051919.GR14023@dastard>
 <20161031073116.GO27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161031073116.GO27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 31, 2016 at 03:31:16PM +0800, Eryu Guan wrote:
> Hi Dave,
> 
> On Mon, Oct 31, 2016 at 04:19:19PM +1100, Dave Chinner wrote:
> > Hi folks,
> > 
> > The master branch of the xfstests repository at:
> > 
> > 	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > 
> > have just been updated. Thatnks to everyone who added tests, fixed
> 
> Thanks for the update! But I don't see it in master branch, 'git pull'
> fetched nothing, and master HEAD still points to "16ef084 xfs/122:
> remove dead code".
> 
> Is there any latency from kernel.org so that I only have to wait for
> more time? Or something went wrong with the push?

No idea what went wrong there. I pushed, logged in and then switched
windows to write the email. For the first time in an awful long
time, I didn't bother to check that the push finished and the branch
was updated on kernel.org. Turns out something went wrong mid push -
looking at the logs on various machines round here I think the net
connection on my end went down, and when it reconnected I got a
different IP address and so the push failed without me actually
noticing...

I just repushed, and it has completed from my end, and the web
interface on git.kernel.org now registers it.

Thanks for letting me know somehting went wrong!

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
