Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7CDC433E6
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Mar 2021 12:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917A664FEC
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Mar 2021 12:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhCKMM0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Mar 2021 07:12:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232910AbhCKMMX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Mar 2021 07:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615464742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZaUSzKMQ/91EP85rlhVLcZxuAl+vcIVUe3l14n8yuJ4=;
        b=Pv7zT+NN9uP+6n5qu41bhoLed0gzGdKl3SNb6op5oGHj2iqr1UBvkl93T/wEWtGgRng+5O
        MiZY1OJhDcxjOmzbhEpjCb0riPDBJJLdEY/HqtZcGH1tNr3bFnnvB7GiHoIVJinUMIDiYT
        pkybBurWCiXqJTD9FGynS4zqpYhHNP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-J3v4SxU_PF6S1o4-NUWWHA-1; Thu, 11 Mar 2021 07:12:19 -0500
X-MC-Unique: J3v4SxU_PF6S1o4-NUWWHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C52708015BD
        for <fstests@vger.kernel.org>; Thu, 11 Mar 2021 12:12:18 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-12-77.pek2.redhat.com [10.72.12.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCF7260853
        for <fstests@vger.kernel.org>; Thu, 11 Mar 2021 12:12:16 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] common/rc: specifically make new xfs in _test_mkfs
Date:   Thu, 11 Mar 2021 20:12:13 +0800
Message-Id: <20210311121213.1348303-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When we test different filesystems with different sections in config
file, always hit below failure:
   ...
   our local _test_mkfs routine ...
   mkfs.xfs: /dev/vdb1 appears to contain an existing filesystem (xfs)
   mkfs.xfs: Use the -f option to force overwrite.
   check: failed to mkfs $TEST_DEV using specified options
   ...

To fix this problem, change the _test_mkfs to deal with xfs creation
properly. Due to xfstests uses _test_mkfs rarely, currently only in
check program, so I don't intend to write a whole new series of
_test_mkfs_xfs_* functions likes what _scratch_mkfs_xfs_* does.

Reported-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 common/rc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/common/rc b/common/rc
index 0ce3cb0d..c783def7 100644
--- a/common/rc
+++ b/common/rc
@@ -258,6 +258,7 @@ _test_options()
 
     case $type in
     mkfs)
+	TEST_OPTIONS="$TEST_OPTIONS -f"
 	rt_opt="-r"
         log_opt="-l"
 	;;
@@ -633,6 +634,15 @@ _test_mkfs()
     ext2|ext3|ext4)
 	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
 	;;
+    xfs)
+	local mkfs_opts=$*
+
+	if [ -n "$XFS_MKFS_HAS_NO_META_SUPPORT" ]; then
+		mkfs_opts=`echo $mkfs_opts | sed "s/-m\s\+\S\+//g"`
+	fi
+	_test_options mkfs
+	$MKFS_XFS_PROG $TEST_OPTIONS $MKFS_OPTIONS $mkfs_opts $TEST_DEV
+	;;
     *)
 	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
 	;;
-- 
2.29.2

