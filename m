Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FC2C433EF
	for <linux-fstests@archiver.kernel.org>; Sat, 21 May 2022 03:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiEUDQa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 May 2022 23:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiEUDQ3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 May 2022 23:16:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4D650E13
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 20:16:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A7DEB82A55
        for <fstests@vger.kernel.org>; Sat, 21 May 2022 03:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09380C385A9;
        Sat, 21 May 2022 03:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653102986;
        bh=ENwzOGpVtswbhZkusJzc+HiUHn7828mw/1GZFXMVmTw=;
        h=From:To:Cc:Subject:Date:From;
        b=V7vIitlFW+J/0GcomcA23R966E6SOhhK4fjhm/XlV94XiL9G8DGV+GGQbq59lyWHo
         MmNc3QULDk2qDtNqCoy8s0IaIWs4NuWk0QFPe0UmS0MEntAuEl9cnPa0EK5rLo+YhM
         1kxJdAyq8kFojjj4p/AMxokHJH+yNtelPvb/itj5if4UqDsIR0d0UuY1PE6gpzWZVb
         AjVAovLldAO134eWGCikjyVLook9R/HpD+hdLkBDpOyDnuMHjaWtucOBG0e3PjVYiO
         aCswzylgsVTRqJGS+nuEK3h68dcPLRwxC5Moa1nTuRtEKdUfptIKycAm4ejAOs/Fk5
         hxW3nhzOYuQ9g==
From:   Chao Yu <chao@kernel.org>
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me, linux-f2fs-devel@lists.sourceforge.net,
        chao@kernel.org
Subject: [PATCH] generic: adjust strict SPO recovery testcases for f2fs
Date:   Sat, 21 May 2022 11:16:21 +0800
Message-Id: <20220521031621.3494402-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Testcases like generic 342/502/526/527 expect that filesystems will
recover all related metadata changes to the file which was fsynced
before sudden power off.

This patch adjusts to use "fsync_mode=strict" mountoption for f2fs
to pass these testcases.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/generic/342 | 5 +++++
 tests/generic/502 | 5 +++++
 tests/generic/526 | 5 +++++
 tests/generic/527 | 5 +++++
 4 files changed, 20 insertions(+)

diff --git a/tests/generic/342 b/tests/generic/342
index 676b876b..cdffaaf3 100755
--- a/tests/generic/342
+++ b/tests/generic/342
@@ -31,6 +31,11 @@ _require_dm_target flakey
 
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
+
+if [ $FSTYP = "f2fs" ]; then
+	export MOUNT_OPTIONS="-o fsync_mode=strict $MOUNT_OPTIONS"
+fi
+
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/502 b/tests/generic/502
index b0f9077f..b5589b81 100755
--- a/tests/generic/502
+++ b/tests/generic/502
@@ -34,6 +34,11 @@ _require_dm_target flakey
 
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
+
+if [ $FSTYP = "f2fs" ]; then
+	export MOUNT_OPTIONS="-o fsync_mode=strict $MOUNT_OPTIONS"
+fi
+
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/526 b/tests/generic/526
index dc7cb36c..ada4dbee 100755
--- a/tests/generic/526
+++ b/tests/generic/526
@@ -32,6 +32,11 @@ _require_dm_target flakey
 
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
+
+if [ $FSTYP = "f2fs" ]; then
+	export MOUNT_OPTIONS="-o fsync_mode=strict $MOUNT_OPTIONS"
+fi
+
 _init_flakey
 _mount_flakey
 
diff --git a/tests/generic/527 b/tests/generic/527
index 40cd1c6a..de09d171 100755
--- a/tests/generic/527
+++ b/tests/generic/527
@@ -32,6 +32,11 @@ _require_dm_target flakey
 
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
+
+if [ $FSTYP = "f2fs" ]; then
+	export MOUNT_OPTIONS="-o fsync_mode=strict $MOUNT_OPTIONS"
+fi
+
 _init_flakey
 _mount_flakey
 
-- 
2.25.1

