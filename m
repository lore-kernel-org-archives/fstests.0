Return-Path: <SRS0=chfm=ZG=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA9EC432C3
	for <linux-fstests@archiver.kernel.org>; Thu, 14 Nov 2019 14:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961D620718
	for <linux-fstests@archiver.kernel.org>; Thu, 14 Nov 2019 14:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMXflQd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKNOBu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:01:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59005 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726374AbfKNOBu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Nov 2019 09:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573740108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LXzBSabGasL5wWWG90ENPDVy8Gflx7Hh7nvY//+h5W8=;
        b=BMXflQd309Ki0yS46mfXoN7Jo/Bugr3DuUulwTu4eEyWfC5l7359MYn46feM5d0N4xUp3b
        qP0cSkJBYu6WqL2/+weS/ylsaPmKOA8SMh5ZGqTHO8yTPdoHqUTab9ua3FkpbzKmNsDofi
        LRr/57yQNpTzOKzlOTq5P3fA+Q8Wro8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-hxQlZ5BtPCi8Ow03OjbUlw-1; Thu, 14 Nov 2019 09:01:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E354800C77
        for <fstests@vger.kernel.org>; Thu, 14 Nov 2019 14:01:46 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 107181081172
        for <fstests@vger.kernel.org>; Thu, 14 Nov 2019 14:01:44 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/563.out: fix the wrong case number in golden image
Date:   Thu, 14 Nov 2019 22:01:38 +0800
Message-Id: <20191114140138.9299-1-zlang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: hxQlZ5BtPCi8Ow03OjbUlw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The first line of generic/563.out is wrong, the number should be 563,
not 011. This mismatch will always cause testing fail.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/generic/563.out | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/563.out b/tests/generic/563.out
index 277f4bcb..29bfbf53 100644
--- a/tests/generic/563.out
+++ b/tests/generic/563.out
@@ -1,4 +1,4 @@
-QA output created by 011
+QA output created by 563
 read/write
 read is in range
 write is in range
--=20
2.20.1

