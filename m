Received: from mga14.intel.com ([192.55.52.115]:20566 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753765AbdDZSFk (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 26 Apr 2017 14:05:40 -0400
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH v3 1/2] xfs: fix incorrect argument count check
Date: Wed, 26 Apr 2017 12:05:30 -0600
Message-Id: <20170426180531.26291-1-ross.zwisler@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Xiong Zhou <xzhou@redhat.com>, jmoyer@redhat.com, eguan@redhat.com
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@ml01.01.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <fstests@vger.kernel.org>

t_mmap_dio.c actually requires 4 arguments, not 3 as the current check
enforces:

	# ./src/t_mmap_dio
	usage: t_mmap_dio <src file> <dest file> <size> <msg>
	# ./src/t_mmap_dio  one two three
	open src(No such file or directory) len 0 (null)

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Fixes: 456581661b4d ("xfs: test per-inode DAX flag by IO")
---
 src/t_mmap_dio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/t_mmap_dio.c b/src/t_mmap_dio.c
index 69b9ca8..6c8ca1a 100644
--- a/src/t_mmap_dio.c
+++ b/src/t_mmap_dio.c
@@ -39,7 +39,7 @@ int main(int argc, char **argv)
 	char *dfile;
 	unsigned long len, opt;
 
-	if (argc < 4)
+	if (argc < 5)
 		usage(basename(argv[0]));
 
 	while ((opt = getopt(argc, argv, "b")) != -1)
-- 
2.9.3

