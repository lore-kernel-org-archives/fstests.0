Return-Path: <SRS0=Jk7F=BU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9F5C433DF
	for <linux-fstests@archiver.kernel.org>; Mon, 10 Aug 2020 16:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500E6207DE
	for <linux-fstests@archiver.kernel.org>; Mon, 10 Aug 2020 16:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHJQhK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:37:10 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1242 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725873AbgHJQhJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 10 Aug 2020 12:37:09 -0400
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; 
   d="scan'208";a="97947357"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Aug 2020 00:36:50 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id CE3734CE34F1;
        Tue, 11 Aug 2020 00:36:46 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 11 Aug 2020 00:36:51 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 11 Aug 2020 00:36:50 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, <ira.weiny@intel.com>,
        <darrick.wong@oracle.com>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v3 1/2] common/dmlogwrites: Update _require_log_writes_dax() for new dax option
Date:   Tue, 11 Aug 2020 00:29:08 +0800
Message-ID: <20200810162909.26665-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: CE3734CE34F1.ABF78
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1) Rename _require_log_writes_dax to _require_log_writes_dax_mountopt.
2) Make _require_log_writes_dax_mountopt check if old or new dax option
   is supported.
3) generic/470 takes use of _require_log_writes_dax_mountopt.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---

V2->V3:
Update comments.

 common/dmlogwrites | 24 +++++++++++++++++++-----
 tests/generic/470  |  2 +-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/common/dmlogwrites b/common/dmlogwrites
index 2a7ff612..573f4b8a 100644
--- a/common/dmlogwrites
+++ b/common/dmlogwrites
@@ -23,7 +23,18 @@ _require_log_writes()
 # explicitly. But this is considered as a temporary workaround, we want to move
 # all the DAX check back to _require_log_writes when dm-log-writes gains full
 # DAX support and remove this helper.
-_require_log_writes_dax()
+#
+# Check if dax mount options are supported
+# $1 can be either 'dax=always' or 'dax'
+# dax=always
+#      Check for the new dax options (dax=inode, dax=always or dax=never)
+#      by passing "dax=always".
+# dax
+#      Check for the old dax or new dax=always by passing "dax".
+# This only accepts 'dax=always' because dax=always, dax=inode and
+# dax=never are always supported together.  So if the other options are
+# required checking for 'dax=always' indicates support for the other 2.
+_require_log_writes_dax_mountopt()
 {
 	[ -z "$LOGWRITES_DEV" -o ! -b "$LOGWRITES_DEV" ] && \
 		_notrun "This test requires a valid \$LOGWRITES_DEV"
@@ -32,16 +43,19 @@ _require_log_writes_dax()
 	_require_test_program "log-writes/replay-log"
 
 	local ret=0
+	local mountopt=$1
+
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



