Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F465346FA4
	for <fstests@vger.kernel.org>; Tue, 16 Dec 2025 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872164; cv=none; b=Fzm5D2Z0Hb3KtkW6I0pHjwVCtFh8khFjZQe/OM44dum5Tgj37Ryes6M253CBWDyByINQzIxbLE5bzDU+B3X5z26y0Ze4oZ36LLEhZIHoXverFpeqaldlC+EP5+GTM69DdwdQdTvh/YndtD9v81lMhEE2KxqBsozjCAnKXc8XOwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872164; c=relaxed/simple;
	bh=czBAiE/4fYQsFUv5ZaYdzY2QqyntrTRTbluyQNy9IW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aldE4TGtVgDib8Z1G/aeBLSBY78B7ylLyPz2Q3LPxJ/nIIpA0miiWPI0vRxCYdmFn6eYgfgy5806w/uVmB15ePOkIU/u1uELdzWRJ6WB+rdGQhonDjNWoJq2THz3lMO/gVthuRc5P2RdhuRBZJAymCXH4dhgnRekWFS4XF6kT/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dA/XRFlv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA/XRFlv"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477632d9326so26304155e9.1
        for <fstests@vger.kernel.org>; Tue, 16 Dec 2025 00:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765872160; x=1766476960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tAzWEVvN6bbrF/qLUTAf3M582VLyoyCCZHJjbAe8IYM=;
        b=dA/XRFlvxn6OC1LvOLZSo5ndQ4DQ858fIxX1H7p4PrOqBapYRJntEieoxM2Ygf2YLs
         PcoqQItZD9JHTD4koARyqzXeskxG4F5hxQaiW6E80MqXsbNg2fcUmMT0G7xDOZo6cUKn
         eqwiLmflSS6siHPvEmiaXUDuaS1rNWjcZqSmet6Eb8Hh7Rcdbhcu3+yraJ9kZLEvouq1
         8gQhZxIkYHCTH6ozMm3IPLjJFWUrPoP/d04BKQCmq1Nk2J6g8pyh5cEyTN6pL/TlcVQ7
         9cWv54KjLoMEulfghY7ZLzoqR+UUYhfyDErW+kVcTVxD06mht6IRIePVp9gr+XCQVZdK
         V62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765872160; x=1766476960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAzWEVvN6bbrF/qLUTAf3M582VLyoyCCZHJjbAe8IYM=;
        b=itYhhAL7oKATV51JdhkQBxsBWLya1C9D6FkEncmwb11cWR9ers8aQyFmzAJ6wus0ea
         ZOpAxgLWIihA5bSe0Jo3Ikl/IKpGx0QNMd3parR4KuK27SJokhCmQXQO5aJPxWucT1CW
         PU92JC5pBMG7qIdEOg0+p9+1wNLfuBCGPck3D2uXIICwQJfw+TrWC0zTdKCCeUM5ObHw
         DW4G6gLyfL5QK47aTP45O+RmKunYXv1XlRioFFJZVf8TssCGKNjaoQTf87FzaqHN0OeR
         TZZQb7cK7Y6TaR6/rfwbOzmhmIQBIKm96IHvnRgUQl2ZbpG8UkVz4WpKphn6iCbrJb4f
         Ze0g==
X-Gm-Message-State: AOJu0Ywym3GZe+YR8grW8hG6/gw8vyBuf5rf9fRwR2jBvBukYDnf0dBY
	a+PYfOgqgwAQilgzDna+mMcJMqth5uL5gjijDpN6GEF4IukCorydfAC8sIn27tM4
X-Gm-Gg: AY/fxX64WRdk1MHjIN/Jgnqyzs1/jHO38Gqz23WqxeBhd9D+nNo8NKWJCeZa6ynmZu3
	rUpMoPOPfC1Uv3glIP4UdmjUh77wnP87GP+vfpWgnYQ44oF6QMN9+CATrc5iuTYlsjgAtOeychG
	W4vqKGaXP4KumobO1wmVlRkcMNSw/s/fzNh8mv+LQXOPpQ+KVGyvPJt9q/Y/i/bLsrK5nyprhBH
	btWRlgxc1PrRj/20MY6Jky3zM5qz9dIKFTDwqO3N5ZQynszVkt1LM4InYMS/2LOKSh3XCByzDZ/
	EsrS2oy5UpAE4sYgmfL1SOt75CFaMNs0T52zptX85RwMUqPN05StbCj1dfxuH6F9Jdu+XkPhCXE
	2umcTGq2hR3ELOdVMW3Y68Hu6T/nlDRq+qPOI5vSDwwCDUMk7ArTyww63+SXPJkKSkXY8r8VS6R
	EEWfslikpdRs0NpcLGr7yVQ+BE6A==
X-Google-Smtp-Source: AGHT+IHerRAQ+nGZxilFOkG1RtoTFetA+MjwyaJV9uzwCkZ8kX89SijsBjhCGYRaGjZk8KMOZWZUUw==
X-Received: by 2002:a05:600c:4e09:b0:477:9c73:267f with SMTP id 5b1f17b1804b1-47a8f914a25mr159613895e9.33.1765872160354;
        Tue, 16 Dec 2025 00:02:40 -0800 (PST)
Received: from f13.tail696c1.ts.net ([2a01:e11:3:1ff0:d056:b665:7783:f98d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f8d9c6fsm230839775e9.11.2025.12.16.00.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 00:02:39 -0800 (PST)
From: Luca Di Maio <luca.dimaio1@gmail.com>
To: fstests@vger.kernel.org
Cc: Luca Di Maio <luca.dimaio1@gmail.com>,
	djwong@kernel.org,
	hch@infradead.org
Subject: [PATCH v4] xfs: test reproducible builds
Date: Tue, 16 Dec 2025 09:02:33 +0100
Message-ID: <20251216080233.2324849-1-luca.dimaio1@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the addition of the `-p` populate option, SOURCE_DATE_EPOCH and
DETERMINISTIC_SEED support, it is possible to create fully reproducible
pre-populated filesystems. We should test them here.

v1 -> v2:
- Changed test group from parent to mkfs
- Fixed PROTO_DIR to point to a new dir
- Populate PROTO_DIR with relevant file types
- Move from md5sum to sha256sum
v2 -> v3
- Properly check if mkfs.xfs supports SOURCE_DATE_EPOCH and
  DETERMINISTIC_SEED
- use fsstress program to generate the PROTO_DIR content
- simplify test output
v3 -> v4
- Add _cleanup function

Signed-off-by: Luca Di Maio <luca.dimaio1@gmail.com>
---
 tests/xfs/841     | 171 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/841.out |   3 +
 2 files changed, 174 insertions(+)
 create mode 100755 tests/xfs/841
 create mode 100644 tests/xfs/841.out

diff --git a/tests/xfs/841 b/tests/xfs/841
new file mode 100755
index 00000000..a75f5879
--- /dev/null
+++ b/tests/xfs/841
@@ -0,0 +1,171 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chainguard, Inc. All Rights Reserved.
+#
+# FS QA Test No. 841
+#
+# Test that XFS filesystems created with reproducibility options produce
+# identical images across multiple runs. This verifies that the combination
+# of SOURCE_DATE_EPOCH, DETERMINISTIC_SEED, and -m uuid= options result in
+# bit-for-bit reproducible filesystem images.
+
+. ./common/preamble
+_begin_fstest auto quick mkfs
+
+# Image file settings
+IMG_SIZE="512M"
+IMG_FILE="$TEST_DIR/xfs_reproducible_test.img"
+PROTO_DIR="$TEST_DIR/proto"
+
+# Fixed values for reproducibility
+FIXED_UUID="12345678-1234-1234-1234-123456789abc"
+FIXED_EPOCH="1234567890"
+
+_cleanup() {
+	rm -r -f "$PROTO_DIR" "$IMG_FILE"
+}
+
+# Check if mkfs.xfs supports required options
+_check_mkfs_xfs_options()
+{
+	local check_img="$TEST_DIR/mkfs_check.img"
+	truncate -s 64M "$check_img" || return 1
+
+	# Check -m uuid support
+	$MKFS_XFS_PROG -m uuid=00000000-0000-0000-0000-000000000000 \
+		-N "$check_img" &> /dev/null
+	local uuid_support=$?
+
+	# Check -p support (protofile/directory population)
+	$MKFS_XFS_PROG 2>&1 | grep populate &> /dev/null
+	local proto_support=$?
+
+	grep -q SOURCE_DATE_EPOCH "$MKFS_XFS_PROG"
+	local reproducible_support=$?
+
+	rm -f "$check_img"
+
+	if [ $uuid_support -ne 0 ]; then
+		_notrun "mkfs.xfs does not support -m uuid= option"
+	fi
+	if [ $proto_support -ne 0 ]; then
+		_notrun "mkfs.xfs does not support -p option for directory population"
+	fi
+	if [ $reproducible_support -ne 0 ]; then
+		_notrun "mkfs.xfs does not support env options for reproducibility"
+	fi
+}
+
+# Create a prototype directory with all file types supported by mkfs.xfs -p
+_create_proto_dir()
+{
+	rm -rf "$PROTO_DIR"
+	mkdir -p "$PROTO_DIR"
+
+	$FSSTRESS_PROG -d $PROTO_DIR -s 1 $F -n 2000 -p 2 -z \
+		-f creat=15 \
+		-f mkdir=8 \
+		-f write=15 \
+		-f truncate=5 \
+		-f symlink=8 \
+		-f link=8 \
+		-f setfattr=12 \
+		-f chown=3 \
+		-f rename=5 \
+		-f unlink=2 \
+		-f rmdir=1
+
+
+	# FIFO (named pipe)
+	mkfifo "$PROTO_DIR/fifo"
+
+	# Unix socket
+	$here/src/af_unix "$PROTO_DIR/socket" 2> /dev/null || true
+
+	# Block device (requires root)
+	mknod "$PROTO_DIR/blockdev" b 1 0 2> /dev/null || true
+
+	# Character device (requires root)
+	mknod "$PROTO_DIR/chardev" c 1 3 2> /dev/null || true
+}
+
+_require_test
+_check_mkfs_xfs_options
+
+# Create XFS filesystem with full reproducibility options
+# Uses -p to populate from directory during mkfs (no mount needed)
+_mkfs_xfs_reproducible()
+{
+	local img=$1
+
+	# Create fresh image file
+	rm -f "$img"
+	truncate -s $IMG_SIZE "$img" || return 1
+
+	# Set environment variables for reproducibility:
+	# - SOURCE_DATE_EPOCH: fixes all inode timestamps to this value
+	# - DETERMINISTIC_SEED: uses fixed seed (0x53454544) instead of
+	#   getrandom()
+	#
+	# mkfs.xfs options:
+	# - -m uuid=: fixed filesystem UUID
+	# - -p dir: populate filesystem from directory during creation
+	SOURCE_DATE_EPOCH=$FIXED_EPOCH \
+	DETERMINISTIC_SEED=1 \
+	$MKFS_XFS_PROG \
+		-f \
+		-m uuid=$FIXED_UUID \
+		-p "$PROTO_DIR" \
+		"$img" >> $seqres.full 2>&1
+
+	return $?
+}
+
+# Compute hash of the image file
+_hash_image()
+{
+	sha256sum "$1" | awk '{print $1}'
+}
+
+# Run a single reproducibility test iteration
+_run_iteration()
+{
+	local iteration=$1
+
+	echo "Iteration $iteration: Creating filesystem with -p $PROTO_DIR" >> $seqres.full
+	if ! _mkfs_xfs_reproducible "$IMG_FILE"; then
+		echo "mkfs.xfs failed" >> $seqres.full
+		return 1
+	fi
+
+	local hash=$(_hash_image "$IMG_FILE")
+	echo "Iteration $iteration: Hash = $hash" >> $seqres.full
+
+	echo $hash
+}
+
+# Create the prototype directory with various file types
+_create_proto_dir
+
+echo "Test: XFS reproducible filesystem image creation"
+
+# Run three iterations
+hash1=$(_run_iteration 1)
+[ -z "$hash1" ] && _fail "Iteration 1 failed"
+
+hash2=$(_run_iteration 2)
+[ -z "$hash2" ] && _fail "Iteration 2 failed"
+
+hash3=$(_run_iteration 3)
+[ -z "$hash3" ] && _fail "Iteration 3 failed"
+
+# Verify all hashes match
+if [ "$hash1" = "$hash2" ] && [ "$hash2" = "$hash3" ]; then
+	echo "All filesystem images are identical."
+else
+	echo "ERROR: Filesystem images differ!"
+fi
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/841.out b/tests/xfs/841.out
new file mode 100644
index 00000000..3bdfbfda
--- /dev/null
+++ b/tests/xfs/841.out
@@ -0,0 +1,3 @@
+QA output created by 841
+Test: XFS reproducible filesystem image creation
+All filesystem images are identical.
-- 
2.51.0

