Received: from szxga06-in.huawei.com ([45.249.212.32]:47996 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbfANGRz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 14 Jan 2019 01:17:55 -0500
From: yangerkun <yangerkun@huawei.com>
Subject: [PATCH V2] common/scsi_debug: make sure scsi_debug been removed correctly
Date: Mon, 14 Jan 2019 14:21:25 +0800
Message-ID: <20190114062125.24432-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com, david@fromorbit.com
Cc: yi.zhang@huawei.com, yangerkun@huawei.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Case generic/108 sometimes may fail while testing with some fs, and
the reson is that rmmod scsi_debug in _put_scsi_debug_dev can randomly
fail due to open references from udev scan. Now add the loop to do rmmod
to make sure scsi_debug can remove correctly.

This patch is a reference to
'https://gitlab.com/cryptsetup/cryptsetup.git' commit
d7b9ed05f0931b416c33c8eb2ff1e6efa39270ff from Ondrej Kozina,
thanks a lot!

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
