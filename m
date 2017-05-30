Received: from mx2.suse.de ([195.135.220.15]:46574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751224AbdE3Nvf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 30 May 2017 09:51:35 -0400
From: Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] listxattr: Fix read past end of array
Date: Tue, 30 May 2017 16:51:28 +0300
Message-Id: <1496152288-4101-1-git-send-email-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
List-ID: <fstests@vger.kernel.org>

listxattr reaturns a null-terminated list of entries that represent
the xattr names. However, if it is passed larger buffer than it
requires it won't zero-out the rest of the memory. The way the
loop iterator in listxattr.c is written makes it go print every
null-terminated entry up to bufsize (which is user passed parameter).
This can lead to a situation where listxattr users N bytes out of
M bytes big buffer ( M > N). This will leave the rest (M-N)
as garbage, which in turn will be printed by listxattr. Fix this
by modifying the terminating condition of the loop to print
up to the return value of listxattr which in case of success is the
amount of bytes used in the passed buffer.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 src/listxattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/listxattr.c b/src/listxattr.c
index cd46637a..f07c23f8 100644
--- a/src/listxattr.c
+++ b/src/listxattr.c
@@ -61,7 +61,7 @@ int main(int argc, char **argv)
                 perror("listxattr");
         } else {
                 char *l;
-                for (l = buf; l != (buf + bufsize) && *l != '\0';
+                for (l = buf; l != (buf + ret) && *l != '\0';
                                 l = strchr(l, '\0') + 1) {
                         printf("xattr: %s\n", l);
                 }
-- 
2.12.3

