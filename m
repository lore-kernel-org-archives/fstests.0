Received: from mail-pg1-f193.google.com ([209.85.215.193]:40640 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDYHag (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Apr 2019 03:30:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so10732676pgl.7
        for <fstests@vger.kernel.org>; Thu, 25 Apr 2019 00:30:35 -0700 (PDT)
Date: Thu, 25 Apr 2019 15:30:27 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] misc: xfs_fsop_geom_t -> struct xfs_fsop_geom
Message-ID: <20190425073027.GA15846@desktop>
References: <20190422154820.GA4675@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422154820.GA4675@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 22, 2019 at 08:48:20AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Remove the typedef usage for the xfs geometry structure.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

I guess this is due to patch "xfs: bump XFS_IOC_FSGEOMETRY to v5
structures" which removes the xfs_fsop_geom_t typedef? And I'm wondering
if xfs/122 needs update too? as xfs/122.out contains an xfs_fsop_geom_t
entry as well.

Thanks,
Eryu

> ---
>  dmapi/src/suite1/cmd/make_rt_sparse.c |    2 +-
>  ltp/fsstress.c                        |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/dmapi/src/suite1/cmd/make_rt_sparse.c b/dmapi/src/suite1/cmd/make_rt_sparse.c
> index 14ee8a0d..13fd3676 100644
> --- a/dmapi/src/suite1/cmd/make_rt_sparse.c
> +++ b/dmapi/src/suite1/cmd/make_rt_sparse.c
> @@ -36,7 +36,7 @@ main(
>  	int	argc,
>  	char	**argv)
>  {
> -	xfs_fsop_geom_t	geom;
> +	struct  xfs_fsop_geom	geom;
>  	struct	fsxattr	fsx;
>  	struct	dioattr	dio;
>  	char	*pathname;
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 450cf4f1..279da9f1 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -294,7 +294,7 @@ int		errrange;
>  int		errtag;
>  opty_t		*freq_table;
>  int		freq_table_size;
> -xfs_fsop_geom_t	geom;
> +struct xfs_fsop_geom	geom;
>  char		*homedir;
>  int		*ilist;
>  int		ilistlen;
