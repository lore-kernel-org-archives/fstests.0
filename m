Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FEEECAAA1
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Oct 2022 09:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJXJff (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Oct 2022 05:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJXJfc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Oct 2022 05:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B2736DC5
        for <fstests@vger.kernel.org>; Mon, 24 Oct 2022 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666604131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xQDsfABEzS9MnHARa8GrAEDLo8ByohZJlP/QnpDA4M8=;
        b=fRIJnpL6QNmQLwul58boIcfNuDlz+9pzyTRXjuQpUXMtgJNLhHZH/xbZs82O3xaLAhEqp3
        6vzVncuL0k5YHVSRu8Lo9SbIEylBoHkpPdmgmWqypXeze8XNW1N7CEwGq+TgDUZIZEBPeO
        3u4UcfE2r8Zi+/nYe0U41YvSF7z6eEc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-ERbDqS-bMfGfZAag-63DcA-1; Mon, 24 Oct 2022 05:35:26 -0400
X-MC-Unique: ERbDqS-bMfGfZAag-63DcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5BA885A583
        for <fstests@vger.kernel.org>; Mon, 24 Oct 2022 09:35:25 +0000 (UTC)
Received: from ovpn-194-158.brq.redhat.com (ovpn-194-158.brq.redhat.com [10.40.194.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62551C15BA4
        for <fstests@vger.kernel.org>; Mon, 24 Oct 2022 09:35:25 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] tests: Add missing _require_odirect from generic tests
Date:   Mon, 24 Oct 2022 11:35:24 +0200
Message-Id: <20221024093524.15796-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 tests/generic/219 | 1 +
 tests/generic/252 | 1 +
 tests/generic/446 | 1 +
 tests/generic/459 | 1 +
 tests/generic/569 | 1 +
 tests/generic/570 | 1 +
 tests/generic/587 | 1 +
 7 files changed, 7 insertions(+)

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
diff --git a/tests/generic/252 b/tests/generic/252
index 8c5adb53..b35833ba 100755
--- a/tests/generic/252
+++ b/tests/generic/252
@@ -27,6 +27,7 @@ _require_scratch
 _require_dm_target error
 _require_xfs_io_command "falloc"
 _require_aiodio "aiocp"
+_require_odirect
 AIO_TEST="$here/src/aio-dio-regress/aiocp"
 
 # Disable the scratch rt device to avoid test failures relating to the rt
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

