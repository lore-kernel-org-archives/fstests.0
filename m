Received: from mail-wm0-f68.google.com ([74.125.82.68]:34533 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753378AbcJNUoE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Oct 2016 16:44:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id z189so171574wmb.1
        for <fstests@vger.kernel.org>; Fri, 14 Oct 2016 13:44:03 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 2/2] fstests: run xfs_io as multi threaded process
Date: Fri, 14 Oct 2016 23:43:30 +0300
Message-Id: <1476477810-17478-2-git-send-email-amir73il@gmail.com>
In-Reply-To: <1476477810-17478-1-git-send-email-amir73il@gmail.com>
References: <1476477810-17478-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, eguan@redhat.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Try to run xfs_io in all tests with command line option -M
which starts an idle thread before performing any io.

The purpose of this idle thread is to test io from a multi threaded
process. With single threaded process, the file table is not shared
and file structs are not reference counted.

So in order to improve the change of detecting file struct reference
leaks, all xfs_io commands in tests will try to run with this option.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/rc b/common/rc
index c3da064..64bf341 100644
--- a/common/rc
+++ b/common/rc
@@ -3799,6 +3799,10 @@ init_rc()
 	xfs_io -c stat $TEST_DIR 2>&1 | grep -q "is not on an XFS filesystem" && \
 	export XFS_IO_PROG="$XFS_IO_PROG -F"
 
+	# Figure out if we can add -M (run as multi threaded) option to xfs_io
+	$XFS_IO_PROG -M -c quit 2>&1 | grep -q "invalid option" || \
+	export XFS_IO_PROG="$XFS_IO_PROG -M"
+
 	# xfs_copy doesn't work on v5 xfs yet without -d option
 	if [ "$FSTYP" == "xfs" ] && [[ $MKFS_OPTIONS =~ crc=1 ]]; then
 		export XFS_COPY_PROG="$XFS_COPY_PROG -d"
-- 
2.7.4

