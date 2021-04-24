Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA23C433B4
	for <linux-fstests@archiver.kernel.org>; Sat, 24 Apr 2021 16:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F3961474
	for <linux-fstests@archiver.kernel.org>; Sat, 24 Apr 2021 16:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhDXQQQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 24 Apr 2021 12:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34000 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230010AbhDXQQN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 24 Apr 2021 12:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619280931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=HEi8dkKWCjfE3v76fG9uptB27jL+RpqcLL0n5fJ59yo=;
        b=ZzVFlOCjay4OyupLtJbhN9BLnxe8dQNxHk9dWsEaGHJwWN7VL26w1RFSduu/ga5/eXOIW9
        PL4zxwBn80ZZhQIw0ge0ecM4umJL+xpqCIj06WH5nqIe20/2YvMdJwPDVZxcZOhdilO334
        sxx8S9paug4bk46uNEfrGdGf7TQBArI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-2rPaTYFUPKeN-Wb6KbsYig-1; Sat, 24 Apr 2021 12:15:28 -0400
X-MC-Unique: 2rPaTYFUPKeN-Wb6KbsYig-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 526B487A826;
        Sat, 24 Apr 2021 16:15:27 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.60.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E50C11837A;
        Sat, 24 Apr 2021 16:15:25 +0000 (UTC)
From:   XiaoLi Feng <xifeng@redhat.com>
To:     fstests@vger.kernel.org
Cc:     djwong@kernel.org, Xiaoli Feng <xifeng@redhat.com>
Subject: [PATCH v2] common/rc: not run swapfile test for DAX
Date:   Sun, 25 Apr 2021 00:15:23 +0800
Message-Id: <20210424161523.4786-1-xifeng@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Xiaoli Feng <xifeng@redhat.com>

DAX doesn't support swapfile. Without this patch,
_require_scratch_swapfile always returns fail for fsdax. Now
change to notrun.

Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
---
 common/rc | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 11ff7635..c3c40f30 100644
--- a/common/rc
+++ b/common/rc
@@ -2461,8 +2461,13 @@ _require_scratch_swapfile()
 	case "$FSTYP" in
 	ext2|ext3|ext4|xfs)
 		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
-			_scratch_unmount
-			_fail "swapon failed for $FSTYP"
+			if _check_s_dax "$SCRATCH_MNT/swap" 1 >/dev/null; then
+				_scratch_unmount
+				_notrun "swapfiles are not supported"
+			else
+				_scratch_unmount
+				_fail "swapon failed for $FSTYP"
+			fi
 		fi
 		;;
 	*)
@@ -3326,6 +3331,7 @@ _check_s_dax()
 {
 	local target=$1
 	local exp_s_dax=$2
+	local ret=0
 
 	local attributes=$($XFS_IO_PROG -c 'statx -r' $target | awk '/stat.attributes / { print $3 }')
 
@@ -3347,9 +3353,12 @@ _check_s_dax()
 
 	if [ $exp_s_dax -eq 0 ]; then
 		(( attributes & 0x00200000 )) && echo "$target has unexpected S_DAX flag"
+		(( attributes & 0x00200000 )) && ret=1
 	else
 		(( attributes & 0x00200000 )) || echo "$target doesn't have expected S_DAX flag"
+		(( attributes & 0x00200000 )) || ret=2
 	fi
+	return $ret
 }
 
 _check_xflag()
-- 
2.18.1

