Received: from mx2.suse.de ([195.135.220.15]:51462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751004AbdE3OKM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 30 May 2017 10:10:12 -0400
From: Nikolay Borisov <nborisov@suse.com>
Subject: [PATCHv2] src/listxattr: Fix reading past the end of the user buffer
Date: Tue, 30 May 2017 17:10:07 +0300
Message-Id: <1496153407-6060-1-git-send-email-nborisov@suse.com>
In-Reply-To: <1496152288-4101-1-git-send-email-nborisov@suse.com>
References: <1496152288-4101-1-git-send-email-nborisov@suse.com>
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
by converting the 'for' loop to 'while' and properly ensuring
we are reading at most howevermany elements the syscall reported
it returned

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

v2: 
 Rewrite the loop, hopefully making the code a bit more legible.
 Functionally it's the same as my previous fix

 src/listxattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/listxattr.c b/src/listxattr.c
index cd46637a..584ebb2d 100644
--- a/src/listxattr.c
+++ b/src/listxattr.c
@@ -60,10 +60,10 @@ int main(int argc, char **argv)
         if (ret < 0) {
                 perror("listxattr");
         } else {
-                char *l;
-                for (l = buf; l != (buf + bufsize) && *l != '\0';
-                                l = strchr(l, '\0') + 1) {
+                char *l = buf;
+                while (l != (buf + ret)) {
                         printf("xattr: %s\n", l);
+                        l = strchr(l, '\0') + 1;
                 }
         }
 
-- 
2.12.3

