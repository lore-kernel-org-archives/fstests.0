Return-Path: <SRS0=6y5p=YI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71024C10F14
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Oct 2019 10:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415D82089C
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Oct 2019 10:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfJOKKG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:10:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37816 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727625AbfJOKKF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 15 Oct 2019 06:10:05 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 59D5769221E3251C0F2B;
        Tue, 15 Oct 2019 18:10:03 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 15 Oct 2019 18:09:57 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        "Chao Yu" <yuchao0@huawei.com>
Subject: [PATCH v2 1/2] common/defrag: support f2fs
Date:   Tue, 15 Oct 2019 18:09:37 +0800
Message-ID: <20191015100938.123519-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

F2FS supports defragment based on file granularity, adjust test suit
to support f2fs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- use local variable in function
 common/config |  2 ++
 common/defrag | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/common/config b/common/config
index a0d58bde..22592cec 100644
--- a/common/config
+++ b/common/config
@@ -176,6 +176,7 @@ export XFS_COPY_PROG="$(type -P xfs_copy)"
 export FSTRIM_PROG="$(type -P fstrim)"
 export DUMPE2FS_PROG="$(type -P dumpe2fs)"
 export RESIZE2FS_PROG="$(type -P resize2fs)"
+export F2FS_IO_PROG="$(type -P f2fs_io)"
 export FIO_PROG="$(type -P fio)"
 export FILEFRAG_PROG="$(type -P filefrag)"
 export E4DEFRAG_PROG="$(type -P e4defrag)"
@@ -242,6 +243,7 @@ case "$HOSTOS" in
 	export MKFS_BTRFS_PROG=$(set_mkfs_prog_path_with_opts btrfs)
 	export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
 	export DUMP_F2FS_PROG=$(type -P dump.f2fs)
+	export F2FS_IO_PROG=$(type -P f2fs_io)
 	export BTRFS_UTIL_PROG=$(type -P btrfs)
 	export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
 	export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
diff --git a/common/defrag b/common/defrag
index 2bd739c0..1381a4dd 100644
--- a/common/defrag
+++ b/common/defrag
@@ -27,6 +27,9 @@ _require_defrag()
 	rm -f $testfile $donorfile 2>&1 > /dev/null
 	DEFRAG_PROG="$E4DEFRAG_PROG"
 	;;
+    f2fs)
+	DEFRAG_PROG="$F2FS_IO_PROG defrag_file"
+	;;
     btrfs)
 	DEFRAG_PROG="$BTRFS_UTIL_PROG filesystem defragment"
 	;;
@@ -140,7 +143,13 @@ _defrag()
 
 	[ ! -z $csum ] && CSUM_BEFORE=`md5sum $1`
 	STAT_BEFORE=`stat -c "a: %x m: %y c: %z" $1`
-	$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
+
+	if [ $FSTYP == "f2fs" ]; then
+		local filesize=`ls -l $1 | $AWK_PROG '{print $5}'`
+		$DEFRAG_PROG 0 $filesize $1 >> $seqres.full 2>&1
+	else
+		$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
+	fi
 
 	_scratch_cycle_mount
 	STAT_AFTER=`stat -c "a: %x m: %y c: %z" $1`
-- 
2.18.0.rc1

