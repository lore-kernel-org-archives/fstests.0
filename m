Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759C3C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 10 Mar 2022 11:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiCJLTw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 10 Mar 2022 06:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbiCJLTv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 10 Mar 2022 06:19:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1054141E27
        for <fstests@vger.kernel.org>; Thu, 10 Mar 2022 03:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646911128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fOUv8CC9l4kKtWYoKy5/qqT0gB/kMD/AVP13pr2+r9g=;
        b=HF7I0o+WMLlzJ2BisG8+4rqHa/AY2nSlOuYmI+dloI8eaflydLQ2Svi5xGxZY7D9e9GXQC
        z6uWyLs7qUU3CzzQEtTYZtsyiIPeW0/a85DwbrRcle+H84TOgTOESnSoFiGkHDNuNkhaQ/
        oOrMRClNhh6B/f2OoSliFhNtoR5mH78=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-1TW1XfknNWaOxgvMtNWZow-1; Thu, 10 Mar 2022 06:18:48 -0500
X-MC-Unique: 1TW1XfknNWaOxgvMtNWZow-1
Received: by mail-ed1-f72.google.com with SMTP id n11-20020a50cc4b000000b00415e939bf9eso2908380edi.22
        for <fstests@vger.kernel.org>; Thu, 10 Mar 2022 03:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fOUv8CC9l4kKtWYoKy5/qqT0gB/kMD/AVP13pr2+r9g=;
        b=Gz7DKiDDXWtU7BfDOT+5kYKXrZhTKka2KJCE/6TLYJ9CQMVs/yfaJ7FlJIErQnfE8x
         UZpf18lWm6+MK7meQuFEPhE61D8wYtf0AnGKjMCQist1uN6LtrsA4OPA27NiAxZlsZvL
         AKOZHuhubX2infSNvoGIydPxDUM33RHkHCAmbz8+N/q5UDc5eZHRTN8t/iC3pD8+sW2S
         G0+bAeB+bm63sjiH591NhalIVAxciTjxYzr76NTLDXtBhVz2lenHkRn/QrqXAG6y8Oxz
         G2xvptVWHgHZ3eybYcmRyhSGbHCCuy20vWPbF/hSMoEZOodyikmMEfJAicl3ziRvFN3J
         /DAQ==
X-Gm-Message-State: AOAM531cFemdLALi/cRr1xxVbGa1eq1c7sPD5h5gl8yAygrt/wefkI0e
        mtt5XhIQvyryxyLai2zEWjtu/iCuRudOWhp74FhegNeKI8hCO/8zhDYfE7f5ECxjOoVW/7VvDgD
        RRolVBAlvLcaDP3YTcM9tpu0FzoFYiDdfgPdjCtklBWbRPMn+8+X3aeVQwvgYnekd6+BK
X-Received: by 2002:a05:6402:2548:b0:416:4155:e12 with SMTP id l8-20020a056402254800b0041641550e12mr3829057edb.175.1646911126483;
        Thu, 10 Mar 2022 03:18:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw75CsCHKzpRnarSxMAdtQaPtOT39UmBmL5GDZu1W9I68rlat84LhBMaUL6IlXc7zLeMoxJHQ==
X-Received: by 2002:a05:6402:2548:b0:416:4155:e12 with SMTP id l8-20020a056402254800b0041641550e12mr3829038edb.175.1646911126142;
        Thu, 10 Mar 2022 03:18:46 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id q12-20020a1709060e4c00b006db01e2c29asm1655701eji.211.2022.03.10.03.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 03:18:45 -0800 (PST)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH] ext4/053: check that remount with abort makes fs read-only
Date:   Thu, 10 Mar 2022 12:18:11 +0100
Message-Id: <20220310111810.14543-1-aalbersh@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The 6e47a3cc68fc ("ext4: get rid of super block and sbi from
handle_mount_ops()") broke abort mount option. That problem was not
detected by ext4/053.

This addition test checks that during aborted remount, filesystem
switches into read-only state (enabled by ext4_handle_error()
causing mount to fail).

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 tests/ext4/053 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/ext4/053 b/tests/ext4/053
index e1e79592..38f162a9 100755
--- a/tests/ext4/053
+++ b/tests/ext4/053
@@ -360,6 +360,10 @@ not_remount() {
 	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
 }
 
+mnt_not_remount() {
+	do_mnt
+	not_remount -r $@
+}
 
 do_mkfs() {
 	$MKE2FS_PROG -T $fstype -Fq $* >> $seqres.full 2>&1 ||
@@ -450,6 +454,7 @@ for fstype in ext2 ext3 ext4; do
 	only_ext4 mnt nojournal_checksum
 	only_ext4 mnt journal_async_commit,data=writeback
 	mnt abort ignored
+	mnt_not_remount abort ignored
 	not_ext2 mnt -t data=journal
 	not_ext2 mnt -t data=ordered
 	not_ext2 mnt -t data=writeback
-- 
2.27.0

