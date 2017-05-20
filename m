Received: from mail.sigma-star.at ([95.130.255.111]:45996 "EHLO
        mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbdETWGW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 20 May 2017 18:06:22 -0400
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] stat_test: Fix stx_attributes check
Date: Sun, 21 May 2017 00:06:13 +0200
Message-Id: <1495317973-24072-1-git-send-email-richard@nod.at>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: dhowells@redhat.com, amir73il@gmail.com, darrick.wong@oracle.com, eguan@redhat.com, Richard Weinberger <richard@nod.at>
List-ID: <fstests@vger.kernel.org>

I found that this test succeeds on UBIFS:
stat_test /mnt/foo attr=+compressed attr=-compressed

Since stx_attributes can hold many flags, check the flags
correctly with the & operator.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 src/stat_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/stat_test.c b/src/stat_test.c
index 3dc44bbdb71d..fc87ed5c6e8f 100644
--- a/src/stat_test.c
+++ b/src/stat_test.c
@@ -621,10 +621,10 @@ static void check_attribute(const struct statx *stx, char *arg)
 
 	attr = p->attr_flag;
 	if (set) {
-		check(stx->stx_attributes && attr,
+		check((stx->stx_attributes & attr) == attr,
 		      "Attribute %s should be set\n", arg);
 	} else {
-		check(~stx->stx_attributes && attr,
+		check((stx->stx_attributes & attr) == 0,
 		      "Attribute %s should be unset\n", arg);
 	}
 }
-- 
2.7.3

