Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42F37153
	for <fstests@vger.kernel.org>; Tue,  9 Jan 2024 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A89Hr+Z4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409A7Xws017862;
	Tue, 9 Jan 2024 11:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=0nK57Rnf+VxXgjetCwT2I/M9gwxGP1GNc0nsBHudCIA=;
 b=A89Hr+Z4J2e+QoX6NtPcYRiK4YOuPspdE4ynR2xfXvNn9PBfKtu/AQUR9TkIXCkaMorJ
 NG7RdBToSn7V017SPaB9cZEXQE1Nq9HBvMEmrZpMSDniA60vL9QDmyFvVvDgLcCB9amq
 YlzTAY4Wxx2b+/6Aqv+nuX6LDT7QE2dlzfgvjxy4bFn2Fe4rHNbMuUjskaJ9XjjawA5Q
 dUpj2kRp+4k77sY0XDmUBeud1XUL1+zcrBA4f7T2OYxjkj5p36XcQdaJ+KxJEP3YMQ5D
 ppDerNTk8N8x3kDuxPXxFH19kEk0l9MStAWgdntJO/2+w+cocwTm3WuARxoEuY3GPf4n RA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh444hjg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 11:11:25 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 409B89Zv016598;
	Tue, 9 Jan 2024 11:11:25 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh444hjfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 11:11:24 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 409Ao3uK022916;
	Tue, 9 Jan 2024 11:11:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfj6ne582-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 11:11:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 409BBLwf18678450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jan 2024 11:11:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37AA020043;
	Tue,  9 Jan 2024 11:11:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19F7720040;
	Tue,  9 Jan 2024 11:11:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.53.108])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jan 2024 11:11:18 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: fstests@vger.kernel.org, djwong@kernel.org
Cc: ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH v3] xfstest: add detection for ext4.h presence in configure.ac
Date: Tue,  9 Jan 2024 16:41:05 +0530
Message-Id: <20240109111105.28836-1-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9pu3N6aikgA_HPQC3knzlO1wDupDExHz
X-Proofpoint-ORIG-GUID: 2XYy0S8UtSVi-YC6KGFgVSTLdTElvjTB
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
 definitions=2024-01-09_04,2024-01-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=909 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401090091

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

To address this issue, configure.ac now checks for the presence and
compilability of <linux/ext4.h>. If found and compilable, the macro
HAVE_LINUX_EXT4_H is defined. The commit also updates src/ext4_resize.c
to conditionally include <linux/ext4.h> based on the presence of the
header, ensuring compatibility with systems where ext4.h is either
present or not. Also include <linux/types.h> which gets __u64
definition on systems where ext4.h is not present. This change
enhances the configure process and improves code consistency.

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
v2 -> v3
Addressed below review comments from Darrick.
Replaced the explicit AC_COMPILE_IFELSE block with a simplified
check using AC_CHECK_HEADERS for <linux/ext4.h>.
Added unconditional inclusion of <linux/types.h> regardless of
the presence of <linux/ext4.h> in ext4_resize.c file.

v1 -> v2
Drop usage of uint64_t to match the definition in the kernel uapi
headers. Use <linux/ext4.h> or <linux/types.h> based on the
presence of the header to get the __u64 definition as suggested
by Darrick.

Link to v1:
https://lore.kernel.org/fstests/20231221061231.44347-1-disgoel@linux.ibm.com/T/#u

Link to v2:
https://lore.kernel.org/fstests/20240103184208.80772-1-disgoel@linux.ibm.com/T/#u

 configure.ac      | 4 ++++
 src/ext4_resize.c | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index b22fc52b..8f9fb062 100644
--- a/configure.ac
+++ b/configure.ac
@@ -35,6 +35,10 @@ AC_CHECK_HEADERS([	assert.h		\
 			sys/mman.h		\
 ])
 
+AC_CHECK_HEADERS([linux/ext4.h], [
+AC_DEFINE([HAVE_LINUX_EXT4_H], [1])
+])
+
 AC_CHECK_HEADERS([xfs/xfs_log_format.h],,,[
 #define _GNU_SOURCE
 #include <xfs/libxfs.h>])
diff --git a/src/ext4_resize.c b/src/ext4_resize.c
index 78b66432..31779225 100644
--- a/src/ext4_resize.c
+++ b/src/ext4_resize.c
@@ -13,8 +13,11 @@
 #include <string.h>
 #include <sys/ioctl.h>
 #include <sys/mount.h>
+#include <linux/types.h>
 
-typedef unsigned long long __u64;
+#ifdef HAVE_LINUX_EXT4_H
+#include <linux/ext4.h>
+#endif
 
 #ifndef EXT4_IOC_RESIZE_FS
 #define EXT4_IOC_RESIZE_FS		_IOW('f', 16, __u64)
-- 
2.39.1

