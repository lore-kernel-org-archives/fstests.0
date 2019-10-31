Return-Path: <SRS0=ptrv=YY=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13400CA9EC3
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Oct 2019 09:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68302080F
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Oct 2019 09:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfJaJMH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:12:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726776AbfJaJMH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 31 Oct 2019 05:12:07 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AA405144E3B8C18F361E;
        Thu, 31 Oct 2019 17:12:05 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 31 Oct 2019
 17:11:56 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <guaneryu@gmail.com>, <darrick.wong@oracle.com>,
        <ebiggers@google.com>, <yi.zhang@huawei.com>
CC:     <fstests@vger.kernel.org>
Subject: [PATCH xfstests] generic/317: Use relative paths to avoid traversal permission problems
Date:   Thu, 31 Oct 2019 17:19:17 +0800
Message-ID: <1572513557-112797-1-git-send-email-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

generic/317 will fail because execvp(cmd) is executed without permission,
where cmd is '$here/src/lstat64 $file', which is called by
  $here/src/nsexec -s -U -M "0 $qa_user_id 1000" -G "0 $qa_user_id 1000"\
  $here/src/lstat64 $file

So, you will see following output:
  From user_ns
  ...
  +execvp: Permission denied

nsexec runs the instruction '$here/src/lstat64 $file' as a regular user,
the regular user may not have permission to access path in '$here'.

Actually, it has been fixed in 4818302fbf ("xfstests: generic/317 use
relative paths..."), which then been modified by b7cecbea22 ("fstests:
Add path $here before src/<file>").

Fixes: b7cecbea22 ("fstests: Add path $here before src/<file>")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 tests/generic/317 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/generic/317 b/tests/generic/317
index 509887d..8ea9d81 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -61,7 +61,10 @@ _print_numeric_uid()
     $here/src/lstat64 $file |head -3 |_filter_output
 
     echo "From user_ns"
-    $here/src/nsexec -s -U -M "0 $qa_user_id 1000" -G "0 $qa_user_id 1000" $here/src/lstat64 $file |head -3 |_filter_output
+    # don't use $here/src/lstat64, as we're running cmd(src/lstat64) in
+    # nsexec as a regular user, and $here may contain path component that
+    # a regular user doesn't have search permission
+    $here/src/nsexec -s -U -M "0 $qa_user_id 1000" -G "0 $qa_user_id 1000" src/lstat64 $file |head -3 |_filter_output
 }
 
 _scratch_unmount >/dev/null 2>&1
-- 
2.7.4

