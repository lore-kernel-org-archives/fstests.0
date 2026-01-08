Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03F479808
	for <fstests@vger.kernel.org>; Thu,  8 Jan 2026 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882180; cv=none; b=t4EiNmZ3A+PTCQn0Gllk15dd982bmk9b+K4aTbA57M+hoB4Z9gv0R47tNkC4rTZdcbragYWA0uGlpDIEUUZ7RYhadYCqdRUnpcFWYtUDRJQnQXLo19dgbi1lbZAib4Ptkm8uCjHCcQxhFOCfOjoauaAdzQERnMHc/fD57etSBgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882180; c=relaxed/simple;
	bh=M35bOmKsk3Kqa4NjNzYVHXdW0uKSefn7qZ01KTPO2qY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k8BYUnXkr5qtEp57xgrri/0v0l9L2rxXFv3HgFv93MIFULfXatqg0c2H33bHXXSlXlrKJPupaDlRGwA6tzwZ/NpqdNzs4RnNN4m+3+gXQSoGclXeVeSa0N6W30XHuCa8YDXjSxCndA1LEGinOMIZlgqrJ8M54qvG5015g8v20gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsuOOB2D; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsuOOB2D"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47774d3536dso18674265e9.0
        for <fstests@vger.kernel.org>; Thu, 08 Jan 2026 06:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767882177; x=1768486977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b0VpW2GfctedALWlFzuUwyV+h2vwG39MVomXTl5MAM4=;
        b=OsuOOB2Dn+yQ6wm7XB34vVR9fyA1MvGi6yg5NXAM+PaDwnHK95vG5sEjJtTCV/qkWZ
         PByLzrVfUhdvrlA44MXxuVdOoxBK9/uYajq+ePsjZcWrgscmbsktsrfZjib1Qmkykf10
         9nO1lbc/M4yEwgIHey65q4m0zZ+RXCVI6wgfDZ+cWt7Tk/ndo+UF/sf/dHDZubzsT6kp
         Zw2J5MVZ2y/DoYcDfdZ33O/R2vXkPbs7drAVtI4kPhmzgEZJAwzvUaJGfAHD5aiGWFXm
         aJqR+3x4jzr2cKTTzgTcMpNAPTMUb1xc70xk6YpwluKnN2Eq9uf01ht1B8wnJJhmjesM
         5hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767882177; x=1768486977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0VpW2GfctedALWlFzuUwyV+h2vwG39MVomXTl5MAM4=;
        b=EZJQI3MWnqYCfqp2H4d2DleAU2Lbw/FxaXnpDBLQn3vHD3Nu5iOZjjp6aqWBk3kDga
         t+7cD1wi1juxJMKBm7UuNNPqafy5SYa/rzHjsBC1IMfo8IBnGhQDCTzMegt0kVZtR452
         fQEebHUY8Hz2oUOglKi57qzwSpYNB/mUZhAZlwV/e1nI5OC28eu2jQKdWUqxC4HTjGZb
         xzu0AbDjXB+dQFA6yQxpd1/ciz8tYTh23pFj3OTCiIzmsXFnrN7DzM/Mrle3qVaJkzB2
         rnJxqIs1aZBppMb3XJqMcFEWfLhQ3S5UWaEkD74eCdM+N/8FIg5iINPt6uG0U5KeXtJ8
         n0Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXevD05M8GeTfwYrTqf01nyM8cyHJpIv5i582uXYs5QIu9p/Wz6+Rgw4AXw7m3xy79k6Sa2uTq7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2GN0YX7QKStE5lD2vsOyraonzUceQjRaujUEzIf+ouvA7Wbni
	clgqXrfiwW8K8o7xKXmIPWUWbJTh9HQIwtCmTsu8hnyB3YxIjpo12OV2
X-Gm-Gg: AY/fxX6NJwY3tIimKiGguyXWT0HjgDt4yw/2YtQLNjc4I0Sq/evFagv3FqYyOH6/6Um
	lxc9h0jqAPYI7yAS2JOjPu7OKXeJBHFrQOLIuBVHYbcYAN0Zmm91SUHOYVrwmrqdnFmopbmBS0U
	p4jChTrnekgdLvHUw4ehc9/Jiaf8cHOyuqnTTi8juBjBt3Tm7gK3BYQ06TT3ekw91fBB9lDIV/Q
	lhncLiEnPEcOvu4mvO/kp2XPHVovI4AiWGiQBtOtlcqs8VW1hGNHZo5iSqEARJD+WDgtbHPu4fQ
	i/G5A/Sgh1QnhXCn1LQu/kEi9qhX5UkCf401MYv3/fNe5jG15SpvNDkNqtgAE4d5NkOXMtSrjmh
	vduydIcpdRUvGLYtBAqjXc4gC186X+sj9KBN2x5iS3B9OKs8o1lvE/ZZJ8iUfEPBcGijwhL/c8l
	SYKLWJc6KeYzphkykSE4aLPsS9iSW3DArBu1Rg
X-Google-Smtp-Source: AGHT+IE2+JkY1NLrs26dZqqzUmt/rqDqDdSpIIqRnkhBOmtayof9WyaK3WF5JCG5jPQv5LY1eLQEzw==
X-Received: by 2002:a05:600c:c113:b0:47a:9b80:7b36 with SMTP id 5b1f17b1804b1-47d7f4047edmr108520665e9.2.1767882176831;
        Thu, 08 Jan 2026 06:22:56 -0800 (PST)
Received: from framework13.tail696c1.ts.net ([2a01:e11:3:1ff0:b48e:204e:3838:b119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8717db51sm37648805e9.11.2026.01.08.06.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:22:56 -0800 (PST)
From: Luca Di Maio <luca.dimaio1@gmail.com>
To: linux-xfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Luca Di Maio <luca.dimaio1@gmail.com>,
	djwong@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	zlang@redhat.com
Subject: [PATCH v6] xfs: test reproducible builds
Date: Thu,  8 Jan 2026 15:22:22 +0100
Message-ID: <20260108142222.37304-1-luca.dimaio1@gmail.com>
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
v5 -> v6
- remove debug typo/leftover

Signed-off-by: Luca Di Maio <luca.dimaio1@gmail.com>
---
 tests/xfs/841     | 173 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/841.out |   3 +
 2 files changed, 176 insertions(+)
 create mode 100755 tests/xfs/841
 create mode 100644 tests/xfs/841.out

diff --git a/tests/xfs/841 b/tests/xfs/841
new file mode 100755
index 00000000..5f981d0a
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
+	$FSSTRESS_PROG -d $PROTO_DIR -s 1 -n 2000 -p 2 -z \
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

