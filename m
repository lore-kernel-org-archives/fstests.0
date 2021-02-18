Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC521C433DB
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Feb 2021 09:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B4C864DE8
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Feb 2021 09:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhBRJBj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Feb 2021 04:01:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231415AbhBRI70 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Feb 2021 03:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613638680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=cPyBoiBLIiJ44JwDZcz6d7DWybQT2h9m5ZCw3ye7qPk=;
        b=ZFQl0Nt/ca/tOaYF3/s5pjBHYNHvItC9/k1ARzHd4qJhtjBvg2EHYNUz0Vn2hAHZuEJitp
        4RmqjyyTI/3GKVHZUzrQ0s/97yI8QRSM8ZcG63bWWRVh8tlwUszABX1jZCznB4sXGkZoKY
        MpfO6q1eGVfrygsczKoR4nZf98TybeI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-p97VvGwOMvmFwMvM1ADy7Q-1; Thu, 18 Feb 2021 03:57:58 -0500
X-MC-Unique: p97VvGwOMvmFwMvM1ADy7Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8428192AB7E
        for <fstests@vger.kernel.org>; Thu, 18 Feb 2021 08:57:57 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.60.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E86C36F134;
        Thu, 18 Feb 2021 08:57:56 +0000 (UTC)
From:   XiaoLi Feng <xifeng@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Xiaoli Feng <xifeng@redhat.com>
Subject: [PATCH v3] common/rc: add filter in _test_inode_flag
Date:   Thu, 18 Feb 2021 16:57:52 +0800
Message-Id: <20210218085752.24123-1-xifeng@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Xiaoli Feng <xifeng@redhat.com>

Add _filter_testdir_and_scratch to avoid _test_inode_flag failed when
mount point contains flag string.

Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 649b1cfd..473188c1 100644
--- a/common/rc
+++ b/common/rc
@@ -3112,7 +3112,7 @@ _test_inode_flag()
 	local flag=$1
 	local file=$2
 
-	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | grep -q "$flag" ; then
+	if $XFS_IO_PROG -r -c 'lsattr -v' "$file" | _filter_testdir_and_scratch | grep -q "$flag" ; then
 		return 0
 	fi
 	return 1
-- 
2.18.1

