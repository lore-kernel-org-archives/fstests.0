Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1859EC433E9
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Feb 2021 22:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C015764FE2
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Feb 2021 22:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhBEWM4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:12:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232795AbhBEOkt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 5 Feb 2021 09:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612541888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=cJblKX678JHha852YlH0fEWJ8TS8dMZeYNCkONBYrLY=;
        b=azvyP4xhpr6+7MLEAXPGFqmDOaMY34MTHscHDdCJ0abmvBex+vScCAoQxUobnkv23L6zNI
        RWR99txwYUWbMPfLEdUGxUjMew+TaxHuLXvlzb+cSLotnrbP4YQ9xD6stimC1hdSX0EjUr
        0h7/Z3FMkizCiR9/qeFeS74GP4EF14o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-_pHzmuNFN_-blpNT0SokOg-1; Fri, 05 Feb 2021 09:17:13 -0500
X-MC-Unique: _pHzmuNFN_-blpNT0SokOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D16F107AD28;
        Fri,  5 Feb 2021 14:17:12 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.60.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2BF75DEFA;
        Fri,  5 Feb 2021 14:17:10 +0000 (UTC)
From:   XiaoLi Feng <xifeng@redhat.com>
To:     fstests@vger.kernel.org
Cc:     darrick.wong@oracle.com, yangx.jy@cn.fujitsu.com,
        Xiaoli Feng <xifeng@redhat.com>
Subject: [PATCH v1] generic/608: verify S_DAX is active immediately for DONTCACHE
Date:   Fri,  5 Feb 2021 22:17:08 +0800
Message-Id: <20210205141708.2558-1-xifeng@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Xiaoli Feng <xifeng@redhat.com>

After upstream linux patches(77573fa310d, 88149082bb8), if
FS_XFLAG_DAX is set, DONTCACHE is also set. So S_DAX on the file
should be active immediately once FS_XFLAG_DAX is set.

Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
---
 tests/generic/608 | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/generic/608 b/tests/generic/608
index dd89d91c..278fb4d1 100755
--- a/tests/generic/608
+++ b/tests/generic/608
@@ -7,6 +7,7 @@
 # the file can take effect immediately by the following steps:
 # 1) Stop all applications which are using the file.
 # 2) Do drop_caches or umount & mount cycle.
+# 3) DONTCACHE is set.
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
@@ -91,6 +92,20 @@ test_cycle_mount()
 	_check_s_dax $t_file 0
 }
 
+test_nocache()
+{
+	local t_file=$SCRATCH_MNT/testnocache
+
+	rm -f $t_file
+	touch $t_file
+	_check_xflag $t_file 0
+	_check_s_dax $t_file 0
+
+	$XFS_IO_PROG -c 'chattr +x' $t_file
+	_check_xflag $t_file 1
+	_check_s_dax $t_file 1
+}
+
 do_tests()
 {
 	local mount_option=$1
@@ -100,6 +115,8 @@ do_tests()
 
 	test_drop_caches
 
+	test_nocache
+
 	test_cycle_mount "$cycle_mount_option"
 
 	_scratch_unmount
-- 
2.18.1

