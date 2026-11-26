Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795724982;
	b=nhWYDUcGtwt6+SHuZB+uvc02EvSWowIDCEufynlEY1nHM0vGoT/vn6UX6Xy5dEaDaGON
	 bmKn7OiVEhiyrezOFgJib+LEqhTrWvNMOqnGF0vxuoFHzhx8YUrQHeds/c1mRTLyxR2Ss
	 rsweD7YJGsKh7adoOMs8LDKf5ylpp7fwygMjliKdJCAYHxexDr3ohdiW9ePTbZQuL9ual
	 jOtI6O1wto4isnnuybuQ0mccgnmUJ0vxua7Sdye/1algiPhuKaBlOrkxJMJJec2c1aB5I
	 +8OZiuXN7Iq683FUiKiG0tncN/ZOasKlPzmb+jG1Wg3LaqPbafhqVj0gRJwzhJcEyOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724982;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KCjWiZiwXp5sJmT9pw/lHFyVaUG6to6r2YGXNlsYx/0=;
	b=QG8KN7VTAoWy/s+V58His883VT/Yqia2wzpxvn4WxJeYhgKw9p+domQce0MyIUXfBgCI
	 Fwvw6adbLGPw9KsdxNGGXwX0IT6jT/rOJQZqnM7bOFBEKafDk8mJtharB7NF/KdDPa4dI
	 sYnwZWAWpsLM9Ws5aXkXUyOCfdgk3EWuQDp865PCf8wQtsAYnLz147ZbDZL48kUF/J/R6
	 hc4ntaoYzZqUMxV7l3CdGfz+lC/ENw6gBjq4kN6Uqqp2tD+s+CG1/OHNiKnyq86tteRWl
	 3nBKpqx1tUmH/cCLMzXhwfrCM5ljgyaPF+MgrN1Sxeyr+KQXzEGoX0o4rnx/qgK+WKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gx2alcwS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7B7606A32F;
	Thu, 26 Nov 2026 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gx2alcwS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795724982;
	b=mw/T0pKu/XOcX03gGbFGTBMjxw2V3zyvKIPbb9vtQCTrGvb72evVddnvBQBZfzk2f3Zp
	 Xbb+o14E+kFqtPD0wr1H07L0RxntIB1zltsgicBj+3YXxkPGzIYueU9aKAhQX5FJ7tsD7
	 hP4Y6WKA7+F2252Kri/wC27X3DYp/bSg2qZzKdjuUpOK35aXjefKOw8oI4FgiM4IB1ocM
	 3IuxTG1btJMb3eRSfkx8/rFhp3OlR5VVOb0RLNDu+s1hSE4o5siLWH1i3uIHcBsBneTzM
	 4AVo5JUI2XMBJYdGr8JYr6iIE4RiGt3o4fRrzPmrbJZIh37EZyJtTWwUQBvjLTJ/2AQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795724982;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KCjWiZiwXp5sJmT9pw/lHFyVaUG6to6r2YGXNlsYx/0=;
	b=IXeJlucGzzHrqi1OhsDxmDBTX/RlyPnMZVKvahoKPxhUTp0ahFA9+qcQeYsNQxTIoCDw
	 lYH7Ev/Fth+OQP2uH29lm1QnqbwNovqfT8rI6Zq2g849l1D+SY83xr+f8/R9kQzPKhY+X
	 u6VfzD57LO8H7Z6PF0Lf74KnWUycPym6Z7sdLehy5NDmYT8a62R+WbKdDMb9nBA6dVkKQ
	 wMWOuF7A+qGurfUeUFZE4mKFTSNs9sO4yXDrtm/7hB7dIrydhqfHrInvvrG81ekhQ4oNX
	 gF4s7TMmOuCk0rKlzrt7ujLCRJzKI/YhvtgtZtAiF10m7FRVseBjCkW7W0zJFu5P5QA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7AF2F1F008A0;
	Thu, 26 Nov 2026 20:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795724982;
	bh=KCjWiZiwXp5sJmT9pw/lHFyVaUG6to6r2YGXNlsYx/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Gx2alcwSEZu2YzsBt3SGHWZ64JbYd1r/hTEbQQ7maY1DGzdsP0vSS3KaVXipCgtVq
	 dz7zVNPUzzhA3NMgbXQmr//gondPpFxvSIUHkjJ65YKXKztqpxDKZsSDvH2GyFXmRK
	 O8IhYEhuqS1+CHIXfvMRoh1VHboAHc8qbQdq9SLv39+rL3m1WtMqDqUtYFdM4zXUjE
	 bKiCM+492lsVDc76wLXUvqqy2F/t5Dk2EgdyBv9WX38FJvYwO9pNmaJnFGt1B3t+mA
	 ymbuInUwyVXVsxiG1Rn+yEtwnPk43IMbBWn0/GNRC9l6Pyk2Zkbc2DqbD8rJhZovBz
	 DU7Yhca8e1XKw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0BE3D4D7FC;
	Thu, 26 Nov 2026 20:29:26 +0000 (UTC)
From: Ernest Borowski via B4 Relay <devnull+ernest.borowski.git.proton.me@kernel.org>
Date: Thu, 26 Nov 2026 21:29:26 +0100
Subject: [PATCH v2 3/4] generic: test fallocate after a buffered write that
 faulted
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-ntfs-reproducers-v2-3-7d5fa5a688b9@proton.me>
References: <20261126-ntfs-reproducers-v2-0-7d5fa5a688b9@proton.me>
In-Reply-To: <20261126-ntfs-reproducers-v2-0-7d5fa5a688b9@proton.me>
To: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Cc: ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>, 
 Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
 Baolin Liu <liubaolin@kylinos.cn>, 
 Ernest Borowski <ernest.borowski.git@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8466;
 i=ernest.borowski.git@proton.me; s=default; h=from:subject:message-id;
 bh=4Ajtj39huvflL8CVUGDgddPJ399OWHnl/RfumozQ4Aw=;
 b=owGbwMvMwCVWzJ65uCpJ5D/jabUkhmyOaUsel2ukHD07ob62jZnrWI+rsdqShj0rXMsObFhzN
 vDLEp/EjlIWBjEuBlkxRZaO/zdCfEK+fVoWp9UHM4eVCWQIAxenAExkzmyG/3G8XOdOtM3Xtd9x
 wjd67YJbc+fNyTt46s6mBZvXary8yaLAyLAgIbmP79OxyZzP1/CLzF20bZbCxzcZSrsNOU7bSGf
 2SfACAA==
X-Developer-Key: i=ernest.borowski.git@proton.me; a=openpgp;
 fpr=88FFD8544C54F6F2A65E2A8E730769A37A6214FF
X-Endpoint-Received: by B4 Relay for ernest.borowski.git@proton.me/default
 with auth_id=1589
X-Original-From: Ernest Borowski <ernest.borowski.git@proton.me>
Reply-To: ernest.borowski.git@proton.me
Content-Transfer-Encoding: 7bit

From: Ernest Borowski <ernest.borowski.git@proton.me>

A buffered write into a hole may reserve or map space before it copies from
the user buffer, and when the copy faults on the first byte the write fails
with EFAULT and must leave nothing behind. On ntfs the delayed allocation
run it set up stayed in the runlist without any dirty data, and punching,
collapsing or inserting a range through it shifted the run onto clusters of
other files, so the file read their contents and ntfsck found the cluster
bitmap inconsistent. The fixes are "ntfs: punch out the delalloc
reservation of a failed buffered write" and "ntfs: do not shift the cluster
number of a delalloc run on split" from the ntfs delayed allocation series,
not merged yet. Fail a write over the first half of a sparse file, then
punch, collapse, insert or write a range inside that half, and compare each
file with its expected contents after a remount. The new helper
src/pwrite-short-copy calls pwrite(2) once from a buffer whose readable
part ends a given number of bytes in, and prints what it returned.

Link: https://lore.kernel.org/all/20261124-b4-ntfs-delalloc-fixes-v2-0-f394c800ec03@proton.me/
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
---
 .gitignore              |   1 +
 src/Makefile            |   2 +-
 src/pwrite-short-copy.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/817       |  84 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/817.out   |   2 +
 5 files changed, 189 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index cdcfa06e..afce03d4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -123,6 +123,7 @@ tags
 /src/preallo_rw_pattern_reader
 /src/preallo_rw_pattern_writer
 /src/punch-alternating
+/src/pwrite-short-copy
 /src/pwrite_mmap_blocked
 /src/randholes
 /src/readdir-while-renames
diff --git a/src/Makefile b/src/Makefile
index a1fc38d8..0b031620 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -38,7 +38,7 @@ LINUX_TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
 	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
 	rw_hint btrfs_ioctl refluxfs xfs-exchange-to-eof \
-	xfs-exchange-to-dirty-eof xfs-swapext-reflink
+	xfs-exchange-to-dirty-eof xfs-swapext-reflink pwrite-short-copy
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
diff --git a/src/pwrite-short-copy.c b/src/pwrite-short-copy.c
new file mode 100644
index 00000000..2f1c36a3
--- /dev/null
+++ b/src/pwrite-short-copy.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Ernest Borowski <ernest.borowski.git@proton.me>.  All Rights Reserved.
+ *
+ * Call pwrite(2) once with a source buffer that ends in an inaccessible page,
+ * so that the copy from user space stops after a given number of bytes: the
+ * write comes up short, or fails with EFAULT when no byte is readable.
+ *
+ * usage: pwrite-short-copy [-p pattern] file offset length readable
+ *
+ * The first "readable" bytes of the buffer hold the pattern byte (default
+ * 0x5c), and the page after them is PROT_NONE.  The program prints what
+ * pwrite(2) returned: the number of bytes written, or minus the errno.
+ * It exits 0 in both cases, and 1 on a usage or setup error.
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+static void usage(const char *prog)
+{
+	fprintf(stderr,
+		"usage: %s [-p pattern] file offset length readable\n", prog);
+	exit(1);
+}
+
+static long long parse(const char *s, const char *prog)
+{
+	char *end;
+	long long v;
+
+	errno = 0;
+	v = strtoll(s, &end, 0);
+	if (errno || *end || v < 0)
+		usage(prog);
+	return v;
+}
+
+int main(int argc, char **argv)
+{
+	long long offset, length, readable;
+	size_t pagesize = getpagesize();
+	size_t npages;
+	int pattern = 0x5c;
+	char *map, *buf;
+	ssize_t ret;
+	int fd, c;
+
+	while ((c = getopt(argc, argv, "p:")) != -1) {
+		switch (c) {
+		case 'p':
+			pattern = parse(optarg, argv[0]) & 0xff;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+	if (argc - optind != 4)
+		usage(argv[0]);
+
+	offset = parse(argv[optind + 1], argv[0]);
+	length = parse(argv[optind + 2], argv[0]);
+	readable = parse(argv[optind + 3], argv[0]);
+
+	fd = open(argv[optind], O_WRONLY);
+	if (fd < 0) {
+		perror(argv[optind]);
+		return 1;
+	}
+
+	/* the readable bytes end where the last, inaccessible page starts */
+	npages = (readable + pagesize - 1) / pagesize + 1;
+	map = mmap(NULL, npages * pagesize, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (map == MAP_FAILED) {
+		perror("mmap");
+		return 1;
+	}
+	buf = map + (npages - 1) * pagesize - readable;
+	memset(buf, pattern, readable);
+	if (mprotect(map + (npages - 1) * pagesize, pagesize, PROT_NONE)) {
+		perror("mprotect");
+		return 1;
+	}
+
+	ret = pwrite(fd, buf, length, offset);
+	if (ret < 0)
+		printf("%d\n", -errno);
+	else
+		printf("%zd\n", ret);
+
+	if (close(fd)) {
+		perror("close");
+		return 1;
+	}
+	return 0;
+}
diff --git a/tests/generic/817 b/tests/generic/817
new file mode 100755
index 00000000..0f87b389
--- /dev/null
+++ b/tests/generic/817
@@ -0,0 +1,84 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Ernest Borowski <ernest.borowski.git@proton.me>.  All Rights Reserved.
+#
+# FS QA Test No. 817
+#
+# A buffered write into a hole that fails with EFAULT, because not one byte of
+# its source buffer is readable, must not leave anything behind that later
+# operations trip over.  After such a write over the first half of a sparse
+# file, punch a hole through that range, collapse a range out of it, insert a
+# range into it or write into it, and check that after a remount the file
+# reads back as zeroes, apart from the data written.
+#
+. ./common/preamble
+_begin_fstest auto quick rw punch collapse insert
+
+_fixed_by_fs_commit ntfs xxxxxxxxxxxx \
+	"ntfs: punch out the delalloc reservation of a failed buffered write"
+_fixed_by_fs_commit ntfs xxxxxxxxxxxx \
+	"ntfs: do not shift the cluster number of a delalloc run on split"
+
+_require_scratch
+_require_test_program "pwrite-short-copy"
+_require_xfs_io_command "fpunch"
+_require_xfs_io_command "fcollapse"
+_require_xfs_io_command "finsert"
+
+_scratch_mkfs >> "$seqres.full" 2>&1
+_scratch_mount
+
+blksz=$(_get_file_block_size "$SCRATCH_MNT")
+unit=$((blksz > 65536 ? blksz : 65536))
+size=$((16 * unit))
+piece=$((2 * unit))
+
+# Data in other files, so that blocks a broken mapping points to are not zero.
+for i in 1 2 3 4; do
+	$XFS_IO_PROG -f -c "pwrite -q -S 0x3$i 0 $((8 * unit))" \
+		"$SCRATCH_MNT/other$i"
+done
+_scratch_sync
+
+for op in none punch collapse insert write; do
+	file=$SCRATCH_MNT/$op
+	$XFS_IO_PROG -f -c "truncate $size" -c fsync "$file"
+
+	# EFAULT is errno 14
+	ret=$("$here/src/pwrite-short-copy" "$file" 0 $((size / 2)) 0)
+	[ "$ret" = "-14" ] || \
+		echo "$op: write from an unreadable buffer returned $ret"
+
+	newsize=$size
+	case $op in
+	punch)
+		$XFS_IO_PROG -c "fpunch $piece $piece" "$file"
+		;;
+	collapse)
+		$XFS_IO_PROG -c "fcollapse $piece $piece" "$file"
+		newsize=$((size - piece))
+		;;
+	insert)
+		$XFS_IO_PROG -c "finsert $piece $piece" "$file"
+		newsize=$((size + piece))
+		;;
+	write)
+		$XFS_IO_PROG -c "pwrite -q -S 0x77 $piece $unit" "$file"
+		;;
+	esac
+
+	$XFS_IO_PROG -f -c "truncate $newsize" "$tmp.$op"
+	[ "$op" = write ] && \
+		$XFS_IO_PROG -c "pwrite -q -S 0x77 $piece $unit" "$tmp.$op"
+done
+
+# Read everything back from the disk.
+# shellcheck disable=SC2119 # the mount options argument is optional
+_scratch_cycle_mount
+for op in none punch collapse insert write; do
+	cmp -s "$SCRATCH_MNT/$op" "$tmp.$op" || \
+		echo "$op: file contents differ after the failed write"
+done
+
+echo "Silence is golden"
+_exit 0
diff --git a/tests/generic/817.out b/tests/generic/817.out
new file mode 100644
index 00000000..86920a4f
--- /dev/null
+++ b/tests/generic/817.out
@@ -0,0 +1,2 @@
+QA output created by 817
+Silence is golden

-- 
2.56.1


