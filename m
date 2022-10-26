Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50301C433FE
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Oct 2022 10:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJZK6x (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Oct 2022 06:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJZK6w (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Oct 2022 06:58:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53B9CBFDB
        for <fstests@vger.kernel.org>; Wed, 26 Oct 2022 03:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666781930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lk3lra9g2oBFL/qcqS+Dw68wcyUEO624Ep0lPS4mY0k=;
        b=ikKg7A++ePmH+hdSRWWsM0Ui3baugxS9f57TG5Odyruw0z9UlpMzhhqjAsocm6cnuN2B04
        4irJD7f6tx36rhCkVNKa1YnFZlIyF2NKCcgx6ajEl3xnN+a0gLONDFEFn6d+NGu5p8FxRi
        LNGVP11csynkCea1JwDHtzMZ3BFAsBA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-ZGRJ-rgRNOSXIokGh8h61A-1; Wed, 26 Oct 2022 06:58:49 -0400
X-MC-Unique: ZGRJ-rgRNOSXIokGh8h61A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E25A1C06902
        for <fstests@vger.kernel.org>; Wed, 26 Oct 2022 10:58:49 +0000 (UTC)
Received: from ovpn-192-204.brq.redhat.com (ovpn-192-204.brq.redhat.com [10.40.192.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBCBC2027064;
        Wed, 26 Oct 2022 10:58:48 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com
Subject: [PATCH v2] tests: Add missing _require_odirect from generic tests
Date:   Wed, 26 Oct 2022 12:58:47 +0200
Message-Id: <20221026105847.21885-1-lczerner@redhat.com>
In-Reply-To: <20221024093524.15796-1-lczerner@redhat.com>
References: <20221024093524.15796-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
v2: generic/252 already has _require_odirect, remove it from patch

 tests/generic/219 | 1 +
 tests/generic/446 | 1 +
 tests/generic/459 | 1 +
 tests/generic/569 | 1 +
 tests/generic/570 | 1 +
 tests/generic/587 | 1 +
 6 files changed, 6 insertions(+)

diff --git a/tests/generic/219 b/tests/generic/219
index d3d257f1..71da25e3 100755
--- a/tests/generic/219
+++ b/tests/generic/219
@@ -20,6 +20,7 @@ _require_scratch
 _require_quota
 _require_user
 _require_group
+_require_odirect
 
 test_files()
 {
diff --git a/tests/generic/446 b/tests/generic/446
index 5f2d2edd..b69502cb 100755
--- a/tests/generic/446
+++ b/tests/generic/446
@@ -21,6 +21,7 @@ _begin_fstest auto quick rw punch
 _require_scratch
 _require_xfs_io_command "truncate"
 _require_xfs_io_command "fpunch"
+_require_odirect
 
 # format and mount
 _scratch_mkfs > $seqres.full 2>&1
diff --git a/tests/generic/459 b/tests/generic/459
index 7be39089..4dd7a43b 100755
--- a/tests/generic/459
+++ b/tests/generic/459
@@ -47,6 +47,7 @@ _require_dm_target snapshot
 _require_command $LVM_PROG lvm
 _require_command "$THIN_CHECK_PROG" thin_check
 _require_freeze
+_require_odirect
 
 vgname=vg_$seq
 lvname=lv_$seq
diff --git a/tests/generic/569 b/tests/generic/569
index c5dcfefe..eeaf3f16 100755
--- a/tests/generic/569
+++ b/tests/generic/569
@@ -25,6 +25,7 @@ _supported_fs generic
 _require_xfs_io_command "falloc"
 _require_test_program swapon
 _require_scratch_swapfile
+_require_odirect
 
 _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
diff --git a/tests/generic/570 b/tests/generic/570
index 126b222d..2143c742 100755
--- a/tests/generic/570
+++ b/tests/generic/570
@@ -25,6 +25,7 @@ _supported_fs generic
 _require_test_program swapon
 _require_scratch_nocheck
 _require_block_device $SCRATCH_DEV
+_require_odirect
 # We cannot create swap on a zoned device because it can cause random write IOs
 _require_non_zoned_device "$SCRATCH_DEV"
 test -e /dev/snapshot && _notrun "userspace hibernation to swap is enabled"
diff --git a/tests/generic/587 b/tests/generic/587
index 19b047ac..ebfeea1d 100755
--- a/tests/generic/587
+++ b/tests/generic/587
@@ -25,6 +25,7 @@ _require_user
 _require_quota
 _require_xfs_io_command "falloc"
 _require_scratch
+_require_odirect
 
 cat > $tmp.awk << ENDL
 {
-- 
2.37.3

