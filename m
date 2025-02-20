Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA581E5B66
	for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036176; cv=none; b=cCa//7cvPn2DPpTzIzaZ2bKUeEDwNe2uvBEaDQUhJaner4lES0BkmEpfIshF0txZyzXYbZxRltt/gWMXCnZkcPtvHzisCBZPQ7PhGmrtYvzi7lzgyXgRQRuDtSfOijEgWzecDULfAtoS2ObTr77smZoSLNRJPwN4QcGDDW30/ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036176; c=relaxed/simple;
	bh=X042Dj2o+zocOWZR5A5eTlIWFI+tYdCRZ0UCYUix0Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=reRTVPleJsAliDN/jcENnA9r5aAW75hUz+40lwuNC/IrDgYK7iVYPAbpNsvsk9OXbmlkDBuLX+mgT9Fw+5fBoZbWaizk0HiFTKiwO3Xo1Hy03XbIykntqGjppSnviJbnhQrfLTnnax5zj7JS7Lq5+TthAB0PrRx9sLMIoUN9Hj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wc/a24o3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wc/a24o3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740036172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R19ZL8+iJW4L6bS5N/KMSFOavNon1OWT+fysGKUXdCE=;
	b=Wc/a24o33uPNucO9UbPfC8MXoaZMODBn5IaaO8bT1YELkR4NARd7lDu125zh9juL/qN7b7
	KAJNLf792S2lEGauYABrrQPDDVdvotgIMaOOIXlLGG+wFu6MJBOj0koNQYi5X+CBnrloPv
	iUVnQ7oOBovvEADxT1+vOAP92XZgsN8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-B86Ni3gNPBSFQkIFKjBd5w-1; Thu,
 20 Feb 2025 02:22:50 -0500
X-MC-Unique: B86Ni3gNPBSFQkIFKjBd5w-1
X-Mimecast-MFC-AGG-ID: B86Ni3gNPBSFQkIFKjBd5w_1740036169
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B7421978C9A
	for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 07:22:49 +0000 (UTC)
Received: from fs-qe.nay.redhat.com (unknown [10.66.60.126])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC36B1800D96;
	Thu, 20 Feb 2025 07:22:47 +0000 (UTC)
From: Boyang Xue <bxue@redhat.com>
To: fstests@vger.kernel.org
Cc: Boyang Xue <bxue@redhat.com>
Subject: [PATCH v1] ext4: add test case 061 for ext3 to ext4 conversion
Date: Thu, 20 Feb 2025 15:20:29 +0800
Message-ID: <20250220072226.175071-1-bxue@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Signed-off-by: Boyang Xue <bxue@redhat.com>
---
 tests/ext4/061     | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/061.out | 17 +++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100755 tests/ext4/061
 create mode 100644 tests/ext4/061.out

diff --git a/tests/ext4/061 b/tests/ext4/061
new file mode 100755
index 00000000..f42f2a92
--- /dev/null
+++ b/tests/ext4/061
@@ -0,0 +1,63 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Red Hat Inc.  All Rights Reserved.
+#
+# FS QA Test 061
+#
+# Test conversion from ext3 to ext4 filesystem with various mount options
+#
+. ./common/preamble
+_begin_fstest auto
+
+# Import common functions.
+. ./common/filter
+
+_supported_fs ext3 ext4
+
+_require_scratch
+
+MOUNT_OPTS_LIST=(
+    ""
+    "noatime"
+    "data=journal"
+    "data=writeback"
+)
+
+_cleanup()
+{
+    if _is_dev_mounted "$SCRATCH_DEV" > /dev/null 2>&1; then
+        $UMOUNT_PROG "$SCRATCH_DEV" || _fail "_cleanup: umount failed"
+    fi
+}
+
+
+fill_fs() {
+    echo "Filling filesystem..."
+    while true; do
+        dd if=/dev/urandom of="${SCRATCH_MNT}/file$(date +%s)" bs=1M count=4 \
+> /dev/null 2>&1 || _fail "dd failed"
+        df -h ${SCRATCH_MNT} | awk 'NR==2 {print $5}' | grep -q '[9][0-9]%' \
+&& break
+    done
+    echo "Filesystem almost full."
+}
+
+for mount_opt in "${MOUNT_OPTS_LIST[@]}"; do
+    echo "Starting test with mount options: '$mount_opt'"
+    mkfs.ext3 -F "$SCRATCH_DEV" 1g >> $seqres.full 2>&1 \
+|| _fail "mkfs.ext3 failed"
+    mount -t ext3 -o "$mount_opt" "$SCRATCH_DEV" "$SCRATCH_MNT" \
+ >> $seqres.full 2>&1 || _fail "mount ext3 failed"
+    fill_fs
+    umount "$SCRATCH_MNT" >> $seqres.full 2>&1 || _fail "umount ext3 failed"
+    tune2fs -O extents,uninit_bg,dir_index "$SCRATCH_DEV" \
+>> $seqres.full 2>&1 || _fail "tune2fs failed"
+    e2fsck -f -y "$SCRATCH_DEV" >> $seqres.full 2>&1 || _fail "e2fsck failed"
+    mount -t ext4 "$SCRATCH_DEV" "$SCRATCH_MNT" >> $seqres.full 2>&1 \
+|| _fail "mount ext4 failed"
+    umount "$SCRATCH_MNT" >> $seqres.full 2>&1 || _fail "umount ext3 failed"
+    echo "Test with mount options: '$mount_opt' completed successfully."
+done
+
+status=0
+exit
diff --git a/tests/ext4/061.out b/tests/ext4/061.out
new file mode 100644
index 00000000..ed2997a0
--- /dev/null
+++ b/tests/ext4/061.out
@@ -0,0 +1,17 @@
+QA output created by 061
+Starting test with mount options: ''
+Filling filesystem...
+Filesystem almost full.
+Test with mount options: '' completed successfully.
+Starting test with mount options: 'noatime'
+Filling filesystem...
+Filesystem almost full.
+Test with mount options: 'noatime' completed successfully.
+Starting test with mount options: 'data=journal'
+Filling filesystem...
+Filesystem almost full.
+Test with mount options: 'data=journal' completed successfully.
+Starting test with mount options: 'data=writeback'
+Filling filesystem...
+Filesystem almost full.
+Test with mount options: 'data=writeback' completed successfully.
-- 
2.48.1

