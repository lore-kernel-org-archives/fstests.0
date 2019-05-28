Received: from mail-wm1-f66.google.com ([209.85.128.66]:39814 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1MIy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 May 2019 08:08:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so2573621wma.4
        for <fstests@vger.kernel.org>; Tue, 28 May 2019 05:08:53 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] fstests: fix _repair_scratch_fs error reporting
Date: Tue, 28 May 2019 15:08:47 +0300
Message-Id: <20190528120847.31003-1-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: zhangyi <yi.zhang@huawei.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

_dump_err2() helper was introduced over two years ago and it broke
the error reporting from _repair_scratch_fs.

Every test that runs:
_repair_scratch_fs >> $seqres.full

and expect to fail if anything is written to stderr is not working
as intended.

Spotted-by: zhangyi (F) <yi.zhang@huawei.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Eryu,

This bug was found by zhangyi while working on fsck.overlay patches,
but it affects all filesystems. I just re-found zhangyi's fix while
going through some old notes.

Amir.

 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 17b89d5d..e78e0920 100644
--- a/common/rc
+++ b/common/rc
@@ -98,7 +98,7 @@ _dump_err_cont()
 _dump_err2()
 {
     _err_msg="$*"
-    >2& echo "$_err_msg"
+    >&2 echo "$_err_msg"
 }
 
 _log_err()
-- 
2.17.1
