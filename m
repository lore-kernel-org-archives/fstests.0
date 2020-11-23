Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC67C2D0E4
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Nov 2020 06:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726242073C
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Nov 2020 06:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrAw54RS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgKWGZh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 23 Nov 2020 01:25:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26518 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbgKWGZh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Nov 2020 01:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606112736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=WIujW8jhupNyKkdFskFcDgCMu8Ew61Lg7reBLmAMnaQ=;
        b=CrAw54RS4mXSyGHXDTdRAXSHHBrotI5wyDgKIby+yRjZp17pwxkVSkvpmkun8smQJH3oeQ
        tvVfB8DR69j9MryEwfxKBs6ugxck2d0neAknIdhhv1JbfQzYxCbmN+xf4iBqE0s99Rh6Nd
        GapiywwKePzu1c7IUekVAF39V0k/+A4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-TLy2KSYmOQSpB4wSUTwiow-1; Mon, 23 Nov 2020 01:25:31 -0500
X-MC-Unique: TLy2KSYmOQSpB4wSUTwiow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B1F18144E3
        for <fstests@vger.kernel.org>; Mon, 23 Nov 2020 06:25:30 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.60.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 903551000232;
        Mon, 23 Nov 2020 06:25:29 +0000 (UTC)
From:   XiaoLi Feng <xifeng@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Xiaoli Feng <xifeng@redhat.com>
Subject: [PATCH] common/rc: add _filter_scratch in _test_inode_flag
Date:   Mon, 23 Nov 2020 14:25:26 +0800
Message-Id: <20201123062526.18465-1-xifeng@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Xiaoli Feng <xifeng@redhat.com>

Avoid the invalid failure when the path of file include test flag.

Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index b5a504e0..04080331 100644
--- a/common/rc
+++ b/common/rc
@@ -3069,7 +3069,7 @@ _test_inode_flag()
 	local flag=$1
 	local file=$2
 
-	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | grep -q "$flag" ; then
+	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | _filter_scratch | grep -q "$flag" ; then
 		return 0
 	fi
 	return 1
-- 
2.18.1

