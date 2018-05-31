Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750949AbeEaEKT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 31 May 2018 00:10:19 -0400
From: XiaoLi Feng <xifeng@redhat.com>
Subject: [PATCH v3] common/rc: skip atime related tests on CIFS
Date: Thu, 31 May 2018 12:10:14 +0800
Message-Id: <1527739814-30451-1-git-send-email-xifeng@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-cifs@vger.kernel.org, xiaoli feng <xifeng@redhat.com>
List-ID: <fstests@vger.kernel.org>

From: xiaoli feng <xifeng@redhat.com>

>From the feedback of cifs developer, the behaviour of atime/noatime
for cifs is basically noatime always. So the atime related mount
options have no effect on cifs mounts. And Skip these tests on CIFS.

Signed-off-by: xiaoli feng <xifeng@redhat.com>
---
 common/rc | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index ffe5323..0295b30 100644
--- a/common/rc
+++ b/common/rc
@@ -3242,9 +3242,16 @@ _exclude_scratch_mount_option()
 _require_atime()
 {
 	_exclude_scratch_mount_option "noatime"
-	if [ "$FSTYP" == "nfs" ]; then
-		_notrun "atime related mount options have no effect on NFS"
-	fi
+	case $FSTYP
+	in
+		nfs)
+			_notrun "atime related mount options have no effect on NFS"
+		;;
+		cifs)
+			_notrun "atime related mount options have no effect on CIFS"
+		;;
+	esac
+
 }
 
 _require_relatime()
-- 
1.8.3.1

