Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0030C433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Feb 2021 08:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC3864E25
	for <linux-fstests@archiver.kernel.org>; Wed, 10 Feb 2021 08:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhBJIgL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 10 Feb 2021 03:36:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36888 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229754AbhBJIfm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Feb 2021 03:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612946053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=QngPvtyfaBHMmhcSY2QKHemBq6147RuIyirreoB04Vc=;
        b=R2Nmuhk2DJxq1hm43jPV9JXJKHNsjOvIEZijn7W8Xw4PqWTfTM7mtlDXqqrTd1/QcIhLpf
        vUaDO7raF/lTn2F6odLZGgn1q8e9r22QY3RI0w+2afpPxg37+1kPtQAPVuVBoSkE6ds1i9
        IqFRCZHeqRiAB4Sk6887lZYYkaV+MLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-suAcnGCENrGXMvdAPQnX9Q-1; Wed, 10 Feb 2021 03:34:11 -0500
X-MC-Unique: suAcnGCENrGXMvdAPQnX9Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5D538030BB
        for <fstests@vger.kernel.org>; Wed, 10 Feb 2021 08:34:10 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.60.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1C681820C;
        Wed, 10 Feb 2021 08:34:09 +0000 (UTC)
From:   XiaoLi Feng <xifeng@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Xiaoli Feng <xifeng@redhat.com>
Subject: [PATCH v2] common/rc: add filter in _test_inode_flag
Date:   Wed, 10 Feb 2021 16:34:07 +0800
Message-Id: <20210210083407.19184-1-xifeng@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Xiaoli Feng <xifeng@redhat.com>

Add _filter_scratch and _filter_test_dir to avoid _test_inode_flag failed when
mount point contains flag string.
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 649b1cfd..f3bb665e 100644
--- a/common/rc
+++ b/common/rc
@@ -3112,7 +3112,7 @@ _test_inode_flag()
 	local flag=$1
 	local file=$2
 
-	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | grep -q "$flag" ; then
+	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | _filter_scratch | _filter_test_dir | grep -q "$flag" ; then
 		return 0
 	fi
 	return 1
-- 
2.18.1

