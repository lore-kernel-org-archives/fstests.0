Return-Path: <SRS0=glCd=YP=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC60BCA9EA0
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Oct 2019 12:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB82621872
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Oct 2019 12:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbfJVMbn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Oct 2019 08:31:43 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:19068 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388066AbfJVMbn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Oct 2019 08:31:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Tfv6Apt_1571747490;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0Tfv6Apt_1571747490)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Oct 2019 20:31:30 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     fstests@vger.kernel.org
Cc:     Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Eryu Guan <eguan@linux.alibaba.com>
Subject: [PATCH] ltp/fsx: hornor keep_size_calls when replaying operations
Date:   Tue, 22 Oct 2019 20:31:15 +0800
Message-Id: <20191022123115.12250-1-eguan@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When replaying fsx operations with "--replay-ops opsfile" option, the
ops described by opsfile may contain 'keep_size' directive for fallocate
and/or zero_range operations, but it's possible that the underlying
filesystem doesn't support KEEP_SIZE flag and causes fsx reports false
failure, despite the 'keep_size_calls' switch is set to false.

For example, running generic/469 on NFSv4, which supports fallocate(2)
but not the KEEP_SIZE flag, we see:

main: filesystem does not support fallocate mode FALLOC_FL_KEEP_SIZE, disabling!
main: filesystem does not support fallocate mode FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, disabling!
main: filesystem does not support fallocate mode FALLOC_FL_ZERO_RANGE, disabling!
main: filesystem does not support fallocate mode FALLOC_FL_COLLAPSE_RANGE, disabling!
main: filesystem does not support fallocate mode FALLOC_FL_INSERT_RANGE, disabling!
main: filesystem does not support clone range, disabling!
main: filesystem does not support dedupe range, disabling!
fallocate: 0x0 to 0x1000
do_preallocate: fallocate: Operation not supported
LOG DUMP (1 total operations):
1(  1 mod 256): FALLOC   0x0 thru 0x1000        (0x1000 bytes) PAST_EOF
Log of operations saved to "/test1/469.fsx.fsxops"; replay with --replay-ops
Correct content saved for comparison
(maybe hexdump "/test1/469.fsx" vs "/test1/469.fsx.fsxgood")

Fix it by making sure 'keep_size_calls' is true when 'keep_size' is
set, otherwise just skip the operation.

Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
---
 ltp/fsx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 06d08e4e93f3..ae89bf665db4 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -2044,6 +2044,9 @@ have_op:
 		if (!fallocate_calls) {
 			log4(OP_FALLOCATE, offset, size, FL_SKIPPED);
 			goto out;
+		} else if (keep_size && !keep_size_calls) {
+			log4(OP_FALLOCATE, offset, size, FL_SKIPPED | FL_KEEP_SIZE);
+			goto out;
 		}
 		break;
 	case OP_PUNCH_HOLE:
@@ -2056,6 +2059,9 @@ have_op:
 		if (!zero_range_calls) {
 			log4(OP_ZERO_RANGE, offset, size, FL_SKIPPED);
 			goto out;
+		} else if (keep_size && !keep_size_calls) {
+			log4(OP_ZERO_RANGE, offset, size, FL_SKIPPED | FL_KEEP_SIZE);
+			goto out;
 		}
 		break;
 	case OP_COLLAPSE_RANGE:
-- 
2.14.4.44.g2045bb6

