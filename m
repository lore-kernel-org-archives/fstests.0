Received: from mx1.redhat.com ([209.132.183.28]:50290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfDIEyL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 9 Apr 2019 00:54:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD542308626F
        for <fstests@vger.kernel.org>; Tue,  9 Apr 2019 04:54:11 +0000 (UTC)
Received: from dhcp-12-125.nay.redhat.com (dhcp-12-125.nay.redhat.com [10.66.12.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCC3B19C5B
        for <fstests@vger.kernel.org>; Tue,  9 Apr 2019 04:54:10 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] src/t_attr_corruption: covert value to little endian order
Date: Tue,  9 Apr 2019 12:54:04 +0800
Message-Id: <20190409045404.20215-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

generic/529 always fails on ppc64 or s390x big-endian machine as:

  set posix acl: Operation not supported

Due to the members of struct posix_acl_xattr_entry/header need to be
little-endian byte order, so use htole*() helper to make sure that.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 src/t_attr_corruption.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/t_attr_corruption.c b/src/t_attr_corruption.c
index 9101024e..e7d435b1 100644
--- a/src/t_attr_corruption.c
+++ b/src/t_attr_corruption.c
@@ -32,6 +32,7 @@
 #include <stdint.h>
 #include <unistd.h>
 #include <sys/xattr.h>
+#include <endian.h>
 
 void die(const char *msg)
 {
@@ -52,13 +53,14 @@ struct myacl {
 
 int main(int argc, char *argv[])
 {
+	/* posix_acl_xattr_entry/header need little-endian order */
 	struct myacl acl = {
-		.d = 2,
+		.d = htole32(2),
 		.e = {
-			{1, 0, 0},
-			{4, 0, 0},
-			{0x10, 0, 0},
-			{0x20, 0, 0},
+			{htole16(1), 0, 0},
+			{htole16(4), 0, 0},
+			{htole16(0x10), 0, 0},
+			{htole16(0x20), 0, 0},
 		},
 	};
 	char buf[64];
-- 
2.17.2
