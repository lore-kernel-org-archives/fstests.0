Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833A5C4361B
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Dec 2020 14:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 509A423B42
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Dec 2020 14:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgLIOJT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:09:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728822AbgLIOJL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Dec 2020 09:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607522865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ipp3HD1RC/v2FtiHNwc0ZOmzpOckM750TzFUhzhbYLI=;
        b=W23fdx6Yz6/ceu4rsyqlwceKmAs1OetGEKzKBx9igInjUgyJ1VMo8XuYh5harpFCsz1zRq
        Ofv69oT/K4lzcDQHedQJVHo9wWwPTvlV1RE+6SRy1xoOgLIYw5uXLDoExcCHJnerrBCtY/
        OPbKc0nI8J0M8L94gXFVhbC9cRqpcwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-SRG055BXPgO86sn4i3IuQA-1; Wed, 09 Dec 2020 09:07:43 -0500
X-MC-Unique: SRG055BXPgO86sn4i3IuQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F10E10054FF
        for <fstests@vger.kernel.org>; Wed,  9 Dec 2020 14:07:42 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-12-181.pek2.redhat.com [10.72.12.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D59B60BF3
        for <fstests@vger.kernel.org>; Wed,  9 Dec 2020 14:07:41 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] common/rc: filter uncertain stat error output
Date:   Wed,  9 Dec 2020 22:07:38 +0800
Message-Id: <20201209140738.1057460-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The xfs/348 start to fail with latest coreutils' stat command, the
mismatched part likes below:

  -stat: cannot stat 'SCRATCH_MNT/test/DIR': Structure needs cleaning
  +stat: cannot statx 'SCRATCH_MNT/test/DIR': Structure needs cleaning

So filter 'statx' to 'stat' to prevent the golden image broken.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 common/rc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/rc b/common/rc
index b5a504e0..95def920 100644
--- a/common/rc
+++ b/common/rc
@@ -4345,6 +4345,12 @@ _getcap()
 	return ${PIPESTATUS[0]}
 }
 
+stat()
+{
+	# filter uncertain "statx/stat" error output
+	command stat $@ 2> >(sed -e 's/statx/stat/' >&2)
+}
+
 init_rc
 
 ################################################################################
-- 
2.25.4

