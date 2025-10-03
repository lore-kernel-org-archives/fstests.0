Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C92B278158
	for <fstests@vger.kernel.org>; Fri,  3 Oct 2025 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534939; cv=none; b=ZwHntTPdUwlWenNvQH8JTxSXupdtVLzCOM1JWgbA9chEh/JYd4Z4s6eAeLHCYfcgD2BWCReg3MpDDylvpuiIbc5qcVE7JKIPZgOXBPgASTc+YhlJR2ZrmUcU6Ugjw7lfnMP4psp+jFjChXYyP0t20FFbnfMSyQ/r3SfReLTo7+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534939; c=relaxed/simple;
	bh=fA/iItnoCi+GkBd1MHPqmKC4Ilu5imymQ0NjVAyxgFw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKo8O/cbNu4qtYuHEux/tc0I/bGuvtQAkW20W8vjBpYNkOU0fzyDmlDmBfCACPK+n1sxlQ3BP54Z57x8FzUMKUeR4Z9QtMoRaEmJfz6oTTVTuQ/7MPmWDK+H9hhjdSwjh25Aj+LFU4/90lZnmBf4p5tzVgwFq6fD5K1JXrZnPBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOKBRnhY; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOKBRnhY"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-749399349ddso38073517b3.3
        for <fstests@vger.kernel.org>; Fri, 03 Oct 2025 16:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759534937; x=1760139737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoONqeITOu1OJUM88cumPNXT1Sugp6nUBehkV0YhSJ0=;
        b=lOKBRnhYejpUJ2PYZpiv4Qd0UOZ4SgRqLNKsjXXRhpP3V0Rz7iyikAbBrA25MelUwi
         tnJMd/JQ1GtOxPxMUVKFh09cxSNiVEp8k9hIWkcQj6mH9KJjrrXKbQe1xSwSyfFzKXCf
         dF7AHqvvcPCZKG4PMjxBw2NDlURCzmE1R4S064xAlIJV62vB3aeZpVt87eAeaZEIoiSv
         E9J57ypK+3sjEOmR/kloKSFFEZqm5Q+WQa3Qr5R8nI/ZfN7XWrC8dBLVgJPrUEWyIYz1
         bUf8xVEZt0Jy7vTl6cnA5tzA/qL/KBmaLNLwp2yrx4lOrGIpEA6uwCPEsY6Y1mPKXUDd
         OxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759534937; x=1760139737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoONqeITOu1OJUM88cumPNXT1Sugp6nUBehkV0YhSJ0=;
        b=DWU5wDtVQKNiL5bAAVDjvj4GV7ZvAYVlQFZ9Cz45I9tP0+2Q7sNT5W+1EBtBIPJ8vY
         idVkhvw1DKeQwSgm95B+Msb/W+kf5UxSt2SJrxwt2X7y38F1phonLzcL3yZ7a6ERJPxA
         lyZGPsPrQHYCMkh0ehRFiSKN1keGBcdCgo5fzYh8S4FuvCFOZCK0aY5u0eGjLdSzZhQB
         L1tMBsy710D/DIs+lSFBVqkN2fZOLtyjr1ywVoUfT+eRCWZ+0o4BSRd/Ogh267XEW4Sx
         VXIUP0+LXgs6mRq66vukBA7FQqj10DB7+UsyCI++CQhsIAPZMTn5r0YDvLLGYxlxP15l
         anuA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Q74IJoD7P/pimbdameKFM0YlHyI6lb3hP4lkUlV2e6RdtOW/YvpOt6PD/I1sJK4JMIrKKqdQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+2BlJ9Kt1KxleZR9dclUdDnTkSI2FZr6lFB1gLxCbbsuTTdv
	I335AT72H8zoDS4hZdyved/zdPDfP4QPDSga/Zg/r7A2GG2AnAYzfqjomqMyOzC8
X-Gm-Gg: ASbGncvW7nwFoxumPq2u9Q9AM+vKkN0kwQ7C8/qJiX5BFZuI7u3PwoYhMtP/SceTcpz
	BwoFU3Zxw8OFjraA+xt+XFJ1SwfuuaqA6FQ6Ks7Jd3qoMdLYZw09SFc0+T4FBTxlXbp/L7VT2H/
	hjwjVyF3iVVTiuDOnKp+VHeEywHAu4thY3GXQkOHPbKaUS7y2cXu2vGsgBFgcxtbkPr2LBeAVkx
	sR0nQRr8KqvmIU8Dlaqama8lYFRHsQWTPJ2LBUoPShS9uaOCEX9aoQB6nhbxuxiQSYYgsd+7mh3
	vY4g/bcaIVSUj9QgIwsPsiZvcVFdNL2wSdxQUvyJI+hIek37GRFQQ+IbKqYK3KBFcIgJq7i4xC0
	DxuPksUNvcv0vkP9MCDRLeLLxGNHjWWDgXH61Jx/RdvKwzS3xvTSqK2qj/edwTuJn
X-Google-Smtp-Source: AGHT+IGxWIdATjQKfsBLLoZDjWvk4Oh/wgBbreIU54NjJL8oYV5b+5WgAmBNgPMh8S/bVGQzaibJKA==
X-Received: by 2002:a05:690c:3802:b0:772:5ad9:3bf8 with SMTP id 00721157ae682-77f9476c561mr57878107b3.51.1759534936982;
        Fri, 03 Oct 2025 16:42:16 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:48::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77faaa9938csm850127b3.33.2025.10.03.16.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 16:42:16 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v2 3/3] fstests: btrfs: test RAID conversions under stress
Date: Fri,  3 Oct 2025 16:41:59 -0700
Message-ID: <455b9a2b102631febc1b05802006d3d304d4baeb.1759534540.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759532729.git.loemra.dev@gmail.com>
References: <cover.1759532729.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test to test btrfs conversion while being stressed. This is
important since btrfs no longer allows allocating from different RAID
block_groups during conversions meaning there may be added enospc
pressure.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 tests/btrfs/337     | 95 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/337.out |  2 +
 2 files changed, 97 insertions(+)
 create mode 100755 tests/btrfs/337
 create mode 100644 tests/btrfs/337.out

diff --git a/tests/btrfs/337 b/tests/btrfs/337
new file mode 100755
index 00000000..fa335ed7
--- /dev/null
+++ b/tests/btrfs/337
@@ -0,0 +1,95 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Meta Platforms, Inc. All Rights Reserved.
+#
+# FS QA Test btrfs/337
+#
+# Test RAID profile conversion with concurrent allocations.
+# This combines profile conversion (like btrfs/195) with concurrent
+# fsstress allocations (like btrfs/060-064).
+
+. ./common/preamble
+_begin_fstest auto volume balance scrub raid
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	_kill_fsstress
+}
+
+. ./common/filter
+# we check scratch dev after each loop
+_require_scratch_nocheck
+_require_scratch_dev_pool 4
+# Zoned btrfs only supports SINGLE profile
+_require_non_zoned_device "${SCRATCH_DEV}"
+
+# Load up the available configs
+_btrfs_get_profile_configs
+declare -a TEST_VECTORS=(
+# $nr_dev_min:$data:$metadata:$data_convert:$metadata_convert
+"4:single:raid1"
+"4:single:raid0"
+"4:single:raid10"
+"4:single:dup"
+"4:single:raid5"
+"4:single:raid6"
+"2:raid1:single"
+)
+
+run_testcase() {
+	IFS=':' read -ra args <<< $1
+	num_disks=${args[0]}
+	src_type=${args[1]}
+	dst_type=${args[2]}
+
+	if [[ ! "${_btrfs_profile_configs[@]}" =~ "$dst_type" ]]; then
+		echo "=== Skipping test: $1 ===" >> $seqres.full
+		return
+	fi
+
+	_scratch_dev_pool_get $num_disks
+
+	echo "=== Running test: $1 (converting $src_type -> $dst_type) ===" >> $seqres.full
+
+	_scratch_pool_mkfs -d$src_type -m$src_type >> $seqres.full 2>&1
+	_scratch_mount
+
+	echo "Creating initial data..." >> $seqres.full
+	_run_fsstress -d $SCRATCH_MNT -w -n 10000 >> $seqres.full 2>&1
+
+	args=`_scale_fsstress_args -p 20 -n 1000 -d $SCRATCH_MNT/stressdir`
+	echo "Starting fsstress: $args" >> $seqres.full
+	_run_fsstress_bg $args
+
+	echo "Starting conversion: $src_type -> $dst_type" >> $seqres.full
+	_run_btrfs_balance_start -f -dconvert=$dst_type $SCRATCH_MNT >> $seqres.full
+	[ $? -eq 0 ] || echo "$1: Failed convert"
+
+	echo "Waiting for fsstress to complete..." >> $seqres.full
+	_wait_for_fsstress
+
+	# Verify the conversion was successful
+	echo "Checking filesystem profile after conversion..." >> $seqres.full
+	$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
+
+	# Scrub to verify data integrity
+	echo "Scrubbing filesystem..." >> $seqres.full
+	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
+	if [ $? -ne 0 ]; then
+		echo "$1: Scrub found errors"
+	fi
+
+	_scratch_unmount
+	_check_scratch_fs
+	_scratch_dev_pool_put
+}
+
+echo "Silence is golden"
+for i in "${TEST_VECTORS[@]}"; do
+	run_testcase $i
+done
+
+status=0
+exit
diff --git a/tests/btrfs/337.out b/tests/btrfs/337.out
new file mode 100644
index 00000000..d80a9830
--- /dev/null
+++ b/tests/btrfs/337.out
@@ -0,0 +1,2 @@
+QA output created by 337
+Silence is golden
-- 
2.47.3

