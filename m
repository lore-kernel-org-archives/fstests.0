Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4409BC433E0
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Feb 2021 06:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E120E64EDF
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Feb 2021 06:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhBBGY2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 2 Feb 2021 01:24:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46211 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230084AbhBBGY2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 2 Feb 2021 01:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612246981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sn7r8Xko64VKL8YWO7+L2hRQnRxJT8Oto/bWVoknQew=;
        b=OGlACPpldmfe7ncrBGnkEXrVIFgCeLe/XFPh1q0R+rZ26Hx/vrKFOGfdSq3XuAIAzjUolK
        /r0urXOFMf/6oINnl2LwNlJpi+d3xgRLGzBlh+Zflgm+DEPrWcfSO2pWhs/6ws2vGTw8NV
        tp5jdp2A726R0A+IFM0vqeWIeoo4z6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-ZVJl5-1bP8GhKJX-OLxinw-1; Tue, 02 Feb 2021 01:22:59 -0500
X-MC-Unique: ZVJl5-1bP8GhKJX-OLxinw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69460802B4B
        for <fstests@vger.kernel.org>; Tue,  2 Feb 2021 06:22:58 +0000 (UTC)
Received: from zlang-laptop.redhat.com (ovpn-13-182.pek2.redhat.com [10.72.13.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79CAD27C24
        for <fstests@vger.kernel.org>; Tue,  2 Feb 2021 06:22:57 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/095: don't silence fio error output
Date:   Tue,  2 Feb 2021 14:22:53 +0800
Message-Id: <20210202062253.24478-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This case print both fio stdout and stderr to .full file, that cause
we miss some unexpected failures when there's a bug. For example:

  file:io_u.c:1803, func=io_u error, error=Block device required

This's an regression issue we find on a downstream kernel, not in
upstream. So release unexpected fio error output to find more issues.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/generic/095 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/generic/095 b/tests/generic/095
index 9afaa761..30fe77a5 100755
--- a/tests/generic/095
+++ b/tests/generic/095
@@ -98,8 +98,11 @@ _require_fio $fio_config
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
+# There's a known EIO failure to report collisions between directio and buffered
+# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
+# at here.
+$FIO_PROG $fio_config --ignore_error=,EIO --output=$seqres.full
 echo "Silence is golden"
-$FIO_PROG $fio_config >>$seqres.full 2>&1
 
 # xfs generates WARNINGs on purpose when applications mix buffered/mmap IO with
 # direct IO on the same file. On the other hand, this fio job has been proven
-- 
2.29.2

