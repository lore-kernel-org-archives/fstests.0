Received: from mx1.redhat.com ([209.132.183.28]:37228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751461AbdCWHaI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 23 Mar 2017 03:30:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00AA821722
        for <fstests@vger.kernel.org>; Thu, 23 Mar 2017 06:50:10 +0000 (UTC)
Received: from dhcp-12-168.nay.redhat.com (dhcp-12-168.nay.redhat.com [10.66.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 402587DFC2
        for <fstests@vger.kernel.org>; Thu, 23 Mar 2017 06:50:09 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v7 1/2] fsstress: add mwrite/mread into test operation list
Date: Thu, 23 Mar 2017 14:50:04 +0800
Message-Id: <1490251805-22658-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

mmap as a popular and basic operation, most of softwares use it to
access files. More and more customers report bugs related with
mmap/munmap and other stress conditions.

So add mmap read/write test into fsstress to increase mmap related
stress to reproduce or find more bugs easily.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

V7 did below changes:
1) Move inode_info() function call backward, to init "struct st" before
use it.
2) Return directly if mmap fails
3) Add HAVE_SYS_MMAN_H detection in mwrite() and mread() functions.

Thanks,
Zorro

 configure.ac   |   1 +
 ltp/fsstress.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/global.h   |   4 ++
 3 files changed, 119 insertions(+)

diff --git a/configure.ac b/configure.ac
index fa48d2f..246f92e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -32,6 +32,7 @@ AC_HEADER_STDC
 			xfs/platform_defs.h	\
 			btrfs/ioctl.h		\
 			cifs/ioctl.h		\
+			sys/mman.h		\
     ])
=20
 AC_CHECK_HEADERS([xfs/xfs_log_format.h],,,[
diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 7e7cf60..f8203cf 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -69,6 +69,8 @@ typedef enum {
 	OP_LINK,
 	OP_MKDIR,
 	OP_MKNOD,
+	OP_MREAD,
+	OP_MWRITE,
 	OP_PUNCH,
 	OP_ZERO,
 	OP_COLLAPSE,
@@ -168,6 +170,8 @@ void	getdents_f(int, long);
 void	link_f(int, long);
 void	mkdir_f(int, long);
 void	mknod_f(int, long);
+void	mread_f(int, long);
+void	mwrite_f(int, long);
 void	punch_f(int, long);
 void	zero_f(int, long);
 void	collapse_f(int, long);
@@ -208,6 +212,8 @@ opdesc_t	ops[] =3D {
 	{ OP_LINK, "link", link_f, 1, 1 },
 	{ OP_MKDIR, "mkdir", mkdir_f, 2, 1 },
 	{ OP_MKNOD, "mknod", mknod_f, 2, 1 },
+	{ OP_MREAD, "mread", mread_f, 2, 0 },
+	{ OP_MWRITE, "mwrite", mwrite_f, 2, 1 },
 	{ OP_PUNCH, "punch", punch_f, 1, 1 },
 	{ OP_ZERO, "zero", zero_f, 1, 1 },
 	{ OP_COLLAPSE, "collapse", collapse_f, 1, 1 },
@@ -2656,6 +2662,114 @@ mknod_f(int opno, long r)
 }
=20
 void
+do_mmap(int opno, long r, int prot)
+{
+#ifdef HAVE_SYS_MMAN_H
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
+			printf("%d/%d: do_mmap - no filename\n", procid, opno);
+		free_pathname(&f);
+		return;
+	}
+	fd =3D open_path(&f, O_RDWR);
+	e =3D fd < 0 ? errno : 0;
+	check_cwd();
+	if (fd < 0) {
+		if (v)
+			printf("%d/%d: do_mmap - open %s failed %d\n",
+			       procid, opno, f.path, e);
+		free_pathname(&f);
+		return;
+	}
+	if (fstat64(fd, &stb) < 0) {
+		if (v)
+			printf("%d/%d: do_mmap - fstat64 %s failed %d\n",
+			       procid, opno, f.path, errno);
+		free_pathname(&f);
+		close(fd);
+		return;
+	}
+	inode_info(st, sizeof(st), &stb, v);
+	if (stb.st_size =3D=3D 0) {
+		if (v)
+			printf("%d/%d: do_mmap - %s%s zero size\n", procid, opno,
+			       f.path, st);
+		free_pathname(&f);
+		close(fd);
+		return;
+	}
+
+	lr =3D ((__int64_t)random() << 32) + random();
+	off =3D (off64_t)(lr % stb.st_size);
+	off &=3D (off64_t)(~(sysconf(_SC_PAGE_SIZE) - 1));
+	len =3D (size_t)(random() % MIN(stb.st_size - off, FILELEN_MAX)) + 1;
+
+	flags =3D (random() % 2) ? MAP_SHARED : MAP_PRIVATE;
+	addr =3D mmap(NULL, len, prot, flags, fd, off);
+	e =3D (addr =3D=3D MAP_FAILED) ? errno : 0;
+	if (e) {
+		if (v)
+			printf("%d/%d: do_mmap - mmap failed %s%s [%lld,%d,%s] %d\n",
+			       procid, opno, f.path, st,
+			       (long long)off, (int)len,
+			       (flags & MAP_PRIVATE) ? "MAP_PRIVATE" : "MAP_SHARED",
+			       e);
+		free_pathname(&f);
+		close(fd);
+		return;
+	}
+
+	if (prot & PROT_WRITE) {
+		/* PROT_READ maybe set, if PROT_WRITE is set. Not vice versa */
+		memset(addr, nameseq & 0xff, len);
+	} else {
+		char *buf;
+		if ((buf =3D malloc(len)) !=3D NULL) {
+			memcpy(buf, addr, len);
+			free(buf);
+		}
+	}
+	e =3D munmap(addr, len) < 0 ? errno : 0;
+	if (v)
+		printf("%d/%d: %s %s%s [%lld,%d] %d\n",
+		       procid, opno, (prot & PROT_WRITE) ? "mwrite" : "mread",
+		       f.path, st, (long long)off, (int)len, e);
+
+	free_pathname(&f);
+	close(fd);
+#endif
+}
+
+void
+mread_f(int opno, long r)
+{
+#ifdef HAVE_SYS_MMAN_H
+	do_mmap(opno, r, PROT_READ);
+#endif
+}
+
+void
+mwrite_f(int opno, long r)
+{
+#ifdef HAVE_SYS_MMAN_H
+	do_mmap(opno, r, PROT_WRITE);
+#endif
+}
+
+void
 punch_f(int opno, long r)
 {
 #ifdef HAVE_LINUX_FALLOC_H
diff --git a/src/global.h b/src/global.h
index f63246b..3920c0d 100644
--- a/src/global.h
+++ b/src/global.h
@@ -178,4 +178,8 @@
=20
 #endif /* HAVE_LINUX_FALLOC_H */
=20
+#ifdef HAVE_SYS_MMAN_H
+#include <sys/mman.h>
+#endif
+
 #endif /* GLOBAL_H */
--=20
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DZ1leMBab4qLfpKF547IMbHJ4BYkn2LGzkzPpkm_h6co&s=3D2u5WJYHswnAQkeRJleiX-47K=
r8_6ET2i1njN-4t5gQE&e=3D=20
