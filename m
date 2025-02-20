Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F871E8345
	for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039593; cv=none; b=haRBBfJEc3vHml6rb3KDlcgHMWpJHNgQcDXyN1jHilpcumyUP45PblT48/0RK4f49AObzTR+Nm4O1uuiMkRtYRdMBGwR5fY8XAR12tWZB/r1Q7TWVYEThVFcRf5VH48bEO7p/PnbXEstztaJVP2JvP9FeiDNtjuRA4tyQEG1bcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039593; c=relaxed/simple;
	bh=ZwHVxznDpq4P2wjscx82lNuQEmgj4N3w0vYXMg0iT3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t2Gydk5YAPENenayfmC783q16CAtd2V9QBsesIq35tJ5K6tJzgiBAsFsBGKOmUxC389sHePD2EUEDo5frblC1/lxTkzOmPZ4WTThFxSTyS5o+WdE8AdAjrjMxv4eAy9qTtFsbozkhtIeBaGnapnx0204fIBYchK57d0KEX5x34U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOP9iG5P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOP9iG5P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740039591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xs1w39wUkKXg52okTIhVErzJFji0BSBnlOmP5ksucLU=;
	b=cOP9iG5PfNHN8B6gJzpgE2pM00WOOChK6OV0iuxZAcMFPHIhk7BEo3ReyFkBW9Yv3pCfog
	ZsqrTEzVuAHg9Lrs2xoyQgcmTWwpb1nzjOnCiZ+anh+9tXzQcUKbpq0T8NA/5EoKTOkDfN
	SnSaW+OGNDlB0DtbORa2P7+/CF3aYII=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-oGvNT_-jMOWuHbz1RulAmA-1; Thu,
 20 Feb 2025 03:19:48 -0500
X-MC-Unique: oGvNT_-jMOWuHbz1RulAmA-1
X-Mimecast-MFC-AGG-ID: oGvNT_-jMOWuHbz1RulAmA_1740039588
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 065E019373C4
	for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 08:19:48 +0000 (UTC)
Received: from fs-qe.nay.redhat.com (unknown [10.66.60.126])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5835F1800352;
	Thu, 20 Feb 2025 08:19:45 +0000 (UTC)
From: Boyang Xue <bxue@redhat.com>
To: fstests@vger.kernel.org
Cc: Boyang Xue <bxue@redhat.com>
Subject: [PATCH v2] ext4: add test case 061 for ext3 to ext4 conversion
Date: Thu, 20 Feb 2025 16:14:38 +0800
Message-ID: <20250220081748.185731-1-bxue@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Signed-off-by: Boyang Xue <bxue@redhat.com>
---
v1->v2:
 - fix mount check in _cleanup()

 tests/ext4/061     | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/061.out | 17 +++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100755 tests/ext4/061
 create mode 100644 tests/ext4/061.out

diff --git a/tests/ext4/061 b/tests/ext4/061
new file mode 100755
index 00000000..785aecbc
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
+    if mount | grep -q "$SCRATCH_DEV" > /dev/null 2>&1; then
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

