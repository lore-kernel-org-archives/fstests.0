Received: from userp2130.oracle.com ([156.151.31.86]:57236 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfDYPuh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Apr 2019 11:50:37 -0400
Date: Thu, 25 Apr 2019 08:50:30 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] misc: xfs_fsop_geom_t -> struct xfs_fsop_geom
Message-ID: <20190425155030.GB178319@magnolia>
References: <20190422154820.GA4675@magnolia>
 <20190425073027.GA15846@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425073027.GA15846@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 25, 2019 at 03:30:27PM +0800, Eryu Guan wrote:
> On Mon, Apr 22, 2019 at 08:48:20AM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > Remove the typedef usage for the xfs geometry structure.
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> I guess this is due to patch "xfs: bump XFS_IOC_FSGEOMETRY to v5
> structures" which removes the xfs_fsop_geom_t typedef? And I'm wondering
> if xfs/122 needs update too? as xfs/122.out contains an xfs_fsop_geom_t
> entry as well.

xfs/122 does need an update for the new 5.2 ioctls, so yes, I'll send
that one along once they've landed upstream.

In the meantime, the xfs_fsop_geom_t -> struct xfs_fsop_geom conversion
ought to be applied since the struct FOO approach has always worked.

--D

> Thanks,
> Eryu
> 
> > ---
> >  dmapi/src/suite1/cmd/make_rt_sparse.c |    2 +-
> >  ltp/fsstress.c                        |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/dmapi/src/suite1/cmd/make_rt_sparse.c b/dmapi/src/suite1/cmd/make_rt_sparse.c
> > index 14ee8a0d..13fd3676 100644
> > --- a/dmapi/src/suite1/cmd/make_rt_sparse.c
> > +++ b/dmapi/src/suite1/cmd/make_rt_sparse.c
> > @@ -36,7 +36,7 @@ main(
> >  	int	argc,
> >  	char	**argv)
> >  {
> > -	xfs_fsop_geom_t	geom;
> > +	struct  xfs_fsop_geom	geom;
> >  	struct	fsxattr	fsx;
> >  	struct	dioattr	dio;
> >  	char	*pathname;
> > diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> > index 450cf4f1..279da9f1 100644
> > --- a/ltp/fsstress.c
> > +++ b/ltp/fsstress.c
> > @@ -294,7 +294,7 @@ int		errrange;
> >  int		errtag;
> >  opty_t		*freq_table;
> >  int		freq_table_size;
> > -xfs_fsop_geom_t	geom;
> > +struct xfs_fsop_geom	geom;
> >  char		*homedir;
> >  int		*ilist;
> >  int		ilistlen;
