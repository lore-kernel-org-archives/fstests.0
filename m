Return-Path: <SRS0=YkYO=DB=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2EEC4363D
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Sep 2020 18:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46AE32220C
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Sep 2020 18:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcFtPM11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgIXSVZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 24 Sep 2020 14:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727753AbgIXSVZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 Sep 2020 14:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600971685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ShEiDSWPZQcOz+8R0fv1HYxfB96St3TO6+vfxlfKl4M=;
        b=dcFtPM11/1vMBISKTIB+VCB1flYdJF0ffHHu/TsPxaCfT0FN+9p3iWdRdHEKtiiQjQCOuU
        GtWvdBIa7/lIkxSuAWQnB1wjWFPCNRmhg3n7hegKM9ziThe92nqWzjRalTBAiiix7PeW9J
        H+egLQA7dPWtUoCmpZxRFO1B+0KZoBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-G7Q_OIH7ODaaH8ky5g0pkg-1; Thu, 24 Sep 2020 14:21:23 -0400
X-MC-Unique: G7Q_OIH7ODaaH8ky5g0pkg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 567A31868434
        for <fstests@vger.kernel.org>; Thu, 24 Sep 2020 18:21:22 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06C9A5D9D3
        for <fstests@vger.kernel.org>; Thu, 24 Sep 2020 18:21:21 +0000 (UTC)
To:     fstests@vger.kernel.org
From:   Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] src/t_mmap_dio: do not build if !HAVE_AIO
Message-ID: <a11d5ba4-9479-112a-cc82-694e4abc02a4@redhat.com>
Date:   Thu, 24 Sep 2020 13:21:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

We have a config check for libaio headers, and don't build certain
tools if it is not present, but this one was missed.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/src/Makefile b/src/Makefile
index 643c1916..020e1dc9 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -13,7 +13,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	godown resvtest writemod writev_on_pagefault makeextents itrash rename \
 	multi_open_unlink dmiperf unwritten_sync genhashnames t_holes \
 	t_mmap_writev t_truncate_cmtime dirhash_collide t_rename_overwrite \
-	holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
+	holetest t_truncate_self af_unix t_mmap_stale_pmd \
 	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
 	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
 	t_ofd_locks t_mmap_collision mmap-write-concurrent \
@@ -61,6 +61,7 @@ LLDLIBS += $(LIBGDBM)
 endif
 
 ifeq ($(HAVE_AIO), true)
+TARGETS += t_mmap_dio
 SUBDIRS += aio-dio-regress
 LLDLIBS += -laio
 endif

