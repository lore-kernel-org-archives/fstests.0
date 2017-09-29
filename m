Received: from mx1.redhat.com ([209.132.183.28]:38784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751899AbdI2Qhe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 29 Sep 2017 12:37:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70893C04AC52
        for <fstests@vger.kernel.org>; Fri, 29 Sep 2017 16:37:34 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-44.pek2.redhat.com [10.72.12.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CF2118621
        for <fstests@vger.kernel.org>; Fri, 29 Sep 2017 16:37:33 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2] src/nsexec: fix stack pointer alignment exception
Date: Sat, 30 Sep 2017 00:37:28 +0800
Message-Id: <20170929163728.17859-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When test g/317 or g/318 on ARM server, we got a kernel exception:

  kernel: nsexec[8203]: SP Alignment exception: pc=00000000004010a0 sp=00000000005200e8

nsexec gives an unaligned child stack address to clone() system
call sometimes. For making sure it's always aligned, use
"__attribute__((aligned))" extension of GCC (Thanks this suggestion
from Eric sandeen).

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

V2 move the "__attribute__((aligned))" after array name, for following
common "__attribute__" usage.

Thanks,
Zorro

 src/nsexec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/nsexec.c b/src/nsexec.c
index f033b1a4..205dd081 100644
--- a/src/nsexec.c
+++ b/src/nsexec.c
@@ -138,7 +138,8 @@ childFunc(void *arg)
 
 #define STACK_SIZE (1024 * 1024)
 
-static char child_stack[STACK_SIZE];    /* Space for child's stack */
+/* Space for child's stack */
+static char __attribute__((aligned)) child_stack[STACK_SIZE];
 
 int
 main(int argc, char *argv[])
-- 
2.13.6

