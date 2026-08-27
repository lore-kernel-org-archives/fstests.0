Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137AE340A6B;
	Thu, 27 Aug 2026 23:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874494; cv=none; b=nS5ZlgVZbm6REpAuGN8FwDEQjLwyPnKKLSSgcKyKdQS7uYpst0BnAQq60A/4OgtpA/dk1KZ68bq5lXYM1RKZEKmC4YUHEnR3LL+HzLYEGGlQ2hI0iBgT8TAiaOyVMnALROSMR0FYzRqf554dEOXvwo93tidSjeLC7vzrmrMGEPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874494; c=relaxed/simple;
	bh=YK8G+iPRIjxc3aKSenayB4ic16Oi6d9sbaaKAK/A+Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nX5qA76JHyc2b7apw/A3shOXbo/DxjaEDfWbitZym4dzM4FgYI5ylWFdwr6Mm0RWAL3XII9fOFe5r9+eAZKYiZBeZTxRZrXfLeDCEBKnfxePsUUZq9U/m65kOu05EoAK8FUDDtNsHwOyLmEpMONCo5vmB4Q293BfE3jgBqovISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ORbim67d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fGMBBHz0; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ORbim67d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fGMBBHz0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1928B14000F7;
	Thu, 27 Aug 2026 19:48:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 27 Aug 2026 19:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1787874491;
	 x=1787960891; bh=FbS8vj4e5oP2of7Lygv3Xgqfm+mysZL27AEue1Z0Z8s=; b=
	ORbim67dh1Ni5spIMZfwsbuM94L1JJORwYPQeHdyzTVsoUQSqzaAY6By1/XhXRWk
	2ITNs+8bOVIqqSHXPEROXOfayd+WAmjzp279WRYLr5bbebU930E+Kb3hnfxiKpj4
	yxL0B25p2hBTYCi9GX9aW+A8gKZPbSSLaIp7paTWxTput+J1To+i1xeOWRZvOdQ+
	vuE8J6qrzSZTnWMDulmYQt3BLlOrvQnKuRdF8WZah8zF5viFQU9W4YWCSiVWtcz+
	Mw9MLAfXAb/u627sVujXCpGFST9nAgwRM0YHQ2GuNIW//512WiV/UvOE+HBGmElT
	ptup36m/rG6UjEP5pgjkzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787874491; x=1787960891; bh=F
	bS8vj4e5oP2of7Lygv3Xgqfm+mysZL27AEue1Z0Z8s=; b=fGMBBHz0+dfAYTc7M
	8F9FPdYqnEWG98fXAMrAj787a2PL8jrv6oiuk6qznwQ8tCUYpqJLzs1jUXvBJZsp
	LlTBBhKn69rexqWXUIwopH1YiD13X2AIbd/m0Gg4/OYRC/kLyaRsodzgO9eEOjY3
	ojFQJIU2gRQZ/YxeX1ca7HMSUJLheSxdK1oxwld3VyR+R7zFofNu1aCjnFk4khvv
	AoBo65OZFzOsgOqfrmt2rIfY2qNwE5S2icYRnNpD6ovb4NopnM2PEXsRSPmOGaNQ
	mXou+ze5c/GrsiNMBl96vILUmLX5pT46qj+iRf1oQoWTNu7ZTMWQhRcQoDjRCpQy
	Yqyzg==
X-ME-Sender: <xms:usyQaqbRw4kAbrnG6DdbESe-_N4bDVeZTTwYh3TMuWHrl5h-0l0_aQ>
    <xme:usyQalLrjbgc6Sksd49ouz6cd9lIe9blF0LTImEOLzJLGmxG0G19Zzd-FHUWv9mD2
    nv2KBLjPDn5jP9WGP4eV7GrDKlGYrg4dSfdQRbrys5MrZSFofg>
X-ME-Received: <xmr:usyQaoBZ0oseDCyoL_98cysch9cXVGGFHOpXFRt6IQkSLlB2PRCnBCfN6na_DMLIYp5LsNaT0zbvcnSjrUPZyYdQjRM1jQY>
X-ME-Proxy-Cause: dmFkZTFR4qw4Szh/FpHxKaZOGEoM9ktTWm9UbFBSxTHYiLAF8VaTUSU2F2FZMKWE/LxG7p
    k/Zw/JGs6kNPTrQ/ht82vt5+G8cyKcn/QYvosRPnWwVHn1i8sU4edaNHygInObg5P6/9vl
    9/H9zSm7yK/hW51yULsUSi4y5RTBrIWFr2F/FiE67MxAo1QlP8Ad9iHie/mPq2omnhMrVh
    8tgtBCHFFVx4Fzm8sKNpAJRwXJA8O7fwTcumBJVc/9+Go/QNGccOdEhXlvi0jTAC2YCFCT
    H85EXQTHxdCvMlfZotZxLUfqUWvgrfSUNbKuDocQMhO7GFxM2/9Z4I0WtZM/XXwesdmtRo
    0vS1uxBCUx4GOzRe+97jl0MIFwOHeNQqjK5fdh8NuoiXnyzoyzXncHSqo4z7n8QAsujKGD
    UFx8VCwdyjrDoo1g7F+PxipaUI1yh9BAF/Hp0D0PmymXhC8W0RHysrabyoRFA53soylXfq
    5pClxP0dyaA9iVOaZsxSrkK6tvN4s7Ac77IVGlmUYbk00GT40UfB3whCktIn2e2o89NfGu
    5Xo1YdZ19u0Du6gx4HOA4wHksI3ShjmmV5yClUDj0Ja+fuCvbuuKSGAK+ETjzwXWkZAXRO
    eHF+HcjmID8iQMEPPn1bUSSPZIabx1MhQqQkDZFLGWE8NhnpXeOGm+dD/1FQ
X-ME-Proxy: <xmx:usyQaqqcihFX4mWXLu9UBjGNzXgnWh1ruN5IpTeIYt5NxApVWFtHzQ>
    <xmx:u8yQajh6UEcqmmR1wqS1x033uYSJ_llhB77Ft624T_BRryiIXL7pzQ>
    <xmx:u8yQanAa4UnkOtgj__TrlHGmXV92jGKL45s--iVt3M4-u7zycbrWlA>
    <xmx:u8yQaoHvwp_RIESQByvd2VzA-JfSle-o0Gg7s7Ltj5yz9_X_-UfxYw>
    <xmx:u8yQar7dLLL6bMRjV3r03RBuxHzXnC1fI0BJwF1ZcwbsJMr-buX0TlrO>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 19:48:09 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Chuck Lever <cel@kernel.org>
Subject: [PATCH] fstests: generic: Add test of seek in directories
Date: Fri, 28 Aug 2026 09:36:10 +1000
Message-ID: <20260827234743.2389778-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260827234743.2389778-1-neilb@ownmail.net>
References: <20260827234743.2389778-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Add a test for consistency of readdir (getdents64) results.
The expectation is that name which exist before a readdir starts, and
still exist when the readdir completes, and which have not been removed
or renamed away and re-created, should appear exactly once.
Also if the fd on the file is closed in the middle of a readdir and
re-opened with a seek to some offset previously reported, the same
sequence should be reported as if the file was kept open with no
seeking.  This last is important for nfsd.

Names which are the target of a rename have not been removed or renamed
away, and so they should be stable too.

The test involves creating a large number of names and designating
half as "stable".  Those which aren't "stable" may be removed,
recreated, or renamed to something else.  Names which are stable
might be the target of a rename, but will always exist.

The test then reads the directory to find the order of the stable name,
which should never change. It also find the "d_off" of all names.
These d_off should be usable as a "seek" offset to find at least all
the stable names that came after that point in the original listing.

After creating the names and finding the order, a loop which repeatly:
  - makes random changes to unstable names
  - checks the complete order of stable names in a new readdir
  - checks what appears after a seek() to a randomly chosen offet

In Linux 7.2 this test always passes for xfs and ext4 but fails
for btrfs unless we suppress renames with a "stable" name as target.
It also fails for tmpfs.

To support NFS it is possible to suppress RENAME_EXCHANGE tests.

Signed-off-by: NeilBrown <neil@brown.name>
---
 .gitignore            |   1 +
 src/Makefile          |   2 +-
 src/t_dir_seek.c      | 545 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/799     |  25 ++
 tests/generic/799.out |   3 +
 5 files changed, 575 insertions(+), 1 deletion(-)
 create mode 100644 src/t_dir_seek.c
 create mode 100755 tests/generic/799
 create mode 100644 tests/generic/799.out

diff --git a/.gitignore b/.gitignore
index 0b6b94529892..8645520cbe85 100644
--- a/.gitignore
+++ b/.gitignore
@@ -144,6 +144,7 @@ tags
 /src/t_create_short_dirs
 /src/t_dir_offset
 /src/t_dir_offset2
+/src/t_dir_seek
 /src/t_dir_type
 /src/t_encrypted_d_revalidate
 /src/t_enospc
diff --git a/src/Makefile b/src/Makefile
index 76cf50c3e169..17e7f1560033 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -36,7 +36,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
 	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
 	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
-	rw_hint fs-monitor btrfs_ioctl
+	rw_hint fs-monitor btrfs_ioctl t_dir_seek
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
diff --git a/src/t_dir_seek.c b/src/t_dir_seek.c
new file mode 100644
index 000000000000..3b05c7eb900a
--- /dev/null
+++ b/src/t_dir_seek.c
@@ -0,0 +1,545 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (c) 2026 NeilBrown <neil@brown.name>
+/*
+ * This test aims to verify that seekdir (or lseek() on a directory)
+ * is reliable, including after closing and re-openning the directory.
+ * This is important for nfsd operation, among other things.
+ *
+ * The expected behaviour is that a sequence of getdents64 calls
+ * which start at a seek offset of "0" and continue until EOF
+ * is reported (getdents64 returns 0) will report all "stable" names
+ * precisely once and if that process is repeated then the order
+ * of "stable" name will stay the same.
+ * Further, if the process starts at some other seek offset which was
+ * returned in a getdents() together with a particular "stable" name,
+ * then scanning with getdents64 to the end will return all "stable" names
+ * that appear after the particular name in the known order, and none of the
+ * "stable" names which appears at or before the particular name in that order.
+ *
+ * Here a name is "stable" over a period of time if it exists at the
+ * start of the period and at the end of the period and was not unlinked
+ * or renamed during that period.  If a stable name is the target of a
+ * rename of the source of a RENAME_EXCHANGE rename, then it remains stable.
+ *
+ * The behavour of the test is to create some number (5000 by default) of names
+ * in a directory and to designate half of them as stable.
+ * Then to read the directory and establish the order and reported d_off lseek
+ * offsets.
+ * Then to repeatedly:
+ *  - randomly modify unstable names including:
+ *        + unlink existing name
+ *        + create file an non-exising name
+ *        + rename existing name to non-existing name
+ *        + RENAME_EXCHANGE two existing names
+ *        + rename existing unstable name to a stable name
+ *        + RENAME_EXCHANGE two stable names
+ *  - scan the directory from the start and validate the order of stable name
+ *  - scan the directory from some random stable name to the end and
+ *    verify the order.
+ *  This repeats 100 times by default
+ *
+ * Each name used is 12 chars long consisting of 6 random alphabetics,
+ * a hyphen, and 5 digits. which spell a sequence number of 00000 upwards.
+ */
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <fcntl.h>
+#include <string.h>
+#include <time.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+
+#define BUF_SIZE 4096
+struct linux_dirent64 {
+	uint64_t	d_ino;
+	uint64_t	d_off;
+	unsigned short	d_reclen;
+	unsigned char	d_type;
+	char		d_name[0];
+};
+
+typedef char fname[6+1+5+1];
+
+fname *names;
+struct flist {
+	int num;
+	int *list;
+} stable, unstable, unused;
+
+struct fstatus {
+	bool stable;
+	int index;
+	uint64_t pos;
+} *status;
+
+int num_names = 5000;
+int num_loops = 100;
+int num_ops = 10;
+bool trace = false;
+
+int homefd;
+char *dir = "testdir";
+
+enum {
+	op_unlink,
+	op_create,
+	op_rename, // rename to unused name
+	op_replace, // rename to unstable name
+	op_exchange,
+	op_replace_stable,
+	op_exchange_stable,
+	NUM_OPS
+};
+
+#define OP_STABLE ((1 << op_replace_stable) | (1 << op_exchange_stable))
+#define OP_EXCH ((1 << op_exchange) | (1 << op_exchange_stable))
+int disabled_ops = 0;
+
+static char nchars[] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
+
+static void make_name(fname name, int num)
+{
+
+	for (int i = 0; i < 6; i++)
+		name[i] = nchars[random()%(sizeof(nchars)-1)];
+	name[6] = '-';
+	sprintf(name+7, "%05d", num);
+}
+
+static int num_of(char *name)
+{
+	char *ep = NULL;
+	int num;
+
+	if (strlen(name) != 7+5)
+		return -1;
+	num = strtoul(name + 7, &ep, 10);
+	if (ep && *ep == '\0')
+		return num;
+	return -1;
+}
+
+static void make_names(void)
+{
+	names = calloc(num_names, sizeof(*names));
+	for (int i = 0; i <num_names; i++)
+		make_name(names[i], i);
+}
+
+static void alloc_flist(struct flist *list)
+{
+	list->num = 0;
+	list->list = calloc(num_names, sizeof(list->list[0]));
+}
+
+static void alloc_status(void)
+{
+	status = calloc(num_names, sizeof(*status));
+}
+
+static int get_file(struct flist *list)
+{
+	int i;
+	int ret;
+
+	if (list->num <= 0)
+		return -1;
+	i = random() % list->num;
+	ret = list->list[i];
+	list->list[i] = list->list[list->num-1];
+	list->num -= 1;
+	return ret;
+}
+
+static void put_file(struct flist *list, int f)
+{
+	list->list[list->num] = f;
+	list->num += 1;
+}
+
+static void clean_files(void)
+{
+	int n;
+
+	while ( (n = get_file(&unstable)) >= 0)
+		unlink(names[n]);
+	while ( (n = get_file(&stable)) >= 0)
+		unlink(names[n]);
+
+	fchdir(homefd);
+	if (rmdir(dir))
+		perror(dir);
+}
+
+static void fail(char *op, char *name)
+{
+	fprintf(stderr, "FATAL: %s failed on %s\n", op, name);
+	clean_files();
+	exit(3);
+}
+
+static int getdents(int fd, char *buf, int bufsize)
+{
+	return syscall(SYS_getdents64, fd, buf, bufsize);
+}
+
+static void get_order(void)
+{
+	char buf[BUF_SIZE];
+	int index = 0;
+	int fd;
+	int n;
+
+	fd = open(".", O_RDONLY | O_DIRECTORY);
+	if (fd < 0)
+		fail("open", ".");
+
+	lseek(fd, 0, SEEK_SET);
+	for (int i = 0; i < num_names; i++)
+		status[i].index = -1;
+	while ((n = getdents(fd, buf, BUF_SIZE)) > 0) {
+		int pos = 0;
+		while (pos < n) {
+			struct linux_dirent64 *d = (void*)buf + pos;
+			int i = num_of(d->d_name);
+
+			if (i >= 0) {
+				if (status[i].stable)
+					index++;
+				status[i].index = index;
+				status[i].pos = d->d_off;
+				if (trace)
+					printf("get_order %s %sstable index %d pos %lu\n",
+					       d->d_name, status[i].stable ?"":"un",
+					       status[i].index, d->d_off);
+			}
+			pos += d->d_reclen;
+		}
+	}
+	close(fd);
+}
+
+static bool check_order(int seen, uint64_t off)
+{
+	char buf[BUF_SIZE];
+	int fd = open(".", O_RDONLY | O_DIRECTORY);
+	int n;
+
+	if (fd < 0)
+		fail("open", ".");
+
+	if (trace)
+		printf("check order at offset %lu expecting index %d\n",
+		       off, seen+1);
+	lseek(fd, off, SEEK_SET);
+	while ((n = getdents(fd, buf, BUF_SIZE)) > 0) {
+		int pos = 0;
+		while (pos < n) {
+			struct linux_dirent64 *d = (void*)buf + pos;
+			int i = num_of(d->d_name);
+
+			if (i >= 0 && status[i].stable) {
+				if (status[i].index != seen + 1) {
+					fprintf(stderr, "order wrong at %s: expected index %d got %d\n",
+						d->d_name, seen+1, status[i].index);
+					close(fd);
+					return false;
+				}
+				seen += 1;
+			}
+			pos += d->d_reclen;
+		}
+	}
+	close(fd);
+	if (seen != num_names / 2) {
+		fprintf(stderr, "last stable name seen was %d, not %d\n", seen,
+			num_names/2);
+		return false;
+	}
+	return true;
+}
+
+static void create_files(void)
+{
+	for (int i = 0; i < num_names; i++) {
+		if (mknod(names[i], S_IFREG | 0600, 0) < 0)
+			fail("create", names[i]);
+
+		if (i & 1) {
+			put_file(&stable, i);
+			status[i].stable = true;
+		} else {
+			put_file(&unstable, i);
+			status[i].stable = false;
+		}
+	}
+}
+
+static void run_ops(int num)
+{
+	for (int i = 0; i < num;) {
+		int n, n2;
+		int op = random() % NUM_OPS;
+
+		if (disabled_ops & (1<<op))
+			continue;
+
+		switch (op) {
+		case op_unlink:
+			n = get_file(&unstable);
+			if (n >= 0) {
+				if (unlink(names[n]) == 0)
+					put_file(&unused, n);
+				else
+					fail("unlink", names[n]);
+				i++;
+				if (trace)
+					printf("unlink unstable %s\n", names[n]);
+			}
+			break;
+		case op_create:
+			n = get_file(&unused);
+			if (n > 0) {
+				if (mknod(names[n], S_IFREG | 0600, 0) == 0)
+					put_file(&unstable, n);
+				else
+					fail("create", names[n]);
+				i++;
+				if (trace)
+					printf("create unstable %s\n", names[n]);
+			}
+			break;
+		case op_rename:
+			n = get_file(&unstable);
+			if (n < 0)
+				break;
+			n2 = get_file(&unused);
+			if (n2 < 0) {
+				put_file(&unstable, n);
+				break;
+			}
+			if (rename(names[n], names[n2]) == 0) {
+				put_file(&unused, n);
+				put_file(&unstable, n2);
+				i++;
+			} else
+				fail("rename-to", names[n2]);
+			if (trace)
+				printf("rename unstable %s to unused %s\n",
+				       names[n], names[n2]);
+			break;
+		case op_replace:
+			n = get_file(&unstable);
+			if (n < 0)
+				break;
+			n2 = get_file(&unstable);
+			if (n2 < 0) {
+				put_file(&unstable, n);
+				break;
+			}
+			if (rename(names[n], names[n2]) == 0) {
+				put_file(&unused, n);
+				put_file(&unstable, n2);
+				i++;
+			} else
+				fail("replace", names[n2]);
+			if (trace)
+				printf("rename unstable %s to unstable %s\n",
+				       names[n], names[n2]);
+			break;
+		case op_exchange:
+			n = get_file(&unstable);
+			if (n < 0)
+				break;
+			n2 = get_file(&unstable);
+			if (n2 < 0) {
+				put_file(&unstable, n);
+				break;
+			}
+			if (renameat2(AT_FDCWD, names[n],
+				      AT_FDCWD, names[n2],
+				      RENAME_EXCHANGE) == 0) {
+				put_file(&unstable, n);
+				put_file(&unstable, n2);
+				i++;
+			} else
+				fail("exchange", names[n]);
+			if (trace)
+				printf("exchange unstable %s with unstable %s\n",
+				       names[n], names[n2]);
+			break;
+		case op_replace_stable:
+			n = get_file(&unstable);
+			if (n < 0)
+				break;
+			n2 = get_file(&stable);
+			if (n2 < 0) {
+				put_file(&unstable, n);
+				break;
+			}
+			if (rename(names[n], names[n2]) == 0) {
+				put_file(&unused, n);
+				put_file(&stable, n2);
+				i++;
+			} else
+				fail("replace", names[n2]);
+			if (trace)
+				printf("rename unstable %s to stable %s\n",
+				       names[n], names[n2]);
+			break;
+		case op_exchange_stable:
+			n = get_file(&stable);
+			if (n < 0)
+				break;
+			n2 = get_file(&stable);
+			if (n2 < 0) {
+				put_file(&stable, n);
+				break;
+			}
+			if (renameat2(AT_FDCWD, names[n],
+				      AT_FDCWD, names[n2],
+				      RENAME_EXCHANGE) == 0) {
+				put_file(&stable, n);
+				put_file(&stable, n2);
+				i++;
+			} else
+				fail("exchange", names[n2]);
+			if (trace)
+				printf("exchange stable %s with stable %s\n",
+				       names[n], names[n2]);
+			break;
+		}
+	}
+}
+
+static void usage(void)
+{
+	fprintf(stderr, "Usage: t_dir_seek -n numfiles -l numloops -o numops\n");
+	fprintf(stderr, "                  -p working-path -d temp-dir -S randomseed\n");
+	fprintf(stderr, "                  -T -O ops\n");
+	fprintf(stderr, " -T enables tracing\n");
+	fprintf(stderr, " -O disables ops. Currently:\n");
+	fprintf(stderr, "           \"nostable\" - disables ops affecting stable names\n");
+	fprintf(stderr, "           \"noexchange\" - disables RENAME_EXCHANGE\n");
+	fprintf(stderr, " random seed default to seconds since epoch\n");
+	fprintf(stderr, " temp-dir default to \"testdir\" and is removed on completion\n");
+	fprintf(stderr, " other defaults: -n 5000 -l 100 -p 10\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int opt;
+	int loop;
+	unsigned int seed = time(NULL);
+
+	while ( (opt = getopt(argc, argv, "n:l:o:p:d:S:TO:")) > 0) {
+		switch (opt) {
+		case 'n': /* number of names */
+			num_names = atoi(optarg);
+			if (num_names < 10 || num_names > 100000) {
+				fprintf(stderr, "-N: number of names must be 10..100000\n");
+				exit(2);
+			}
+			break;
+		case 'l': /* number of loops */
+			num_loops = atoi(optarg);
+			if (num_loops < 1 || num_loops > 10000) {
+				fprintf(stderr, "-l: number of loops must be 1..10000\n");
+				exit(2);
+			}
+			break;
+		case 'o': /* number of ops per loop */
+			num_ops = atoi(optarg);
+			if (num_ops < 1 || num_ops > 100) {
+				fprintf(stderr, "-l: number of ops must be 1..100\n");
+				exit(2);
+			}
+			break;
+		case 'p': /* name of dir to work in */
+			if (chdir(optarg) != 0) {
+				perror(optarg);
+				exit(2);
+			}
+			break;
+		case 'd': /* Directory to create and use */
+			if (strlen(optarg) == 0 ||
+			    strchr(optarg, '/') != NULL ||
+			    optarg[0] == '.') {
+				fprintf(stderr, "illegal directory name \"%s\"\n",
+					optarg);
+				exit(2);
+			}
+			dir = optarg;
+			break;
+		case 'S':
+			seed = atoi(optarg);
+			break;
+		case 'T':
+			trace = true;
+			break;
+		case 'O':
+			if (strcmp(optarg, "nostable") == 0)
+				disabled_ops |= OP_STABLE;
+			else if (strcmp(optarg, "noexchange") == 0)
+				disabled_ops |= OP_EXCH;
+			else {
+				fprintf(stderr, "-O %s - not recognised\n", optarg);
+				exit(2);
+			}
+			break;
+		case '?':
+		default:
+			usage();
+			exit(2);
+		}
+	}
+
+	if (optind < argc) {
+		fprintf(stderr, "Unrecognised argument: %s\n", argv[optind]);
+		usage();
+		exit(2);
+	}
+
+	homefd = open(".", O_RDONLY | O_DIRECTORY);
+	if (homefd < 0)
+		fail("open", ".");
+	if (mkdir(dir, 0755)) {
+		perror(dir);
+		exit(1);
+	}
+	chdir(dir);
+	srandom(seed);
+	make_names();
+	alloc_flist(&stable);
+	alloc_flist(&unstable);
+	alloc_flist(&unused);
+	alloc_status();
+
+	create_files();
+	get_order();
+	for (loop = 0; loop < num_loops; loop++) {
+		int n;
+
+		run_ops(num_ops);
+		if (!check_order(0, 0))
+			break;
+
+		n = random() % num_names;
+		if (!check_order(status[n].index, status[n].pos))
+			break;
+	}
+	clean_files();
+	if (loop == num_loops) {
+		printf("Passed all %d loops with seed %u\n", loop, seed);
+		exit(0);
+	} else {
+		printf("Failed on loop %d of %d with seed %u\n", loop,
+		       num_loops, seed);
+		exit(1);
+	}
+}
diff --git a/tests/generic/799 b/tests/generic/799
new file mode 100755
index 000000000000..07279394ef43
--- /dev/null
+++ b/tests/generic/799
@@ -0,0 +1,25 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 NeilBrown
+#
+# Check dir list and offsets are stable in the fast of churn.
+# Name that are not unlinks or renamed should rename in-order w.r.t
+# each other and any seek positions reported.
+
+. ./common/preamble
+_begin_fstest auto dir quick
+
+_require_test
+_require_test_program "t_dir_seek"
+
+extra=""
+if [ "$FSTYP" == "nfs" ]; then
+    extra="-O noexchange"
+fi
+
+# provide a seed as it is reported in the output
+$here/src/t_dir_seek -p $TEST_DIR -S 1234567 $extra
+
+# success, all done
+echo "*** done"
+status=0
diff --git a/tests/generic/799.out b/tests/generic/799.out
new file mode 100644
index 000000000000..3acd51a1847b
--- /dev/null
+++ b/tests/generic/799.out
@@ -0,0 +1,3 @@
+QA output created by 799
+Passed all 100 loops with seed 1234567
+*** done

base-commit: 56c410ad0f69da5b13c5807bc47b4876dcfa02b2
-- 
2.50.0.107.gf914562f5916.dirty

