Received: from mail-wm0-f65.google.com ([74.125.82.65]:34654 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754254AbeAGSGj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Jan 2018 13:06:39 -0500
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 2/7] open_by_handle: verify dir content only with -r flag
Date: Sun,  7 Jan 2018 20:07:20 +0200
Message-Id: <1515348445-1403-3-git-send-email-amir73il@gmail.com>
In-Reply-To: <1515348445-1403-1-git-send-email-amir73il@gmail.com>
References: <1515348445-1403-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Jeff Layton <jlayton@poochiereds.net>, "J . Bruce Fields" <bfields@fieldses.org>, Miklos Szeredi <miklos@szeredi.hu>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Without -r flag file handles are opened, but file content is not read.
Treat dir file hanldes, similarly. without -r flag, open dir file
handle, but don't verify its content.

This is going to be used by tests for which dir content is changed
between encode and decode of dir file handle.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 src/open_by_handle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/open_by_handle.c b/src/open_by_handle.c
index f9dfefc..5b7a592 100644
--- a/src/open_by_handle.c
+++ b/src/open_by_handle.c
@@ -472,7 +472,7 @@ int main(int argc, char **argv)
 			if (!nlink) {
 				printf("open_by_handle(%s) opened an unlinked dir!\n", dname);
 				return EXIT_FAILURE;
-			} else {
+			} else if (rd) {
 				/*
 				 * Sanity check dir fd - expect to access orig file IFF
 				 * it was not unlinked nor renamed.
-- 
2.7.4

