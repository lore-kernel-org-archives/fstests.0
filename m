Received: from mail.cn.fujitsu.com ([183.91.158.132]:29619 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934839AbeFZLme (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Jun 2018 07:42:34 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] generic/085: Call $UDEV_SETTLE_PROG before "dmsetup remove"
Date: Tue, 26 Jun 2018 18:59:10 +0800
Message-ID: <1530010750-16516-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: guaneryu@gmail.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

cleanup_dmdev() may fail to remove dm device because of EBUSY
and cause subsequent tests to fail.  Make sure dm device is
fully settled before removing it.

PS: I am not sure whether calling "dmsetup remove --retry" is
better or not.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/085 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/generic/085 b/tests/generic/085
index bed1e0d..bdc4dba 100755
--- a/tests/generic/085
+++ b/tests/generic/085
@@ -32,6 +32,9 @@ cleanup_dmdev()
 	$DMSETUP_PROG resume $lvdev >/dev/null 2>&1
 	$UMOUNT_PROG $lvdev >/dev/null 2>&1
 
+	# wait for device to be fully settled so that
+	# 'dmsetup remove' doesn't fail due to EBUSY
+	$UDEV_SETTLE_PROG >/dev/null 2>&1
 	$DMSETUP_PROG remove $node >>$seqres.full 2>&1
 	$DMSETUP_PROG mknodes >/dev/null 2>&1
 }
-- 
1.8.3.1



