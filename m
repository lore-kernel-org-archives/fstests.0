Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857A3E3D8E
	for <fstests@vger.kernel.org>; Wed,  5 Aug 2026 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914329; cv=none; b=FMNqBBTTW5zkpYXgp02g0WaZfHM8Vxv8hhuZC1DLXCzwzW53/7HSMB/aaYMV3Cd73Xmrc4KIINIg8tDAIJb0ZJeLiUnzdwK/VyApG9yxq6kqBbO1DqSRXrhbqA25gOrh2MK5CH+4RpK/N8fiiYij/wqR+8cyy4xCA3pWR0y52sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914329; c=relaxed/simple;
	bh=3dAPUhyZBX8IDsralCwbAEGIgsMuD1G4/o4jZWId4qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+dmRIYRl03hhFIkbYbm3oMRhiKN/58kendcNo5I810/mv0PZ249YHY86br4b3SjhoLE/y5MHIsBRG7BnTYXC2rw63GtCXaZtTpgMwn1XDi5zAqXvTjUxuw9npMeTmWloxb6GOSdrAELsW/kXlIuDDejOcjMUAejINwmb13vb30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n/IFdTxr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/IFdTxr"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38101f85591so1611057a91.1
        for <fstests@vger.kernel.org>; Wed, 05 Aug 2026 00:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785914327; x=1786519127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lh2620vaE445e1Spt9lVD8B0gj7jhXojq342pAMtOGs=;
        b=n/IFdTxr1thGydpMj3LPKCswgBptKWUqGskebeNNBovldv2pJBkyI4q1Qn6zi+Mxqm
         q6/74Ix3a9jh+d13270mZJuRuFExmAaSTu7fvrth8Z1FT/vf+IyZpKRHhnA0c994zacH
         foHsDNq25P5+h0TXxPnWFg23joegBaSQIDV37FcCF5vGreADSOOHeoM2cd57FxU6PwII
         x0yI7RdQNog1E3cBuBSgjt+KkVZuJVESanpzQT1WCsOo7WfdxCryR2xtm+q6eTmRaMM0
         9rG/F9zDCWexwvK77vh30+U9Hi7WSdyYPkSfB17f/f6wi4WlaPaZwo8nC6vS2+Nimqcu
         279A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785914327; x=1786519127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lh2620vaE445e1Spt9lVD8B0gj7jhXojq342pAMtOGs=;
        b=hMsvMTQ3byeIe8InVOwiT4JCE9MxqYFHaUKV0Y3dT0QwMwxCiIUGrQ9CLSECMuQWNw
         84Gp10HSeyNRoU/DsDfGdVPfIK0JL6ewSEO37U1I5JlXFa71kkhbQvTAEWu8KfxAQZGd
         1+H/XpUJICBOujwVLTFWdQ1KvxDSU9mDxQx3Z8qGGcAzIBhV1GlW1RXddqF67e+h/8nA
         gEruGx262OU3mDAyDGFzYEoDgGaF7X/ofzq8q0ZGge8O5p5GZKqFNaBjQUJtygeXpAcf
         e1z5FwAvZ176b9AWhCrD5de6aASO/hGGOSFyoDaJNdimWOXASiZi07BTvjShwQNUy/WU
         2l4w==
X-Gm-Message-State: AOJu0YyNaTllbJbM4REkEvlYxrdfutL3brLPPsAfWJ+lnNRmvV6Pq+MZ
	O2CQSgiR3zT8zrtkZej01NERVWhTJbOpCGgjQTlgBV9bexiBzzESmBm/6QwJOmqA
X-Gm-Gg: AR+sD128bW6FdN+u+c5xdo1x3x4Egc2xEN0uSQtI1jpKzMXkDkbPOP2vbRYfnBB34/s
	Dk8tLydJ3PtKAw5ikHIKE4c53sX6yW+RLugDiw78Sga2NgiIEFkIijZ31e3qrVgn2ak609iAxBn
	2LG12PiZJIvxqI+9WH/8bp9LmMy6kN+OssBaA/TDTxW40v3tHq3iGJRrocSy/hNtXiwrJPuCFEL
	nigEe/yottOk+xCMHjquJMvDfJpkp5HxxxJwWjeY/doEZlIIQxo3tLvHsWr5MszkAwidFG+S30q
	49/DUj6xVY1lhetjYLjOdCxY2h9qBsRltcY80TbDjQNrf86q8UOpR0wbk1vO5jsM9FhaWmxuhXr
	3sMR+N0Aj9/2eFXsyrwUVtTU9+coYd3L3kxOvCA4Tkq6hFUULGhVHi/taIlM9GvlhEzhFc1Ko6x
	6mMOuZuarL0t7oZKQrOfHcVaD4+gdcOdub1TxIE2UO0jBJVExGfQToVOj8Dq1G72p6FcRAMxD1Y
	U3uV/lmS+20gcANLYm8OfgYIo7HiXvKLcFr7NDodslvxpWrJEbxQ6Fltb4Q9UJckr7w3cDtzMQa
	Tr9xwWS0OiH3GYuWySyH+lCAXsBSYLsVQFPWYqnfCsR3jp+/Tsbe
X-Received: by 2002:a17:90b:530b:b0:387:d5bd:6231 with SMTP id 98e67ed59e1d1-3903c719d7emr2270780a91.20.1785914326526;
        Wed, 05 Aug 2026 00:18:46 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fedc650a0sm3638742a91.14.2026.08.05.00.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 00:18:46 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: fstests@vger.kernel.org
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	Zorro Lang <zlang@kernel.org>
Subject: [PATCH 2/2] generic: test FIDEDUPERANGE result reporting
Date: Wed,  5 Aug 2026 15:18:39 +0800
Message-ID: <20260805071839.3423779-3-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805071839.3423779-1-matthias.goergens@gmail.com>
References: <20260805071839.3423779-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfs_io retries shortened dedupe operations, so its output cannot verify one
raw multi-destination ioctl or distinguish an explicit zero-length request
from a nonzero request shortened to zero.

Add a small FIDEDUPERANGE helper that reports each destination's raw
bytes_deduped and status fields.  Use it in generic/806 to check an explicit
zero-length success, a request that is shortened for an interior destination
but remains full-length at EOF, and a sub-block request that returns -EINVAL
for the interior destination while succeeding at EOF.

Compute the request lengths from the filesystem block size so the expected
semantics do not assume 4K blocks.  The paired kernel series is linked from
the cover letter.

The test passes on btrfs and XFS with the paired kernel changes.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 src/Makefile          |   2 +-
 src/fideduperange.c   | 138 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/806     |  83 +++++++++++++++++++++++++
 tests/generic/806.out |   4 ++
 4 files changed, 226 insertions(+), 1 deletion(-)
 create mode 100644 src/fideduperange.c
 create mode 100755 tests/generic/806
 create mode 100644 tests/generic/806.out

diff --git a/src/Makefile b/src/Makefile
index 76cf50c3..e686fe27 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -25,7 +25,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
-	locktest unwritten_mmap bulkstat_unlink_test deduperace \
+	locktest unwritten_mmap bulkstat_unlink_test deduperace fideduperange \
 	bulkstat_unlink_test_modified t_dir_offset t_futimens t_immutable \
 	stale_handle pwrite_mmap_blocked t_dir_offset2 seek_sanity_test \
 	seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner \
diff --git a/src/fideduperange.c b/src/fideduperange.c
new file mode 100644
index 00000000..24813de8
--- /dev/null
+++ b/src/fideduperange.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Issue a raw FIDEDUPERANGE ioctl and report each destination's result.
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <linux/fs.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#ifndef FIDEDUPERANGE
+/* These definitions must match the kernel UAPI. */
+#define FILE_DEDUPE_RANGE_SAME		0
+#define FILE_DEDUPE_RANGE_DIFFERS	1
+
+struct file_dedupe_range_info {
+	__s64 dest_fd;
+	__u64 dest_offset;
+	__u64 bytes_deduped;
+	__s32 status;
+	__u32 reserved;
+};
+
+struct file_dedupe_range {
+	__u64 src_offset;
+	__u64 src_length;
+	__u16 dest_count;
+	__u16 reserved1;
+	__u32 reserved2;
+	struct file_dedupe_range_info info[0];
+};
+
+#define FIDEDUPERANGE _IOWR(0x94, 54, struct file_dedupe_range)
+#endif
+
+static void
+usage(const char *progname)
+{
+	fprintf(stderr,
+		"Usage: %s src src_offset length dest dest_offset "
+		"[dest dest_offset ...]\n",
+		progname);
+	exit(EXIT_FAILURE);
+}
+
+static uint64_t
+parse_u64(const char *arg, const char *name)
+{
+	char *end;
+	unsigned long long value;
+
+	errno = 0;
+	value = strtoull(arg, &end, 0);
+	if (errno || end == arg || *end != '\0') {
+		fprintf(stderr, "Invalid %s: %s\n", name, arg);
+		exit(EXIT_FAILURE);
+	}
+
+	return value;
+}
+
+int
+main(int argc, char **argv)
+{
+	struct file_dedupe_range *range;
+	size_t range_size;
+	unsigned int dest_count;
+	unsigned int i;
+	int src_fd;
+	int ret;
+
+	if (argc < 6 || (argc - 4) % 2 != 0)
+		usage(argv[0]);
+
+	dest_count = (argc - 4) / 2;
+	if (dest_count > UINT16_MAX) {
+		fprintf(stderr, "Too many destinations: %u\n", dest_count);
+		return EXIT_FAILURE;
+	}
+
+	range_size = sizeof(*range) +
+			dest_count * sizeof(struct file_dedupe_range_info);
+	range = calloc(1, range_size);
+	if (!range) {
+		perror("calloc");
+		return EXIT_FAILURE;
+	}
+
+	src_fd = open(argv[1], O_RDONLY);
+	if (src_fd < 0) {
+		perror(argv[1]);
+		free(range);
+		return EXIT_FAILURE;
+	}
+
+	range->src_offset = parse_u64(argv[2], "source offset");
+	range->src_length = parse_u64(argv[3], "length");
+	range->dest_count = dest_count;
+
+	for (i = 0; i < dest_count; i++) {
+		const char *dest_path = argv[4 + i * 2];
+
+		range->info[i].dest_fd = open(dest_path, O_RDWR);
+		if (range->info[i].dest_fd < 0) {
+			perror(dest_path);
+			ret = EXIT_FAILURE;
+			goto close_destinations;
+		}
+		range->info[i].dest_offset =
+			parse_u64(argv[5 + i * 2], "destination offset");
+	}
+
+	if (ioctl(src_fd, FIDEDUPERANGE, range) < 0) {
+		perror("FIDEDUPERANGE");
+		ret = EXIT_FAILURE;
+		goto close_destinations;
+	}
+
+	for (i = 0; i < dest_count; i++)
+		printf("destination %u: bytes=%" PRIu64 " status=%d\n", i,
+		       (uint64_t)range->info[i].bytes_deduped,
+		       range->info[i].status);
+	ret = EXIT_SUCCESS;
+
+close_destinations:
+	while (i > 0) {
+		i--;
+		close(range->info[i].dest_fd);
+	}
+	close(src_fd);
+	free(range);
+	return ret;
+}
diff --git a/tests/generic/806 b/tests/generic/806
new file mode 100755
index 00000000..98254b79
--- /dev/null
+++ b/tests/generic/806
@@ -0,0 +1,83 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Matthias Goergens. All Rights Reserved.
+#
+# FS QA Test No. 806
+#
+# Check FIDEDUPERANGE result reporting for zero-length requests and for a
+# multi-destination request where the VFS shortens only some destinations.
+#
+. ./common/preamble
+_begin_fstest auto quick dedupe clone
+
+. ./common/reflink
+
+_require_scratch_dedupe
+_require_test_program "fideduperange"
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+block_size=$(_get_block_size "$SCRATCH_MNT")
+short_length=$((2 * block_size))
+full_length=$((short_length + 100))
+
+src=$SCRATCH_MNT/src
+src_short=$SCRATCH_MNT/src-short
+dest_interior=$SCRATCH_MNT/dest-interior
+dest_eof=$SCRATCH_MNT/dest-eof
+dest_short_eof=$SCRATCH_MNT/dest-short-eof
+
+$XFS_IO_PROG -f -c "pwrite -S 0x6b 0 $full_length" "$src" \
+	>>$seqres.full 2>&1
+$XFS_IO_PROG -f -c "pwrite -S 0x6b 0 100" "$src_short" \
+	>>$seqres.full 2>&1
+$XFS_IO_PROG -f -c "pwrite -S 0x6b 0 $((full_length + block_size))" \
+	"$dest_interior" >>$seqres.full 2>&1
+$XFS_IO_PROG -f -c "pwrite -S 0x6b 0 $full_length" "$dest_eof" \
+	>>$seqres.full 2>&1
+$XFS_IO_PROG -f -c "pwrite -S 0x6b 0 100" "$dest_short_eof" \
+	>>$seqres.full 2>&1
+
+check_results()
+{
+	local description="$1"
+	local expected="$2"
+	shift 2
+	local result
+	local ret
+
+	result=$($here/src/fideduperange "$@" 2>&1)
+	ret=$?
+	{
+		echo "$description"
+		echo "$result"
+	} >>$seqres.full
+
+	if [ $ret -ne 0 ]; then
+		_fail "$description: ioctl helper failed"
+	fi
+	if [ "$result" != "$expected" ]; then
+		_fail "$description: unexpected ioctl result"
+	fi
+
+	echo "$description"
+}
+
+expected="destination 0: bytes=0 status=0"
+check_results "zero length: 0 bytes, SAME" "$expected" \
+	"$src" 0 0 "$dest_interior" 0
+
+expected="destination 0: bytes=$short_length status=0
+destination 1: bytes=$full_length status=0"
+check_results "mixed partial request: shortened, full" "$expected" \
+	"$src" 0 "$full_length" "$dest_interior" 0 "$dest_eof" 0
+
+expected="destination 0: bytes=0 status=-22
+destination 1: bytes=100 status=0"
+check_results "mixed sub-block request: EINVAL, full" "$expected" \
+	"$src_short" 0 100 "$dest_interior" 0 "$dest_short_eof" 0
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/806.out b/tests/generic/806.out
new file mode 100644
index 00000000..d7226e34
--- /dev/null
+++ b/tests/generic/806.out
@@ -0,0 +1,4 @@
+QA output created by 806
+zero length: 0 bytes, SAME
+mixed partial request: shortened, full
+mixed sub-block request: EINVAL, full
-- 
2.55.0

