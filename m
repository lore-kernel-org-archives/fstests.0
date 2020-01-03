Return-Path: <SRS0=PjwK=2Y=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0923C32767
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Jan 2020 07:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C8B222C3
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Jan 2020 07:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgACH7G (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 3 Jan 2020 02:59:06 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24793 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726077AbgACH7G (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Jan 2020 02:59:06 -0500
X-IronPort-AV: E=Sophos;i="5.69,389,1571673600"; 
   d="scan'208";a="81265937"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Jan 2020 15:59:03 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 60FE449E930E;
        Fri,  3 Jan 2020 15:50:07 +0800 (CST)
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 3 Jan 2020 15:59:01 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.439.0; Fri, 3 Jan 2020 15:59:04 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <guaneryu@gmail.com>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] ltp/fsx.c: Ignore unsupported keep_size flag even if it's specified by --replay-ops
Date:   Fri, 3 Jan 2020 15:54:51 +0800
Message-ID: <20200103075451.12354-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 60FE449E930E.AB076
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Current fsx cannot drop keep_size flag if it is specified by --replay-ops but not
supported by fallocate().  For example, running generic/469 got the following
error on NFSv4.2:
----------------------------------------------------
main: filesystem does not support fallocate mode FALLOC_FL_KEEP_SIZE, disabling!
...
fallocate: 0x0 to 0x1000
do_preallocate: fallocate: Operation not supported
LOG DUMP (1 total operations):
1(  1 mod 256): FALLOC   0x0 thru 0x1000        (0x1000 bytes) PAST_EOF
...
----------------------------------------------------

Avoid calling fallocate(FALLOC_FL_KEEP_SIZE) in this case by ignoring keep_size flag.

BTW: NFSv4.2 doesn't support single keep_size flag，as below:
----------------------------------------------------
if ((mode != 0) && (mode != (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)))
        return -EOPNOTSUPP;
----------------------------------------------------

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 ltp/fsx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 06d08e4e..4da9d7d8 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1948,7 +1948,18 @@ test(void)
 			size = log_entry.args[1];
 			offset2 = log_entry.args[2];
 			closeopen = !!(log_entry.flags & FL_CLOSE_OPEN);
+
+			/*
+			 * Ignore unsupported keep_size flag even if it's specified
+			 * by --replay-ops
+			 */
 			keep_size = !!(log_entry.flags & FL_KEEP_SIZE);
+			if (!keep_size_calls && keep_size) {
+				if (!quiet)
+					prt("Ignoring unsupported keep_size flag\n");
+				keep_size = 0;
+			}
+
 			goto have_op;
 		}
 		return 0;
-- 
2.21.0



