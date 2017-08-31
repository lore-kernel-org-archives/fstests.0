Received: from mx1.redhat.com ([209.132.183.28]:51170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750908AbdHaF7s (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 31 Aug 2017 01:59:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75B7E7EBD6
        for <fstests@vger.kernel.org>; Thu, 31 Aug 2017 05:59:48 +0000 (UTC)
Received: from dhcp-12-116.nay.redhat.com (dhcp-12-116.nay.redhat.com [10.66.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FD33A2A6F
        for <fstests@vger.kernel.org>; Thu, 31 Aug 2017 05:59:47 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] fsstress: fallback to stat() if XFS_IOC_DIOINFO fails
Date: Thu, 31 Aug 2017 13:59:43 +0800
Message-Id: <20170831055943.25402-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

XFS_IOC_DIOINFO is only used for XFS, but fsstress use it to get
DIO aligned size. If XFS_IOC_DIOINFO returns error, then stop
doing any DIO related test (dread/dwrite/aread/awrite etc). That
means we never do DIO related test on other filesystems by fsstress.

The real minimal dio size is really not so important for DIO test
in fsstress. The multiple of real min dio size is fine too. I think
the stat.st_blksize get from stat() system call can be used to be
a fake minimal dio size, if XFS_IOC_DIOINFO fails (not supported).

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

Without this patch, I got below things on ext4:
  2/8: dwrite - xfsctl(XFS_IOC_DIOINFO) f2[1441795 1 0 0 0 0] failed 25

With this patch, I got this on ext4:
  0/20: dwrite - xfsctl(XFS_IOC_DIOINFO) f0[1048578 1 0 0 112 507904] return 25, fallback to stat()
  0/20: dwrite f0[1048578 1 0 0 112 507904] [565248,24576] 0
and this on glusterfs:
  0/7: dwrite - xfsctl(XFS_IOC_DIOINFO) f0[-5682875992630699762 1 0 0 0 0] return 38, fallback to stat()
  0/7: dwrite f0[-5682875992630699762 1 0 0 0 0] [917504,131072] 0

The equation about d_maxiosz is according to XFS_IOC_DIOINFO ioctl
source code in current linux kernel:

  case XFS_IOC_DIOINFO: {
    ...

    da.d_mem =  da.d_miniosz = target->bt_logical_sectorsize;
    da.d_maxiosz = INT_MAX & ~(da.d_miniosz - 1);

    ...
  }

Maybe it's not the real max dio size, but I think it's helpful to
keep running fsstress dio test on other filesystems. Please feel
free to show me your better methods :)

Thanks,
Zorro

 ltp/fsstress.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 7ae7fdf2..24c063e3 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -1901,11 +1901,11 @@ do_aio_rw(int opno, long r, int flags)
 	if (xfsctl(f.path, fd, XFS_IOC_DIOINFO, &diob) < 0) {
 		if (v)
 			printf(
-			"%d/%d: do_aio_rw - xfsctl(XFS_IOC_DIOINFO) %s%s failed %d\n",
+			"%d/%d: do_aio_rw - xfsctl(XFS_IOC_DIOINFO) %s%s return %d,"
+			" fallback to stat()\n",
 				procid, opno, f.path, st, errno);
-		free_pathname(&f);
-		close(fd);
-		return;
+		diob.d_mem = diob.d_miniosz = stb.st_blksize;
+		diob.d_maxiosz = INT_MAX & ~(diob.d_miniosz - 1);
 	}
 	dio_env = getenv("XFS_DIO_MIN");
 	if (dio_env)
@@ -2352,11 +2352,11 @@ dread_f(int opno, long r)
 	if (xfsctl(f.path, fd, XFS_IOC_DIOINFO, &diob) < 0) {
 		if (v)
 			printf(
-			"%d/%d: dread - xfsctl(XFS_IOC_DIOINFO) %s%s failed %d\n",
+			"%d/%d: dread - xfsctl(XFS_IOC_DIOINFO) %s%s return %d,"
+			" fallback to stat()\n",
 				procid, opno, f.path, st, errno);
-		free_pathname(&f);
-		close(fd);
-		return;
+		diob.d_mem = diob.d_miniosz = stb.st_blksize;
+		diob.d_maxiosz = INT_MAX & ~(diob.d_miniosz - 1);
 	}
 
 	dio_env = getenv("XFS_DIO_MIN");
@@ -2430,11 +2430,10 @@ dwrite_f(int opno, long r)
 	if (xfsctl(f.path, fd, XFS_IOC_DIOINFO, &diob) < 0) {
 		if (v)
 			printf("%d/%d: dwrite - xfsctl(XFS_IOC_DIOINFO)"
-				" %s%s failed %d\n",
+				" %s%s return %d, fallback to stat()\n",
 			       procid, opno, f.path, st, errno);
-		free_pathname(&f);
-		close(fd);
-		return;
+		diob.d_mem = diob.d_miniosz = stb.st_blksize;
+		diob.d_maxiosz = INT_MAX & ~(diob.d_miniosz - 1);
 	}
 
 	dio_env = getenv("XFS_DIO_MIN");
-- 
2.13.5

