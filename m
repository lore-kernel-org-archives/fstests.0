Received: from mail-wm0-f68.google.com ([74.125.82.68]:43913 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbeAWU6Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 23 Jan 2018 15:58:16 -0500
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 1/7] open_by_handle: verify dir content only with -r flag
Date: Tue, 23 Jan 2018 22:59:06 +0200
Message-Id: <1516741152-20345-2-git-send-email-amir73il@gmail.com>
In-Reply-To: <1516741152-20345-1-git-send-email-amir73il@gmail.com>
References: <1516741152-20345-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
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
index dbc5b0f..9c13b2a 100644
--- a/src/open_by_handle.c
+++ b/src/open_by_handle.c
@@ -412,7 +412,7 @@ int main(int argc, char **argv)
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

