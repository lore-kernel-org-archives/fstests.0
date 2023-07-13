Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED528C001DD
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Jul 2023 16:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjGMQCM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Jul 2023 12:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjGMQB4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Jul 2023 12:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ACD2702
        for <fstests@vger.kernel.org>; Thu, 13 Jul 2023 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689264061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=NsPUKDa7JreJw2Oh4v0Y8kH8DgIeOpkzBAJrq4GAkRY=;
        b=h9peUM5fzp4IlC/pkIMB6TOSYAmbomegdJLXF5H18HlIliaCPFVyR135exy7Huz+CK063Z
        7+JbUYGU/yjfN60LOmVNHqisvwxdXbpdNJcvayUw6WVhjKi/fjUSjbwXauyNwv7soo2uqs
        KDa7xgNm/91Jy+Fd2yuhVjaY3O7sz+k=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-r2CrefthN6C35bvFRuO9og-1; Thu, 13 Jul 2023 12:00:29 -0400
X-MC-Unique: r2CrefthN6C35bvFRuO9og-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABBA53C100A0;
        Thu, 13 Jul 2023 16:00:28 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4282200AD6E;
        Thu, 13 Jul 2023 16:00:28 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 950523096A42; Thu, 13 Jul 2023 16:00:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 9368E3F7CF;
        Thu, 13 Jul 2023 18:00:28 +0200 (CEST)
Date:   Thu, 13 Jul 2023 18:00:28 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
cc:     Zorro Lang <zlang@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: [PATCH] bcachefs: mark bch_inode_info and bkey_cached as
 reclaimable
Message-ID: <ea7fe56-dbac-27b8-33cc-5c722f366e63@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Mark these caches as reclaimable, so that available memory is correctly
reported when there is a lot of cached inodes.

Note that more work is needed - you should add __GFP_RECLAIMABLE to some 
of the kmalloc calls, so that they are allocated from the "kmalloc-rcl-*" 
caches.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 fs/bcachefs/btree_key_cache.c |    2 +-
 fs/bcachefs/fs.c              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: bcachefs/fs/bcachefs/btree_key_cache.c
===================================================================
--- bcachefs.orig/fs/bcachefs/btree_key_cache.c
+++ bcachefs/fs/bcachefs/btree_key_cache.c
@@ -1079,7 +1079,7 @@ void bch2_btree_key_cache_exit(void)
 
 int __init bch2_btree_key_cache_init(void)
 {
-	bch2_key_cache = KMEM_CACHE(bkey_cached, 0);
+	bch2_key_cache = KMEM_CACHE(bkey_cached, SLAB_RECLAIM_ACCOUNT);
 	if (!bch2_key_cache)
 		return -ENOMEM;
 
Index: bcachefs/fs/bcachefs/fs.c
===================================================================
--- bcachefs.orig/fs/bcachefs/fs.c
+++ bcachefs/fs/bcachefs/fs.c
@@ -1926,7 +1926,7 @@ int __init bch2_vfs_init(void)
 {
 	int ret = -ENOMEM;
 
-	bch2_inode_cache = KMEM_CACHE(bch_inode_info, 0);
+	bch2_inode_cache = KMEM_CACHE(bch_inode_info, SLAB_RECLAIM_ACCOUNT);
 	if (!bch2_inode_cache)
 		goto err;
 

