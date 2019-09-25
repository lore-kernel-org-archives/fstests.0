Received: from mail.cn.fujitsu.com ([183.91.158.132]:37925 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2634139AbfIYIcm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 Sep 2019 04:32:42 -0400
From: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Subject: [PATCH] generic/442: add sync before dmsetup remove
Date: Wed, 25 Sep 2019 16:29:18 +0800
Message-ID: <1569400158-5297-1-git-send-email-suyj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, suyj.fnst@cn.fujitsu.com
List-ID: <fstests@vger.kernel.org>

This test case sometime fails. Because "dmsetup remove error-test" may
fail when some writeback is going on.

This patch adds sync before dmsetup remove operation.

Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
---
 tests/generic/442 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/442 b/tests/generic/442
index fe6d460..d48ca36 100755
--- a/tests/generic/442
+++ b/tests/generic/442
@@ -43,6 +43,7 @@ $here/src/fsync-err -d $here/src/dmerror $DMERROR_DEV
 
 # success, all done
 _dmerror_load_working_table
+sync
 _dmerror_cleanup
 _scratch_mkfs > $seqres.full 2>&1
 status=0
-- 
2.7.4
