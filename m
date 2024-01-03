Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905071C6AB
	for <fstests@vger.kernel.org>; Wed,  3 Jan 2024 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gpNXCIQc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403Hd5QL004839;
	Wed, 3 Jan 2024 18:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=pKupbGRe1+zuuwJmlBVbdzWIitl6dfklRxz2cp0KXno=;
 b=gpNXCIQc1cISEPUVKAhoJstBKpEKX4D3LZwh/Km+WNjIt3AtFkTxSToIooQYJaD3nwz9
 qkGV9pLfFmmZnHJmxxghCxRPl2bCcw8k1KSBBgEd7R0912bAoteEKulg8vAJ4O9rfCP5
 C+xqy8FTcEWz52xFd6tb6pLImfILIzQEZ2ex/gT0WGy1udYu+7QnJPX2uJcBVFl/mb/u
 c+qL21ZJzQiH5zFAkZYvUZXF8qJ3lcwnIQYQQ6YTepqXNiz842bYsW6jIEvuYK6ByTIz
 OD5KjdnkX6HWroGLY1bAahOtwyE2Md0CM2fR2DQ7yz3DDH7CkW0wKHt2uCm1b8r7MQi6 zA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vd86d9syr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 18:43:34 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 403IUFqE025487;
	Wed, 3 Jan 2024 18:43:34 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vd86d9sy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 18:43:34 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 403HwUPU018005;
	Wed, 3 Jan 2024 18:43:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vayrkmfyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 18:43:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 403IhU2M31719892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jan 2024 18:43:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6BD120040;
	Wed,  3 Jan 2024 18:43:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19D7D20043;
	Wed,  3 Jan 2024 18:43:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.105.105])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jan 2024 18:43:27 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: fstests@vger.kernel.org, djwong@kernel.org
Cc: ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH v2] xfstest: add detection for ext4.h presence in configure.ac
Date: Thu,  4 Jan 2024 00:12:08 +0530
Message-Id: <20240103184208.80772-1-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KjDZhnRYNKqbVpCDLHv952ErgbBbp8ih
X-Proofpoint-ORIG-GUID: 5rq1dTKh99oWKBApHgfDqSYsrViaUGLE
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401030151

In some distributions, __u64 is already defined in system header files,
causing compilation errors when building xfstest.

        # make
            [CC]    ext4_resize
        ext4_resize.c:17:28: error: conflicting types for '__u64'
         typedef unsigned long long __u64;
                                    ^~~~~
        In file included from /usr/include/asm/types.h:26:0,
                         from /usr/include/linux/types.h:5,
                         from /usr/include/linux/mount.h:4,
                         from /usr/include/sys/mount.h:32,
                         from ext4_resize.c:15:
        /usr/include/asm-generic/int-l64.h:30:23: note: previous declaration of '__u64' was here
         typedef unsigned long __u64;
                       ^~~~~

To address this issue, configure.ac now checks for the presence
and compilability of <linux/ext4.h>. If found and compilable, the
macro HAVE_LINUX_EXT4_H is defined. If not, a warning message
is displayed. The commit also updates src/ext4_resize.c to
conditionally include <linux/ext4.h> based on the presence of
the header, ensuring compatibility with systems where ext4.h
is either present or not. This change enhances the configure
process and improves code consistency.

The changes were tested on various distributions on Power
architecture, by successfully compiling xfstest. Additionally,
verified the compatibility by running ext4/033 and ext4/056
tests, both of which use ext4_resize and observed successful
test execution.

        # make
            [CC]    detached_mounts_propagation
            [CC]    ext4_resize
            [CC]    t_readdir_3

Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
---

Changelog:
v1 -> v2
Drop usage of uint64_t to match the definition in the kernel uapi
headers. Use <linux/ext4.h> or <linux/types.h> based on the
presence of the header to get the __u64 definition as suggested
by Darrick.

Link to v1:
https://lore.kernel.org/fstests/20231221061231.44347-1-disgoel@linux.ibm.com/T/#u

 configure.ac      | 8 ++++++++
 src/ext4_resize.c | 6 +++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index b22fc52b..76378e6d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -35,6 +35,14 @@ AC_CHECK_HEADERS([	assert.h		\
 			sys/mman.h		\
 ])
 
+AC_COMPILE_IFELSE([
+    AC_LANG_PROGRAM([#include <linux/ext4.h>], [])
+], [
+    AC_DEFINE([HAVE_LINUX_EXT4_H], [1], [Define if ext4.h is present])
+], [
+    AC_MSG_WARN([ext4.h not found or not compilable.])
+])
+
 AC_CHECK_HEADERS([xfs/xfs_log_format.h],,,[
 #define _GNU_SOURCE
 #include <xfs/libxfs.h>])
diff --git a/src/ext4_resize.c b/src/ext4_resize.c
index 78b66432..51bd8d78 100644
--- a/src/ext4_resize.c
+++ b/src/ext4_resize.c
@@ -14,7 +14,11 @@
 #include <sys/ioctl.h>
 #include <sys/mount.h>
 
-typedef unsigned long long __u64;
+#ifdef HAVE_LINUX_EXT4_H
+#include <linux/ext4.h>
+#else
+#include <linux/types.h>
+#endif
 
 #ifndef EXT4_IOC_RESIZE_FS
 #define EXT4_IOC_RESIZE_FS		_IOW('f', 16, __u64)
-- 
2.39.1

