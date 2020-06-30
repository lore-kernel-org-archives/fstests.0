Return-Path: <SRS0=QKYl=AL=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EF3C433DF
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Jun 2020 14:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57352072D
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Jun 2020 14:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbgF3OH0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:07:26 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10820 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731037AbgF3OH0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Jun 2020 10:07:26 -0400
X-IronPort-AV: E=Sophos;i="5.75,297,1589212800"; 
   d="scan'208";a="95563329"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Jun 2020 22:06:50 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 107744CE4B19;
        Tue, 30 Jun 2020 21:56:17 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 30 Jun 2020 22:06:46 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 30 Jun 2020 22:06:44 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v3 1/6] common/rc: Introduce new helpers for DAX mount options and FS_XFLAG_DAX
Date:   Tue, 30 Jun 2020 21:59:46 +0800
Message-ID: <20200630135951.21202-2-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200630135951.21202-1-yangx.jy@cn.fujitsu.com>
References: <20200630135951.21202-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 107744CE4B19.AEAE5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1) _require_scratch_dax_mountopt() checks both old and new DAX mount option
2) _require_scratch_dax_iflag() checks FS_XFLAG_DAX

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/common/rc b/common/rc
index f17b19f2..09b1175d 100644
--- a/common/rc
+++ b/common/rc
@@ -3188,6 +3188,41 @@ _require_scratch_dax()
 	_scratch_unmount
 }
 
+_require_scratch_dax_mountopt()
+{
+	local mountopt=$1
+	local output
+
+	_require_scratch
+	_scratch_mkfs > /dev/null 2>&1
+	_try_scratch_mount -o "$mountopt" || \
+		_notrun "mount $SCRATCH_DEV with $mountopt failed"
+
+	output=$(_fs_options $SCRATCH_DEV)
+
+	# For new dax mount option, /proc/mounts shows different outputs if we
+	# mount with -o dax=inode on ext4 and xfs so skip checking it.
+	# /proc/mounts shows 'dax=inode' on ext4 but shows nothing on xfs.
+	if [ "$mountopt" != "dax=inode" ]; then
+		echo $output | grep -qw "$mountopt" || \
+			_notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
+	fi
+
+	# For new dax mount option, /proc/mounts shows "dax=never" if we
+	# mount with -o dax on xfs and underlying device doesn't support dax.
+	if [ "$mountopt" = "dax" ]; then
+		echo $output | grep -qw "dax=never" && \
+			_notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
+	fi
+
+	_scratch_unmount
+}
+
+_require_scratch_dax_iflag()
+{
+	_require_xfs_io_command "chattr" "x"
+}
+
 # Does norecovery support by this fs?
 _require_norecovery()
 {
-- 
2.21.0



