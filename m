Received: from imap.thunk.org ([74.207.234.97]:37879 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbbGZMVH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 26 Jul 2015 08:21:07 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 6/6] xfsprogs: add missing include of <stat.h>
Date: Sun, 26 Jul 2015 08:20:55 -0400
Message-Id: <1437913255-7524-7-git-send-email-tytso@mit.edu>
In-Reply-To: <1437913255-7524-1-git-send-email-tytso@mit.edu>
References: <1437913255-7524-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: xfs@oss.sgi.com
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

In libdisk/evms.c, fields from struct stat are used without including
<stat.h>.  Apparently stat.h is included indirectly in glibc's header
files; not so in Android's bionic libc.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 libdisk/evms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libdisk/evms.c b/libdisk/evms.c
index 4c22ee1..7d41af6 100644
--- a/libdisk/evms.c
+++ b/libdisk/evms.c
@@ -22,6 +22,7 @@
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <sys/sysmacros.h>
+#include <sys/stat.h>
 #include <disk/volume.h>
 #include "evms.h"
 
-- 
2.3.0

