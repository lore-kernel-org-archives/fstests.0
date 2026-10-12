Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28CB3D1CC6
	for <fstests@vger.kernel.org>; Mon, 12 Oct 2026 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804033; cv=none; b=dx9ZafC7Xaua1QGqMhlH2Krff4tyx7q5b3lRWfnWgzJlLEj4HEtS2ErpS8DXtyqkJKJtJ8Jj1FbmJwIxSb7ZCEQMpgL5d3jvxd6KPgGjW3W+SksJqO+B9wNBZ6yIZbsQFPjB64ZUQyENS+R80XjKiG2xXmnjshEuXy5tdOo8IbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804033; c=relaxed/simple;
	bh=ezAWYSiOMHcOstdnvKfBU9bKQrJnh5QmDMoZwJpeMDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kwMkKhCxVdREnwXiH9kHsQpifw9GCjFYzT84xZFNufhH1VBwZ4vpnuax9LJeisSXVbA7V5fLDGtN/WpReET3SE1Vy6D06x3HIhTynbSwmL03rIzM9DRJ/Pq51zmPdRedbqIw1LF2xmwTEZ3Lh3KE9w1GlaY4OM+kbXJ3yjm3hJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C//A1cln; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C//A1cln"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6768403e9bbso1291120d50.1
        for <fstests@vger.kernel.org>; Mon, 12 Oct 2026 04:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791804031; x=1792408831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QP2S9DQXjUWI2uMwvTrTir7We1C5El/+/5eKCgZBZu4=;
        b=C//A1clnWYnFjVMCPsTxlsi8wPcW5fMHsWQpbiAD9YRnu+CjyExnZDKlrtQ3E/5oCy
         q6GCIaXAFqpr1UnOETpa2VRE/kcl9gswLNP1qsl4ELQUfcxyldvmbRg4SgQfRUdCkU1a
         R8H7dt4wXYe40c+cb+Too4vMFre4FQOlM6ZFrbrHjgnUMvQXGq3il7CX3UOKKpxTcETj
         u/+w6ts0bVLkq1DyLuoLnd1YyNx+fuhHwWbXG++RmT1lY7VLIt2BsKjtUPMWT0QZdJi9
         XXKEIMgJuTSLykm1N9P35a/vgE7rbVKEq3/camePM+XH2LINcPyommyNgifvz7dt61lr
         L93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791804031; x=1792408831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QP2S9DQXjUWI2uMwvTrTir7We1C5El/+/5eKCgZBZu4=;
        b=dr4DUzPlo0udvjw7puj4lz6TBLF65KxYaPaLSbAVKuyTRfxDJGKAutduKkvWID71Ni
         Dh9b58mmJFiDPugDrQ6jsK36oSCp9zhzaSobtAPAkgTeFwxhPL+ISoB18WZvujGeciw/
         KtzqMwkIVbB3MB4spCwhawJo/rIsJd0etJyyi6peYYOP4n0LJsb34fRay2Ausk4RjbFm
         K3qn0stVCHF+fanl2NAb4EsK1aswhaWHDOhVpS+gIoDp8JPwmVwxFmv4N/TbeSmFWCIM
         Mj92BHRNcjFb1MRlXWae2mzFiSQ460gRe1OFtNJxnv/cy74cNKrvEWyUBoxsRylGMqp7
         YVYA==
X-Gm-Message-State: AFq9FYKWmk0R6k1/+mZ4I6kwRsZjaSwmVgrit9uP4v+2Z+W9C/mEvCSC
	f0zKsu88K2zavP4Zfy/BR25YhqFmkmiBeaiK4ZOmyVQP9hC/1xZQt+FiICrzDSFf
X-Gm-Gg: AYBFou0sf0SSs8op7fuivplqiRJaHZ00unYCLUeTEDeBmV18kUNGPHx7BzWhauiaAAd
	fkebvjUfmK9g6vCKuaC4Wua84J6iOgSW0CQ0n4yOHsxtt/ctpCoNs0N+2ZZKX9ylZMg2xnTnhDR
	2ySIDYIWLVRfgQG1X/M0ntsryRTPSNs4ErX4f5aq9aEH2P/P8uRpIDfoAgLsNDO3Pr8GXRHOTXj
	lLDIbG+0TULemdeen+5/Zg+aOSUdg6lw8Zal6kecVWdtv5RO9bhjEEAvVCUBYlR8ZRF/ysUKK2F
	ZlxhR6avHcxBcF2Zou1synv6pzkyACIXz2vNGcQirN22p4XYIdQZlIU8h8AIccVyS6o58E85sXi
	JAlSVZC1ZWScpKAOWu+kInz3KTzrDNsLW44KdzuJwnSYzWddNhXv3n8q4xXuyFmt36l4unOYKqz
	etu59CRwjSUiFnU4dPUdsQtLxRTQdK6aKw/y5ABLuu+VXa13Jk9+NbEquDDRoKhOnZKnrQw1rcU
	1pG9LwnRPkGDfh5AUi14icvTvJMVSzv
X-Received: by 2002:a05:690e:b49:b0:675:6da9:1473 with SMTP id 956f58d0204a3-67936984122mr3438760d50.19.1791804030782;
        Mon, 12 Oct 2026 04:20:30 -0700 (PDT)
Received: from obadmin-Precision-3680.atlascopco.group ([136.226.232.167])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6793566418bsm3662569d50.12.2026.10.12.04.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 04:20:30 -0700 (PDT)
From: Sahaj Chaudhari <sahaj123.sc@gmail.com>
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: test reserved GID block allocation
Date: Mon, 12 Oct 2026 16:51:09 +0530
Message-ID: <20261012112109.3363168-1-sahaj123.sc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an xfstests regression test that exhausts ordinary free space, then
checks that a process using ext4's reserved GID can allocate a block.

Link: https://lore.kernel.org/r/20261008065651.3517824-1-sahaj123.sc@gmail.com
Signed-off-by: Sahaj Chaudhari <sahaj123.sc@gmail.com>
---
 .gitignore          |   1 +
 src/Makefile        |   1 +
 src/t_ext4_resgid.c | 207 ++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/309      |  43 +++++++++
 tests/ext4/309.out  |   2 +
 5 files changed, 254 insertions(+)
 create mode 100644 src/t_ext4_resgid.c
 create mode 100755 tests/ext4/309
 create mode 100644 tests/ext4/309.out

diff --git a/.gitignore b/.gitignore
index d52ba4ad..9baf0aa4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -149,6 +149,7 @@ tags
 /src/t_enospc
 /src/t_ext4_dax_inline_corruption
 /src/t_ext4_dax_journal_corruption
+/src/t_ext4_resgid
 /src/t_futimens
 /src/t_get_file_time
 /src/t_getcwd
diff --git a/src/Makefile b/src/Makefile
index 0ff607ae..aba5da1e 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -16,6 +16,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	holetest af_unix t_mmap_stale_pmd \
 	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
 	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
+	t_ext4_resgid \
 	t_ofd_locks t_mmap_collision mmap-write-concurrent \
 	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
 	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
diff --git a/src/t_ext4_resgid.c b/src/t_ext4_resgid.c
new file mode 100644
index 00000000..3085a06a
--- /dev/null
+++ b/src/t_ext4_resgid.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <errno.h>
+#include <fcntl.h>
+#include <grp.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#define TEST_UID 1000
+#define FILL_GID 1001
+#define RESGID 456
+#define TEST_BLOCK_SIZE 4096
+#define MAX_BLOCKS 32768
+#define TEST_SKIP 77
+
+struct worker_result {
+	off_t offset;
+	int error;
+	int setup_error;
+};
+
+static int report_error(const char *message, int error)
+{
+	fprintf(stderr, "%s: %s\n", message, strerror(error));
+	return 1;
+}
+
+static void worker(int fd, gid_t gid, bool fill, off_t offset, int pipefd)
+{
+	struct worker_result result = {
+		.offset = offset,
+	};
+	ssize_t n;
+	int i;
+
+	if (setgroups(0, NULL) || setresgid(gid, gid, gid) ||
+	    setresuid(TEST_UID, TEST_UID, TEST_UID)) {
+		result.setup_error = errno;
+		goto report;
+	}
+
+	if (fill) {
+		for (i = 0; i < MAX_BLOCKS; i++) {
+			if (fallocate(fd, 0, result.offset, TEST_BLOCK_SIZE)) {
+				result.error = errno;
+				goto report;
+			}
+			result.offset += TEST_BLOCK_SIZE;
+		}
+		result.error = EFBIG;
+	} else if (fallocate(fd, 0, result.offset, TEST_BLOCK_SIZE)) {
+		result.error = errno;
+	}
+
+report:
+	do {
+		n = write(pipefd, &result, sizeof(result));
+	} while (n < 0 && errno == EINTR);
+	if (n != sizeof(result))
+		_exit(1);
+	_exit(0);
+}
+
+static int read_result(int fd, struct worker_result *result)
+{
+	char *data = (char *)result;
+	size_t remaining = sizeof(*result);
+
+	while (remaining) {
+		ssize_t n = read(fd, data, remaining);
+
+		if (n < 0 && errno == EINTR)
+			continue;
+		if (n < 0)
+			return -errno;
+		if (!n)
+			return -EIO;
+		data += n;
+		remaining -= n;
+	}
+
+	return 0;
+}
+
+static int run_worker(int fd, gid_t gid, bool fill, off_t offset,
+		      struct worker_result *result)
+{
+	int pipefd[2], status, ret;
+	pid_t pid, waited;
+
+	if (pipe(pipefd))
+		return -errno;
+
+	pid = fork();
+	if (pid < 0) {
+		ret = -errno;
+		close(pipefd[0]);
+		close(pipefd[1]);
+		return ret;
+	}
+	if (!pid) {
+		close(pipefd[0]);
+		worker(fd, gid, fill, offset, pipefd[1]);
+	}
+
+	close(pipefd[1]);
+	ret = read_result(pipefd[0], result);
+	close(pipefd[0]);
+
+	do {
+		waited = waitpid(pid, &status, 0);
+	} while (waited < 0 && errno == EINTR);
+	if (waited < 0)
+		return -errno;
+	if (waited != pid || !WIFEXITED(status) || WEXITSTATUS(status))
+		return -EIO;
+
+	return ret;
+}
+
+int main(int argc, char **argv)
+{
+	char filename[PATH_MAX];
+	struct worker_result fill_result, group_result;
+	int fd = -1, ret = 1, result;
+	bool created = false;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s mountpoint\n", argv[0]);
+		return 2;
+	}
+	result = snprintf(filename, sizeof(filename), "%s/ext4_resgid.fill",
+			  argv[1]);
+	if (result < 0 || (size_t)result >= sizeof(filename)) {
+		fprintf(stderr, "mountpoint path is too long\n");
+		return 2;
+	}
+
+	fd = open(filename, O_CREAT | O_EXCL | O_RDWR, 0666);
+	if (fd < 0)
+		return report_error("creating test file", errno);
+	created = true;
+
+	if (fchown(fd, TEST_UID, FILL_GID))
+		goto fail_file;
+	if (fchmod(fd, 0666))
+		goto fail_file;
+
+	result = run_worker(fd, FILL_GID, true, 0, &fill_result);
+	if (result)
+		goto fail_worker;
+	if (fill_result.setup_error) {
+		fprintf(stderr, "dropping fill-worker credentials: %s\n",
+			strerror(fill_result.setup_error));
+		ret = fill_result.setup_error == EPERM ? TEST_SKIP : 1;
+		goto out;
+	}
+	if (fill_result.error != ENOSPC) {
+		fprintf(stderr, "unprivileged fill stopped with %s, expected ENOSPC\n",
+			strerror(fill_result.error));
+		goto out;
+	}
+
+	result = run_worker(fd, RESGID, false, fill_result.offset, &group_result);
+	if (result)
+		goto fail_worker;
+	if (group_result.setup_error) {
+		fprintf(stderr, "setting reserved-GID credentials: %s\n",
+			strerror(group_result.setup_error));
+		ret = group_result.setup_error == EPERM ? TEST_SKIP : 1;
+		goto out;
+	}
+	if (group_result.error) {
+		fprintf(stderr, "reserved-GID allocation failed: %s\n",
+			strerror(group_result.error));
+		goto out;
+	}
+
+	ret = 0;
+	goto out;
+
+fail_file:
+	ret = report_error("setting test-file owner and mode", errno);
+	goto out;
+fail_worker:
+	ret = report_error("running allocation worker", -result);
+out:
+	if (fd >= 0 && close(fd)) {
+		fprintf(stderr, "closing test file: %s\n", strerror(errno));
+		ret = 1;
+	}
+	if (created && unlink(filename)) {
+		fprintf(stderr, "removing test file: %s\n", strerror(errno));
+		ret = 1;
+	}
+
+	return ret;
+}
diff --git a/tests/ext4/309 b/tests/ext4/309
new file mode 100755
index 00000000..0702a3dd
--- /dev/null
+++ b/tests/ext4/309
@@ -0,0 +1,43 @@
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
+_exclude_scratch_mount_option "resuid=" "resgid="
+
+_fixed_by_kernel_commit c87abbab6147 \
+	"ext4: fix incorrect function call when initializing s_resgid"
+
+_require_scratch
+_require_command "$TUNE2FS_PROG" tune2fs
+_require_test_program "t_ext4_resgid"
+
+echo "Silence is golden"
+
+MKFS_OPTIONS="-m 10 -N 1024 -O ^has_journal $MKFS_OPTIONS" \
+	_scratch_mkfs_sized $((16 * 1024 * 1024)) 4096 >>"$seqres".full 2>&1
+"$TUNE2FS_PROG" -u 123 -g 456 "$SCRATCH_DEV" >>"$seqres".full 2>&1
+_scratch_mount
+
+if "$here/src/t_ext4_resgid" "$SCRATCH_MNT" >>"$seqres".full 2>&1; then
+	:
+else
+	ret=$?
+	if [ "$ret" -eq 77 ]; then
+		_notrun "cannot drop worker privileges"
+	fi
+	_fail "reserved-GID allocation test failed"
+fi
+
+_scratch_unmount
+status=0
+exit
diff --git a/tests/ext4/309.out b/tests/ext4/309.out
new file mode 100644
index 00000000..56330d65
--- /dev/null
+++ b/tests/ext4/309.out
@@ -0,0 +1,2 @@
+QA output created by 309
+Silence is golden
-- 
2.43.0

