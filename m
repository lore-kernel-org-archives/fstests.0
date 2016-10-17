Received: from mail-lf0-f66.google.com ([209.85.215.66]:34430 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757465AbcJQHcQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Oct 2016 03:32:16 -0400
Received: by mail-lf0-f66.google.com with SMTP id x23so19415236lfi.1
        for <fstests@vger.kernel.org>; Mon, 17 Oct 2016 00:32:15 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v3 3/3] fstests: run xfs_io with -i option if supported
Date: Mon, 17 Oct 2016 10:31:41 +0300
Message-Id: <1476689501-735-1-git-send-email-amir73il@gmail.com>
In-Reply-To: <1476689014-384-3-git-send-email-amir73il@gmail.com>
References: <1476689014-384-3-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Eryu Guan <eguan@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Try to run xfs_io with command line option -i, which starts an idle
thread before performing any io.

The purpose of this idle thread is to test io from a multi threaded
process. With single threaded process, the file table is not shared
and file structs are not reference counted.

In order to improve the chance of detecting file struct reference
leaks, we should run xfs_io commands with this option as much as
possible.

Analysis of the effect of xfs_io -i on tests runtime showed that
it may lead to slightly longer run times in extreme cases (e.g +3s
for generic/132), but has a negligible effect on runtime of tests
among the 'quick' group (worst case +0.3s for generic/130).

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/rc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/rc b/common/rc
index a838750..da079f3 100644
--- a/common/rc
+++ b/common/rc
@@ -3799,6 +3799,15 @@ init_rc()
 	$XFS_IO_PROG -c stat $TEST_DIR 2>&1 | grep -q "is not on an XFS filesystem" && \
 		export XFS_IO_PROG="$XFS_IO_PROG -F"
 
+	# xfs_io -i option starts an idle thread for xfs_io.
+	# With single threaded process, the file table is not shared
+	# and file structs are not reference counted.
+	# Spawning an idle thread can help detecting file struct
+	# reference leaks, so we want to enable the option whenever
+	# it is supported.
+	$XFS_IO_PROG -i -c quit 2>/dev/null && \
+		export XFS_IO_PROG="$XFS_IO_PROG -i"
+
 	# xfs_copy doesn't work on v5 xfs yet without -d option
 	if [ "$FSTYP" == "xfs" ] && [[ $MKFS_OPTIONS =~ crc=1 ]]; then
 		export XFS_COPY_PROG="$XFS_COPY_PROG -d"
-- 
2.7.4

