Received: from userp2130.oracle.com ([156.151.31.86]:47430 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfDVPs3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Apr 2019 11:48:29 -0400
Date: Mon, 22 Apr 2019 08:48:20 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] misc: xfs_fsop_geom_t -> struct xfs_fsop_geom
Message-ID: <20190422154820.GA4675@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

From: Darrick J. Wong <darrick.wong@oracle.com>

Remove the typedef usage for the xfs geometry structure.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 dmapi/src/suite1/cmd/make_rt_sparse.c |    2 +-
 ltp/fsstress.c                        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dmapi/src/suite1/cmd/make_rt_sparse.c b/dmapi/src/suite1/cmd/make_rt_sparse.c
index 14ee8a0d..13fd3676 100644
--- a/dmapi/src/suite1/cmd/make_rt_sparse.c
+++ b/dmapi/src/suite1/cmd/make_rt_sparse.c
@@ -36,7 +36,7 @@ main(
 	int	argc,
 	char	**argv)
 {
-	xfs_fsop_geom_t	geom;
+	struct  xfs_fsop_geom	geom;
 	struct	fsxattr	fsx;
 	struct	dioattr	dio;
 	char	*pathname;
diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 450cf4f1..279da9f1 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -294,7 +294,7 @@ int		errrange;
 int		errtag;
 opty_t		*freq_table;
 int		freq_table_size;
-xfs_fsop_geom_t	geom;
+struct xfs_fsop_geom	geom;
 char		*homedir;
 int		*ilist;
 int		ilistlen;
