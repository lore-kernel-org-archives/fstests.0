Return-Path: <SRS0=6y5p=YI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31545ECE58E
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Oct 2019 10:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB3D2089C
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Oct 2019 10:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbfJOKMT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:12:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3719 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729759AbfJOKMT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 15 Oct 2019 06:12:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9914840AE17C4FF6D7AA;
        Tue, 15 Oct 2019 18:12:17 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 15 Oct 2019 18:12:09 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        "Chao Yu" <yuchao0@huawei.com>
Subject: [PATCH v2] common/rc: generalize _get_filesize()
Date:   Tue, 15 Oct 2019 18:11:49 +0800
Message-ID: <20191015101149.127599-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There are some testcases use below command to get file size, generalize
it as global function _get_filesize()

ls -l $1 | $AWK_PROG '{print $5}'

And in addition, using more simple command "stat -c %s" instead.

- adjust common/defrag, generic/275 and generic/315 to use it
- remove unused _filesize in generic/013

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- As suggested by Eryu, let's use "stat -c %s" instead of original
complicated one.

 common/defrag     | 2 +-
 common/rc         | 5 +++++
 tests/generic/013 | 5 -----
 tests/generic/275 | 2 +-
 tests/generic/315 | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/common/defrag b/common/defrag
index 1381a4dd..1769013b 100644
--- a/common/defrag
+++ b/common/defrag
@@ -145,7 +145,7 @@ _defrag()
 	STAT_BEFORE=`stat -c "a: %x m: %y c: %z" $1`
 
 	if [ $FSTYP == "f2fs" ]; then
-		local filesize=`ls -l $1 | $AWK_PROG '{print $5}'`
+		local filesize=`_get_filesize $1`
 		$DEFRAG_PROG 0 $filesize $1 >> $seqres.full 2>&1
 	else
 		$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
diff --git a/common/rc b/common/rc
index cfaabf10..bd388a4c 100644
--- a/common/rc
+++ b/common/rc
@@ -165,6 +165,11 @@ if [ ! -z "$REPORT_LIST" ]; then
 	_assert_report_list
 fi
 
+_get_filesize()
+{
+    echo `stat -c %s $1`
+}
+
 _mount()
 {
     $MOUNT_PROG `_mount_ops_filter $*`
diff --git a/tests/generic/013 b/tests/generic/013
index 9e533ee8..bc596102 100755
--- a/tests/generic/013
+++ b/tests/generic/013
@@ -24,11 +24,6 @@ _cleanup()
     rm -rf $TEST_DIR/fsstress.$$.*
 }
 
-_filesize()
-{
-    ls -l $1 | $AWK_PROG '{print "    filesize = " $5}'
-}
-
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
diff --git a/tests/generic/275 b/tests/generic/275
index a934c19c..adc82856 100755
--- a/tests/generic/275
+++ b/tests/generic/275
@@ -73,7 +73,7 @@ echo "Bytes written until ENOSPC:" >>$seqres.full
 du $SCRATCH_MNT/tmp1 >>$seqres.full
 
 # And at least some of it should succeed.
-_filesize=`ls -l $SCRATCH_MNT/tmp1 | awk '{print $5}'`
+_filesize=`_get_filesize $SCRATCH_MNT/tmp1`
 [ $_filesize -lt $((128 * 1024)) ] && \
 	_fail "Partial write until enospc failed; wrote $_filesize bytes."
 
diff --git a/tests/generic/315 b/tests/generic/315
index fd49b579..808d7d74 100755
--- a/tests/generic/315
+++ b/tests/generic/315
@@ -52,7 +52,7 @@ $XFS_IO_PROG -f -c 'falloc -k 0 $(($avail_begin/2))' \
 	$TEST_DIR/testfile.$seq >>$seqres.full 2>&1
 
 # Verify the file size, it should keep unchanged as 0 in this case
-fsize=`ls -l $TEST_DIR/testfile.$seq | awk '{print $5}'`
+fsize=`_get_filesize $TEST_DIR/testfile.$seq`
 [ "$fsize" -eq 0 ] || _fail "File size is changed to ($fsize Bytes)"
 
 # Truncate the file size back to 0
-- 
2.18.0.rc1

