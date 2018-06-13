Received: from userp2120.oracle.com ([156.151.31.85]:56460 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935256AbeFMW1P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Jun 2018 18:27:15 -0400
Date: Wed, 13 Jun 2018 15:25:58 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [fstests PATCH] generic/223: skip when using DAX
Message-ID: <20180613222558.GA9432@magnolia>
References: <20180613210742.28148-1-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613210742.28148-1-ross.zwisler@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, linux-nvdimm@lists.01.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 13, 2018 at 03:07:42PM -0600, Ross Zwisler wrote:
> As of these upstream kernel commits:
> 
> commit 6e2608dfd934 ("xfs, dax: introduce xfs_dax_aops")
> commit 5f0663bb4a64 ("ext4, dax: introduce ext4_dax_aops")
> 
> generic/223 fails on XFS and ext4 because filesystems mounted with DAX no
> longer support bmap.  This is desired behavior and will not be fixed,
> according to:
> 
> https://lists.01.org/pipermail/linux-nvdimm/2018-April/015383.html
> 
> So, just skip over generic/223 when using DAX so we don't throw false
> positive test failures.

Just because we decided not to support FIBMAP on XFSDAX doesn't mean we
should let this test bitrot. :)

Just out of curiosity, does the following patch fix g/223 for you?

--D

diff --git a/src/t_stripealign.c b/src/t_stripealign.c
index 05ed36b5..690f743a 100644
--- a/src/t_stripealign.c
+++ b/src/t_stripealign.c
@@ -17,8 +17,13 @@
 #include <fcntl.h>
 #include <stdio.h>
 #include <sys/ioctl.h>
+#include <linux/fiemap.h>
+#include <linux/fs.h>
 
-#define FIBMAP          _IO(0x00, 1)    /* bmap access */
+#define FIEMAP_EXTENT_ACCEPTABLE	(FIEMAP_EXTENT_LAST | \
+		FIEMAP_EXTENT_DATA_ENCRYPTED | FIEMAP_EXTENT_ENCODED | \
+		FIEMAP_EXTENT_UNWRITTEN | FIEMAP_EXTENT_MERGED | \
+		FIEMAP_EXTENT_SHARED)
 
 /*
  * If only filename given, print first block.
@@ -28,11 +33,14 @@
 
 int main(int argc, char ** argv)
 {
-	int	fd;
-	int	ret;
-	int	sunit = 0;	/* in blocks */
-	char	*filename;
-	unsigned int	block = 0;
+	struct stat		sb;
+	struct fiemap		*fie;
+	struct fiemap_extent	*fe;
+	int			fd;
+	int			ret;
+	int			sunit = 0;	/* in blocks */
+	char			*filename;
+	unsigned long long	block;
 
         if (argc < 3) {
                 printf("Usage: %s <filename> <sunit in blocks>\n", argv[0]);
@@ -48,21 +56,63 @@ int main(int argc, char ** argv)
                 return 1;
         }
 
-	ret = ioctl(fd, FIBMAP, &block);
-	if (ret < 0) {
+	ret = fstat(fd, &sb);
+	if (ret) {
+		perror(filename);
 		close(fd);
-		perror("fibmap");
 		return 1;
 	}
 
-	close(fd);
+	fie = calloc(1, sizeof(struct fiemap) + sizeof(struct fiemap_extent));
+	if (!fie) {
+		close(fd);
+		perror("malloc");
+		return 1;
+	}
+	fie->fm_length = 1;
+	fie->fm_flags = FIEMAP_FLAG_SYNC;
+	fie->fm_extent_count = 1;
+
+	ret = ioctl(fd, FS_IOC_FIEMAP, fie);
+	if (ret < 0) {
+		unsigned int	bmap = 0;
+
+		ret = ioctl(fd, FIBMAP, &bmap);
+		if (ret < 0) {
+			perror("fibmap");
+			free(fie);
+			close(fd);
+			return 1;
+		}
+		block = bmap;
+		goto check;
+	}
 
+
+	if (fie->fm_mapped_extents != 1) {
+		printf("%s: no extents?\n", filename);
+		free(fie);
+		close(fd);
+		return 1;
+	}
+	fe = &fie->fm_extents[0];
+	if (fe->fe_flags & ~FIEMAP_EXTENT_ACCEPTABLE) {
+		printf("%s: bad flags 0x%x\n", filename, fe->fe_flags);
+		free(fie);
+		close(fd);
+		return 1;
+	}
+
+	block = fie->fm_extents[0].fe_physical / sb.st_blksize;
+check:
 	if (block % sunit) {
-		printf("%s: Start block %u not multiple of sunit %u\n",
+		printf("%s: Start block %llu not multiple of sunit %u\n",
 			filename, block, sunit);
 		return 1;
 	} else
 		printf("%s: well-aligned\n", filename);
+	free(fie);
+	close(fd);
 
 	return 0;
 }
