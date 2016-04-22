Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45014 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594AbcDVINo (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 22 Apr 2016 04:13:44 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7501710F1B8
	for <fstests@vger.kernel.org>; Fri, 22 Apr 2016 08:13:44 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH 2/2] overlay: notrun if upper fs does not support d_type
Date: Fri, 22 Apr 2016 16:11:55 +0800
Message-Id: <1461312715-14197-2-git-send-email-xzhou@redhat.com>
In-Reply-To: <1461312715-14197-1-git-send-email-xzhou@redhat.com>
References: <20160421125732.GF4675@eguan.usersys.redhat.com>
 <1461312715-14197-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Overlayfs whiteout can be visible if underlying upper fs does not
support d_type. Kernel commit
	45aebea (ovl: Ensure upper filesystem supports d_type)
prevents mounting overlayfs like this since v4.6-rc1.

Check upper fs before mounting overlay, mark as not run if needs.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 common/rc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/rc b/common/rc
index 8bec836..a25d30e 100644
--- a/common/rc
+++ b/common/rc
@@ -273,6 +273,18 @@ _overlay_mount()
 	local dir=$1
 	local mnt=$2
 	shift 2
+
+	if [ "$(df --output=fstype $dir | tail -1)" == "xfs" ] && \
+	   ! xfs_info $dir | grep -q "ftype=1" ; then
+		_notrun "upper fs needs to support d_type"
+	fi
+
+	if [[ "$(df --output=fstype $dir | tail -1)" =~ ext ]] && \
+	   ! tune2fs -l $(df --output=source $dir | tail -1) | \
+	   grep -q filetype ; then
+		_notrun "upper fs needs to support d_type"
+	fi
+
 	mkdir -p $dir/$OVERLAY_UPPER_DIR
 	mkdir -p $dir/$OVERLAY_LOWER_DIR
 	mkdir -p $dir/$OVERLAY_WORK_DIR
-- 
2.5.5

