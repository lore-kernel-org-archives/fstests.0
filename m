Return-Path: <SRS0=5/bx=A2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F11BC433E3
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 16:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF7A72065E
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 16:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgGOQa5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:30:57 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32043 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725792AbgGOQa5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Jul 2020 12:30:57 -0400
X-IronPort-AV: E=Sophos;i="5.75,355,1589212800"; 
   d="scan'208";a="96401542"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Jul 2020 00:30:55 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id DE54A4CE3F1A;
        Thu, 16 Jul 2020 00:30:54 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 16 Jul 2020 00:30:55 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 16 Jul 2020 00:30:53 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ira.weiny@intel.com>, <darrick.wong@oracle.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2 2/2] common/rc: Update _exclude_scratch_mount_option() and _require_dm_target() for new dax option
Date:   Thu, 16 Jul 2020 00:23:42 +0800
Message-ID: <20200715162342.15192-2-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200715162342.15192-1-yangx.jy@cn.fujitsu.com>
References: <20200715162342.15192-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: DE54A4CE3F1A.AC9CF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Some tests(e.g. ext4/035) cannot include dax option(dax=inode/dax=never
is OK) so make _exclude_scratch_mount_option() and _require_dm_target()
check if old or new dax option is not defined in $MOUNT_OPTIONS.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 8b19b3f7..7d0b8691 100644
--- a/common/rc
+++ b/common/rc
@@ -1896,7 +1896,7 @@ _require_dm_target()
 	_require_sane_bdev_flush $SCRATCH_DEV
 	_require_command "$DMSETUP_PROG" dmsetup
 
-	echo $MOUNT_OPTIONS | grep -q dax
+	_normalize_mount_options | egrep -q "dax(=always| |$)"
 	if [ $? -eq 0 ]; then
 		case $target in
 		stripe|linear|log-writes)
@@ -3452,12 +3452,16 @@ _normalize_mount_options()
 }
 
 # skip test if MOUNT_OPTIONS contains the given strings
+# For dax option, only accept dax/dax=always mount option
 _exclude_scratch_mount_option()
 {
 	local mnt_opts=$(_normalize_mount_options)
+	local pattern=$1
+
+	echo "$pattern" | grep -q 'dax' && pattern="dax(=always| |$)"
 
 	while [ $# -gt 0 ]; do
-		if echo $mnt_opts | grep -qw "$1"; then
+		if echo $mnt_opts | egrep -q "$pattern"; then
 			_notrun "mount option \"$1\" not allowed in this test"
 		fi
 		shift
-- 
2.21.0



