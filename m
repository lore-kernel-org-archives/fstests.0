Received: from mx2.suse.de ([195.135.220.15]:39628 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726850AbfBYTLA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 25 Feb 2019 14:11:00 -0500
From: jeffm@suse.com
Subject: [PATCH] src/t_attr_corruption: use security.capability instead of security.evm
Date: Mon, 25 Feb 2019 14:10:52 -0500
Message-Id: <20190225191052.15342-1-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, Jeff Mahoney <jeffm@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Jeff Mahoney <jeffm@suse.com>

src/t_attr_corruption uses the security.evm extended attribute because
it sorts before security.posix_acl_access.  The security.evm attribute
is a formatted structure and when passed an uninitialized buffer, it
will fail with EPERM.

We see test failures like:
    --- tests/generic/529.out2019-02-21 13:22:47.583406922 -0500
    +++ /opt/xfstests/results//generic/529.out.bad 2019-02-21 13:57:31.967406922 -0500
    @@ -1,2 +1,2 @@
     QA output created by 529
    -list attr: Numerical result out of range
    +set evm: Operation not permitted

This patch uses security.capability which also sorts where it needs to
do for the test and also accepts an unformatted buffer.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 src/t_attr_corruption.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/t_attr_corruption.c b/src/t_attr_corruption.c
index f26611f9..0c229dbc 100644
--- a/src/t_attr_corruption.c
+++ b/src/t_attr_corruption.c
@@ -76,7 +76,7 @@ int main(int argc, char *argv[])
 	if (ret)
 		die("set posix acl");
 
-	ret = fsetxattr(fd, "security.evm", buf, 1, 1);
+	ret = fsetxattr(fd, "security.capability", buf, 1, 1);
 	if (ret)
 		die("set evm");
 
-- 
2.16.4
