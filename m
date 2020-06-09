Return-Path: <SRS0=3iZY=7W=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E35CC433DF
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Jun 2020 08:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6CD2074B
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Jun 2020 08:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZncrMnnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgFIIYv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:24:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20056 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728034AbgFIIYv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 9 Jun 2020 04:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591691090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EgUkEMKxYPeJnPkseqdAKFLouakPdvdseV4cr6inbi8=;
        b=ZncrMnnZJm721Qo/nHQDTqeaQ2yD42apT3ISLXsO14nEG9OwmI/uwSn3EIKu1eXY5GyMy8
        GYisCChh1HeOggBYFeJkYGoaJdSg+InXDpaTF11+wHBRlfo5Bh78faQIC9NXsmXeIzr1Nt
        GAcwABNF4ozR7gFG8WMYx7dKQkll/Sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-12dhoFnSMAeraYkYsLXc8A-1; Tue, 09 Jun 2020 04:24:48 -0400
X-MC-Unique: 12dhoFnSMAeraYkYsLXc8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 216F5464
        for <fstests@vger.kernel.org>; Tue,  9 Jun 2020 08:24:48 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-12-68.pek2.redhat.com [10.72.12.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E18AE7C336
        for <fstests@vger.kernel.org>; Tue,  9 Jun 2020 08:24:46 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] xfs/096: filter out the "Discarding..." output
Date:   Tue,  9 Jun 2020 16:24:42 +0800
Message-Id: <20200609082442.31982-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Latest xfsprogs mkfs.xfs prints "Discarding blocks...Done" if the
disk supports the trim. That breaks the golden image, cause
unexpected failure, so filter out it.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/096 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/xfs/096 b/tests/xfs/096
index ef6136af..04bc7b7d 100755
--- a/tests/xfs/096
+++ b/tests/xfs/096
@@ -78,6 +78,7 @@ mkfs_filter()
 	-e 's/ ftype=[01]//' \
 	-e '/^log stripe unit.*too large/d' \
 	-e '/^log stripe unit adjusted/d' \
+	-e '/Discarding/d' \
    | grep -v parent
 }
 
-- 
2.20.1

