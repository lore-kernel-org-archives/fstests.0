Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2FCC433B4
	for <linux-fstests@archiver.kernel.org>; Sat, 17 Apr 2021 16:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D005861245
	for <linux-fstests@archiver.kernel.org>; Sat, 17 Apr 2021 16:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbhDQQrb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 17 Apr 2021 12:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236537AbhDQQrb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 17 Apr 2021 12:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618678024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QV7/7nc96+0utVzezemGAOG/wx3PCduUP5l0VD1KnUw=;
        b=UQvuhOw0BYS7BWbWFqVYSwyBni36tkkEOpK/Ce/oFV50OZ6dMw1ezOCnSXKCQcqBdj0lYa
        S7I7usFz2wp2ESDmTpuejfiwE5JH0+oDpu5unNCVVWJqhmZ2OWS7ttMUPClYWa+dnXPsCi
        tvwkf0Ye1SCbjpkz3Gkq+3+JIrp1mno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-YG3Imdi4PhiWiOKSNeiOFw-1; Sat, 17 Apr 2021 12:47:02 -0400
X-MC-Unique: YG3Imdi4PhiWiOKSNeiOFw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9A3F1898297
        for <fstests@vger.kernel.org>; Sat, 17 Apr 2021 16:47:01 +0000 (UTC)
Received: from hp-dl385pg8-01.rhts.eng.pek2.redhat.com (hp-dl385pg8-01.rhts.eng.pek2.redhat.com [10.73.4.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C19A5D9C0;
        Sat, 17 Apr 2021 16:46:57 +0000 (UTC)
From:   xifeng@redhat.com
To:     fstests@vger.kernel.org
Cc:     xifeng@redhat.com,
        root <root@hp-dl385pg8-01.rhts.eng.pek2.redhat.com>
Subject: [PATCH v1] common/rc: not run swapfile test for DAX
Date:   Sat, 17 Apr 2021 12:46:55 -0400
Message-Id: <20210417164655.64065-1-xifeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: root <root@hp-dl385pg8-01.rhts.eng.pek2.redhat.com>

DAX doesn't support swapfile. Without this patch,
_require_scratch_swapfile always returns fail for fsdax. Now
change to notrun.

Signed-off-by: root <root@hp-dl385pg8-01.rhts.eng.pek2.redhat.com>
---
 common/rc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 23f86ce6..d02b9f72 100644
--- a/common/rc
+++ b/common/rc
@@ -2384,7 +2384,11 @@ _require_scratch_swapfile()
 	ext2|ext3|ext4|xfs)
 		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
 			_scratch_unmount
-			_fail "swapon failed for $FSTYP"
+			if _normalize_mount_options | egrep -q "dax(=always| |$)"; then
+				_notrun "swapfiles are not supported"
+			else
+				_fail "swapon failed for $FSTYP"
+			fi
 		fi
 		;;
 	*)
-- 
2.27.0

