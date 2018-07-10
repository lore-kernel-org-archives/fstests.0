Received: from mga03.intel.com ([134.134.136.65]:20996 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732237AbeGJWKv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 10 Jul 2018 18:10:51 -0400
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [fstests PATCH v2 1/2] src/: add license and copyright info to files
Date: Tue, 10 Jul 2018 16:09:41 -0600
Message-Id: <20180710220942.21074-2-ross.zwisler@linux.intel.com>
In-Reply-To: <20180710220942.21074-1-ross.zwisler@linux.intel.com>
References: <20180710220942.21074-1-ross.zwisler@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>, linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Add copyright and license info to files that I've authored in src/.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 src/t_ext4_dax_inline_corruption.c  | 2 ++
 src/t_ext4_dax_journal_corruption.c | 2 ++
 src/t_mmap_cow_race.c               | 2 ++
 src/t_mmap_stale_pmd.c              | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/src/t_ext4_dax_inline_corruption.c b/src/t_ext4_dax_inline_corruption.c
index b52bcc0d..e1a39a6c 100644
--- a/src/t_ext4_dax_inline_corruption.c
+++ b/src/t_ext4_dax_inline_corruption.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018 Intel Corporation. */
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
diff --git a/src/t_ext4_dax_journal_corruption.c b/src/t_ext4_dax_journal_corruption.c
index fccef8f5..ba7a96e4 100644
--- a/src/t_ext4_dax_journal_corruption.c
+++ b/src/t_ext4_dax_journal_corruption.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018 Intel Corporation. */
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
diff --git a/src/t_mmap_cow_race.c b/src/t_mmap_cow_race.c
index 207ba425..5941fcf3 100644
--- a/src/t_mmap_cow_race.c
+++ b/src/t_mmap_cow_race.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2017 Intel Corporation. */
 #include <errno.h>
 #include <fcntl.h>
 #include <libgen.h>
diff --git a/src/t_mmap_stale_pmd.c b/src/t_mmap_stale_pmd.c
index 6a52201c..a139d8ac 100644
--- a/src/t_mmap_stale_pmd.c
+++ b/src/t_mmap_stale_pmd.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2017 Intel Corporation. */
 #include <errno.h>
 #include <fcntl.h>
 #include <libgen.h>
-- 
2.14.4

