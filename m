Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751813AbeEVDYA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 May 2018 23:24:00 -0400
From: XiaoLi Feng <xifeng@redhat.com>
Subject: [PATCH] common/rc: skip atime related tests on CIFS
Date: Tue, 22 May 2018 11:23:56 +0800
Message-Id: <1526959436-7170-1-git-send-email-xifeng@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-cifs@vger.kernel.org, xiaoli feng <xifeng@redhat.com>
List-ID: <fstests@vger.kernel.org>

From: xiaoli feng <xifeng@redhat.com>

The atime related mount options have no effect on cifs mounts
now or in the future. So skip these tests on CIFS.

Signed-off-by: xiaoli feng <xifeng@redhat.com>
---
 common/rc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/rc b/common/rc
index ffe5323..d3af55f 100644
--- a/common/rc
+++ b/common/rc
@@ -3244,6 +3244,8 @@ _require_atime()
 	_exclude_scratch_mount_option "noatime"
 	if [ "$FSTYP" == "nfs" ]; then
 		_notrun "atime related mount options have no effect on NFS"
+	elif [ "$FSTYP" == "cifs" ]; then
+		_notrun "atime related mount options have no effect on CIFS"
 	fi
 }
 
-- 
1.8.3.1

