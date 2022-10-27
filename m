Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CA3FA3742
	for <linux-fstests@archiver.kernel.org>; Thu, 27 Oct 2022 10:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbiJ0KvK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 27 Oct 2022 06:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbiJ0KvI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 27 Oct 2022 06:51:08 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B037B2AB
        for <fstests@vger.kernel.org>; Thu, 27 Oct 2022 03:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1666867864; i=@fujitsu.com;
        bh=GE8KNhk5G6h0QHUz6zUBId59+CF7wkXvLuWEJYpeiZY=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=IDDuYgoBA8w2eazRPOFoJ/NOzXKn6PkTM6SqRlYr1heqQ2nfYeDAnC14LZL6qp1Ao
         qBKth7Ttr8NIjc7GAxEpfSn2lXp6soh4adlR2dbapr1HDOjHn7+rwHYzjEMkz6EpbQ
         AifoiZGE+dLm9It9AmMPSjhDodZphxFJWzLb9UMd3zfbY4+kRcsquvUksZk9OxBKzt
         3NajU7TVoR+snCvC9iIuk1zlQA3GEHXzn4KVoQtcckxdERFRnvi9hKgXJcyeewVarl
         fZy88etNDxsNf7SRUF/3Z6lSvWAWneIWUcpKBvjHewF81NOUn9kMHYBJWSjobjyFj/
         OoNOZWXtZDokg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRWlGSWpSXmKPExsViZ8ORqDs9KSr
  Z4M5Pc4vTLXvZLfae3MnqwOTxft9VNo/Pm+QCmKJYM/OS8isSWDM6jy9kLfgkWbHny0vGBsYl
  ol2MXBxCAlsYJXoWL2SFcJYzSfSunszYxcgJ5OxnlGifHAdiswmoSeyc/pIFxBYRkJX4P2M1E
  4jNLGAh0fi6mRXEFhaIkFiy5SIziM0ioCqx6UkTexcjBwevgJPE7hflIGEJAQWJKQ/fg5XwCg
  hKnJz5hAVijITEwRcvmCFqFCXalvxjh7ArJGbNamOCsNUkrp7bxDyBkX8WkvZZSNoXMDKtYjQ
  vTi0qSy3SNTLQSyrKTM8oyU3MzNFLrNJN1Est1c3LLyrJ0DXUSywv1kstLtYrrsxNzknRy0st
  2cQIDM+U4qTEHYx9y/7oHWKU5GBSEuVNZIpKFuJLyk+pzEgszogvKs1JLT7EKMPBoSTB2xYHl
  BMsSk1PrUjLzAHGCkxagoNHSYS3OgYozVtckJhbnJkOkTrFaMxxfuf+vcwcH/9c3MssxJKXn5
  cqJc5rmghUKgBSmlGaBzcIFsOXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzaoNM4cnMK4H
  b9wroFCagU9bMDQM5pSQRISXVwFR7Jlvp193HfNzLhD6yNDaaZRy4vPzc30qfSY+W9M273bxK
  fFVU7+NTiyb1+e3cabA9S11+f/nXyliRhZrr47cli9VtZPmpqM1mYNXIwG6juHpS8QfpNp+62
  SFFUoxODFNmqTfvOPlp45STzp97aizUr4s/KssRsd7wuspr3krm16u/vxJ8WafkuSvHIZDp/h
  3xnlopg6MTXt6e/7xzSt97KUveq6LT2X7x39E2eLTum6/umlXsk+Jdb7X4T00NmsnJcS5qh+L
  WQ+cPF3Ge+3yreKlyb5m6nFWH+r8fB0oPJOvq3/u+aP1OTd09n3QdnZMtvOZsFHvHazczKvau
  5GWm1oT/rmHyf/Ykz37xyEeJpTgj0VCLuag4EQC01CkiXAMAAA==
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-12.tower-728.messagelabs.com!1666867863!515784!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3724 invoked from network); 27 Oct 2022 10:51:03 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-12.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Oct 2022 10:51:03 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 5C13B100187;
        Thu, 27 Oct 2022 11:51:03 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 50220100182;
        Thu, 27 Oct 2022 11:51:03 +0100 (BST)
Received: from 1376b0ab6900.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 27 Oct 2022 11:51:01 +0100
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <zlang@redhat.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH] common/config: Make test and scratch devices use the same mount options
Date:   Thu, 27 Oct 2022 10:50:52 +0000
Message-ID: <1666867852-134-1-git-send-email-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Some cases(e.g. generic/519) check commands/features on test device but
do tests on scratch device.  If some mount options can impact the check
result, these cases may throw error instead if not run when we use
different mount options for test and scratch devices.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 common/config | 65 +++++++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/common/config b/common/config
index 5eaae447..6f428eae 100644
--- a/common/config
+++ b/common/config
@@ -334,89 +334,72 @@ if [ "$FSTYP" == "xfs" ]; then
 	export XFS_MKFS_HAS_NO_META_SUPPORT
 fi
 
-_mount_opts()
+_common_mount_opts()
 {
 	case $FSTYP in
 	9p)
-		export MOUNT_OPTIONS=$PLAN9_MOUNT_OPTIONS
+		echo $PLAN9_MOUNT_OPTIONS
 		;;
 	xfs)
-		export MOUNT_OPTIONS=$XFS_MOUNT_OPTIONS
+		echo $XFS_MOUNT_OPTIONS
 		;;
 	udf)
-		export MOUNT_OPTIONS=$UDF_MOUNT_OPTIONS
+		echo $UDF_MOUNT_OPTIONS
 		;;
 	nfs)
-		export MOUNT_OPTIONS=$NFS_MOUNT_OPTIONS
+		echo $NFS_MOUNT_OPTIONS
 		;;
 	cifs)
-		export MOUNT_OPTIONS=$CIFS_MOUNT_OPTIONS
+		echo $CIFS_MOUNT_OPTIONS
 		;;
 	ceph)
-		export MOUNT_OPTIONS=$CEPHFS_MOUNT_OPTIONS
+		echo $CEPHFS_MOUNT_OPTIONS
 		;;
 	glusterfs)
-		export MOUNT_OPTIONS=$GLUSTERFS_MOUNT_OPTIONS
+		echo $GLUSTERFS_MOUNT_OPTIONS
 		;;
 	overlay)
-		export MOUNT_OPTIONS=$OVERLAY_MOUNT_OPTIONS
+		echo $OVERLAY_MOUNT_OPTIONS
 		;;
 	ext2|ext3|ext4|ext4dev)
 		# acls & xattrs aren't turned on by default on ext$FOO
-		export MOUNT_OPTIONS="-o acl,user_xattr $EXT_MOUNT_OPTIONS"
+		echo "-o acl,user_xattr $EXT_MOUNT_OPTIONS"
 		;;
 	f2fs)
-		export MOUNT_OPTIONS="-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
+		echo "-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
 		;;
 	reiserfs)
 		# acls & xattrs aren't turned on by default on reiserfs
-		export MOUNT_OPTIONS="-o acl,user_xattr $REISERFS_MOUNT_OPTIONS"
+		echo "-o acl,user_xattr $REISERFS_MOUNT_OPTIONS"
 		;;
        reiser4)
-               # acls & xattrs aren't supported by reiser4
-               export MOUNT_OPTIONS=$REISER4_MOUNT_OPTIONS
-               ;;
+		# acls & xattrs aren't supported by reiser4
+		echo $REISER4_MOUNT_OPTIONS
+		;;
 	gfs2)
 		# acls aren't turned on by default on gfs2
-		export MOUNT_OPTIONS="-o acl $GFS2_MOUNT_OPTIONS"
+		echo "-o acl $GFS2_MOUNT_OPTIONS"
 		;;
 	tmpfs)
 		# We need to specify the size at mount, use 1G by default
-		export MOUNT_OPTIONS="-o size=1G $TMPFS_MOUNT_OPTIONS"
+		echo "-o size=1G $TMPFS_MOUNT_OPTIONS"
 		;;
 	ubifs)
-		export MOUNT_OPTIONS=$UBIFS_MOUNT_OPTIONS
+		echo $UBIFS_MOUNT_OPTIONS
 		;;
 	*)
 		;;
 	esac
 }
 
+_mount_opts()
+{
+	export MOUNT_OPTIONS=$(_common_mount_opts)
+}
+
 _test_mount_opts()
 {
-	case $FSTYP in
-	9p)
-		export TEST_FS_MOUNT_OPTS=$PLAN9_MOUNT_OPTIONS
-		;;
-	cifs)
-		export TEST_FS_MOUNT_OPTS=$CIFS_MOUNT_OPTIONS
-		;;
-	ceph)
-		export TEST_FS_MOUNT_OPTS=$CEPHFS_MOUNT_OPTIONS
-		;;
-	nfs)
-		export TEST_FS_MOUNT_OPTS=$NFS_MOUNT_OPTIONS
-		;;
-	glusterfs)
-		export TEST_FS_MOUNT_OPTS=$GLUSTERFS_MOUNT_OPTIONS
-		;;
-	ext2|ext3|ext4|ext4dev)
-		# acls & xattrs aren't turned on by default on older ext$FOO
-		export TEST_FS_MOUNT_OPTS="-o acl,user_xattr $EXT_MOUNT_OPTIONS"
-		;;
-	*)
-		;;
-	esac
+	export TEST_FS_MOUNT_OPTS=$(_common_mount_opts)
 }
 
 _mkfs_opts()
-- 
2.34.1

