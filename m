Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:21411 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751281AbeERECE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 May 2018 00:02:04 -0400
Date: Fri, 18 May 2018 14:02:02 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/3] generic/382: Fix test when report uses /etc/passwd
Message-ID: <20180518040202.GJ23861@dastard>
References: <20180514170351.13737-1-jack@suse.cz>
 <20180514170351.13737-3-jack@suse.cz>
 <20180517024250.GD29080@desktop.hz.ali.com>
 <20180517091836.ep4pydgqpg6cihgy@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517091836.ep4pydgqpg6cihgy@quack2.suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 17, 2018 at 11:18:36AM +0200, Jan Kara wrote:
> On Thu 17-05-18 10:42:50, Eryu Guan wrote:
> > On Mon, May 14, 2018 at 07:03:50PM +0200, Jan Kara wrote:
> > > On older kernels xfs_quota uses /etc/passwd to report quota entries. In
> > > such case all-zero lines disturb its output and the test fails. Fix the
> > > problem by ignoring all-zero lines in quota report.
> > 
> > I notice that generic/381 does quota report in a similar way as in
> > generic/382, is 381 affected by the same problem? If only generic/382 is
> > affected, we could move the filter from common/filter to the test
> > itself.
> 
> Yes, that test is affected as well. I just didn't notice because on my
> system I don't have user 123456-fsgqa (SLE/openSUSE don't allow you to
> create user with such name and I didn't bother to force-create it by
> manually editting passwd). I'll send a patch to update that test to use the
> filter as well if you're otherwise fine with this approach.

Perhaps it would also be worthwhile to send a patch to allow an
alternate username for quota testing (e.g. fstests-user) and probe
which one to use at startup?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
