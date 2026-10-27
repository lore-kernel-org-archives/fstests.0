Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109547;
	b=04vfW6mRwVaw+V7cbnueUCbg78/H7siWNKLHHLapsdHLx7z5CMFpAesA6RBu1FnGRH/E
	 tK7+TWlpbIPxv/lsHBqGyqnOBu6L1XTp8qM1YY7GUPp7BTIBGINHRttfr/l2ZSEbMKmxH
	 7Su+Cs1c4+7Coclug27Hdb7vDhScx9P91lLJOr0E9lZMZqk5NeBawLBAMrRopChW7Z+fE
	 LWikMjupxFPRaE9HHgvE7Q+52tCygC3e2GvTV8KC1+eJFu0YDNHk9lbilLAmpm7wxLJsp
	 R3KlLM67rplFMvfnpNmMC6NHdhB2nkvqp/LlWnXbeFEa/kBHgAU80+mq34//ercfSjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109547;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rPe27RbvP6GtpecsSZ0D87hfr+w6vC5YNLVEkYMpTJc=;
	b=SmsQ1gW2DhNWjOIO6GZGtijVXuTqWEUh5ONIyyAWqgx7gQY1BfW69ubWBsILPstxMT5l
	 yZLsvuhMhWQaszCSWZ7ygsCHszjqj7yrS7ZjHh4uaoPeNYCnVhrtgiEx6Gy6nqqJyOr7A
	 z6yCxV8HCcW7NKAO45XqSejxIeSYZGBICjZGJJXunZXtPrZxBE+X9M63Dif5q+QEeY8Zh
	 oq5Bte7/rwWo6apNSYa9gzbnD3XscSt88TwOgn61qr2uHT5mDZt2G0Wqte0zK8aH9L/S3
	 regUt/qPfsoEwEDmJ0EUHyExbeBqZJ0eTPXflZyvRbmLQ3njpTVPW2ovIlEXai3rMjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQgZ3W6B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77563606A31B;
	Tue, 27 Oct 2026 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQgZ3W6B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BDD1F01825;
	Tue, 27 Oct 2026 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793109547;
	bh=rPe27RbvP6GtpecsSZ0D87hfr+w6vC5YNLVEkYMpTJc=;
	h=From:Date:Subject:To:Cc;
	b=kQgZ3W6BbczP2yuCtEF0r3RJuC4t0o40g9tYVWLaRwfdNzQTP2fIfhS47KzWhXWwX
	 RshTrPFiZQfjrGftPRjAqlFeila24TjyQCdYC/H1LluBYiWjec0DvJ/7koX0a3YsQh
	 oL/dlKAgFuZ0JtNcNTFkczu/APlwNDqDnubK/TE6WlUfPGmG+2G/T/Ig3dJ5RZkjH7
	 /daRtN3LJ/60GJBMm0GmtlJ1PBZwtYhrSr1OTZyn/kUPbqGlIORZiJAtxHF000Opj8
	 a4koEUY/jrMzlp5ssMKUz+R2FXaZFeHDca8MUSIiH+g2X4826DiFlFI424Y5hyvWIm
	 EcJiG2kWahUSA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 27 Oct 2026 09:58:50 -0400
Subject: [PATCH RFC fstests] generic: add a test for multigrain timestamps
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-mgtime-v1-1-ec68914a116e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNz3dz0kszcVF0zE0NLkySTVCOjJBMloOKCotS0zAqwQdFKQW7OCmn
 FJanFJcVKsbW1AGeVdu9lAAAA
X-Change-ID: 20261027-mgtime-64194b4e22b4
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5357; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LHczyrdP2SRQ7ZsogHfsyBVbEW1DktvXqph4p/kEmio=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBq4K4qLY8XNNqRV63Mwci8RZK4302W31J6veUpF
 oncXhiJ9E+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCauCuKgAKCRAADmhBGVaC
 FWqyEADXNmD3+8Vu5sjqbIOeK9B+vAm/G2drYT3FGDOsocWhpU3TcZkK62/aqg6ohlncvsVuFIR
 fNSKnVUcuCe5l4SsAxRjy60WPL7p5SkpNqnCvTyq958TSG3JU1YHtZRrugARJQShmTdP2LtjmKR
 l49BhAvUmQVpwY4YJeJC0qCN6f0RvlLP/h0/QyJM8QDa3VFXC+q9+k8R0rjHH7jNI3C6Rmg01nC
 QlUVaR+2dM9R5MBkPN1PBJYF2mhD0BQSNmidwaoUIcyJHeJOst3WhJ5YhoT7/7PvVrYLuAVNc9D
 HpLxEyOyAENqDHS/Ec/WQQsPXusFOZz8Uz/vQdQRrpd3RCIz7fpA8lCnSDBl5ejQ40ZpiBN293D
 SCSpOwvp6QtrgQeDk/H8Au6xWrEgoQtzGtR1y2PNUMkDpi3Recwwh1nVDNZMZ5M+r81xUb1tQ6e
 mnL9QVQAXJp5fWuDw/x7h9cOV0NwBGv3NRoayMQX8RTu3J+pyzvl5wbmzpwBr3y7ZgXgMjEfMyu
 R77n+nLROu87LQ+BjW1Z+qxgYIgN7GlFx/l1q7oEF6T25tmzyKHgoaUyXQ2RtaaTN6w91y0eFoi
 8lalg7xgnOWIgngxALh501EAyUYjfoEOdz1a+6ptkvm7kL/HLTBp3CAZeFyfZT0Qmv5iRALuDrG
 TNhivCTb6zbml5Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Ensure that the mtime and ctime apparently change, even when there are
multiple writes in quick succession. Since this is opt-in for in-kernel
filesystems and there is no way to test for this feature in userland,
limit it to just ext4, f2fs, btrfs, tmpfs and xfs for now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I'd like to start testing this to make sure it doesn't break, but it's
not universally supported on all filesystems. Is an explicit allowlist
like this the right approach?
---
 src/Makefile          |   2 +-
 src/mgtime.c          | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999     |  35 ++++++++++++++++
 tests/generic/999.out |   1 +
 4 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/src/Makefile b/src/Makefile
index 0ff607ae1593..07bf749a1b8c 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -36,7 +36,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
 	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
 	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
-	rw_hint btrfs_ioctl
+	rw_hint btrfs_ioctl mgtime
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
diff --git a/src/mgtime.c b/src/mgtime.c
new file mode 100644
index 000000000000..4ff7c206d31f
--- /dev/null
+++ b/src/mgtime.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Older Linux kernels always use coarse-grained timestamps, with a
+ * resolution of around 1 jiffy. Writes that are done in quick succession
+ * on those kernels apparent change to the ctime or mtime.
+ *
+ * Newer kernels attempt to ensure that fine-grained timestamps are used
+ * when the mtime or ctime are queried from userland.
+ *
+ * Open a file and do a 1 byte write to it and then statx the mtime and ctime.
+ * Do that in a loop 1000 times and ensure that the value is different from
+ * the last.
+ *
+ * Copyright (c) 2023: Jeff Layton <jlayton@kernel.org>
+ */
+#define _GNU_SOURCE 1
+#include <stdio.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <getopt.h>
+#include <stdbool.h>
+
+#define NUM_WRITES 1000
+
+static int64_t statx_ts_cmp(struct statx_timestamp *ts1, struct statx_timestamp *ts2)
+{
+	int64_t ret = ts2->tv_sec - ts1->tv_sec;
+
+	if (ret)
+		return ret;
+
+	ret = ts2->tv_nsec;
+	ret -= ts1->tv_nsec;
+
+	return ret;
+}
+
+int main(int argc, char **argv)
+{
+	int ret, fd, i;
+	struct statx stx = { };
+	struct statx_timestamp ctime, mtime;
+	bool verbose = false;
+
+	while ((i = getopt(argc, argv, "v")) != -1) {
+		switch (i) {
+		case 'v':
+			verbose = true;
+			break;
+		}
+	}
+
+	if (argc < 2) {
+		errno = -EINVAL;
+		perror("usage");
+	}
+
+	fd = open(argv[1], O_WRONLY|O_CREAT|O_TRUNC, 0644);
+	if (fd < 0) {
+		perror("open");
+		return 1;
+	}
+
+	ret = statx(fd, "", AT_EMPTY_PATH, STATX_MTIME|STATX_CTIME, &stx);
+	if (ret < 0) {
+		perror("stat");
+		return 1;
+	}
+
+	ctime = stx.stx_ctime;
+	mtime = stx.stx_mtime;
+
+	for (i = 0; i < NUM_WRITES; ++i) {
+		ssize_t written;
+
+		written = write(fd, "a", 1);
+		if (written < 0) {
+			perror("write");
+			return 1;
+		}
+
+		ret = statx(fd, "", AT_EMPTY_PATH, STATX_MTIME|STATX_CTIME, &stx);
+		if (ret < 0) {
+			perror("stat");
+			return 1;
+		}
+
+		if (verbose)
+			printf("%d: %llu.%u\n", i, stx.stx_ctime.tv_sec, stx.stx_ctime.tv_nsec);
+
+		if (!statx_ts_cmp(&ctime, &stx.stx_ctime)) {
+			printf("Duplicate ctime after write!\n");
+			return 1;
+		}
+
+		if (!statx_ts_cmp(&mtime, &stx.stx_mtime)) {
+			printf("Duplicate mtime after write!\n");
+			return 1;
+		}
+
+		ctime = stx.stx_ctime;
+		mtime = stx.stx_mtime;
+	}
+	return 0;
+}
diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 000000000000..878247515e71
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,35 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026, Jeff Layton <jlayton@kernel.org>
+#
+# FS QA Test No. 999
+#
+# Multigrain time test
+#
+# Open a file, and do 1 byte writes to it, and statx the file for
+# the ctime and mtime after each write. Ensure that they have changed
+# since the previous write.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+# Override the default cleanup function.
+_require_test_program mgtime
+
+# Multigrain timestamps are opt-in per filesystem; only allowlist the ones
+# known to support them.
+case "$FSTYP" in
+ext4|btrfs|tmpfs|xfs|f2fs)
+	;;
+*)
+	_notrun "multigrain timestamps not supported on $FSTYP"
+	;;
+esac
+
+testfile="$TEST_DIR/test_mgtime_file.$$"
+
+$here/src/mgtime $testfile
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 000000000000..7fbc67688211
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1 @@
+QA output created by 999

---
base-commit: 333c067ccf2f389f5558860336a7fa64157cd46e
change-id: 20261027-mgtime-64194b4e22b4

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

