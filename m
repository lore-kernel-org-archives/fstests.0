Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911D76026
	for <fstests@vger.kernel.org>; Tue, 18 Aug 2026 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035237; cv=none; b=K1Hz52oHqxEqHmN1PKEmF9VMThYZSzEg0p1yq+pjxmZcJuXrvYTMdDXsanF1mvPVw/XiO/+WyIPnbrAptQe0MqGcwZ9mBKtPUCMAAYIuercVHWBapDL+1NO3nDUN9EY3jDKm5FAIabjnSgzPdsgLfY+2REYUOzaf+4G9PD8ty8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035237; c=relaxed/simple;
	bh=ema5EO857V1xlh+GIRXb9OU98vo+p0l2j1i/VjUWS0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kxC/XWlil0npD/XTUfCQvL5AwJTHR245dBJ3tizyZFDSrCNnzDj+tPAE/YKeZDdIw3cfaJpBgWFa7PivgEOVQ4xY16KZCyuyEuWgqLFRmIXrRz2Uy1i2rfooGMR/drWXoFOWmEpR4iqoKMMymXcaQRYqVF+5PFL2237ORIwrP7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mb25LWd6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mb25LWd6"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caea3f742bso71658985ad.0
        for <fstests@vger.kernel.org>; Mon, 17 Aug 2026 23:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787035235; x=1787640035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QX0b74IlpbSM3dgK046b30SEVwdUCS3eQbsy8vqL4EY=;
        b=Mb25LWd69B+lOlSt6crs9eFc9wSY5FoPtGwtc9C/ArGnMU+V39orGKlloAh4Y0gL+6
         /pROWJudD0OZX9Ba8cFT+/bS08EgdAD6wAGCEB0E+anS9JiS6oJnhSqAlTDpTqFNNJMB
         euVTQbWGnEGmx+m/hHQe2GRRtXmdgLMIKy0suYFo0x8IN4RWdWoJEnsFtgyMGcrm8E66
         MW8pNTsae32EsGsV7ChCa1Fx2/7p5lHsvZYNF7ZP/0ZebqGkWRyGUM1+DTLlvZKGLVmc
         W7TuEs6BC6y9eirUxAk+qDJ0vrwHEyVM5G+P9NZbOSNnb4z/jyYejrzGOjZVYeLgalCH
         i1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787035235; x=1787640035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QX0b74IlpbSM3dgK046b30SEVwdUCS3eQbsy8vqL4EY=;
        b=drq5dSJiEOobf5KOWCTFC18PPjp9XGcHGZh3FuqcoUEz1afV9eZgisrol90l/u813x
         4JcMDC8I2smOjdI4vVWcu+MTeP3iPTLzAokE/WjM7rJ+2vb4ZQEmnrFKYvTMu+nA7nqa
         i8dLWa1DWCizlnbTWD1L0MWe0JKSwBmZZNurpRfvep9uQfYydsUH0i9sZ+sTrQa1jEew
         b7zcq4NfjSAdYhEO4ohW8SclU3rnOyhWqygUExKQj0fWGi4GwLJ/TKYwxzOwfRskbufZ
         t3M2WpGptE++g2OfvkUjIgGxZPKoSC2q2dtnz8ybxiX/GfD07unElT+J7XsBMd39vfTn
         ZM9g==
X-Gm-Message-State: AOJu0YzZhBYLA4UPcl5NmAtHNlnfwsrAFqDtRmS47QhKTUKUKyk1/Tdr
	AHHaKJOHh0BeqAp/WEkbGANLRtm/aCpm5wE7ATzHlUEw9Z2JUgLzFTJGzeJpDQ==
X-Gm-Gg: AR+sD10k6o4n0PkEicFYcd2RC/iXPCZEzmZ1beWPpyzUgkuxAarrkM4qnFTDKiwxOTN
	f/2VlQOMuY+e3Tbc0FQ1+r7jXN8F2FdsGscBxOmw6z1gLYIR1LtWbe+1IRoNZ9580vzQ/BEPKVV
	b3WUbma06k7LEda0vNasspP2Nt3qYEoW1x9gesYl6IToq2DjB7kfAr/M5yoc0XNyPhMv0sYObkL
	AQjd4u/8tAsaoDo99nEkxVsHAfmnxpjDrog9bMkoHSLfjcIrm1KjPNVSskcuv27sIUBMR4pMmnW
	Z3dgjdZPtC76JAqGOzLEO0rJFCjE4aySMHUtSeUQOlYAxIVBH7XWxzpuftSmDbT8YLmejzDBAnp
	stqQkkMbDc3O0mkfaTlcrKKM8JOOGkMrkqlXerpHatp9Df5e8ECHOwDgkLlhhJKrrQEdTqS3h2C
	pZHjwbWKvjRqNYNcOGFePFx5Pc2bpR5x3HAF5nlAGB2xIG+onfmFB4XZ9Vl2CTVJbX8mDPnEl1P
	Ccd/SY=
X-Received: by 2002:a05:6a21:6e97:b0:3c3:bbe6:95c9 with SMTP id adf61e73a8af0-3ccda7cdfcdmr8772111637.16.1787035234931;
        Mon, 17 Aug 2026 23:40:34 -0700 (PDT)
Received: from n232-175-066.byted.org ([36.110.163.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc13bf05584sm1642041a12.4.2026.08.17.23.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:40:34 -0700 (PDT)
From: guzebing <guzebing1612@gmail.com>
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@kernel.org>,
	linux-ext4@vger.kernel.org,
	guzebing <guzebing1612@gmail.com>
Subject: [PATCH] ext4/064: add regression test for delalloc remount leak
Date: Tue, 18 Aug 2026 14:40:23 +0800
Message-Id: <20260818064023.2309786-1-guzebing1612@gmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A delalloc filesystem rejects a remount with nodelalloc, but ext4 used to
apply the option change before rejecting the remount.  Concurrent buffered
writes and truncates can observe the transient nodelalloc state and fail to
release delayed allocation reservations.  The leaked reservations are then
reported when the inodes are evicted during unmount.

Add an ext4 regression test that starts concurrent write/truncate workers and
an expected-failing remount,nodelalloc worker, stops them after a short stress
window, and checks dmesg for leaked delayed allocation reservations.

The proposed kernel fix is still under review:
https://lore.kernel.org/linux-ext4/20260814034855.1573759-1-guzebing1612@gmail.com/

Local validation showed that the test fails without the proposed kernel fix,
with i_reserved_data_blocks not cleared warnings during unmount, and passes
with the proposed fix applied.

Signed-off-by: guzebing <guzebing1612@gmail.com>
---
 tests/ext4/064     | 216 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/064.out |   2 +
 2 files changed, 218 insertions(+)
 create mode 100755 tests/ext4/064
 create mode 100644 tests/ext4/064.out

diff --git a/tests/ext4/064 b/tests/ext4/064
new file mode 100755
index 00000000..5d43764c
--- /dev/null
+++ b/tests/ext4/064
@@ -0,0 +1,216 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 guzebing.  All Rights Reserved.
+#
+# FS QA Test No. ext4/064
+#
+# Exercise rejected delalloc to nodelalloc remounts while buffered writes and
+# truncates are active.  A remount used to clear EXT4_MOUNT_DELALLOC before
+# rejecting the transition, so a concurrent truncate could fail to release
+# delayed allocation reservations.  The leaked inode reservation is reported
+# when the inode is evicted during unmount.
+#
+# This is a regression test for the issue fixed by the proposed patch:
+# "ext4: reject delalloc to nodelalloc remount before applying options"
+# https://lore.kernel.org/linux-ext4/20260814034855.1573759-1-guzebing1612@gmail.com/
+#
+. ./common/preamble
+_begin_fstest auto stress mount
+
+writer_pids=()
+remounter_pid=
+stop_file=$tmp.stop
+worker_error=$tmp.worker_error
+remounter_error=$tmp.remounter_error
+remounter_count=$tmp.remounter_count
+
+stop_workload()
+{
+	touch "$stop_file"
+	if [ -n "$remounter_pid" ]; then
+		wait "$remounter_pid" 2>/dev/null
+		remounter_pid=
+	fi
+	if [ "${#writer_pids[@]}" -gt 0 ]; then
+		wait "${writer_pids[@]}" 2>/dev/null
+		writer_pids=()
+	fi
+}
+
+# Override the default cleanup function.
+_cleanup()
+{
+	stop_workload
+	cd /
+	_is_dir_mountpoint "$SCRATCH_MNT" >/dev/null &&
+		_scratch_unmount >/dev/null 2>&1
+	rm -f "$stop_file" "$worker_error" "$worker_error".* \
+		"$tmp.xfs_io_error".* "$remounter_error" "$remounter_count"
+}
+
+# Import common functions.
+. ./common/filter
+
+_exclude_fs ext2
+_exclude_fs ext3
+_exclude_scratch_mount_option "data=journal" "dax" "nodelalloc"
+_require_check_dmesg
+_require_scratch_size $((2 * 1024 * 1024))
+_require_xfs_io_command "pwrite"
+_require_xfs_io_command "truncate"
+
+record_worker_error()
+{
+	local command=$1
+	local file=$2
+	local err=$3
+	local log=$worker_error.$BASHPID
+
+	{
+		echo "worker failed:"
+		echo "  command: $command"
+		echo "  file: $file"
+		echo "  stderr:"
+		if [ -s "$err" ]; then
+			sed 's/^/    /' "$err"
+		else
+			echo "    <empty>"
+		fi
+	} > "$log"
+	touch "$worker_error"
+}
+
+write_truncate_loop()
+{
+	local file=$1
+	local err=$tmp.xfs_io_error.$BASHPID
+
+	while [ ! -e "$stop_file" ]; do
+		$XFS_IO_PROG -f -c "pwrite -q 0 32m" "$file" \
+			>/dev/null 2>"$err" || {
+			record_worker_error \
+				'xfs_io -f -c "pwrite -q 0 32m"' "$file" "$err"
+			break
+		}
+		$XFS_IO_PROG -c "truncate 256k" "$file" \
+			>/dev/null 2>"$err" || {
+			record_worker_error \
+				'xfs_io -c "truncate 256k"' "$file" "$err"
+			break
+		}
+	done
+	rm -f "$err"
+}
+
+log_worker_errors()
+{
+	local log
+
+	test -e "$worker_error" || return 0
+
+	echo "write/truncate worker failure details:" >> "$seqres.full"
+	for log in "$worker_error".*; do
+		test -f "$log" || continue
+		cat "$log" >> "$seqres.full"
+	done
+}
+
+remount_loop()
+{
+	local count=0
+
+	while [ ! -e "$stop_file" ]; do
+		# This remount is expected to fail.  The bug is that ext4 used
+		# to expose the transient nodelalloc state before failing it.
+		if $MOUNT_PROG -o remount,nodelalloc "$SCRATCH_DEV" "$SCRATCH_MNT" \
+			>/dev/null 2>&1; then
+			echo "delalloc to nodelalloc remount unexpectedly succeeded" \
+				> "$remounter_error"
+			touch "$stop_file"
+			break
+		fi
+		count=$((count + 1))
+	done
+	echo "$count" > "$remounter_count"
+}
+
+log_remount_result()
+{
+	local remounts=0
+
+	if [ -s "$remounter_count" ]; then
+		read -r remounts < "$remounter_count"
+	fi
+	echo "rejected remounts: $remounts" >> "$seqres.full"
+
+	if [ -s "$remounter_error" ]; then
+		echo "remount worker failure details:" >> "$seqres.full"
+		sed 's/^/  /' "$remounter_error" >> "$seqres.full"
+	fi
+}
+
+sleep_msg_ratelimit_interval()
+{
+	local dev=$(_short_dev "$SCRATCH_DEV")
+	local interval_file=/sys/fs/ext4/$dev/msg_ratelimit_interval_ms
+	local interval_ms=0
+	local sleep_secs
+
+	if [ -r "$interval_file" ]; then
+		read -r interval_ms < "$interval_file"
+	fi
+	case "$interval_ms" in
+	''|*[!0-9]*)
+		interval_ms=0
+		;;
+	esac
+
+	sleep_secs=$(((interval_ms + 999) / 1000 + 1))
+	# Repeated expected remount failures can consume ext4's message
+	# ratelimit budget.  Wait one interval plus one second before
+	# unmount so "i_reserved_data_blocks .* not cleared!" is not
+	# filtered out by the ratelimit.
+	echo "sleeping ${sleep_secs}s for ext4 msg ratelimit interval" \
+		"(${interval_ms}ms)" >> "$seqres.full"
+	sleep "$sleep_secs"
+}
+
+echo "Silence is golden"
+
+_scratch_mkfs >> "$seqres.full" 2>&1
+_scratch_mount -o delalloc
+
+options_file=/proc/fs/ext4/$(_short_dev "$SCRATCH_DEV")/options
+grep -qw delalloc "$options_file" ||
+	_fail "scratch filesystem is not mounted with delalloc"
+
+for ((i = 0; i < 16; i++)); do
+	write_truncate_loop "$SCRATCH_MNT/file-$i" &
+	writer_pids+=("$!")
+done
+
+remount_loop &
+remounter_pid=$!
+
+runtime=$((30 * TIME_FACTOR))
+sleep "$runtime"
+
+stop_workload
+log_worker_errors
+log_remount_result
+
+sleep_msg_ratelimit_interval
+_scratch_unmount || _fail "scratch filesystem unmount failed"
+
+warning="i_reserved_data_blocks .* not cleared!"
+if _check_dmesg_for "$warning"; then
+	_dmesg_since_test_start | grep -E "$warning" >> "$seqres.full"
+	_fail "delayed allocation reservations leaked during rejected remount"
+fi
+test ! -e "$remounter_error" ||
+	_fail "delalloc to nodelalloc remount unexpectedly succeeded"
+test ! -e "$worker_error" || _fail "write/truncate worker failed"
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/064.out b/tests/ext4/064.out
new file mode 100644
index 00000000..d9076546
--- /dev/null
+++ b/tests/ext4/064.out
@@ -0,0 +1,2 @@
+QA output created by 064
+Silence is golden

base-commit: acb6d4cb84205a8e3f19ca470cfcf7bf6d93a509
-- 
2.20.1

