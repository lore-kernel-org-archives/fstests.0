Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F4CC433DB
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Mar 2021 13:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC856505D
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Mar 2021 13:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbhCPNBv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 16 Mar 2021 09:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233062AbhCPNBh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Mar 2021 09:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615899697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/lrR+CywcZ6mrW2xkpIGBO2G01aH1b1hN9LHL9dbdW8=;
        b=Hu8XYXep1++fadtHfv+QDwtNCNzR3MHOC5sqOJjkoO051k3QRFJ3PrOlX8ptSFUg/1lp+I
        fwuZEENxKhMomBMVLePXzlG8yHTwH6QE5+n/K4isVVSUsv03zFCuMYVxJx5QfvXiEhTyVT
        jsGo1i7UtUuyzCJF/xIqY3xlx7mwkPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-KJKcr3cvPWGbtORpwM5Svw-1; Tue, 16 Mar 2021 09:01:35 -0400
X-MC-Unique: KJKcr3cvPWGbtORpwM5Svw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90521800C78
        for <fstests@vger.kernel.org>; Tue, 16 Mar 2021 13:01:33 +0000 (UTC)
Received: from localhost (ovpn-115-92.ams2.redhat.com [10.36.115.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32BA35C1A1;
        Tue, 16 Mar 2021 13:01:33 +0000 (UTC)
From:   Max Reitz <mreitz@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Max Reitz <mreitz@redhat.com>
Subject: [PATCH] common/rc: virtiofs does not support atime options
Date:   Tue, 16 Mar 2021 14:01:31 +0100
Message-Id: <20210316130131.11792-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

As documented in Documentation/filesystems/virtiofs.rst (in the Linux
tree), virtiofs ignores atime-related mount options.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index aea0d076..9fdbcd14 100644
--- a/common/rc
+++ b/common/rc
@@ -3572,7 +3572,7 @@ _require_atime()
 {
 	_exclude_scratch_mount_option "noatime"
 	case $FSTYP in
-	nfs|cifs)
+	nfs|cifs|virtiofs)
 		_notrun "atime related mount options have no effect on $FSTYP"
 		;;
 	esac
-- 
2.29.2

