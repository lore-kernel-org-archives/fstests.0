Received: from mx0.herbolt.com (mx0.herbolt.com [5.59.97.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37133A9002
	for <fstests@vger.kernel.org>; Tue,  6 Oct 2026 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.59.97.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283904; cv=none; b=BLXnALXO93UMyRBMOBE2dWHGA2OeEp5wvkHp1OIrPuNW4CTaHGaLXz5u1HJH3DS8t6I0ukubAxYn8uesutYOsz5I9oKwew2UPpVHGnSwtzSN8IoHHu2alFvaSkcLQBh7GuRiois9qfIS63GPYnGXF+DysmdUuopqUJeUHHYmSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283904; c=relaxed/simple;
	bh=xyB0B7OkMNUNgaMWaMPHnPk+crZ9Ta7QG7mGRAvImT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iYFuLEsaP0jSkMDjqnLNHT324OAmJDa2Pv26hM7YiSuF0zP9uePPzq17cJ+ZnZuwdYsYv0r8EFNsKp9ZWk+fwF9ptFmzzQG0AMpKDIFGdIfvtBfEiSZw3iOURxBIw1Lf2NKgtml1FD4ew5RLwqlYap6YYc5c5BiOdBkHfu3SbKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com; spf=pass smtp.mailfrom=herbolt.com; arc=none smtp.client-ip=5.59.97.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbolt.com
Received: from mx0.herbolt.com (localhost [127.0.0.1])
	by mx0.herbolt.com (Postfix) with ESMTP id 5610B180F2C1;
	Tue, 06 Oct 2026 12:43:59 +0200 (CEST)
Received: from trufa.intra.herbolt.com ([172.16.31.30])
	by mx0.herbolt.com with ESMTPSA
	id ktU5Cu/QxGrN4gEAKEJqOA
	(envelope-from <lukas@herbolt.com>); Tue, 06 Oct 2026 12:43:59 +0200
From: Lukas Herbolt <lukas@herbolt.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	Lukas Herbolt <lukas@herbolt.com>
Subject: [PATCH] xfstests: Unify the build targets under LINUX_TARGET
Date: Tue,  6 Oct 2026 12:39:39 +0200
Message-ID: <20261006103937.276181-3-lukas@herbolt.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed previously, the only supported target for now
is LINUX_TARGET. Merging the TARGET into LINUX_TARGET and
fix indentation in the Makefile.

Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
---
 src/Makefile | 55 ++++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/src/Makefile b/src/Makefile
index 0ff607ae1593..1f7f9fd61987 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -6,7 +6,9 @@
 TOPDIR = ..
 include $(TOPDIR)/include/builddefs
 
-TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
+TARGETS =
+
+LINUX_TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	nametest permname randholes runas truncfile usemem \
 	mmapcat append_reader append_writer dirperf metaperf \
 	devzero feature alloc fault fstest t_access_root \
@@ -21,9 +23,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
 	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
 	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
-	dio-writeback-race unlink-fsync truncate dio-read-into-mmap
-
-LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
+	dio-writeback-race unlink-fsync truncate dio-read-into-mmap \
+	xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
 	locktest unwritten_mmap bulkstat_unlink_test deduperace \
 	bulkstat_unlink_test_modified t_dir_offset t_futimens t_immutable \
@@ -48,68 +49,64 @@ SUBDIRS = log-writes perf
 LLDLIBS = $(LIBHANDLE) $(LIBACL) -lpthread -lrt -luuid
 
 ifeq ($(HAVE_XLOG_ASSIGN_LSN), true)
-LINUX_TARGETS += loggen
+    LINUX_TARGETS += loggen
 endif
 
 ifeq ($(HAVE_FIEMAP), true)
-LINUX_TARGETS += fiemap-tester t_stripealign
+    LINUX_TARGETS += fiemap-tester t_stripealign
 endif
 
 ifeq ($(HAVE_OPEN_BY_HANDLE_AT), true)
-LINUX_TARGETS += open_by_handle
+    LINUX_TARGETS += open_by_handle
 endif
 
 ifeq ($(HAVE_FALLOCATE), true)
-LCFLAGS += -DHAVE_FALLOCATE
+    LCFLAGS += -DHAVE_FALLOCATE
 endif
 
 ifeq ($(HAVE_FILE_GETATTR), yes)
-LINUX_TARGETS += file_attr
-LCFLAGS += -DHAVE_FILE_GETATTR
-endif
-
-ifeq ($(PKG_PLATFORM),linux)
-TARGETS += $(LINUX_TARGETS)
+    LINUX_TARGETS += file_attr
+    LCFLAGS += -DHAVE_FILE_GETATTR
 endif
 
 ifeq ($(HAVE_DB), true)
-TARGETS += dbtest
-LLDLIBS += $(LIBGDBM)
+    TARGETS += dbtest
+    LLDLIBS += $(LIBGDBM)
 endif
 
 ifeq ($(HAVE_AIO), true)
-TARGETS += t_mmap_dio
-SUBDIRS += aio-dio-regress
-LLDLIBS += -laio
+    LINUX_TARGETS += t_mmap_dio
+    SUBDIRS += aio-dio-regress
+    LLDLIBS += -laio
 endif
 
 ifeq ($(HAVE_URING), true)
-LINUX_TARGETS += btrfs_encoded_read btrfs_encoded_write
-TARGETS += uring_read_fault
-LLDLIBS += -luring
+    LINUX_TARGETS += btrfs_encoded_read btrfs_encoded_write \
+		     uring_read_fault
+    LLDLIBS += -luring
 endif
 
 SUBDIRS += vfs
 ifeq ($(HAVE_LIBCAP), true)
-LLDLIBS += -lcap
+    LLDLIBS += -lcap
 endif
 
 ifeq ($(HAVE_SEEK_DATA), yes)
  ifeq ($(HAVE_NFTW), yes)
   ifeq ($(HAVE_BMV_OF_SHARED), yes)
    ifeq ($(HAVE_RLIMIT_NOFILE), yes)
-     TARGETS += xfsfind
+     LINUX_TARGETS += xfsfind
    endif
   endif
  endif
 endif
 
 ifeq ($(HAVE_FICLONE),yes)
-     TARGETS += t_reflink_read_race
+     LINUX_TARGETS += t_reflink_read_race
 endif
 
 ifeq ($(HAVE_FANOTIFY_FID),yes)
-     TARGETS += fs-monitor
+     LINUX_TARGETS += fs-monitor
 endif
 
 ifeq ($(HAVE_LIBBTRFSUTIL), true)
@@ -117,7 +114,11 @@ ifeq ($(HAVE_LIBBTRFSUTIL), true)
 endif
 
 ifeq ($(NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE),yes)
-LCFLAGS += -DNEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
+     LCFLAGS += -DNEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
+endif
+
+ifeq ($(PKG_PLATFORM),linux)
+     TARGETS += $(LINUX_TARGETS)
 endif
 
 CFILES = $(TARGETS:=.c)
-- 
2.55.0

