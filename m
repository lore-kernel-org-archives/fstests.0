Received: from mx1.redhat.com ([209.132.183.28]:33952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbdCRFke (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 18 Mar 2017 01:40:34 -0400
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3] fsstress: add mwrite/mread into test operation list
Date: Sat, 18 Mar 2017 13:40:11 +0800
Message-Id: <1489815611-15434-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: amir73il@gmail.com
List-ID: <fstests@vger.kernel.org>

mmap as a popular and basic operation, most of softwares use it to
access files. More and more customers report bugs related with
mmap/munmap and other stress conditions.

So add mmap read/write test into fsstress to increase mmap related
stress to reproduce or find more bugs easily.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

According to Amir's suggestion, V3 change mmap_f to mwrite_f and mread_f.

Recently we got more and more bug reports about writeback, mmap/munmap
and memory reclaim race condition under heavy memeory load. We never
reproduce these bugs before and still hard to reproduce it until now.
Only some servers with real stress from lots of real customers can
reproduce this kind of bugs.

fsstress is a popular tool to simulate randome load stress test used by
many developers and QEs. For we can reproduce more bugs easier (maybe
can't improve too much :-P), add mmap/munmap stress in this patch.

Thanks,
Zorro

 ltp/fsstress.c | 187 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/global.h   |   4 ++
 2 files changed, 191 insertions(+)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 7e7cf60..248fd30 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -67,6 +67,8 @@ typedef enum {
 	OP_GETATTR,
 	OP_GETDENTS,
 	OP_LINK,
+	OP_MWRITE,
+	OP_MREAD,
 	OP_MKDIR,
 	OP_MKNOD,
 	OP_PUNCH,
@@ -166,6 +168,8 @@ void	fsync_f(int, long);
 void	getattr_f(int, long);
 void	getdents_f(int, long);
 void	link_f(int, long);
+void	mwrite_f(int, long);
+void	mread_f(int, long);
 void	mkdir_f(int, long);
 void	mknod_f(int, long);
 void	punch_f(int, long);
@@ -206,6 +210,8 @@ opdesc_t	ops[] = {
 	{ OP_GETATTR, "getattr", getattr_f, 1, 0 },
 	{ OP_GETDENTS, "getdents", getdents_f, 1, 0 },
 	{ OP_LINK, "link", link_f, 1, 1 },
+	{ OP_MWRITE, "mwrite", mwrite_f, 4, 1 },
+	{ OP_MREAD, "mread", mread_f, 4, 1 },
 	{ OP_MKDIR, "mkdir", mkdir_f, 2, 1 },
 	{ OP_MKNOD, "mknod", mknod_f, 2, 1 },
 	{ OP_PUNCH, "punch", punch_f, 1, 1 },
@@ -2580,6 +2586,187 @@ link_f(int opno, long r)
 }
 
 void
+mwrite_f(int opno, long r)
+{
+	char		*addr;
+	int		e;
+	pathname_t	f;
+	int		fd;
+	size_t		len;
+	__int64_t	lr;
+	off64_t		off;
+	int		flags;
+	struct stat64	stb;
+	int		v;
+	char		st[1024];
+
+	init_pathname(&f);
+	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
+		if (v)
+			printf("%d/%d: mwrite - no filename\n", procid, opno);
+		free_pathname(&f);
+		return;
+	}
+	fd = open_path(&f, O_WRONLY);
+	e = fd < 0 ? errno : 0;
+	check_cwd();
+	if (fd < 0) {
+		if (v)
+			printf("%d/%d: mwrite - open %s failed %d\n",
+			       procid, opno, f.path, e);
+		free_pathname(&f);
+		return;
+	}
+	if (fstat64(fd, &stb) < 0) {
+		if (v)
+			printf("%d/%d: mwrite - fstat64 %s failed %d\n",
+			       procid, opno, f.path, errno);
+		free_pathname(&f);
+		close(fd);
+		return;
+	}
+	inode_info(st, sizeof(st), &stb, v);
+	lr = ((__int64_t)random() << 32) + random();
+	off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
+	off %= maxfsize;
+	off &= (off64_t)(~(sysconf(_SC_PAGE_SIZE) - 1));
+	len = (size_t)(random() % MIN(maxfsize - off, FILELEN_MAX)) + 1;
+
+	/*
+	 * truncate file to the size we need to map and access,
+	 * keep away SIGBUS / SIGSEGV killing this process
+	 */
+	e = truncate64_path(&f, off + len) < 0 ? errno : 0;
+	/* try private file mappings with 20% rate */
+	flags = (random() % 20) ? MAP_SHARED : MAP_PRIVATE;
+	do {
+		addr = mmap(NULL, len, PROT_WRITE, flags, fd, off);
+		e = (addr == MAP_FAILED) ? errno : 0;
+		if (errno == ENOMEM && flags & MAP_PRIVATE) {
+		/* turn to shared mapping if memeory is not enough for private mapping */
+			flags = MAP_SHARED;
+		} else if (errno == ENOMEM && len > sysconf(_SC_PAGE_SIZE)) {
+		/* reduce mapping length, if memeory is not enough for shared mapping */
+			len /= 2;
+		}
+	} while (errno == ENOMEM && len > sysconf(_SC_PAGE_SIZE));
+	if (e && v)
+		printf("%d/%d: mwrite - mmap failed %s%s [%lld,%d,%s] %d\n",
+		       procid, opno, f.path, st, (long long)off, (int)len,
+		       (flags & MAP_PRIVATE) ? "MAP_PRIVATE" : "MAP_SHARED", e);
+
+	if (addr != MAP_FAILED) {
+		memset(addr, nameseq & 0xff, len);
+		e = munmap(addr, len) < 0 ? errno : 0;
+		if (e && v)
+			printf("%d/%d: mwrite - munmap failed %s%s [%lld,%d] %d\n",
+			       procid, opno, f.path, st, (long long)off,
+			       (int)len, e);
+	}
+	if (v)
+		printf("%d/%d: mwrite %s%s [%lld,%d,%s] %d\n",
+		       procid, opno, f.path, st, (long long)off, (int)len,
+		       (flags & MAP_PRIVATE) ? "MAP_PRIVATE" : "MAP_SHARED", e);
+
+	free_pathname(&f);
+	close(fd);
+}
+
+void
+mread_f(int opno, long r)
+{
+	char		*addr;
+	char		*buf;
+	int		e;
+	pathname_t	f;
+	int		fd;
+	size_t		len;
+	__int64_t	lr;
+	off64_t		off;
+	int		flags;
+	struct stat64	stb;
+	int		v;
+	char		st[1024];
+
+	init_pathname(&f);
+	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
+		if (v)
+			printf("%d/%d: mread - no filename\n", procid, opno);
+		free_pathname(&f);
+		return;
+	}
+	fd = open_path(&f, O_RDONLY);
+	e = fd < 0 ? errno : 0;
+	check_cwd();
+	if (fd < 0) {
+		if (v)
+			printf("%d/%d: mread - open %s failed %d\n",
+			       procid, opno, f.path, e);
+		free_pathname(&f);
+		return;
+	}
+	if (fstat64(fd, &stb) < 0) {
+		if (v)
+			printf("%d/%d: mread - fstat64 %s failed %d\n",
+			       procid, opno, f.path, errno);
+		free_pathname(&f);
+		close(fd);
+		return;
+	}
+	if (stb.st_size == 0) {
+		if (v)
+			printf("%d/%d: mread - %s%s zero size\n", procid, opno,
+			       f.path, st);
+		free_pathname(&f);
+		close(fd);
+		return;
+	}
+
+	inode_info(st, sizeof(st), &stb, v);
+	lr = ((__int64_t)random() << 32) + random();
+	off = (off64_t)(lr % stb.st_size);
+	off &= (off64_t)(~(sysconf(_SC_PAGE_SIZE) - 1));
+	len = (size_t)(random() % MIN(stb.st_size - off, FILELEN_MAX)) + 1;
+
+	/* try private file mappings with 20% rate */
+	flags = (random() % 20) ? MAP_SHARED : MAP_PRIVATE;
+	do {
+		addr = mmap(NULL, len, PROT_READ, flags, fd, off);
+		e = (addr == MAP_FAILED) ? errno : 0;
+		if (errno == ENOMEM && flags & MAP_PRIVATE) {
+		/* turn to shared mapping if memeory is not enough for private mapping */
+			flags = MAP_SHARED;
+		} else if (errno == ENOMEM && len > sysconf(_SC_PAGE_SIZE)) {
+		/* reduce mapping length, if memeory is not enough for shared mapping */
+			len /= 2;
+		}
+	} while (errno == ENOMEM && len > sysconf(_SC_PAGE_SIZE));
+	if (e && v)
+		printf("%d/%d: mread - mmap failed %s%s [%lld,%d,%s] %d\n",
+		       procid, opno, f.path, st, (long long)off, (int)len,
+		       (flags & MAP_PRIVATE) ? "MAP_PRIVATE" : "MAP_SHARED", e);
+
+	if (addr != MAP_FAILED) {
+		if ((buf = malloc(len)) != NULL) {
+			memcpy(buf, addr, len);
+			free(buf);
+		}
+		e = munmap(addr, len) < 0 ? errno : 0;
+		if (e && v)
+			printf("%d/%d: mread - munmap failed %s%s [%lld,%d] %d\n",
+			       procid, opno, f.path, st, (long long)off,
+			       (int)len, e);
+	}
+	if (v)
+		printf("%d/%d: mread %s%s [%lld,%d,%s] %d\n",
+		       procid, opno, f.path, st, (long long)off, (int)len,
+		       (flags & MAP_PRIVATE) ? "MAP_PRIVATE" : "MAP_SHARED", e);
+
+	free_pathname(&f);
+	close(fd);
+}
+
+void
 mkdir_f(int opno, long r)
 {
 	int		e;
diff --git a/src/global.h b/src/global.h
index f63246b..51d1e94 100644
--- a/src/global.h
+++ b/src/global.h
@@ -178,4 +178,8 @@
 
 #endif /* HAVE_LINUX_FALLOC_H */
 
+#ifndef HAVE_SYS_MMAN_H
+#include <sys/mman.h>
+#endif
+
 #endif /* GLOBAL_H */
-- 
2.7.4

