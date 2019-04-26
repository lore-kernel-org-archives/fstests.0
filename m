Received: from mail-pg1-f193.google.com ([209.85.215.193]:37198 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZCac (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Apr 2019 22:30:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so824637pgc.4
        for <fstests@vger.kernel.org>; Thu, 25 Apr 2019 19:30:31 -0700 (PDT)
Date: Fri, 26 Apr 2019 10:30:25 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] misc: xfs_fsop_geom_t -> struct xfs_fsop_geom
Message-ID: <20190426023025.GB15846@desktop>
References: <20190422154820.GA4675@magnolia>
 <20190425073027.GA15846@desktop>
 <20190425155030.GB178319@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425155030.GB178319@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 25, 2019 at 08:50:30AM -0700, Darrick J. Wong wrote:
> On Thu, Apr 25, 2019 at 03:30:27PM +0800, Eryu Guan wrote:
> > On Mon, Apr 22, 2019 at 08:48:20AM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > > 
> > > Remove the typedef usage for the xfs geometry structure.
> > > 
> > > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > I guess this is due to patch "xfs: bump XFS_IOC_FSGEOMETRY to v5
> > structures" which removes the xfs_fsop_geom_t typedef? And I'm wondering
> > if xfs/122 needs update too? as xfs/122.out contains an xfs_fsop_geom_t
> > entry as well.
> 
> xfs/122 does need an update for the new 5.2 ioctls, so yes, I'll send
> that one along once they've landed upstream.
> 
> In the meantime, the xfs_fsop_geom_t -> struct xfs_fsop_geom conversion
> ought to be applied since the struct FOO approach has always worked.

Ok, thanks!

Eryu
