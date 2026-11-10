Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334795;
	b=2gJ+sxkZ9ak+BXSppq82AtaEJpBnqL8gz5irMWFIouXKdneVQhvTtvq2NewU9Sq36nxu
	 zuamgmCBzg80ohLF67Zx7g/JuG0o7dL4Iy970NJdGSbYbm0ReObTp6OjD+bzQ2xL7q3H2
	 m2mAwNWDS6NTEaY9LDy26tfoMKzFBLMsDbHijEgcnf8eO4SIBVuLAgbw8fHSvkUwvC1Jl
	 DVkUsxxJUDF25Tny44VBx99LhjV/jvVfbD78R8I5TaL+Pz1sCDY10lT+cRNuWw8vQU3J8
	 ojl4/OD/QcuBkfrQDdrpSCsreYKsUwsu/TZLNfLQQ6GHPe25mQuZe4vd5sTqutbXu/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334795;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=u4qLTe41InUkuJCgoejpmAJ1STr0utezqlPIhAywKXY=;
	b=TNrc6BkyFCW3Y0HeH+OwoYTl9quDALgTyMFQp2V2SVps+g7qJa4D70Pp/QpFchsdeI78
	 JtObBexobT2k7UB6VYX3MgHKnUY11nr2oAo4VYcVYW909OOB9WzKHF7DmS9fy2U+TKSE8
	 RMncXEt6ite7ukuOuOFj+SjhtnDfoBmGqNDFBCbd2F5aiBrHAUx6r2acZiW+g18wwvPHY
	 9nQQ326JQE+X2/QATnASSP7vqU8PlG+MU/GMti4s/Prs78MZe8Jjd/ZZMBMu6uGhIKW+D
	 gCHREJSCRK7M2l7J60KMarMRL0rlokrmY2tS8Ogq18V7lLX1LNGXtndGgLyqwfk7I/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Jx/bSwFZ";
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD14606A338
	for <fstests@vger.kernel.org>; Tue, 10 Nov 2026 18:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FD14606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jx/bSwFZ
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a3c08d6928so4069970c88.0
        for <fstests@vger.kernel.org>; Tue, 10 Nov 2026 10:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794334794; x=1794939594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u4qLTe41InUkuJCgoejpmAJ1STr0utezqlPIhAywKXY=;
        b=Jx/bSwFZZ3UwZmyqUCvz+YcSlM8G0/ZRUIF2J8eD4IAh365EYF1VN7BqWtuuTqyVig
         KG3k7tNNaydAUwSMTZpf1q4UPioiKJz4EDJT2sno6iYLvLhJPwXXK6A9MFJ1ngT47AY+
         UCYAvfY26WnTYr/g3Anm2CJ5Lv7pDVUS2bDTxj/D1b84vUkC6pmu0Ou9Ry88H31EQOgF
         yAc1ojTwlqYgYP8kFrw3GesWTTOGmcfzOgdiIgHHhqIA1Rl/c5ZpvrMEFBdI3jib3EPU
         xF/QH8QLhL5S1SKHK23PjlJ1b3TxgTEJyVJj1tB78QdHIUVTdOSfqOozXf7cyJHt4Yp4
         w1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794334794; x=1794939594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u4qLTe41InUkuJCgoejpmAJ1STr0utezqlPIhAywKXY=;
        b=Rvr0co+2VhRJNHAFPAHsKJ0Sncxai4T7RU9hQSWS6af6u29YJ5DzspyD0Wqz/a1wg3
         q0XjNnQisuS4qhkVJHPz9pr7P6CxriEUZNXD5p5IlWl/zKHXyQdCuBFj0b9TV8VB7xmq
         3hujPE7bInxe9kdE9qSxvxcO/zcSEQ2vB96yXlStXsPpLlHVWQkwMJkrsQyrMLT+yYEp
         Zk7+T2LGvTgdMgOZF/cfO2emREaYVgRV3c4DpCbRYl9k0WKyEAYV0p2gJlBKRz/p4ebT
         tLDv6YAUr83CoCkpYrjZfxJBLKfftsXEo9i9PNlEG4+uV6nwUPQ5uyqiR/YpaSSNKAI4
         M/ew==
X-Gm-Message-State: APuU4Z82UqcBFhm9gFwJmbv/zOYSdkw9VFKqr86NU8Y8KGkaNSyMuqL1
	8z7lQM8fndW6ZXwftsENvEl0XupHMpHQHPhn1LOGNKZTPPG8/hNw4ICZ+ig3w6cz
X-Gm-Gg: AYBFou0oPP16YN9AuzU5YhK3Qe9+l87MZPztqWnWvsy19AG2StGp4PAwZ9/1dp27yrH
	DV29gceNwXZIuVY1T7kbVaVyotl4yGCHOtbFpzvvtjHFa7oLEe1jdub6F/ogh5MIULaQEQfPXSQ
	k27H/wCCg423OXdzbFQJCXhpzhAcMA5iG+wkzO/4wu5zd4c579SM8eyfBuXzzY7rd2KinV79oYI
	heAXsfiQ4qBxO0EBrfRA25AoUW3lgprBkm9XMM/QpU0mEfr9WUPRyF6rSvAbXacPlgjezU/NLCG
	QJaLUYvwMFdSCgXKHkJ++pyHCpho1CzWebWCPPS5lA319rpis+oHI9oV4BKZbxk2P/H+ytz8+dl
	jRB5OPHMp/I7vsRgnSWekKX414TiRzNdMcJ+2NIhkGlh1/yjsPYuT3A9ZKuby9o/siXJeyIeHAT
	NF7dhA0xt+GY2AjfUvRH3l1wlNotbS/EnOtIMcTuv2Imz5H+3lYxUlGYRKXhDPlL/Ar8i3pmdG6
	ZpGqXIvQjki7zUoxi/hX+OlK/pdoyuSJkotm4BXKA2PRWxIhCyLwUC56XzTw4tALM8aPiXFFWi5
	2KhMo0s/RUQkujscOrz7v+6wqEMv5+AnPsNOZ9cQ+kTpM59EqYVxyWni2cwCaJG3tgHN1PJlNHT
	qeygxyZ23TaaLkzE=
X-Received: by 2002:a05:701b:4587:b0:14c:1f57:3e86 with SMTP id a92af1059eb24-1b3b604b015mr3761570c88.47.1794334794223;
        Tue, 10 Nov 2026 10:19:54 -0800 (PST)
Received: from obadmin-Precision-3680.atlascopco.group ([136.226.232.167])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2ff3bsm10394386c88.11.2026.11.10.10.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:19:53 -0800 (PST)
From: Sahaj Chaudhari <sahaj123.sc@gmail.com>
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org
Subject: [PATCH v3] ext4: test reserved GID block allocation
Date: Tue, 10 Nov 2026 23:50:40 +0530
Message-ID: <20261110182040.798390-1-sahaj123.sc@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a small ext4 filesystem with a nonzero reserved block pool and a
reserved GID stored in the superblock. Fill ordinary free space as an
unprivileged user outside that group, verify that another allocation is
denied, then verify that the same user can allocate a block with the
reserved group as its primary and only supplementary group.

This exercises loading s_resgid from the superblock rather than overriding
it with a resgid mount option, and detects the regression fixed by:

commit c87abbab6147 ("ext4: fix incorrect function call when initializing s_resgid")

Link: https://lore.kernel.org/r/20261008065651.3517824-1-sahaj123.sc@gmail.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sahaj Chaudhari <sahaj123.sc@gmail.com>
---
Changes since v2:
- Use fsgqa2 instead of root for the fill group, and require it explicitly.
- Do not inherit external MKFS_OPTIONS; exclude journal-dependent mount
  options for the test's no-journal filesystem.
- Check tune2fs and su -g/-G support, and use the validated su executable
  consistently.
- Require the fill operation to write data and reach ENOSPC; check that
  ordinary allocation also fails specifically with ENOSPC.
- Let the check harness unmount scratch and finish with _exit 0.
- Add Jan Kara's Reviewed-by.

Testing:
- ./check ext4/309 in isolated x86-64 QEMU with fresh TEST_DEV and
  SCRATCH_DEV images passes on the fixed kernel and fails specifically
  at reserved-GID allocation on the pre-c87abbab6147 kernel.
- Both filesystems pass e2fsck -fn after each run.
- bash -n and git diff --check pass. Validation is limited to ext4/309,
  not the full xfstests suite.

 tests/ext4/309     | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/309.out |  2 ++
 2 files changed, 77 insertions(+)
 create mode 100755 tests/ext4/309
 create mode 100644 tests/ext4/309.out

diff --git a/tests/ext4/309 b/tests/ext4/309
new file mode 100755
index 00000000..e5dcd215
--- /dev/null
+++ b/tests/ext4/309
@@ -0,0 +1,75 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Sahaj Chaudhari.  All Rights Reserved.
+#
+# FS QA Test No. 309
+#
+# Verify that the ext4 reserved GID can allocate blocks after ordinary
+# free space is exhausted.
+#
+. ./common/preamble
+_begin_fstest auto enospc quick
+
+_exclude_fs ext2
+_exclude_fs ext3
+_exclude_scratch_mount_option "resuid=" "resgid=" "data=" \
+	"data_err=abort" "commit=" "journal_async_commit" "journal_checksum"
+
+_fixed_by_kernel_commit c87abbab6147 \
+	"ext4: fix incorrect function call when initializing s_resgid"
+
+_require_scratch
+_require_command "$TUNE2FS_PROG" tune2fs
+_require_xfs_io_command "falloc"
+_require_user
+_require_group
+RES_GROUP=$qa_group
+_require_group fsgqa2
+FILL_GROUP=fsgqa2
+SU_PROG=$(command -v su) || _notrun "su utility required"
+"$SU_PROG" -s /bin/bash -g "$FILL_GROUP" -G "$FILL_GROUP" "$qa_user" \
+	-c true >/dev/null 2>&1 ||
+	_notrun "su with -g and -G support required"
+
+echo "Silence is golden"
+
+RESGID=$(_cat_group | awk -F: -v group="$RES_GROUP" \
+	'$1 == group { print $3 }')
+FILLGID=$(_cat_group | awk -F: -v group="$FILL_GROUP" \
+	'$1 == group { print $3 }')
+[ "$RESGID" != "$FILLGID" ] || _notrun "reserved and fill groups are identical"
+[ "$(id -u "$qa_user")" -ne 0 ] || _notrun "test user is root"
+TEST_FILE="$SCRATCH_MNT/ext4_resgid.fill"
+
+MKFS_OPTIONS="-m 10 -N 1024 -O ^has_journal" \
+	_scratch_mkfs_sized $((16 * 1024 * 1024)) 4096 >>"$seqres".full 2>&1
+"$TUNE2FS_PROG" -u 0 -g "$RESGID" "$SCRATCH_DEV" >>"$seqres".full 2>&1 ||
+	_fail "could not set scratch filesystem reserved GID"
+_scratch_mount
+
+touch "$TEST_FILE"
+chmod 0666 "$TEST_FILE"
+
+FILL_OUTPUT=$("$SU_PROG" -s /bin/bash -g "$FILL_GROUP" -G "$FILL_GROUP" \
+	"$qa_user" -c "$XFS_IO_PROG -f -c 'pwrite 0 16M' '$TEST_FILE'" 2>&1)
+FILL_STATUS=$?
+printf '%s\n' "$FILL_OUTPUT" >>"$seqres".full
+printf '%s\n' "$FILL_OUTPUT" | grep -q "pwrite: No space left on device" ||
+	_fail "space-fill operation did not reach ENOSPC (status $FILL_STATUS)"
+FILL_SIZE=$(_get_filesize "$TEST_FILE") ||
+	_fail "could not determine space-fill file size"
+[ "$FILL_SIZE" -gt 0 ] || _fail "space-fill operation wrote no data"
+
+if ALLOC_OUTPUT=$("$SU_PROG" -s /bin/bash -g "$FILL_GROUP" -G "$FILL_GROUP" \
+	"$qa_user" -c "$XFS_IO_PROG -c 'falloc 16M 4k' '$TEST_FILE'" 2>&1); then
+	_fail "ordinary user allocated from the reserved pool"
+fi
+printf '%s\n' "$ALLOC_OUTPUT" >>"$seqres".full
+printf '%s\n' "$ALLOC_OUTPUT" | grep -q "fallocate: No space left on device" ||
+	_fail "ordinary allocation failed for a reason other than ENOSPC"
+
+"$SU_PROG" -s /bin/bash -g "$RES_GROUP" -G "$RES_GROUP" "$qa_user" -c \
+	"$XFS_IO_PROG -c 'falloc 16M 4k' '$TEST_FILE'" \
+	>>"$seqres".full 2>&1 || _fail "reserved GID failed to allocate a block"
+
+_exit 0
diff --git a/tests/ext4/309.out b/tests/ext4/309.out
new file mode 100644
index 00000000..56330d65
--- /dev/null
+++ b/tests/ext4/309.out
@@ -0,0 +1,2 @@
+QA output created by 309
+Silence is golden

base-commit: d07dca72d2455f4ba8c660ad4c008541ccccb707
-- 
2.43.0

