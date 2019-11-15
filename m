Return-Path: <SRS0=+cBI=ZH=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944C8C43215
	for <linux-fstests@archiver.kernel.org>; Fri, 15 Nov 2019 14:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D576207FA
	for <linux-fstests@archiver.kernel.org>; Fri, 15 Nov 2019 14:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqSJXtqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfKOOm6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:42:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48228 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727427AbfKOOm6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 15 Nov 2019 09:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573828977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vjDem+84JBsVsG8qUzXknuqHWKp4AzZyoV+bxCf3pt0=;
        b=EqSJXtqa84aF1XmVNyLPUPoHPSUh+Z/oaNXizgiSEKnYc8Eo81Bu2B3x3RcTd6fXYF/nsz
        EAthm9mCnOwy28re/wHa8zQChRwRVOUW9ru0AU5Lq86N7Rd16HAJ885o5OZt1/B7+vk+Kk
        j2Q59bTX3jPX/H+Cc8hdkd2PZdDDFBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-trexYejhOwOWnZ6Z-FGppg-1; Fri, 15 Nov 2019 09:42:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48220477
        for <fstests@vger.kernel.org>; Fri, 15 Nov 2019 14:42:55 +0000 (UTC)
Received: from dhcp-12-126.nay.redhat.com (dhcp-12-126.nay.redhat.com [10.66.12.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 393776049E;
        Fri, 15 Nov 2019 14:42:53 +0000 (UTC)
From:   XiaoLi Feng <xifeng@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Xiaoli Feng <xifeng@redhat.com>
Subject: [PATCH v1] ext4/031: use _try_scratch_mount instead of _scratch_mount
Date:   Fri, 15 Nov 2019 22:42:48 +0800
Message-Id: <20191115144248.477-1-xifeng@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: trexYejhOwOWnZ6Z-FGppg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Xiaoli Feng <xifeng@redhat.com>

Here will check the return code of mount option. So update it
to use _try_scratch_mount.

Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
---
 tests/ext4/031 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/031 b/tests/ext4/031
index 53770f03..dc58214e 100755
--- a/tests/ext4/031
+++ b/tests/ext4/031
@@ -53,7 +53,7 @@ echo "Need to make some inline data..." > $TESTFILE
 export MOUNT_OPTIONS=3D"$SAVE_MOUNT_OPTIONS"
=20
 _scratch_unmount >> $seqres.full 2>&1
-_scratch_mount "-o dax" >> $seqres.full 2>&1
+_try_scratch_mount "-o dax" >> $seqres.full 2>&1
=20
 if [[ $? !=3D 0 ]]; then
 =09# _require_scratch_dax already verified that we could mount with DAX.
--=20
2.18.1

