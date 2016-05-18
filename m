Received: from mx1.redhat.com ([209.132.183.28]:35346 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932882AbcERRk5 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 18 May 2016 13:40:57 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50C167F6B4
	for <fstests@vger.kernel.org>; Wed, 18 May 2016 17:40:56 +0000 (UTC)
Received: from tarantula.localdomain (ovpn-116-102.phx2.redhat.com [10.3.116.102])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u4IHesil007262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Wed, 18 May 2016 13:40:56 -0400
Date: Wed, 18 May 2016 12:40:54 -0500
From: Jeffrey Bastian <jbastian@redhat.com>
Subject: [PATCH] avoid struct fsxattr redefinition
Message-ID: <20160518174054.GA27634@tarantula.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Linux kernel v4.5 defines 'struct fsxattr' in linux/fs.h [0] but it's
still defined in xfs/linux.h as a backup [1].  If the files are included
in the wrong order, the compiler will complain with a redefinition
error.  This patch moves linux/fs.h (and linux/magic.h) before the xfs
headers for the t_immutable.c and fsstress.c tests.

[0] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=334e580a6f97e
[1] http://oss.sgi.com/cgi-bin/gitweb.cgi?p=xfs/cmds/xfsprogs.git;a=blob;f=include/linux.h;h=cc0f70ceed72#l183

Signed-off-by: Jeffrey Bastian <jbastian@redhat.com>
---
 ltp/fsstress.c    | 2 +-
 src/t_immutable.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 1e6c913294ae..7e7cf608f5f3 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -16,6 +16,7 @@
  * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/fs.h>
 #include "global.h"
 
 #ifdef HAVE_ATTR_XATTR_H
@@ -34,7 +35,6 @@
 #include <sys/prctl.h>
 #endif
 
-#include <linux/fs.h>
 #ifndef FS_IOC_GETFLAGS
 #define FS_IOC_GETFLAGS                 _IOR('f', 1, long)
 #endif
diff --git a/src/t_immutable.c b/src/t_immutable.c
index 87ffc75f2d02..7fd9e5dd9625 100644
--- a/src/t_immutable.c
+++ b/src/t_immutable.c
@@ -38,11 +38,11 @@
 #include <libgen.h>
 #include <sys/acl.h>
 #include <attr/xattr.h>
+#include <linux/fs.h>
+#include <linux/magic.h>
 #include <xfs/xfs.h>
 #include <xfs/handle.h>
 #include <xfs/jdm.h>
-#include <linux/fs.h>
-#include <linux/magic.h>
 
 #ifndef XFS_SUPER_MAGIC
 #define XFS_SUPER_MAGIC 0x58465342
-- 
1.9.4
