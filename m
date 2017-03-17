Received: from mx1.redhat.com ([209.132.183.28]:37096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750926AbdCQMZW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 17 Mar 2017 08:25:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82E4680477
        for <fstests@vger.kernel.org>; Fri, 17 Mar 2017 12:14:53 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-8-67.pek2.redhat.com [10.72.8.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2378262927
        for <fstests@vger.kernel.org>; Fri, 17 Mar 2017 12:14:51 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] fsstress: add mmap/munmap into test operation list
Date: Fri, 17 Mar 2017 20:14:22 +0800
Message-Id: <1489752862-15786-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

mmap as a popular and basic operation, most of softwares use it to
access files.

More and more customers report bugs related with mmap/munmap and
other stress conditions. So add mmap test into fsstress to reproduce
or find more bugs easily.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

I've tested this patch on XFS by running:

./ltp/fsstress -d /mnt/scratch -f mmap=1000 -f creat=500 -f mkdir=500 -n 2000 -p10 -v
./ltp/fsstress -d /mnt/scratch -f mmap=1000 -f dwrite=1000 -f write=1000 -f creat=500 -f mkdir=500 -n 4000 -p10 -v
./ltp/fsstress -d /mnt/scratch -n 5000 -p10 -v

I didn't find any unexpected errors. Please help to review.
I'll send another patch to LTP if this patch can be merged into xfstests.

Thanks,
Zorro

 ltp/fsstress.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/global.h   |  4 +++
 2 files changed, 81 insertions(+)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 35e2765..5914551 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -2585,7 +2585,84 @@ link_f(int opno, long r)
 void
 mmap_f(int opno, long r)
 {
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
 
+	init_pathname(&f);
+	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
+		if (v)
+			printf("%d/%d: mmap - no filename\n", procid, opno);
+		free_pathname(&f);
+		return;
+	}
+	fd = open_path(&f, O_RDWR);
+	e = fd < 0 ? errno : 0;
+	check_cwd();
+	if (fd < 0) {
+		if (v)
+			printf("%d/%d: mmap - open %s failed %d\n",
+			       procid, opno, f.path, e);
+		free_pathname(&f);
+		return;
+	}
+	if (fstat64(fd, &stb) < 0) {
+		if (v)
+			printf("%d/%d: write - fstat64 %s failed %d\n",
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
+		addr = mmap(NULL, len, PROT_READ | PROT_WRITE, flags, fd, off);
+		e = (addr == MAP_FAILED) ? errno : 0;
+		if (errno == ENOMEM && flags & MAP_PRIVATE) {
+		/* turn to shared mapping if memeory is not enough for private mapping */
+			flags = MAP_SHARED;
+		} else if (errno == ENOMEM && len > sysconf(_SC_PAGE_SIZE)) {
+		/* reduce mapping length, if memeory is not enough for shared mapping */
+			len /= 2;
+		}
+	} while (errno == ENOMEM && len > sysconf(_SC_PAGE_SIZE));
+	if (v)
+		printf("%d/%d: mmap %s%s [%lld,%d,%s] %d\n",
+		       procid, opno, f.path, st, (long long)off, (int)len,
+		       (flags & MAP_PRIVATE) ? "MAP_PRIVATE" : "MAP_SHARED", e);
+
+	if (addr != MAP_FAILED) {
+		memset(addr, nameseq & 0xff, len);
+		e = munmap(addr, len) < 0 ? errno : 0;
+		if (v)
+			printf("%d/%d: munmap %s%s [%lld,%d] %d\n",
+			       procid, opno, f.path, st, (long long)off,
+			       (int)len, e);
+	}
+
+	free_pathname(&f);
+	close(fd);
 }
 
 void
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

