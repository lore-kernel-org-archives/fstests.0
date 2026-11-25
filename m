Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795633437;
	b=MqTFsPEIfpwqkmet6+Pc6TUnXBIwLMUrAKqbRPNS8tFMUWtWLrNsGjqSeAS811sS9fHC
	 3g1pxtGeN319hpxy67cWZOAwsiwrI7lhs1DTzBsW9Tj5PPQ9IeRwx09aXBj4FaUT+hk56
	 MVoim9wRJfHO1dYaCJRUa6tSqn771hHFYGzd0yVCHSH4w8fFp9OB9WMwK1JlFOEBLb2Ma
	 HxSQl+8/h4IA6wZosu2jfqBYqSKdIS2lcrgo90FKlAwrfM7/cAyboVg1zxBILD0j0NdU2
	 7s1xc07WPljm/BArmqbJq8yCd605DR5Y24Qqpslal+fhr2Dzlt6vnvhc8NS6NcfK1nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633437;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AbkO+bFEQL0iZM4U3Eg/CBKyDpv4Z6WUPkH/NHM8nCs=;
	b=I9jycoTguhI1A5nDPYmSyc6Nr5ZTpI5/B79LtrKptF5ADawb2bcXmJhwLV2iCZsUIJao
	 XgE0Vy7mxp+ookl7rUMWaaub4kX6moavl5dN+QMhv2BLASYPuYMyyH/E7sVIwPZAhzux1
	 /V6uhuigVpce4Wk0CcNvKpQ7BfzQ72opzpGSiha7UdVc1/rMXN3VVu6ZBAgJCnfgLATYI
	 LA4hS9iGP0hn0rjp5q7XeUI9YxFDrSAdlBiEL/Bp+i3h41UAg2z4oG2M1ndQOjX0YvqhC
	 PVYpaWnC/HU6l4iM5TIeESUikjHLWCde7NNX44PmMXhHgOMcQ3/DINsYF8DK89rMRvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsXETU+4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE77606A32C;
	Wed, 25 Nov 2026 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dsXETU+4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795633437;
	b=GAWOomB4eR+xacLUTZPTLbUl/ylJtwCYyluOl0x/SENWogw9B1pfOQXh5DV8ZXFQSSaa
	 8tbikfWZmT3EP73m4k/Dzt0UtdJVpvswGx+Mf4SKQAOnMJcVZeT9OX5zi6XcundiJFW1R
	 BU3L2t65PlPi1tQmZo+4vChAYAaI4XwD+0vU7QNWVF6clpb4NCjq1PNOC26Y8dein/63+
	 qqb+N0a+RDEGmVgmocVsslRyVKm7AMNcw1ycA1sQLXa4WjJEoNHYTpNt4fxF1mOIA/UoB
	 IRZLRorStOqGOGw0rOHB8g3CJJZWsgjX0w3oZjdjj2VLfLjhU6mem+r4f/UxBC0eFlw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795633437;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AbkO+bFEQL0iZM4U3Eg/CBKyDpv4Z6WUPkH/NHM8nCs=;
	b=qe7jTPvbJ+ZTIqYQK2AntF0hM5bmIhlPiWePSc3cBim6ipdZmEaD6KEAR0vMQcIyoOTx
	 EvjANKb7pVq5QKvRf9UUqclpcTUuATahV9pAjToXoSOyD3U8wHFEyZxbk7BkpqxIjf0i4
	 /ipR9N9qI8hb4FY+jmplWx4AaxYLHhuTt/M41RUMWDwO1wy+1iRzuox5RBdx1dG575feR
	 nZtUPHEexDsmnbH1ybyPlqiJnUVJau5+/3uDmR17Wtn/8/ZRbFltjxn2OrecPLhpuBl2Y
	 R0S+POEJo2qchrk2GShquikebamYnGSdMnYotplKGzLyd67z5uKDTAGXPYj22DH9Srg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C54EF1F000D0;
	Wed, 25 Nov 2026 19:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795633436;
	bh=AbkO+bFEQL0iZM4U3Eg/CBKyDpv4Z6WUPkH/NHM8nCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dsXETU+4tkMeA0pXSaSeuC7rqcyAzzEL+k0PTdm2gbD8nle/gBMRNlzTg47Zkp9Ud
	 kiw4CNZfuH5dfHH4Vv5uhpPSVpAmck8w3hg4TbpamuPIsqm5IxcTEFKiKMHHLgEyAZ
	 IGsdQ9t0iGI/iQOGNTbAwd7yh6dwbe1a4OJY6hYIQwSflTDAR7iTP8ZQbC1LhKtAVg
	 Mumz/xSAinLWZglr+6JnJ8WZ5WibuixLzps0Z5QGrmFKndaWfXYC6knWpOoQTr8R3y
	 qwbr5fISA38cLGcbGST2GL+Fr/HXQ7PLxHgtSqIyVanseROJoY1LK/ueQBwVt7tleM
	 zIMZPLI0hlPXw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 50A054CFFC;
	Wed, 25 Nov 2026 19:03:44 +0000 (UTC)
From: Ernest Borowski via B4 Relay <devnull+ernest.borowski.git.proton.me@kernel.org>
Date: Wed, 25 Nov 2026 20:03:45 +0100
Subject: [PATCH 3/4] generic: test fallocate after a buffered write that
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
Message-Id: <20261125-ntfs-reproducers-v1-3-0cc67533d803@proton.me>
References: <20261125-ntfs-reproducers-v1-0-0cc67533d803@proton.me>
In-Reply-To: <20261125-ntfs-reproducers-v1-0-0cc67533d803@proton.me>
To: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Cc: ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>, 
 Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
 Ernest Borowski <ernest.borowski.git@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8316;
 i=ernest.borowski.git@proton.me; s=default; h=from:subject:message-id;
 bh=FmK8rQ9PgJraA67rXGYnPFTdM50KCBK5+eC5GNA44Uw=;
 b=owGbwMvMwCVWzJ65uCpJ5D/jabUkhmx2Q75HjAsMH5ycPJfnbIuqy895AlyTuw6wFGjXrX8vu
 OWJqJt9RykLgxgXg6yYIkvH/xshPiHfPi2L0+qDmcPKBDKEgYtTACYSd5bhf8L+Ta/lZ+xY1Wrx
 b4754zOi0zT8RTbvvHVbSDdinwPnX3aG/3mPVZ8Fdy+6+CPoyOOy46kH/ha3zfEJ05nSbnAlve1
 6JA8A
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
Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
---
 .gitignore              |   1 +
 src/Makefile            |   2 +-
 src/pwrite-short-copy.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/817       |  83 +++++++++++++++++++++++++++++++++++++++
 tests/generic/817.out   |   2 +
 5 files changed, 188 insertions(+), 1 deletion(-)

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
index 00000000..dff08a28
--- /dev/null
+++ b/tests/generic/817
@@ -0,0 +1,83 @@
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
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+blksz=$(_get_file_block_size $SCRATCH_MNT)
+unit=$((blksz > 65536 ? blksz : 65536))
+size=$((16 * unit))
+piece=$((2 * unit))
+
+# Data in other files, so that blocks a broken mapping points to are not zero.
+for i in 1 2 3 4; do
+	$XFS_IO_PROG -f -c "pwrite -q -S 0x3$i 0 $((8 * unit))" \
+		$SCRATCH_MNT/other$i
+done
+_scratch_sync
+
+for op in none punch collapse insert write; do
+	file=$SCRATCH_MNT/$op
+	$XFS_IO_PROG -f -c "truncate $size" -c fsync $file
+
+	# EFAULT is errno 14
+	ret=$($here/src/pwrite-short-copy $file 0 $((size / 2)) 0)
+	[ "$ret" = "-14" ] || \
+		echo "$op: write from an unreadable buffer returned $ret"
+
+	newsize=$size
+	case $op in
+	punch)
+		$XFS_IO_PROG -c "fpunch $piece $piece" $file
+		;;
+	collapse)
+		$XFS_IO_PROG -c "fcollapse $piece $piece" $file
+		newsize=$((size - piece))
+		;;
+	insert)
+		$XFS_IO_PROG -c "finsert $piece $piece" $file
+		newsize=$((size + piece))
+		;;
+	write)
+		$XFS_IO_PROG -c "pwrite -q -S 0x77 $piece $unit" $file
+		;;
+	esac
+
+	$XFS_IO_PROG -f -c "truncate $newsize" $tmp.$op
+	[ $op = write ] && \
+		$XFS_IO_PROG -c "pwrite -q -S 0x77 $piece $unit" $tmp.$op
+done
+
+# Read everything back from the disk.
+_scratch_cycle_mount
+for op in none punch collapse insert write; do
+	cmp -s $SCRATCH_MNT/$op $tmp.$op || \
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


