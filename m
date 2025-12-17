Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B06328269
	for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765969692; cv=none; b=qqj0SiFXPl6aWwo+D41FXKGaD1caF3ovZOfR2QAZSP4yteM0MLM4R80O7p7+/LgK+siV+TOQdMOV+22uurorUqzOUs0K43jMf5jHCCWDm4MEEzrVeI+dFDYY1AUnl7sd2UIlRsPZJmrV82GEfi6SfVjxMLA9lilV7pOsp527ElY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765969692; c=relaxed/simple;
	bh=/Hamfa+ksUPdhkEmwzS5MOtzi1jBdH0AppoWRU6R3rU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=unJs7E/dBTAtXLBmEmAwyLbyIC0Veq5HPqYgaZ57/grzy0+l0vlG2Pj+0LoXpCJ8uCjB1zC9G5BHiHIxIFmFYaIShz0zbhB8KCJnUf+vEWVA2rwieh5Im2bitiTW9npqchVQns+pRbrcqO/NS1061YWQ0Sp7BEEyPKxSgmZTfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyQhGvcK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyQhGvcK"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fbc3056afso2620062f8f.2
        for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 03:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765969689; x=1766574489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w2KXIuUHTxG+9PFYORsRCGlcPMBrjzhW5oYcDljb92E=;
        b=gyQhGvcKxDEXQCDLsSLxEWmkprkPU6qYX+C+Cd3fL/lqHE54xpTnZ7UUh1wXIxflAb
         sWTp73fZYVhymrGuSbvXhSlCQ/Huv1xbRKxgn1fIqYyMbvLcnqOlTSLrTF7JaxLZThEV
         sv6C7gQdOo4ErDQ0F79zvaQ+W+FH5Hh8Wr/PsLJ/zFl9VDcMu0+VVNnf7AiertFxgdLv
         NYtsoJNjNl2Fy6+kUq+rO2uxVQ5yomceqW9ETJunz7in47TIeylYOckhVZoi219jcG15
         h6IALuizX6irbnmPoxGJyjpsbkfabTZQ8uvL76f86PgaWNluRMUSj5ssxgHa1rhPyrYr
         GF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765969689; x=1766574489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2KXIuUHTxG+9PFYORsRCGlcPMBrjzhW5oYcDljb92E=;
        b=Nx5fkHkYLdBZ0YzC0FKUYDeUP3DtNCOLROqseFbKnK6FeaoMA60CqlhWuldRSPhozT
         Xy5hfg1HvCeQeCh/74VInrgShErsMBv4ON9sGfoeTESnPGBOqbmcGm/LgHhVPg+r0J5P
         l7aWnYqaYKU7vkchaO1JuiJyYOOxJi2w7KthOXwljt+piUxlgoFZtA/5qwPvv0n2BEZd
         +pr0/hld1DYYZimJpiukB4GvTnce3GpII0b8XHUFK3JtIdKxWFJiK5VjlxQU5GENGr0f
         MQKKZnheihI5drr7xmpysHiN1RRNhcU9aDFuCm3C9nSG5DwMa/hLJOEIzhKd7a9vi2rC
         87CA==
X-Forwarded-Encrypted: i=1; AJvYcCWgYFMqnQhNAqMPS4p/oomwwO9I9Io3Z1Y3S+Owh/ZYHn9OdvdCistr4xuP/+q5x5pQKcIpXwD4@vger.kernel.org
X-Gm-Message-State: AOJu0YwQaxl6uxkzDa/07LRqyBtmMvQumu2grALim9mwYEZDvDd0RXoN
	AOBfAkicStSUSSmSgxYXj5jogUPC2lYSQOixrLed0F2djt07IZiHz+9s
X-Gm-Gg: AY/fxX6rFsE2p7jabs943tGlZa+7LabhIhcjoXUfkhAjXorMuaBJojs6Ren0OwgbusH
	t8yTJCnZx/fm8wGLIDBQ/WWvvFuavCtu6DQy+RFcDY64QflueOpjm654XJOGr3gZL/V5cmhb/7E
	sCKz04c/0hKK8EmGQK5r27cYCgPTT54FLLllm7aHPB/wBSW9NyKN3m6LeD1Qn870LHw6BC17ixo
	SoZy8l/wdPhvk2dgJ94NQgJ94NBme+xvilTr54w+uu2F5EBkdwI8EY7VfIyErd44XlXZfoIFoZ7
	+AqduczPvnxR5gYd3WQXu5IfFN8Nm17+nIIJIiNFE+yn0V0KgKPFabwXPwiRiF9+jq0etkLbCnP
	O50A9usW9VOjvE1QinKl3xQX1KLpBS2dkBD5yHDIhCXvdGvyn7LFzKshF9qNkzZ6mLuktmH7T68
	DC4t2aCa3fQ6OVgf17/VKWqqTZ
X-Google-Smtp-Source: AGHT+IEcVr9Um4oTkJrJR6C/4as1vBkK1dDxZbVqhSEpOXb+50QRnO5wuBPyVokXqzgeKOhKUSrNrA==
X-Received: by 2002:a05:6000:4205:b0:431:66a:cbc2 with SMTP id ffacd0b85a97d-431066acffcmr5774700f8f.44.1765969688839;
        Wed, 17 Dec 2025 03:08:08 -0800 (PST)
Received: from f13.tail696c1.ts.net ([2a01:e11:3:1ff0:513a:a454:7a0:65ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adf6eabsm3945879f8f.38.2025.12.17.03.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 03:08:08 -0800 (PST)
From: Luca Di Maio <luca.dimaio1@gmail.com>
To: linux-xfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Luca Di Maio <luca.dimaio1@gmail.com>,
	djwong@kernel.org,
	hch@infradead.org,
	david@fromorbit.com
Subject: [PATCH v5] xfs: test reproducible builds
Date: Wed, 17 Dec 2025 12:06:53 +0100
Message-ID: <20251217110653.2969069-1-luca.dimaio1@gmail.com>
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
v4 -> v5
- copy _cleanup from common/preamble

Signed-off-by: Luca Di Maio <luca.dimaio1@gmail.com>
---
 tests/xfs/841     | 173 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/841.out |   3 +
 2 files changed, 176 insertions(+)
 create mode 100755 tests/xfs/841
 create mode 100644 tests/xfs/841.out

diff --git a/tests/xfs/841 b/tests/xfs/841
new file mode 100755
index 00000000..60982a41
--- /dev/null
+++ b/tests/xfs/841
@@ -0,0 +1,173 @@
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
+	cd /
+	command -v _kill_fsstress &>/dev/null && _kill_fsstress
+	rm -r -f $tmp.* "$PROTO_DIR" "$IMG_FILE"
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
2.52.0

