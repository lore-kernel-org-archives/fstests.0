Received: from mx2.mpynet.fi ([82.197.21.85]:48754 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753228AbeARRVN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 Jan 2018 12:21:13 -0500
From: Rostislav Skudnov <rostislav@tuxera.com>
Subject: [PATCH] Replace obsolete symbols and macros, fix build with musl libc.
Date: Thu, 18 Jan 2018 17:20:58 +0000
Message-ID: <1516296058-8224-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This commit replaces some obsolete and non-standard data types, headers,
macros and symbols with standard and modern ones in order to allow
building xfstests with musl C library.

Replace all __[u]intNN_t types with standard [u]intNN_t. This has been
done with the following command:
sed -r -i 's/__(u?int[0-9]{2}_t)/\1/g' src/*.c ltp/*.c

doio, growfiles: Use standard signal name SIGCHLD instead of SIGCLD.

fsstress: Include stddef.h for ptrdiff_t.

metaperf: Include linux/param.h for HZ macro.

dmiperf: Include sys/types.h for u_int32_t.

getdevicesize: Include stdint.h for uint64_t.

t_mtab: Replace sys_siglist[] with strsignal().

fssum: Use bswap_64() instead of __bswap_64().

pwrite_mmap_blocked: Include standard header signal.h instead of
sys/signal.h.
---
 ltp/doio.c                |  2 +-
 ltp/fsstress.c            | 85 ++++++++++++++++++++++++-----------------------
 ltp/growfiles.c           |  2 +-
 src/alloc.c               |  2 +-
 src/dmiperf.c             |  1 +
 src/feature.c             |  2 +-
 src/fssum.c               |  3 +-
 src/getdevicesize.c       |  4 ++-
 src/loggen.c              |  6 ++--
 src/makeextents.c         | 10 +++---
 src/metaperf.c            |  1 +
 src/pwrite_mmap_blocked.c |  2 +-
 src/randholes.c           | 30 ++++++++---------
 src/t_mtab.c              |  2 +-
 14 files changed, 79 insertions(+), 73 deletions(-)

diff --git a/ltp/doio.c b/ltp/doio.c
index b937718..939a1ea 100644
--- a/ltp/doio.c
+++ b/ltp/doio.c
@@ -362,7 +362,7 @@ char	**argv;
 		case SIGTSTP:
 		case SIGSTOP:
 		case SIGCONT:
-		case SIGCLD:
+		case SIGCHLD:
 		case SIGBUS:
 		case SIGSEGV:
 		case SIGQUIT:
diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 4dea029..935f5de 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -19,6 +19,7 @@
 #include <linux/fs.h>
 #include <setjmp.h>
 #include <sys/uio.h>
+#include <stddef.h>
 #include "global.h"
 
 #ifdef HAVE_ATTR_XATTR_H
@@ -1810,7 +1811,7 @@ allocsp_f(int opno, long r)
 	pathname_t	f;
 	int		fd;
 	struct xfs_flock64	fl;
-	__int64_t	lr;
+	int64_t		lr;
 	off64_t		off;
 	struct stat64	stb;
 	int		v;
@@ -1842,7 +1843,7 @@ allocsp_f(int opno, long r)
 		return;
 	}
 	inode_info(st, sizeof(st), &stb, v);
-	lr = ((__int64_t)random() << 32) + random();
+	lr = ((int64_t)random() << 32) + random();
 	off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
 	off %= maxfsize;
 	fl.l_whence = SEEK_SET;
@@ -1861,14 +1862,14 @@ allocsp_f(int opno, long r)
 void
 do_aio_rw(int opno, long r, int flags)
 {
-	__int64_t	align;
+	int64_t		align;
 	char		*buf;
 	struct dioattr	diob;
 	int		e;
 	pathname_t	f;
 	int		fd;
 	size_t		len;
-	__int64_t	lr;
+	int64_t		lr;
 	off64_t		off;
 	struct stat64	stb;
 	int		v;
@@ -1925,8 +1926,8 @@ do_aio_rw(int opno, long r, int flags)
 	dio_env = getenv("XFS_DIO_MIN");
 	if (dio_env)
 		diob.d_mem = diob.d_miniosz = atoi(dio_env);
-	align = (__int64_t)diob.d_miniosz;
-	lr = ((__int64_t)random() << 32) + random();
+	align = (int64_t)diob.d_miniosz;
+	lr = ((int64_t)random() << 32) + random();
 	len = (random() % FILELEN_MAX) + 1;
 	len -= (len % align);
 	if (len <= 0)
@@ -2101,7 +2102,7 @@ bulkstat_f(int opno, long r)
 	__u64		last;
 	int		nent;
 	xfs_bstat_t	*t;
-	__int64_t	total;
+	int64_t		total;
         xfs_fsop_bulkreq_t bsr;
 
 	last = 0;
@@ -2292,7 +2293,7 @@ clonerange_f(
 	if (len > stat1.st_size)
 		len = stat1.st_size;
 
-	lr = ((__int64_t)random() << 32) + random();
+	lr = ((int64_t)random() << 32) + random();
 	if (stat1.st_size == len)
 		off1 = 0;
 	else
@@ -2305,7 +2306,7 @@ clonerange_f(
 	 * until we find one that doesn't overlap the source range.
 	 */
 	do {
-		lr = ((__int64_t)random() << 32) + random();
+		lr = ((int64_t)random() << 32) + random();
 		off2 = (off64_t)(lr % MIN(stat2.st_size + (1024 * 1024), MAXFSIZE));
 		off2 %= maxfsize;
 		off2 &= ~(stat2.st_blksize - 1);
@@ -2496,7 +2497,7 @@ deduperange_f(
 		len = stat[0].st_size / 2;
 
 	/* Calculate offsets */
-	lr = ((__int64_t)random() << 32) + random();
+	lr = ((int64_t)random() << 32) + random();
 	if (stat[0].st_size == len)
 		off[0] = 0;
 	else
@@ -2512,7 +2513,7 @@ deduperange_f(
 		int	tries = 0;
 
 		do {
-			lr = ((__int64_t)random() << 32) + random();
+			lr = ((int64_t)random() << 32) + random();
 			if (stat[i].st_size <= len)
 				off[i] = 0;
 			else
@@ -2701,14 +2702,14 @@ creat_f(int opno, long r)
 void
 dread_f(int opno, long r)
 {
-	__int64_t	align;
+	int64_t		align;
 	char		*buf;
 	struct dioattr	diob;
 	int		e;
 	pathname_t	f;
 	int		fd;
 	size_t		len;
-	__int64_t	lr;
+	int64_t		lr;
 	off64_t		off;
 	struct stat64	stb;
 	int		v;
@@ -2763,8 +2764,8 @@ dread_f(int opno, long r)
 	if (dio_env)
 		diob.d_mem = diob.d_miniosz = atoi(dio_env);
 
-	align = (__int64_t)diob.d_miniosz;
-	lr = ((__int64_t)random() << 32) + random();
+	align = (int64_t)diob.d_miniosz;
+	lr = ((int64_t)random() << 32) + random();
 	off = (off64_t)(lr % stb.st_size);
 	off -= (off % align);
 	lseek64(fd, off, SEEK_SET);
@@ -2787,14 +2788,14 @@ dread_f(int opno, long r)
 void
 dwrite_f(int opno, long r)
 {
-	__int64_t	align;
+	int64_t		align;
 	char		*buf;
 	struct dioattr	diob;
 	int		e;
 	pathname_t	f;
 	int		fd;
 	size_t		len;
-	__int64_t	lr;
+	int64_t		lr;
 	off64_t		off;
 	struct stat64	stb;
 	int		v;
@@ -2840,8 +2841,8 @@ dwrite_f(int opno, long r)
 	if (dio_env)
 		diob.d_mem = diob.d_miniosz = atoi(dio_env);
 
-	align = (__int64_t)diob.d_miniosz;
-	lr = ((__int64_t)random() << 32) + random();
+	align = (int64_t)diob.d_miniosz;
+	lr = ((int64_t)random() << 32) + random();
 	off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
 	off -= (off % align);
 	lseek64(fd, off, SEEK_SET);
@@ -2887,7 +2888,7 @@ do_fallocate(int opno, long r, int mode)
 	int		e;
 	pathname_t	f;
 	int		fd;
-	__int64_t	lr;
+	int64_t		lr;
 	off64_t		off;
 	off64_t		len;
 	struct stat64	stb;
@@ -2919,7 +2920,7 @@ do_fallocate(int opno, long r, int mode)
 		return;
 	}
 	inode_info(st, sizeof(st), &stb, v);
-	lr = ((__int64_t)random() << 32) + random();
+	lr = ((int64_t)random() << 32) + random();
 	off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
 	off %= maxfsize;
 	len = (off64_t)(random() % (1024 * 1024));
@@ -3002,7 +3003,7 @@ fiemap_f(int opno, long r)
 	int		e;
 	pathname_t	f;
 	int		fd;
-	__int64_t	lr;
+	int64_t		lr;
 	off64_t		off;
 	struct stat64	stb;
 	int		v;
@@ -3046,14 +3047,14 @@ fiemap_f(int opno, long r)
 		close(fd);
 		return;
 	}
-	lr = ((__int64_t)random() << 32) + random();
+	lr = ((int64_t)random() << 32) + random();
 	off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
 	off %= maxfsize;
 	fiemap->fm_flags = random() & (FIEMAP_FLAGS_COMPAT | 0x10000);
 	fiemap->fm_extent_count = blocks_to_map;
 	fiemap->fm_mapped_extents = random() & 0xffff;
 	fiemap->fm_start = off;
-	fiemap->fm_length = ((__int64_t)random() << 32) + random();
+	fiemap->fm_length = ((int64_t)random() << 32) + random();
 
 	e = ioctl(fd, FS_IOC_FIEMAP, (unsigned long)fiemap);
 	if (v)
@@ -3074,7 +3075,7 @@ freesp_f(int opno, long r)
 	pathname_t	f;
 	int		fd;
 	struct xfs_flock64	fl;
-	__int64_t	lr;
+	int64_t		lr;
 	off64_t		off;
 	struct stat64	stb;
 	int		v;
@@ -3106,7 +3107,7 @@ freesp_f(int opno, long r)
 		return;
 	}
 	inode_info(st, sizeof(st), &stb, v);
-	lr = ((__int64_t)random() << 32) + random();
+	lr = ((int64_t)random() << 32) + random();
 	off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
 	off %= maxfsize;
 	fl.l_whence = SEEK_SET;
@@ -3349,7 +3350,7 @@ do_mmap(int opno, long r, int prot)
 	pathname_t	f;
 	int		fd;
 	size_t		len;
-	__int64_t	lr;
+	int64_t		lr;
 	off64_t		off;
 	int		flags;
 	struct stat64	stb;
@@ -3392,7 +3393,7 @@ do_mmap(int opno, long r, int prot)
 		return;
 	}
 
-	lr = ((__int64_t)random() << 32) + random();
+	lr = ((int64_t)random() << 32) + random();
 	off = (off64_t)(lr % stb.st_size);
 	off &= (off64_t)(~(sysconf(_SC_PAGE_SIZE) - 1));
 	len = (size_t)(random() % MIN(stb.st_size - off, FILELEN_MAX)) + 1;
@@ -3494,7 +3495,7 @@ read_f(int opno, long r)
 	pathname_t	f;
 	int		fd;
 	size_t		len;
-	__int64_t	lr;
+	int64_t		lr;
 	off64_t		off;
 	struct stat64	stb;
 	int		v;
@@ -3534,7 +3535,7 @@ read_f(int opno, long r)
 		close(fd);
 		return;
 	}
-	lr = ((__int64_t)random() << 32) + random();
+	lr = ((int64_t)random() << 32) + random();
 	off = (off64_t)(lr % stb.st_size);
 	lseek64(fd, off, SEEK_SET);
 	len = (random() % FILELEN_MAX) + 1;
@@ -3578,7 +3579,7 @@ readv_f(int opno, long r)
 	pathname_t	f;
 	int		fd;
 	size_t		len;
-	__int64_t	lr;
+	int64_t		lr;
 	off64_t		off;
 	struct stat64	stb;
 	int		v;
@@ -3623,7 +3624,7 @@ readv_f(int opno, long r)
 		close(fd);
 		return;
 	}
-	lr = ((__int64_t)random() << 32) + random();
+	lr = ((int64_t)random() << 32) + random();
 	off = (off64_t)(lr % stb.st_size);
 	lseek64(fd, off, SEEK_SET);
 	len = (random() % FILELEN_MAX) + 1;
@@ -3725,7 +3726,7 @@ resvsp_f(int opno, long r)
 	pathname_t	f;
 	int		fd;
 	struct xfs_flock64	fl;
-	__int64_t	lr;
+	int64_t		lr;
 	off64_t		off;
 	struct stat64	stb;
 	int		v;
@@ -3757,7 +3758,7 @@ resvsp_f(int opno, long r)
 		return;
 	}
 	inode_info(st, sizeof(st), &stb, v);
-	lr = ((__int64_t)random() << 32) + random();
+	lr = ((int64_t)random() << 32) + random();
 	off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
 	off %= maxfsize;
 	fl.l_whence = SEEK_SET;
@@ -3909,7 +3910,7 @@ truncate_f(int opno, long r)
 {
 	int		e;
 	pathname_t	f;
-	__int64_t	lr;
+	int64_t		lr;
 	off64_t		off;
 	struct stat64	stb;
 	int		v;
@@ -3932,7 +3933,7 @@ truncate_f(int opno, long r)
 		return;
 	}
 	inode_info(st, sizeof(st), &stb, v);
-	lr = ((__int64_t)random() << 32) + random();
+	lr = ((int64_t)random() << 32) + random();
 	off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
 	off %= maxfsize;
 	e = truncate64_path(&f, off) < 0 ? errno : 0;
@@ -3979,7 +3980,7 @@ unresvsp_f(int opno, long r)
 	pathname_t	f;
 	int		fd;
 	struct xfs_flock64	fl;
-	__int64_t	lr;
+	int64_t		lr;
 	off64_t		off;
 	struct stat64	stb;
 	int		v;
@@ -4011,7 +4012,7 @@ unresvsp_f(int opno, long r)
 		return;
 	}
 	inode_info(st, sizeof(st), &stb, v);
-	lr = ((__int64_t)random() << 32) + random();
+	lr = ((int64_t)random() << 32) + random();
 	off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
 	off %= maxfsize;
 	fl.l_whence = SEEK_SET;
@@ -4034,7 +4035,7 @@ write_f(int opno, long r)
 	pathname_t	f;
 	int		fd;
 	size_t		len;
-	__int64_t	lr;
+	int64_t		lr;
 	off64_t		off;
 	struct stat64	stb;
 	int		v;
@@ -4066,7 +4067,7 @@ write_f(int opno, long r)
 		return;
 	}
 	inode_info(st, sizeof(st), &stb, v);
-	lr = ((__int64_t)random() << 32) + random();
+	lr = ((int64_t)random() << 32) + random();
 	off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
 	off %= maxfsize;
 	lseek64(fd, off, SEEK_SET);
@@ -4090,7 +4091,7 @@ writev_f(int opno, long r)
 	pathname_t	f;
 	int		fd;
 	size_t		len;
-	__int64_t	lr;
+	int64_t		lr;
 	off64_t		off;
 	struct stat64	stb;
 	int		v;
@@ -4127,7 +4128,7 @@ writev_f(int opno, long r)
 		return;
 	}
 	inode_info(st, sizeof(st), &stb, v);
-	lr = ((__int64_t)random() << 32) + random();
+	lr = ((int64_t)random() << 32) + random();
 	off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
 	off %= maxfsize;
 	lseek64(fd, off, SEEK_SET);
diff --git a/ltp/growfiles.c b/ltp/growfiles.c
index ad1ecdf..951b926 100644
--- a/ltp/growfiles.c
+++ b/ltp/growfiles.c
@@ -1389,7 +1389,7 @@ set_sig()
 #ifdef SIGRESTART
 	        case SIGRESTART:
 #endif /* SIGRESTART */
-                case SIGCLD:
+                case SIGCHLD:
                     break;
 
                 default:
diff --git a/src/alloc.c b/src/alloc.c
index 92139f7..10d654d 100644
--- a/src/alloc.c
+++ b/src/alloc.c
@@ -171,7 +171,7 @@ bozo!
 	int		tflag = 0;
         int             nflag = 0;
 	int		unlinkit = 0;
-	__int64_t	v;
+	int64_t		v;
 
 	while ((c = getopt(argc, argv, "b:d:f:rtn")) != -1) {
 		switch (c) {
diff --git a/src/dmiperf.c b/src/dmiperf.c
index 245e529..359324a 100644
--- a/src/dmiperf.c
+++ b/src/dmiperf.c
@@ -16,6 +16,7 @@
  * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <sys/types.h>
 #include <sys/param.h>
 #include <sys/stat.h>
 #include <sys/time.h>
diff --git a/src/feature.c b/src/feature.c
index b735468..0fb834a 100644
--- a/src/feature.c
+++ b/src/feature.c
@@ -87,7 +87,7 @@ int check_big_ID(char *filename)
 	}
 
 	/* 98789 is greater than 2^16 (65536) */
-	if ((__uint32_t)sbuf.st_uid == 98789 || (__uint32_t)sbuf.st_gid == 98789)
+	if ((uint32_t)sbuf.st_uid == 98789 || (uint32_t)sbuf.st_gid == 98789)
 		return(0);
 	if (verbose)
 		fprintf(stderr, "lstat64 on %s gave uid=%d, gid=%d\n",
diff --git a/src/fssum.c b/src/fssum.c
index 13111d6..46e02ba 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -40,6 +40,7 @@
 #include <netinet/in.h>
 #include <inttypes.h>
 #include <assert.h>
+#include <byteswap.h>
 
 #define CS_SIZE 16
 #define CHUNKS	128
@@ -51,7 +52,7 @@
 #endif
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
-#define htonll(x)     __bswap_64 (x)
+#define htonll(x)     bswap_64 (x)
 #else
 #define htonll(x)     (x)
 #endif
diff --git a/src/getdevicesize.c b/src/getdevicesize.c
index 9672e91..b932830 100644
--- a/src/getdevicesize.c
+++ b/src/getdevicesize.c
@@ -24,8 +24,10 @@
 #include <stdio.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <stdint.h>
 #include <sys/ioctl.h>
 #include <sys/mount.h>
+#include <sys/types.h>
 
 #ifndef BLKGETSIZE64
 # define BLKGETSIZE64   _IOR(0x12,114,size_t)
@@ -33,7 +35,7 @@
 
 int main(int argc, char **argv)
 {
-	__uint64_t	size;
+	uint64_t	size;
 	long long	sz = -1;
 	int		error, fd;
 
diff --git a/src/loggen.c b/src/loggen.c
index a3d99f8..ed1ebbc 100644
--- a/src/loggen.c
+++ b/src/loggen.c
@@ -119,9 +119,9 @@ loggen_unmount(int count)
     xlog_op_header_t        *op;
     /* the data section must be 32 bit size aligned */
     struct {
-        __uint16_t magic;
-        __uint16_t pad1;
-        __uint32_t pad2; /* may as well make it 64 bits */
+        uint16_t magic;
+        uint16_t pad1;
+        uint32_t pad2; /* may as well make it 64 bits */
     } magic = { XLOG_UNMOUNT_TYPE, 0, 0 };
     
     if (!count) count=1;
diff --git a/src/makeextents.c b/src/makeextents.c
index 8183edb..a36685a 100644
--- a/src/makeextents.c
+++ b/src/makeextents.c
@@ -23,15 +23,15 @@
 #include "global.h"
 
 char *progname;
-__uint64_t num_holes = 1000;
-__uint64_t curr_holes;
+uint64_t num_holes = 1000;
+uint64_t curr_holes;
 int verbose_opt = 0;
 char *filename;
 int status_num = 100;
 int wsync;
 int preserve;
 unsigned int blocksize;
-__uint64_t fileoffset;
+uint64_t fileoffset;
 
 #define JUMP_SIZE (128 * 1024)
 #define NUMHOLES_TO_SIZE(i) (i * JUMP_SIZE)
@@ -51,8 +51,8 @@ main(int argc, char *argv[])
 	int c;
 	int fd;
 	int oflags;
-	__uint64_t i;
-	__uint64_t offset;
+	uint64_t i;
+	uint64_t offset;
 	int blocksize = 512;
 	unsigned char *buffer = NULL;
 	struct stat stat;
diff --git a/src/metaperf.c b/src/metaperf.c
index d06b589..5f5a971 100644
--- a/src/metaperf.c
+++ b/src/metaperf.c
@@ -25,6 +25,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <dirent.h>
+#include <linux/param.h>
 
 typedef	void	*(*fpi_t)(void);
 typedef	void	(*fpt_t)(int, void *);
diff --git a/src/pwrite_mmap_blocked.c b/src/pwrite_mmap_blocked.c
index 26e2230..0ebd746 100644
--- a/src/pwrite_mmap_blocked.c
+++ b/src/pwrite_mmap_blocked.c
@@ -22,7 +22,7 @@
 #include <errno.h>
 #include <time.h>
 #include <sys/mman.h>
-#include <sys/signal.h>
+#include <signal.h>
 #include <sys/stat.h>
 
 
diff --git a/src/randholes.c b/src/randholes.c
index ee5b6b6..a16670f 100644
--- a/src/randholes.c
+++ b/src/randholes.c
@@ -21,7 +21,7 @@
 #include "global.h"
 
 #define	power_of_2(x)	((x) && !((x) & ((x) - 1)))
-#define	DEFAULT_FILESIZE	((__uint64_t) (256 * 1024 * 1024))
+#define	DEFAULT_FILESIZE	((uint64_t) (256 * 1024 * 1024))
 #define	DEFAULT_BLOCKSIZE	512
 
 #define	SETBIT(ARRAY, N)	((ARRAY)[(N)/8] |= (1 << ((N)%8)))
@@ -30,8 +30,8 @@
 /* Bit-vector array showing which blocks have been written */
 static unsigned char	*valid;
 
-static __uint64_t filesize;
-static __uint64_t fileoffset;
+static uint64_t filesize;
+static uint64_t fileoffset;
 
 static unsigned int blocksize;
 static int count;
@@ -72,7 +72,7 @@ usage(char *progname)
 	fprintf(stderr, "\tdefault count is %d block-sized writes\n",
 		(int) (DEFAULT_FILESIZE / DEFAULT_BLOCKSIZE));
 	fprintf(stderr, "\tdefault write_offset is %" PRIu64 " bytes\n",
-		(__uint64_t) 0);
+		(uint64_t) 0);
 	exit(1);
 }
 
@@ -174,7 +174,7 @@ findblock(void)
 }
 
 static void
-dumpblock(int *buffer, __uint64_t offset, int blocksize)
+dumpblock(int *buffer, uint64_t offset, int blocksize)
 {
 	int	i;
 
@@ -190,7 +190,7 @@ dumpblock(int *buffer, __uint64_t offset, int blocksize)
 static void
 writeblks(char *fname, int fd, size_t alignment)
 {
-	__uint64_t offset;
+	uint64_t offset;
 	char *buffer = NULL;
 	int block;
 	int ret;
@@ -226,7 +226,7 @@ writeblks(char *fname, int fd, size_t alignment)
 		    exit(1);
 		}
 
-		offset = (__uint64_t) block * blocksize;
+		offset = (uint64_t) block * blocksize;
 		if (alloconly) {
                         if (test) continue;
                         
@@ -252,8 +252,8 @@ writeblks(char *fname, int fd, size_t alignment)
 			 * into it.  We'll verify this when we read
 			 * it back in again.
 			 */
-			*(__uint64_t *) buffer = fileoffset + offset;
-			*(__uint64_t *) (buffer + 256) = fileoffset + offset;
+			*(uint64_t *) buffer = fileoffset + offset;
+			*(uint64_t *) (buffer + 256) = fileoffset + offset;
 
 		        if (write(fd, buffer, blocksize) < blocksize) {
 			        perror("write");
@@ -273,7 +273,7 @@ writeblks(char *fname, int fd, size_t alignment)
 static int
 readblks(int fd, size_t alignment)
 {
-	__uint64_t offset;
+	uint64_t offset;
 	char *buffer, *tmp;
 	unsigned int xfer, block, i;
         int err=0;
@@ -305,9 +305,9 @@ readblks(int fd, size_t alignment)
 		}
 		tmp = buffer;
 		for (i = 0; i < READ_XFER; i++) {
-			__uint64_t want;
-			__uint64_t first;
-			__uint64_t second;
+			uint64_t want;
+			uint64_t first;
+			uint64_t second;
 
 			if (verbose && ((block % 100) == 0)) {
 				printf("+");
@@ -315,8 +315,8 @@ readblks(int fd, size_t alignment)
 			}
 
 			want = BITVAL(valid, block) ? offset : 0;
-			first = *(__uint64_t *) tmp;
-			second = *(__uint64_t *) (tmp + 256);
+			first = *(uint64_t *) tmp;
+			second = *(uint64_t *) (tmp + 256);
 			if (first != want || second != want) {
 				printf("mismatched data at offset=0x%" PRIx64
 					", expected 0x%" PRIx64
diff --git a/src/t_mtab.c b/src/t_mtab.c
index 5e9d521..fd85c6b 100644
--- a/src/t_mtab.c
+++ b/src/t_mtab.c
@@ -34,7 +34,7 @@ static int signals_have_been_setup = 0;
 /* Ensure that the lock is released if we are interrupted.  */
 static void
 handler (int sig) {
-    fprintf(stderr, "%s\n", sys_siglist[sig]);
+    fprintf(stderr, "%s\n", strsignal(sig));
     exit(1);
 }
 
-- 
2.1.4

