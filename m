Received: from szxga05-in.huawei.com ([45.249.212.191]:17125 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbfAIFpT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 9 Jan 2019 00:45:19 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 772373BD6176EF914F30
        for <fstests@vger.kernel.org>; Wed,  9 Jan 2019 13:45:17 +0800 (CST)
From: yangerkun <yangerkun@huawei.com>
Subject: [PATCH] common/scsi_debug: make sure scsi_debug been removed correctly
Date: Wed, 9 Jan 2019 13:48:45 +0800
Message-ID: <20190109054845.93810-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: houtao1@huawei.com, yangerkun@huawei.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Case generic/108 sometimes will fail while testing ext2, and the reson
is that rmmod scsi_debug in _put_scsi_debug_dev may randomly fail. Now
add the loop to do rmmod to make sure scsi_debug can be removed
correctly.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 common/scsi_debug | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/common/scsi_debug b/common/scsi_debug
index d9aa0bd..890ec68 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -45,11 +45,13 @@ _put_scsi_debug_dev()
 {
 	lsmod | grep -wq scsi_debug || return
 
-	n=2
+	n=15
 	# use redirection not -q option of modprobe here, because -q of old
 	# modprobe is only quiet when the module is not found, not when the
 	# module is in use.
-	while [ $n -ge 0 ] && ! modprobe -nr scsi_debug >/dev/null 2>&1; do
+	while [ $n -ge 0 ]; do
+		modprobe -r scsi_debug >/dev/null 2>&1
+		[ $? -eq 0 ] && return 0
 		sleep 1
 		n=$((n-1))
 	done
-- 
2.9.5
