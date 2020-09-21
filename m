Return-Path: <SRS0=Zf7U=C6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56F2C43464
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 04:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6285B2085B
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 04:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKDFwnAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgIUEbx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Sep 2020 00:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52286 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726011AbgIUEbx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Sep 2020 00:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600662712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CNX23uHYr3lFnjJMu77aiM1cipkze/wJ+JFtt7pB/Es=;
        b=fKDFwnAluYvn2ULpwrDXUzLt6nnXACDbP+P2PGpseJbeIXlKpXqFpH/XwfOU+6OFAhWRhQ
        roTvnH214OJ6zlUntSthbuK2N8yCCiAzkKfC59nT8zik1O/krooKvc1ue7VjCOiVem4Qw/
        LqdqmeQmfC/IypEE97tDt2QusqDnohk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-fKGNEIfEOUqetg8GvoiAaA-1; Mon, 21 Sep 2020 00:31:49 -0400
X-MC-Unique: fKGNEIfEOUqetg8GvoiAaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA8DA56B36
        for <fstests@vger.kernel.org>; Mon, 21 Sep 2020 04:31:48 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-13-221.pek2.redhat.com [10.72.13.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDF9A5C1DC
        for <fstests@vger.kernel.org>; Mon, 21 Sep 2020 04:31:47 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/611: remove _supported_os line
Date:   Mon, 21 Sep 2020 12:31:44 +0800
Message-Id: <20200921043144.8057-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The current xfstests doesn't support _supported_os() function, the
generic/611 always hit an error:

  xfstests-dev/tests/generic/611: line 39: _supported_os: command not found

So remove the "_supported_os Linux" line directly.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/generic/611 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/generic/611 b/tests/generic/611
index 069db6f9..f4158bb3 100755
--- a/tests/generic/611
+++ b/tests/generic/611
@@ -36,7 +36,6 @@ rm -f $seqres.full
 # real QA test starts here
 
 _supported_fs generic
-_supported_os Linux
 _require_scratch
 _require_attrs
 
-- 
2.20.1

