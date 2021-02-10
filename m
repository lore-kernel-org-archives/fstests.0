Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E965FC433DB
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Feb 2021 07:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A91EF64E3B
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Feb 2021 07:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhBJH7t (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 10 Feb 2021 02:59:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233070AbhBJH7t (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2021 02:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612943902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ALJ/zWkKd1QV1sjj4ZKo+GUp4e26mg5al//EQexzvzQ=;
        b=G0tWcQSdCHXOT7QKZ/RCXIPRPf2B4XWUmIFgzkFKrcgpXFtr+cCXjs9CvUIyzv4rFoNTPl
        iGfCDRFeRZ91QOwqw0IlITEy3Qxj5nf6BpzvdRJlLroaF552Y6TZvpz0EkLPzF9YyaEjJw
        XwLPzzK3BBah/TXees2PUget+Q1oMDw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-iGkPO15YN2y69a8u09jzCg-1; Wed, 10 Feb 2021 02:58:20 -0500
X-MC-Unique: iGkPO15YN2y69a8u09jzCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6837A107ACE3;
        Wed, 10 Feb 2021 07:58:19 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.60.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C40CC7086A;
        Wed, 10 Feb 2021 07:58:17 +0000 (UTC)
From:   XiaoLi Feng <xifeng@redhat.com>
To:     fstests@vger.kernel.org
Cc:     yangx.jy@cn.fujitsu.com, darrick.wong@oracle.com,
        Xiaoli Feng <xifeng@redhat.com>
Subject: [PATCH v2] generic/608: verify S_DAX is active immediately for DONTCACHE
Date:   Wed, 10 Feb 2021 15:58:15 +0800
Message-Id: <20210210075815.13958-1-xifeng@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Xiaoli Feng <xifeng@redhat.com>

After upstream linux patches(77573fa310d, 88149082bb8), if
FS_XFLAG_DAX is set, DONTCACHE is also set. So S_DAX on the file
should be active immediately once FS_XFLAG_DAX is set.
---
 tests/generic/608 | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/tests/generic/608 b/tests/generic/608
index dd89d91c..92f368e0 100755
--- a/tests/generic/608
+++ b/tests/generic/608
@@ -6,7 +6,7 @@
 # Change FS_XFLAG_DAX on an existing file and check if S_DAX on
 # the file can take effect immediately by the following steps:
 # 1) Stop all applications which are using the file.
-# 2) Do drop_caches or umount & mount cycle.
+# 2) DONTCACHE is set.
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
@@ -36,7 +36,7 @@ _require_dax_iflag
 _require_xfs_io_command "lsattr" "-v"
 _require_xfs_io_command "statx" "-r"
 
-test_drop_caches()
+test_caches()
 {
 	local t_file=$SCRATCH_MNT/testfile
 
@@ -51,56 +51,40 @@ test_drop_caches()
 	_check_xflag $t_file 1
 	_check_s_dax $t_file 0
 
-	# One application is using test file and check if S_DAX on
-	# the file doesn't take effect immediately by drop_caches
-	echo 2 > /proc/sys/vm/drop_caches
-	_check_s_dax $t_file 0
-
 	exec 3<&-
 
 	# No application is using test file and check if S_DAX on
 	# the file takes effect immediately by drop_caches
-	echo 2 > /proc/sys/vm/drop_caches
 	_check_s_dax $t_file 1
 }
 
-test_cycle_mount()
+test_nocache()
 {
-	local option=$1
-	local t_dir=$SCRATCH_MNT/testdir
-	local t_file=$t_dir/testfile
+	local t_file=$SCRATCH_MNT/testnocache
 
-	mkdir -p $t_dir
-	$XFS_IO_PROG -c 'chattr +x' $t_dir
 	rm -f $t_file
 	touch $t_file
+	_check_xflag $t_file 0
+	_check_s_dax $t_file 0
+
+	$XFS_IO_PROG -c 'chattr +x' $t_file
 	_check_xflag $t_file 1
 	_check_s_dax $t_file 1
 
-	exec 3< $t_file
-
 	$XFS_IO_PROG -c 'chattr -x' $t_file
 	_check_xflag $t_file 0
-	_check_s_dax $t_file 1
-
-	exec 3<&-
-
-	# No application is using test file and check if S_DAX on
-	# the file takes effect immediately by umount & mount
-	_scratch_cycle_mount "$option"
 	_check_s_dax $t_file 0
 }
 
 do_tests()
 {
 	local mount_option=$1
-	local cycle_mount_option=$2
 
 	_scratch_mount "$mount_option"
 
-	test_drop_caches
+	test_caches
 
-	test_cycle_mount "$cycle_mount_option"
+	test_nocache
 
 	_scratch_unmount
 }
@@ -108,7 +92,7 @@ do_tests()
 _scratch_mkfs >> $seqres.full 2>&1
 
 # Mount with dax option
-do_tests "-o dax=inode" "dax=inode"
+do_tests "-o dax=inode"
 
 # Mount without dax option
 export MOUNT_OPTIONS=""
-- 
2.18.1

