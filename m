Return-Path: <SRS0=C+DF=BN=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5C6C433DF
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Aug 2020 08:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B9AC206D7
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Aug 2020 08:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgHCIqN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:46:13 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44087 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725806AbgHCIqN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Aug 2020 04:46:13 -0400
X-IronPort-AV: E=Sophos;i="5.75,429,1589212800"; 
   d="scan'208";a="97500110"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Aug 2020 16:46:07 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id E65C64CE5446;
        Mon,  3 Aug 2020 16:46:03 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 3 Aug 2020 16:46:08 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 3 Aug 2020 16:46:06 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, <darrick.wong@oracle.com>,
        <ira.weiny@intel.com>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v8 1/7] common/rc: Introduce helpers for new dax mount options and FS_XFLAG_DAX
Date:   Mon, 3 Aug 2020 16:38:32 +0800
Message-ID: <20200803083838.26222-2-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200803083838.26222-1-yangx.jy@cn.fujitsu.com>
References: <20200803083838.26222-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: E65C64CE5446.AA16B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1) _check_scratch_dax_mountopt() checks old/new dax mount option and
   returns a value.
2) _require_scratch_dax_mountopt() throws notrun if _check_scratch_dax_mountopt()
   returns a non-zero value.
3) _require_dax_iflag() checks FS_XFLAG_DAX.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/common/rc b/common/rc
index 1b7b2575..d7926bc5 100644
--- a/common/rc
+++ b/common/rc
@@ -3188,6 +3188,48 @@ _require_scratch_dax()
 	_scratch_unmount
 }
 
+# Only accept dax/dax=always mount option becasue dax=always, dax=inode
+# and dax=never are always introduced together.
+# Return 0 if filesystem/device supports the specified dax option.
+# Return 1 if mount fails with the specified dax option.
+# Return 2 if /proc/mounts shows wrong dax option.
+# Check new dax=inode, dax=always or dax=never option by passing "dax=always".
+# Check old dax or new dax=always by passing "dax".
+_check_scratch_dax_mountopt()
+{
+	local option=$1
+
+	_require_scratch
+	_scratch_mkfs > /dev/null 2>&1
+
+	_try_scratch_mount "-o $option" > /dev/null 2>&1 || return 1
+
+	if _fs_options $SCRATCH_DEV | egrep -q "dax(=always|,|$)"; then
+		_scratch_unmount
+		return 0
+	else
+		_scratch_unmount
+		return 2
+	fi
+}
+
+# Throw notrun if _check_scratch_dax_mountopt() returns a non-zero value.
+_require_scratch_dax_mountopt()
+{
+	local mountopt=$1
+
+	_check_scratch_dax_mountopt "$mountopt"
+	local res=$?
+
+	[ $res -eq 1 ] && _notrun "mount $SCRATCH_DEV with $mountopt failed"
+	[ $res -eq 2 ] && _notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
+}
+
+_require_dax_iflag()
+{
+	_require_xfs_io_command "chattr" "x"
+}
+
 # Does norecovery support by this fs?
 _require_norecovery()
 {
-- 
2.21.0



