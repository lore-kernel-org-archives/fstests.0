Return-Path: <SRS0=sm2X=AZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2B5C433DF
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Jul 2020 11:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31E1221FC
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Jul 2020 11:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgGNLJC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:09:02 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:16314 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726041AbgGNLJC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Jul 2020 07:09:02 -0400
X-IronPort-AV: E=Sophos;i="5.75,350,1589212800"; 
   d="scan'208";a="96314551"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Jul 2020 19:08:59 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id B89D54CE4BD9;
        Tue, 14 Jul 2020 19:08:57 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 14 Jul 2020 19:08:57 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 14 Jul 2020 19:08:57 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] common/dmlogwrites: Update _require_log_writes_dax()
Date:   Tue, 14 Jul 2020 19:01:50 +0800
Message-ID: <20200714110150.11186-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: B89D54CE4BD9.AD88B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1) Rename _require_log_writes_dax to _require_log_writes_dax_mountopt
2) Make _require_log_writes_dax_mountopt accept old and new dax option
3) generic/470 takes use of _require_log_writes_dax_mountopt

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/dmlogwrites | 15 ++++++++++-----
 tests/generic/470  |  2 +-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/common/dmlogwrites b/common/dmlogwrites
index 2a7ff612..2e9b2311 100644
--- a/common/dmlogwrites
+++ b/common/dmlogwrites
@@ -23,7 +23,10 @@ _require_log_writes()
 # explicitly. But this is considered as a temporary workaround, we want to move
 # all the DAX check back to _require_log_writes when dm-log-writes gains full
 # DAX support and remove this helper.
-_require_log_writes_dax()
+#
+# Only accept dax/dax=always mount option becasue dax=always, dax=inode
+# and dax=never are always introduced together.
+_require_log_writes_dax_mountopt()
 {
 	[ -z "$LOGWRITES_DEV" -o ! -b "$LOGWRITES_DEV" ] && \
 		_notrun "This test requires a valid \$LOGWRITES_DEV"
@@ -32,16 +35,18 @@ _require_log_writes_dax()
 	_require_test_program "log-writes/replay-log"
 
 	local ret=0
+	local mountopt=$1
 	_log_writes_init $SCRATCH_DEV
 	_log_writes_mkfs > /dev/null 2>&1
-	_log_writes_mount -o dax > /dev/null 2>&1
-	# Check options to be sure. XFS ignores dax option
+	_log_writes_mount "-o $mountopt" > /dev/null 2>&1
+	# Check options to be sure.
+	# XFS ignores dax option(or changes it to dax=never)
 	# and goes on if dev underneath does not support dax.
-	_fs_options $LOGWRITES_DMDEV | grep -qw "dax"
+	_fs_options $LOGWRITES_DMDEV | egrep -q "dax(=always|,|$)"
 	ret=$?
 	_log_writes_cleanup
 	if [ $ret -ne 0 ]; then
-		_notrun "$LOGWRITES_DMDEV $FSTYP does not support -o dax"
+		_notrun "$LOGWRITES_DMDEV $FSTYP does not support -o $mountopt"
 	fi
 }
 
diff --git a/tests/generic/470 b/tests/generic/470
index 93691f4a..fd6da563 100755
--- a/tests/generic/470
+++ b/tests/generic/470
@@ -35,7 +35,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_scratch
-_require_log_writes_dax
+_require_log_writes_dax_mountopt "dax"
 _require_xfs_io_command "mmap" "-S"
 _require_xfs_io_command "log_writes"
 
-- 
2.21.0



