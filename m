Received: from userp2120.oracle.com ([156.151.31.85]:41574 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfEaVGw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 31 May 2019 17:06:52 -0400
Date: Fri, 31 May 2019 14:06:05 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] nfs: disable client side deduplication
Message-ID: <20190531210605.GA5381@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc: fstests@vger.kernel.org, Murphy Zhou <xzhou@redhat.com>, linux-nfs@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, fengxiaoli0714@gmail.com
List-ID: <fstests@vger.kernel.org>

From: Darrick J. Wong <darrick.wong@oracle.com>

The NFS protocol doesn't support deduplication, so turn it off again.

Fixes: ce96e888fe48e ("Fix nfs4.2 return -EINVAL when do dedupe operation")
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/nfs/nfs4file.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index cf42a8b939e3..1915f24bba85 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -187,7 +187,11 @@ static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
 	bool same_inode = false;
 	int ret;
 
-	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
+	/* NFS does not support deduplication. */
+	if (remap_flags & REMAP_FILE_DEDUP)
+		return -EOPNOTSUPP;
+
+	if (remap_flags & ~REMAP_FILE_ADVISORY)
 		return -EINVAL;
 
 	/* check alignment w.r.t. clone_blksize */
