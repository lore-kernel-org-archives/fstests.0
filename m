Return-Path: <SRS0=sm2X=AZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8D0C433E4
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Jul 2020 09:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05FF21927
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Jul 2020 09:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgGNJra (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:47:30 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:64663 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725884AbgGNJra (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Jul 2020 05:47:30 -0400
X-IronPort-AV: E=Sophos;i="5.75,350,1589212800"; 
   d="scan'208";a="96311038"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Jul 2020 17:47:26 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id C3F0D4CE505F;
        Tue, 14 Jul 2020 17:47:22 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 14 Jul 2020 17:47:23 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 14 Jul 2020 17:47:21 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v6 1/7] common/rc: Introduce new helpers for DAX mount options and FS_XFLAG_DAX
Date:   Tue, 14 Jul 2020 17:40:03 +0800
Message-ID: <20200714094009.8654-2-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200714094009.8654-1-yangx.jy@cn.fujitsu.com>
References: <20200714094009.8654-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: C3F0D4CE505F.A95F4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1) _require_scratch_dax_mountopt() checks both old and new DAX mount option
2) _require_dax_iflag() checks FS_XFLAG_DAX

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---

V5->V6:
Simplify _require_scratch_dax_mountopt because it is enough to only check
dax/dax=always mount option.  See the following reasons:
1) we cannot detect if underlying device supports dax by mounting dax=inode
   or dax=never.
2) dax=always, dax=inode, dax=never are always introduced together.

 common/rc | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/common/rc b/common/rc
index f17b19f2..aeec1f11 100644
--- a/common/rc
+++ b/common/rc
@@ -3188,6 +3188,28 @@ _require_scratch_dax()
 	_scratch_unmount
 }
 
+# Only accept dax/dax=always mount option becasue dax=always, dax=inode
+# and dax=never are always introduced together.
+_require_scratch_dax_mountopt()
+{
+	local mountopt=$1
+
+	_require_scratch
+	_scratch_mkfs > /dev/null 2>&1
+	_try_scratch_mount "-o $mountopt" > /dev/null 2>&1 || \
+		_notrun "mount $SCRATCH_DEV with $mountopt failed"
+
+	_fs_options $SCRATCH_DEV | egrep -q "dax(=always|,|$)" || \
+		_notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
+
+	_scratch_unmount
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



