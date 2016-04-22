Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55801 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbcDVJWQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 22 Apr 2016 05:22:16 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0797862664
	for <fstests@vger.kernel.org>; Fri, 22 Apr 2016 09:22:16 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v2] overlay: notrun if upper fs does not support d_type
Date: Fri, 22 Apr 2016 17:21:51 +0800
Message-Id: <1461316911-17533-1-git-send-email-xzhou@redhat.com>
In-Reply-To: <1461312715-14197-2-git-send-email-xzhou@redhat.com>
References: <1461312715-14197-2-git-send-email-xzhou@redhat.com>
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

v2: use case to make this less ugly..


 common/rc | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/common/rc b/common/rc
index 8bec836..946b354 100644
--- a/common/rc
+++ b/common/rc
@@ -273,6 +273,22 @@ _overlay_mount()
 	local dir=$1
 	local mnt=$2
 	shift 2
+
+	local upper_fst=$(df --output=fstype $dir | tail -1)
+	case "$upper_fst" in
+	xfs)
+		if ! xfs_info $dir | grep -q "ftype=1" ; then
+			_notrun "upper fs needs to support d_type"
+		fi
+		;;
+	ext2|ext3|ext4)
+		if ! tune2fs -l $(df --output=source $dir | tail -1) | \
+		   grep -q filetype ; then
+			_notrun "upper fs needs to support d_type"
+		fi
+		;;
+	esac
+
 	mkdir -p $dir/$OVERLAY_UPPER_DIR
 	mkdir -p $dir/$OVERLAY_LOWER_DIR
 	mkdir -p $dir/$OVERLAY_WORK_DIR
-- 
2.5.5

