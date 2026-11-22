Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795352236;
	b=yXNIgmgJLAF2ooppQeP3lUG7ST29ADomA1GAuARg3XG2cglUP79ARzvATRyqDNMV0Ppi
	 YwQMerPvruStQiWw3U23jqiSud0y4HFmt/ir8X0WDQzZwbhN0a7qETEDE/9ydS+W266sI
	 9bmakHumHeHdakQ2aD0k/r9LrdLxo+Z7+R+lHfGZ6pX87HvbNlyFT95gdkRzkE/KttqiR
	 sB0Af5k+vq68AacxjTwP1a0FB10dAe+zSA+RmnSGUVFOrA+MCWUoCVZ651VpwJeUQPRH5
	 7ZkoT1zOQNmR0A4nUFVlRrMkJYWUJ/7Es++kWT+/0R3SQj0bGZwqg2hSxaVSYavtGtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795352236;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Q4RjsKon5d99Zr7ol90LruhFBUx6Ds/UmzYKksx0yfU=;
	b=uBtHTWDcBvKy21cPpQ1rR1N5CO3S434Gt0UdUYf4kCZx/gc5y4QYALhwGA2ekqlSJcba
	 lwGadJKjb0JmqU0uvMSZH5Cg8tlmFjFOtxx5uq5ilIpCw4DJ9/dd+sdQP4e2fhIEwWVQr
	 nJrOtgY/vg4Yjgln18Kk5A+dDOjdB3ZRrXvtYmsYrSUnjPK3kkvdQayCARD7cOr8TPM/z
	 xteWRhANSW69/VcBD+/vnQLhOsL2muscsacq8INg+f4whCGjvY0qk5GADje7clFifxLal
	 iNPszn+3LSb3atvGvniOJdxR0dOB5lLMwPafeFJg29aIlwVvm1PH7tm5jBD+fll89qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GUzvvSaG;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF723606A330
	for <fstests@vger.kernel.org>; Sun, 22 Nov 2026 12:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF723606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GUzvvSaG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Q4
	RjsKon5d99Zr7ol90LruhFBUx6Ds/UmzYKksx0yfU=; b=GUzvvSaG8vN2rFz3Ys
	az8PMBDkq+YEi+UCgJvHZc7VCltTfeISLyBHLh2/gsl0qgQbqrwPzLCHiZOgm6lq
	kUTngg7KaSYX2nd/mQpMQuPoCs67S/ZDAtGLC1nbY3+EQxiEFv8Q6XXtoaMLneoU
	JUnk3b3SnVETzhogSCeIO/Acc=
Received: from ubuntu (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3n6aF5gJrBljsJQ--.53548S2;
	Sun, 22 Nov 2026 20:56:48 +0800 (CST)
From: Shaopei Zhu <shaopei_1012@163.com>
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	exfat@lists.linux.dev
Subject: [PATCH] exfat: test EXFAT_IOC_COMBINE
Date: Sun, 22 Nov 2026 20:56:34 +0800
Message-ID: <20261122125634.624942-1-shaopei_1012@163.com>
X-Mailer: git-send-email 2.53.0
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
X-CM-TRANSID:_____wD3n6aF5gJrBljsJQ--.53548S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WFWUXw1DCF4UCw4fWry5XFb_yoWftr18pa
	yFyw4rJw4IqwsrGa4SkFy0qa4F9w4F9F15Cr92gw1UZFZrtr1kKrZFqrW7urZ3WrsrXFW5
	KFs3tFyY9rn7XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1GQDUUUUU=
X-CM-SenderInfo: pvkd01phlbiiirs6il2tof0z/xtbC6RI5x2sC5pKYvgAA3+

Add a test for EXFAT_IOC_COMBINE, which appends the clusters of one
file to another without copying data, zero-filling the destination up
to the next cluster boundary first, and then unlinks the source.

The test covers an aligned and an unaligned destination, empty
destination and source, a fragmented source appended to a contiguous
destination, a destination extended by truncate and by fallocate, a
source unlinked before the call, and invalid requests, and checks that
the source is unlinked.  The contents are compared with the expected
result before and after a remount.

It is skipped on kernels without the ioctl.

This was written with the help of an AI coding assistant (Claude Code,
Opus 5.5) and reviewed and tested by me.

Signed-off-by: Shaopei Zhu <shaopei_1012@163.com>
---

Notes:
    The ioctl is added by this kernel patch, under review:
    https://lore.kernel.org/all/20261122124029.609636-1-shaopei_1012@163.com/
    
    The test is skipped on kernels without it.  Based on for-next.

 .gitignore          |   1 +
 src/Makefile        |   2 +-
 src/exfat_combine.c |  91 +++++++++++++++++++++++++
 tests/exfat/002     | 158 ++++++++++++++++++++++++++++++++++++++++++++
 tests/exfat/002.out |  15 +++++
 5 files changed, 266 insertions(+), 1 deletion(-)
 create mode 100644 src/exfat_combine.c
 create mode 100755 tests/exfat/002
 create mode 100644 tests/exfat/002.out

diff --git a/.gitignore b/.gitignore
index cdcfa06..0876aee 100644
--- a/.gitignore
+++ b/.gitignore
@@ -82,6 +82,7 @@ tags
 /src/dirperf
 /src/dirstress
 /src/e4compact
+/src/exfat_combine
 /src/ext4_resize
 /src/fake-dump-rootino
 /src/fault
diff --git a/src/Makefile b/src/Makefile
index a1fc38d..b42d7d7 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -38,7 +38,7 @@ LINUX_TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
 	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
 	rw_hint btrfs_ioctl refluxfs xfs-exchange-to-eof \
-	xfs-exchange-to-dirty-eof xfs-swapext-reflink
+	xfs-exchange-to-dirty-eof xfs-swapext-reflink exfat_combine
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
diff --git a/src/exfat_combine.c b/src/exfat_combine.c
new file mode 100644
index 0000000..2b0b795
--- /dev/null
+++ b/src/exfat_combine.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Shaopei Zhu.  All Rights Reserved.
+ *
+ * Call EXFAT_IOC_COMBINE to append the clusters of src to dst.
+ *
+ * Exits with 0 on success, 2 if the ioctl is not supported and 1 on any
+ * other error.
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#ifndef EXFAT_IOC_COMBINE
+struct exfat_combine_args {
+	__s32 src_fd;
+	__u32 flags;
+};
+#define EXFAT_IOC_COMBINE	_IOW('r', 0x20, struct exfat_combine_args)
+#endif
+
+static void usage(const char *prog)
+{
+	fprintf(stderr,
+		"usage: %s [-f flags] [-r|-w] [-U] dst src\n"
+		"  -f flags  value of exfat_combine_args.flags\n"
+		"  -r        open src read-only\n"
+		"  -w        open src write-only\n"
+		"  -U        unlink src before combining (use the open fd)\n",
+		prog);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	struct exfat_combine_args args = { 0 };
+	int src_mode = O_RDWR, unlink_first = 0;
+	int c, dst, src;
+
+	while ((c = getopt(argc, argv, "f:rwU")) != -1) {
+		switch (c) {
+		case 'f':
+			args.flags = strtoul(optarg, NULL, 0);
+			break;
+		case 'r':
+			src_mode = O_RDONLY;
+			break;
+		case 'w':
+			src_mode = O_WRONLY;
+			break;
+		case 'U':
+			unlink_first = 1;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+	if (argc - optind != 2)
+		usage(argv[0]);
+
+	dst = open(argv[optind], O_RDWR);
+	if (dst < 0) {
+		perror(argv[optind]);
+		return 1;
+	}
+	src = open(argv[optind + 1], src_mode);
+	if (src < 0) {
+		perror(argv[optind + 1]);
+		return 1;
+	}
+	if (unlink_first && unlink(argv[optind + 1])) {
+		perror("unlink");
+		return 1;
+	}
+
+	args.src_fd = src;
+	if (ioctl(dst, EXFAT_IOC_COMBINE, &args)) {
+		fprintf(stderr, "EXFAT_IOC_COMBINE: %s\n", strerror(errno));
+		return errno == ENOTTY ? 2 : 1;
+	}
+
+	close(src);
+	close(dst);
+	return 0;
+}
diff --git a/tests/exfat/002 b/tests/exfat/002
new file mode 100755
index 0000000..c2c0d26
--- /dev/null
+++ b/tests/exfat/002
@@ -0,0 +1,158 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Shaopei Zhu.  All Rights Reserved.
+#
+# FS QA Test No. exfat/002
+#
+# Test EXFAT_IOC_COMBINE, which appends the clusters of one file to
+# another without copying any data and then unlinks the source.  A
+# destination that is not cluster aligned is zero-filled up to the next
+# cluster boundary first, so the appended data always starts at a cluster
+# boundary.  Check the result before and after a remount, covering
+# contiguous and fragmented files, a destination extended by truncate and
+# fallocate, an already unlinked source, and the error cases, in which the
+# source must be left alone.
+#
+. ./common/preamble
+_begin_fstest auto quick rw
+
+. ./common/filter
+
+_require_scratch
+_require_test_program "exfat_combine"
+_require_xfs_io_command "falloc"
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+combine=$here/src/exfat_combine
+mnt=$SCRATCH_MNT
+
+touch $mnt/probe_dst $mnt/probe_src
+$combine $mnt/probe_dst $mnt/probe_src >> $seqres.full 2>&1
+[ $? -eq 2 ] && _notrun "kernel does not support EXFAT_IOC_COMBINE"
+rm -f $mnt/probe_dst $mnt/probe_src
+
+# st_blksize is the cluster size on exFAT
+clu=$(stat -c %o $mnt)
+echo "cluster size $clu" >> $seqres.full
+
+# write <file> <pattern> <offset> <length>, to a scratch file and to the
+# file holding its expected contents
+write()
+{
+	$XFS_IO_PROG -f -c "pwrite -S $2 $3 $4" $mnt/$1 >> $seqres.full
+	$XFS_IO_PROG -f -c "pwrite -S $2 $3 $4" $tmp.$1 >> $seqres.full
+}
+
+# what the kernel does to <dst>: zero-fill to a cluster boundary and
+# append the contents of <src>, which is then unlinked
+expect_combine()
+{
+	local size=$(stat -c %s $tmp.$1)
+	local src_size=$(stat -c %s $tmp.$2)
+
+	[ $src_size -eq 0 ] && { rm -f $tmp.$2; return; }
+	size=$(( (size + clu - 1) / clu * clu ))
+	$XFS_IO_PROG -c "truncate $size" $tmp.$1
+	cat $tmp.$2 >> $tmp.$1
+}
+
+do_combine()
+{
+	$combine "$@" $mnt/$dst $mnt/$src || echo "combine $dst $src failed"
+	[ -e $mnt/$src ] && echo "$src still exists"
+	expect_combine $dst $src
+	rm -f $tmp.$src
+}
+
+check()
+{
+	local f
+
+	for f in "$@"; do
+		cmp $mnt/$f $tmp.$f || echo "$f: wrong contents"
+	done
+}
+
+echo "aligned destination, source still in the page cache"
+dst=a src=b
+write $dst 0x61 0 $((4 * clu))
+$XFS_IO_PROG -c fsync $mnt/$dst
+write $src 0x62 0 $((3 * clu + 123))
+do_combine
+
+echo "unaligned destination"
+dst=c src=d
+write $dst 0x63 0 $((clu + 1))
+write $src 0x64 0 $clu
+do_combine
+
+echo "empty destination"
+dst=e src=f
+touch $mnt/$dst $tmp.$dst
+write $src 0x65 0 $clu
+do_combine
+
+echo "empty source does not pad the destination"
+dst=g src=h
+write $dst 0x66 0 100
+touch $mnt/$src $tmp.$src
+do_combine
+
+echo "fragmented source, contiguous destination"
+dst=i src=j
+write $dst 0x67 0 $((2 * clu))
+$XFS_IO_PROG -c fsync $mnt/$dst
+for n in 0 1 2; do
+	write $src 0x68 $((n * clu)) $clu
+	$XFS_IO_PROG -c fsync $mnt/$src
+	write spacer 0x78 $((n * clu)) $clu
+	$XFS_IO_PROG -c fsync $mnt/spacer
+done
+write $src 0x68 $((3 * clu)) 100
+do_combine
+
+echo "destination extended by truncate"
+dst=k src=l
+write $dst 0x69 0 1000
+$XFS_IO_PROG -c fsync -c "truncate $((3 * clu + 10))" $mnt/$dst
+$XFS_IO_PROG -c "truncate $((3 * clu + 10))" $tmp.$dst
+write $src 0x6a 0 $clu
+do_combine
+
+echo "destination extended by fallocate"
+dst=m src=n
+write $dst 0x6b 0 10
+$XFS_IO_PROG -c "falloc 0 $((2 * clu + 5))" $mnt/$dst
+$XFS_IO_PROG -c "truncate $((2 * clu + 5))" $tmp.$dst
+write $src 0x6c 0 $((clu + 7))
+do_combine
+
+echo "source unlinked before combining"
+dst=o src=p
+write $dst 0x6d 0 $((3 * clu))
+write $src 0x6e 0 $((2 * clu + 77))
+do_combine -U
+
+echo "invalid requests"
+dst=q src=r
+write $dst 0x6f 0 $clu
+write $src 0x70 0 $clu
+$combine $mnt/$dst $mnt/$dst 2>&1
+$combine -f 1 $mnt/$dst $mnt/$src 2>&1
+$combine -r $mnt/$dst $mnt/$src 2>&1
+$combine -w $mnt/$dst $mnt/$src 2>&1
+
+check a c e g i k m o q r
+
+echo "after remount"
+_scratch_cycle_mount
+check a c e g i k m o q r
+for f in b d f h j l n p; do
+	[ -e $mnt/$f ] && echo "$f exists after remount"
+done
+
+# success, all done
+status=0
+exit
diff --git a/tests/exfat/002.out b/tests/exfat/002.out
new file mode 100644
index 0000000..f061ae8
--- /dev/null
+++ b/tests/exfat/002.out
@@ -0,0 +1,15 @@
+QA output created by 002
+aligned destination, source still in the page cache
+unaligned destination
+empty destination
+empty source does not pad the destination
+fragmented source, contiguous destination
+destination extended by truncate
+destination extended by fallocate
+source unlinked before combining
+invalid requests
+EXFAT_IOC_COMBINE: Invalid argument
+EXFAT_IOC_COMBINE: Invalid argument
+EXFAT_IOC_COMBINE: Bad file descriptor
+EXFAT_IOC_COMBINE: Bad file descriptor
+after remount
-- 
2.53.0

